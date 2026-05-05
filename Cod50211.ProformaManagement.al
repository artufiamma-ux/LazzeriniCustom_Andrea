namespace Lazzerini;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Setup;
using Microsoft.Finance.Currency;
using Microsoft.Foundation.NoSeries;
using Microsoft.Utilities;
using Microsoft.Inventory.Item;
//    using Microsoft.Base.Application;

codeunit 50211 "Proforma Management"
{

    Permissions =
        tabledata "Sales Shipment Header" = m,
        tabledata "Sales Shipment Line" = m,
        tabledata "Sales Header" = rimd,
        tabledata "Sales Line" = rimd;
    procedure CreateProformaFromSR(var PK: Code[20])
    begin
        CreateProformaFromShipment(PK, '***');
    end;

    procedure CreateProformaFromShipment(var PK: Code[20]; CodValuta: Code[20])
    var
        PostedShipment: Record "Sales Shipment Header";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Shipment Line"; // Il riferimento è stato spostato dall'ordine alla spedizione
        NewSalesHeader: Record "Sales Header";
        NewSalesLine: Record "Sales Line";
        Cust: Record "Customer";
        NoSeriesMgt: Codeunit "No. Series";   // CORRETTO
        Currency: Record "Currency Exchange Rate";
        FattoreValuta: Decimal;
        LineNo: Integer;
        NewNo: Code[20];
        IsValuta: Boolean;
        IsForeign: Boolean;
        Stringa: Text[100];
    begin
        IsValuta := CodValuta <> '***';
        PostedShipment.Get(PK); // Recupero la spedizione di riferimento, non quella temporanea
        // 0. Blocco difensivo
        if PostedShipment."Nr fattura proforma" <> '' then
            Error('Esiste già una proforma associata: %1.', PostedShipment."Nr fattura proforma");

        // 1. Recupero ordine originale
        if not SalesHeader.Get(SalesHeader."Document Type"::Order, PostedShipment."Order No.") then
            Error('Impossibile recuperare l''ordine %1.', PostedShipment."Order No.");
        if IsValuta then begin
            // 2. Recupero valuta proforma appena inserito in pagina
            PostedShipment."Cod valuta proforma" := CodValuta;
            if PostedShipment."Cod valuta proforma" = '' then
                Error('Il campo "Cod valuta proforma" non è valorizzato.');

            FattoreValuta := Currency.GetCurrentCurrencyFactor(PostedShipment."Cod valuta proforma");
            if FattoreValuta = 0 then
                FattoreValuta := 1;
            if PostedShipment."Cod valuta proforma" = PostedShipment."Currency Code" then
                FattoreValuta := 1;
        end;

        //----------------------------------------------------
        // 4. Creo intestazione Proforma
        //----------------------------------------------------
        NewSalesHeader.Init();
        NewSalesHeader.Validate("Document Type", NewSalesHeader."Document Type"::Quote); // La fattura prodforma di fatto è una offerta
        NewNo := NoSeriesMgt.GetNextNo('PROFORMA', 0D, false);
        NewSalesHeader.Validate("No.", NewNo);
        NewSalesHeader.Validate("No. Series", 'PROFORMA');
        NewSalesHeader."EOS Document Class Code" := 'PROFORMA';
        NewSalesHeader."XV Proforma Source" := PK;
        if IsValuta then begin
            NewSalesHeader.Validate("Currency Code", PostedShipment."Cod valuta proforma");
            if NewSalesHeader."Currency Code" = '' then
                NewSalesHeader."Currency Code" := PostedShipment."Cod valuta proforma";
            NewSalesHeader."Currency Factor" := FattoreValuta;
        end
        else
            NewSalesHeader.Validate("Currency Code", PostedShipment."Currency Code");
        NewSalesHeader.Validate("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        NewSalesHeader.Validate("Bill-to Customer No.", SalesHeader."Bill-to Customer No.");
        NewSalesHeader.Validate("Ship-to Code", SalesHeader."Ship-to Code");
        NewSalesHeader.Validate("Activity Code", SalesHeader."Activity Code");
        NewSalesHeader.Validate("Reason Code", SalesHeader."Reason Code");
        NewSalesHeader.Validate("Your Reference", SalesHeader."Your Reference");
        if Cust.Get(PostedShipment."Bill-to Customer No.") then
            IsForeign := Cust."Country/Region Code" <> 'IT';

        NewSalesHeader.Insert(true);

        //----------------------------------------------------
        // 5. Riga COMMENTO iniziale
        //----------------------------------------------------
        LineNo := 10000;

        NewSalesLine.Init();
        NewSalesLine.Validate("Document Type", NewSalesHeader."Document Type");
        NewSalesLine.Validate("Document No.", NewSalesHeader."No.");
        NewSalesLine.Validate("Line No.", LineNo);
        NewSalesLine.Type := NewSalesLine.Type::" ";
        if IsForeign then
            Stringa := 'Order ' + SalesHeader."No." + ' dated ' + Format(SalesHeader."Order Date", 0, '<Day,2>/<Month,2>/<Year4>')
        else
            Stringa := 'Ordine ' + SalesHeader."No." + ' del ' + Format(SalesHeader."Order Date", 0, '<Day,2>/<Month,2>/<Year4>');
        NewSalesLine.Validate(Description, Stringa);
        NewSalesLine.Insert(true);


        //----------------------------------------------------
        // Riga COMMENTO your ref
        //----------------------------------------------------
        if SalesHeader."Your Reference" <> '' then begin
            LineNo := 20000;

            NewSalesLine.Init();
            NewSalesLine.Validate("Document Type", NewSalesHeader."Document Type");
            NewSalesLine.Validate("Document No.", NewSalesHeader."No.");
            NewSalesLine.Validate("Line No.", LineNo);
            NewSalesLine.Type := NewSalesLine.Type::" ";
            if IsForeign then
                Stringa := 'Your ref. ' + SalesHeader."Your Reference"
            else
                Stringa := 'Vs Ref. ' + SalesHeader."Your Reference";
            NewSalesLine.Validate(Description, Stringa);

            NewSalesLine.Insert(true);
        end;

        LineNo += 10000;

        //----------------------------------------------------
        // 6. Copia righe ordine con conversione valuta
        //----------------------------------------------------
        SalesLine.Reset();
        //  SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", PostedShipment."No.");

        if SalesLine.FindSet() then
            repeat
                NewSalesLine.Init();
                NewSalesLine.Validate("Document Type", NewSalesHeader."Document Type");
                NewSalesLine.Validate("Document No.", NewSalesHeader."No.");
                NewSalesLine.Validate("Line No.", LineNo);
                NewSalesLine.TransferFields(SalesLine, false);
                // Conversione valuta
                if IsValuta then
                    if SalesLine."Unit Price" <> 0 then
                        NewSalesLine.Validate("Unit Price",
                                            Round(SalesLine."Unit Price" * FattoreValuta, 0.01, '>')
                                            )
                    else
                        NewSalesLine.Validate("Unit Price", Round(SalesLine."Unit Price"));
                NewSalesLine.Validate(Quantity, SalesLine.Quantity);
                NewSalesLine.Validate("Quantity Invoiced", SalesLine.Quantity);
                NewSalesLine.Validate("Qty. Invoiced (Base)", SalesLine.Quantity);
                NewSalesLine."xv Progressivo Kit Bus" := SalesLine."xv Progressivo Kit Bus";
                NewSalesLine."xv Kit Bus" := SalesLine."xv Kit Bus";
                NewSalesLine."xv Posizione Layout" := SalesLine."Posizione Layout";
                NewSalesLine."xv Nr Layout" := SalesLine."Nr. Layout";
                NewSalesLine."Qta. Origine layout" := SalesLine."Qta. Origine layout";

                NewSalesLine.Amount := NewSalesLine."Unit Price" * NewSalesLine.Quantity;
                //NewSalesLine."Service Tariff No." := SalesLine.;
                NewSalesLine.Insert(true);


                LineNo += 10000;

            until SalesLine.Next() = 0;

        //----------------------------------------------------
        // 7. Salvo numero proforma sulla spedizione
        //----------------------------------------------------
        PostedShipment.Validate("Nr fattura proforma", NewSalesHeader."No.");
        if IsValuta then PostedShipment."Cod valuta proforma" := NewSalesHeader."Currency Code";
        PostedShipment."Nr fattura proforma" := NewSalesHeader."No.";
        PostedShipment.Modify(true);
        SetShipLinesInvoiced(PostedShipment."No.");
        Commit();

        //----------------------------------------------------
        // 8. Messaggio e apertura
        //----------------------------------------------------
        Message('Proforma %1 creata correttamente.', NewSalesHeader."No.");


        PAGE.Run(PAGE::"Sales Quote", NewSalesHeader);
    end;


    procedure SetOrderLineInvoiced(DocNo: Code[20]; LineNo: Integer; QtyShipped: Decimal)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document No.", DocNo);
        SalesLine.SetRange("Line No.", LineNo);
        if SalesLine.FindSet(true) then
            repeat // è uno 
                SalesLine."Quantity Invoiced" := QtyShipped;
                SalesLine."Qty. Invoiced (Base)" := QtyShipped;
                SalesLine."Qty. Shipped Not Invoiced" := SalesLine."Qty. Shipped Not Invoiced" - QtyShipped;
                SalesLine."Qty. to Invoice" := SalesLine."Qty. to Invoice" - QtyShipped;
                SalesLine.Modify(true);
            until SalesLine.Next() = 0;
    end;


    procedure SetShipLinesInvoiced(DocNo: Code[20])
    var
        SalesShipLine: Record "Sales Shipment Line";
        QtyShipped: Decimal;
    begin
        SalesShipLine.Reset();
        SalesShipLine.SetRange("Document No.", DocNo);
        if SalesShipLine.FindSet() then
            repeat
                QtyShipped := SalesShipLine.Quantity;
                SalesShipLine."Qty. Invoiced (Base)" := QtyShipped;
                SalesShipLine."Quantity Invoiced" := QtyShipped;
                SalesShipLine."Qty. Shipped Not Invoiced" := 0;
                SalesShipLine.Modify(true);
                SetOrderLineInvoiced(SalesShipLine."Order No.", SalesShipLine."Order Line No.", QtyShipped);
            until SalesShipLine.Next() = 0;
    end;
}