namespace Lazzerini;
using Microsoft.Sales.Document;

codeunit 50212 "XV Kit Bus Subscriber"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure SalesLineAfterInsert(var Rec: Record "Sales Line")
    var
        SL: Record "Sales Line";
        SH: Record "Sales Header";
        ParentItemNo: Code[20];
    begin
        // Ignora righe non-item o righe padre
        if Rec.Type <> Rec.Type::Item then
            exit;

        // Trova la riga precedente (dovrebbe essere un commento)
        SL.Reset();
        SL.SetRange("Document Type", Rec."Document Type");
        SL.SetRange("Document No.", Rec."Document No.");
        SL.SetFilter("Line No.", '<%1', Rec."Line No.");

        if SL.FindLast() then begin
            if SL.Type = SL.Type::" " then begin
                // Riga commento → estrai l'articolo padre
                ParentItemNo := ExtractParentItemNo(SL.Description);
            end;
        end;

        if ParentItemNo = '' then
            exit; // Nessun padre trovato → non è esplosione kit

        // Imposta i tuoi campi custom
        Rec."xv Kit Bus" := ParentItemNo;
        Rec."xv Progressivo Kit Bus" := 1;
        Rec.Modify();

        // Aggiorna intestazione ordine
        SH.Get(Rec."Document Type", Rec."Document No.");
        SH."Ordine con kit" := true;
        SH.Modify();

        // Messaggio finale
        Message('Kit Bus OK');
    end;

    // Funzione per estrarre il No. Articolo dal commento standard
    local procedure ExtractParentItemNo(CommentTxt: Text): Code[20]
    var
        Pos: Integer;
    begin
        // Esempi commenti standard:
        // "= 4011202-SAL1/SPEC517"
        // "Assembly Item: 4011202-SAL1/SPEC517"

        Pos := StrPos(CommentTxt, ' ');
        if Pos > 0 then
            exit(CopyStr(CommentTxt, Pos + 1, 20));

        exit('');
    end;
}
