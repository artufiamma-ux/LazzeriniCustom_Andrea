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
        Progressivo: Integer;
    begin
        // NON Solo righe di tipo Item possono essere figlie dell'esplosione

            // Se è già valorizzato, evitare loop o duplicazioni
//            if Rec."xv Kit Bus" <> '' then
//                exit;

            ParentItemNo := Rec."BOM Item No."; // GetParentItem(Rec);

            if ParentItemNo = '' then
                exit;  // Non è esplosione kit
Message('ParentItemNo: %1 Type: %2', ParentItemNo, Rec.Type);
            if Rec.Type = Rec.Type::Item then
                Progressivo := getProgressivoFromComment(Rec."Document No.", Rec."Document Type", ParentItemNo)
            else
                Progressivo := getProgressivoNew(Rec."Document No.", Rec."Document Type", ParentItemNo) ;
            // Valorizza i tuoi campi custom su tutte le righe figlie
            Rec."xv Kit Bus" := ParentItemNo;
            Rec."xv Progressivo Kit Bus" := Progressivo;
            Rec.Modify(true);

            // Aggiorna intestazione ordine
            if SH.Get(Rec."Document Type", Rec."Document No.") then 
            begin
                if not SH."Ordine con kit" then 
                begin
                    SH."Ordine con kit" := true;
                    SH.Modify();
                end;
            end;
    end;

    // Trova progressivo dalla riga commento sopra
    local procedure getProgressivoFromComment(DocNo: Code[20]; DocType: Enum "Sales Document Type"; ParentItem: Code[20]): Integer
    var
        SL: Record "Sales Line";
    begin
        SL.Reset();
        SL.SetRange("Document Type", DocType);
        SL.SetRange("Document No.", DocNo);
        SL.SetRange("xv Kit Bus", ParentItem);
        SL.SetRange(Type, SL.Type::" "); // solo commenti

        if SL.FindLast() then
            exit(SL."xv Progressivo Kit Bus");

        exit(1);
    end;


    // Genera nuovo progressivo (MAX + 1)
    local procedure getProgressivoNew(DocNo: Code[20]; DocType: Enum "Sales Document Type"; ParentItem: Code[20]): Integer
    var
        SL: Record "Sales Line";
        MaxProg: Integer;
    begin
        MaxProg := 1;

        SL.Reset();
        SL.SetRange("Document Type", DocType);
        SL.SetRange("Document No.", DocNo);
        SL.SetRange("xv Kit Bus", ParentItem);
        SL.SetRange(Type, SL.Type::" "); // solo commenti-padre

        if SL.FindSet() then
            repeat
                if SL."xv Progressivo Kit Bus" > MaxProg then
                    MaxProg := SL."xv Progressivo Kit Bus";
            until SL.Next() = 0
        else
            MaxProg := 0; 

        exit(MaxProg + 1);
    end;

}