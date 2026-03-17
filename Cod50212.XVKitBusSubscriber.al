namespace Lazzerini;

using Microsoft.Sales.Document;
using Microsoft.Inventory.BOM;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Request;


codeunit 50212 "XV Kit Bus Subscriber"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure SalesLineAfterInsert(var Rec: Record "Sales Line")
    var
        SH: Record "Sales Header";
        ParentItemNo: Code[20];
        Progressivo: Integer;
        IsNewKit: Boolean;
    begin
        // ► Consideriamo solo righe figlio (ITEM);
        if Rec.Type <> Rec.Type::Item then
            exit;

        // ► Solo righe generate da esplosione hanno "BOM Item No."
        ParentItemNo := Rec."BOM Item No.";
        if ParentItemNo = '' then
            exit;

        // ► Evita esecuzioni multiple
        if Rec."xv Kit Bus" <> '' then
            exit;

        // ► RIGA PRECEDENTE = PADRE RAW ? 
        IsNewKit := IsRawParent(Rec);

        if IsNewKit then begin
            // -----------------------------
            // NUOVO KIT → incrementa progressivo
            // -----------------------------
            Progressivo :=
                GetNextKitProgressivo(
                    Rec."Document Type",
                    Rec."Document No.",
                    ParentItemNo);

            // Scrivi il padre
            WriteParentComment(
                Rec,
                ParentItemNo,
                Progressivo);

        end else begin
            // -----------------------------
            // FIGLIO KIT ESISTENTE → eredita progressivo
            // -----------------------------
            Progressivo :=
                GetProgressivoFromParent(
                    Rec."Document Type",
                    Rec."Document No.",
                    ParentItemNo);
        end;

        // ► Imposta sempre sui figli
        Rec."xv Kit Bus" := ParentItemNo;
        Rec."xv Progressivo Kit Bus" := Progressivo;
        Rec."xv Nr Layout" := SH."Nr Layout";
        Rec."xv Posizione Layout" := GetPosizioneLayoutFromBOM(ParentItemNo, Rec."No.");
        Rec.Modify(true);

        // ► Imposta flag su intestazione ordine
        if SH.Get(Rec."Document Type", Rec."Document No.")  then begin
            if not SH."Ordine con kit" then begin
                SH."Ordine con kit" := true;
                SH.Modify();
            end;
            Rec."xv Nr Layout" := SH."Nr Layout";
            Rec.Modify(true);
        end;

    end;


    // -------------------------------------------------------------
    // FUNZIONI DI SUPPORTO
    // -------------------------------------------------------------

    // Verifica se la riga precedente è un padre RAW NON ancora valorizzato
    local procedure IsRawParent(var Rec: Record "Sales Line"): Boolean
    var
        Prev: Record "Sales Line";
    begin
        Prev.SetRange("Document Type", Rec."Document Type");
        Prev.SetRange("Document No.", Rec."Document No.");
        Prev.SetFilter("Line No.", '<%1', Rec."Line No.");

        if Prev.FindLast() then begin
            if (Prev."No." = '') and (Prev."xv Kit Bus" = '') then
                exit(true);
        end;

        exit(false);
    end;


    // Scrive padre (riga commento)
    local procedure WriteParentComment(
        FromLine: Record "Sales Line";
        ParentItemNo: Code[20];
        Progressivo: Integer)
    var
        CommentLine: Record "Sales Line";
    begin
        CommentLine.SetRange("Document Type", FromLine."Document Type");
        CommentLine.SetRange("Document No.", FromLine."Document No.");
        CommentLine.SetFilter("Line No.", '<%1', FromLine."Line No.");

        if CommentLine.FindLast() then begin
            if CommentLine."No." = '' then begin
                CommentLine."xv Kit Bus" := ParentItemNo;
                CommentLine."xv Progressivo Kit Bus" := Progressivo;
                CommentLine.Modify(true);
            end;
        end;
    end;


    // Recupera progressivo dal padre (commento)
    local procedure GetProgressivoFromParent(
        DocType: Enum "Sales Document Type";
        DocNo: Code[20];
        ParentItemNo: Code[20]
    ): Integer
    var
        SL: Record "Sales Line";
    begin
        SL.SetRange("Document Type", DocType);
        SL.SetRange("Document No.", DocNo);
        SL.SetRange("No.", '');
        SL.SetRange("xv Kit Bus", ParentItemNo);

        if SL.FindLast() then
            exit(SL."xv Progressivo Kit Bus");

        exit(1);
    end;


    // Calcolo nuovo progressivo (MAX + 1)
    local procedure GetNextKitProgressivo(
        DocType: Enum "Sales Document Type";
        DocNo: Code[20];
        ParentItemNo: Code[20]
    ): Integer
    var
        SL: Record "Sales Line";
        MaxProg: Integer;
    begin
        MaxProg := 0;

        SL.SetRange("Document Type", DocType);
        SL.SetRange("Document No.", DocNo);
        SL.SetRange("No.", '');
        SL.SetRange("xv Kit Bus", ParentItemNo);

        if SL.FindSet() then
            repeat
                if SL."xv Progressivo Kit Bus" > MaxProg then
                    MaxProg := SL."xv Progressivo Kit Bus";
            until SL.Next() = 0;

        exit(MaxProg + 1);
    end;
    local procedure GetPosizioneLayoutFromBOM(
        ParentItemNo: Code[20];
        ItemNo: Code[20]) : Code[20]
    var IB: Record "BOM Component";
    begin
        IB.SetRange("Parent Item No.", ParentItemNo);
        IB.SetRange("No.", ItemNo);

        if IB.FindFirst() then
            exit(IB."Posizione Layout");

        exit('');
    end;
 


/*
    [EventSubscriber(
        ObjectType::Table,
        Database::"Warehouse Shipment Line",
        'OnAfterSetSourceFilter',
        '', false, false)]
    local procedure OnAfterSetSourceFilterWhse(
        var WarehouseShipmentLine: Record "Warehouse Shipment Line";
        SourceType: Integer; 
        SourceSubType: Option; 
        SourceNo: Code[20]; 
        SourceLineNo: Integer; 
        SetKey: Boolean)

    var
        SalesLine: Record "Sales Line";
    begin
        Message('PASSATO NEL SUBSCRIBER DI CREAZIONE RIGA DI SPEDIZIONE %1 - %2 - %3 - %4 - %5'
        ,WarehouseShipmentLine."Source Type"
        ,WarehouseShipmentLine."Source Subtype"
        ,WarehouseShipmentLine."Source No."
        ,WarehouseShipmentLine."Source Line No."
        ,WarehouseShipmentLine."Line No.");
        // Verifica che l'origine sia una Sales Line
        if WarehouseShipmentLine."Source Type" <> Database::"Sales Line" then
            exit;

        // Recupera la sales line di origine
        if SalesLine.Get(
            WarehouseShipmentLine."Source Subtype",
            WarehouseShipmentLine."Source No.",
            WarehouseShipmentLine."Source Line No.") then begin

            // Copia i campi custom
                    WarehouseShipmentLine."Kit Bus" := SalesLine."xv Kit Bus";
                    WarehouseShipmentLine."Progressivo Kit Bus" := SalesLine."xv Progressivo Kit Bus";
                    WarehouseShipmentLine."Nr. Layout" := SalesLine."xv Nr Layout";
                    WarehouseShipmentLine."Posizione Layout" := SalesLine."xv Posizione Layout";

            WarehouseShipmentLine.Modify(true);
        end;
        Message('Evento di creazione riga di spedizione catturato. Campi Kit Bus copiati dalla Sales Line.');
    end;
*/
/*
    WhseShptLine."Kit Bus" := SalesLine."xv Kit Bus";
    WhseShptLine."Progressivo Kit Bus" := SalesLine."xv Progressivo Kit Bus";
    WhseShptLine."Nr. Layout" := SalesLine."xv Nr Layout";
    WhseShptLine."Posizione Layout" := SalesLine."xv Posizione Layout";
    WhseShptLine.Modify();
*/
}