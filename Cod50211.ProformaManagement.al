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

    procedure CreateProformaFromShipment(var PostedShipment: Record "Sales Shipment Header")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        NewSalesHeader: Record "Sales Header";
        NewSalesLine: Record "Sales Line";
        NoSeriesMgt: Codeunit "No. Series";   // CORRETTO
        Currency: Record "Currency Exchange Rate";
        FattoreValuta: Decimal;
        LineNo: Integer;
        NewNo: Code[20];
    begin
        // 0. Blocco difensivo
        if PostedShipment."Nr fattura proforma" <> '' then
            Error('Esiste già una proforma associata: %1.', PostedShipment."Nr fattura proforma");

        // 1. Recupero ordine originale
        if not SalesHeader.Get(SalesHeader."Document Type"::Order, PostedShipment."Order No.") then
            Error('Impossibile recuperare l''ordine %1.', PostedShipment."Order No.");

        // 2. Recupero valuta proforma
        if PostedShipment."Cod valuta proforma" = '' then
            Error('Il campo "Cod valuta proforma" non è valorizzato.');

 //       if not Currency.Get(PostedShipment."Cod valuta proforma") then
 //           Error('La valuta %1 non esiste.', PostedShipment."Cod valuta proforma");
        
        FattoreValuta := Currency.GetCurrentCurrencyFactor(PostedShipment."Cod valuta proforma");
        if FattoreValuta = 0 then
            FattoreValuta := 1;

        //----------------------------------------------------
        // 3. Nuovo numero tramite no. series "VEND-PROF"
        //----------------------------------------------------

        //----------------------------------------------------
        // 4. Creo intestazione Proforma
        //----------------------------------------------------
        NewSalesHeader.Init();
        NewSalesHeader.Validate("Document Type", NewSalesHeader."Document Type"::Quote);
        NewNo := NoSeriesMgt.GetNextNo('PROFORMA', 0D, false);
        NewSalesHeader.Validate("No.", NewNo);
        NewSalesHeader.Validate("No. Series", 'PROFORMA');
        NewSalesHeader.Validate("Currency Code", PostedShipment."Cod valuta proforma");
//NewSalesHeader.Validate("No. Series", 'VEND-PROF');
        NewSalesHeader.Validate("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        NewSalesHeader.Validate("Bill-to Customer No.", SalesHeader."Bill-to Customer No.");
        NewSalesHeader.Validate("Ship-to Code", SalesHeader."Ship-to Code");

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
        NewSalesLine.Validate(Description, 'Riferimento ordine ' + SalesHeader."No.");
        NewSalesLine.Insert(true);

        LineNo += 10000;

        //----------------------------------------------------
        // 6. Copia righe ordine con conversione valuta
        //----------------------------------------------------
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", SalesHeader."No.");

        if SalesLine.FindSet() then
            repeat
                NewSalesLine.Init();
                NewSalesLine.Validate("Document Type", NewSalesHeader."Document Type");
                NewSalesLine.Validate("Document No.", NewSalesHeader."No.");
                NewSalesLine.Validate("Line No.", LineNo);

                NewSalesLine.TransferFields(SalesLine, false);

                // Conversione valuta
                if SalesLine."Unit Price" <> 0 then
                    NewSalesLine.Validate("Unit Price",
                        Round(SalesLine."Unit Price" * FattoreValuta, 0.01, '>'));

                NewSalesLine.Validate(Quantity, SalesLine.Quantity);

                NewSalesLine.Validate("Line Amount",
                    Round(NewSalesLine.Quantity * NewSalesLine."Unit Price", 0.01, '>'));

                NewSalesLine.Insert(true);

                LineNo += 10000;

            until SalesLine.Next() = 0;

        //----------------------------------------------------
        // 7. Salvo numero proforma sulla spedizione
        //----------------------------------------------------
        PostedShipment.Validate("Nr fattura proforma", NewSalesHeader."No.");
        PostedShipment."Cod valuta proforma" := NewSalesHeader."Currency Code";
        PostedShipment."Nr fattura proforma" := NewSalesHeader."No.";
        PostedShipment.Modify(true);
        Commit();
        //----------------------------------------------------
        // 8. Messaggio e apertura
        //----------------------------------------------------
        Message('Proforma %1 creata correttamente.', NewSalesHeader."No.");


        PAGE.Run(PAGE::"Sales Quote", NewSalesHeader);
    end;
}