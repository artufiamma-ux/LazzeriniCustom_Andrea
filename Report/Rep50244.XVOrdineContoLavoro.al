namespace Xview.Custom.Lazzerini;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.Vendor;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Shipping;
using Microsoft.Bank.BankAccount;
using Microsoft.Foundation.Company;
using Microsoft.Manufacturing.ProductionBOM;

report 50244 "XV Ordine Conto Lavoro"
{
    Caption = 'XV Ordine Conto Lavoro';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/XVOrdineContoLavoro.rdl';

    dataset
    {
        // Purchase Header - table 38
        dataitem(Header; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.";

            // Company banner (used by report layout header)
            column(CompanyAddress1; CompanyAddress[1]) { }
            column(CompanyAddress2; CompanyAddress[2]) { }
            column(CompanyAddress3; CompanyAddress[3]) { }
            column(CompanyAddress4; CompanyAddress[4]) { }
            column(CompanyAddress5; CompanyAddress[5]) { }
            column(CompanyAddress6; CompanyAddress[6]) { }
            column(CompanyAddress7; CompanyAddress[7]) { }
            column(CompanyAddress8; CompanyAddress[8]) { }
            column(CompanyCountry; CompanyCountry) { }
            column(CompanyHomePage; CompanyInfo."Home Page") { }
            column(CompanyEMail; CompanyInfo."E-Mail") { }
            column(CompanyPicture; DummyCompanyInfo.Picture) { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyFaxNo; CompanyInfo."Fax No.") { }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber()) { }
            column(CompanyRegistrationNo; CompanyInfo.GetRegistrationNumber()) { }

            // Ship-to box (used by report layout header)
            column(ShipToName; "Ship-to Name") { }
            column(ShipToName2; "Ship-to Name 2") { }
            column(ShipToAddress; "Ship-to Address") { }
            column(ShipToAddress2; "Ship-to Address 2") { }
            column(ShipToPostCode; "Ship-to Post Code") { }
            column(ShipToCity; "Ship-to City") { }
            column(ShipToCountryRegionCode; "Ship-to Country/Region Code") { }
            column(ShipToCountry; ShipToCountry) { }

            column(DocumentType; "Document Type") { }

            // Codice fornitore -> Purchase Header."Buy-from Vendor No." (id 2)
            column(BuyFromVendorNo; "Buy-from Vendor No.") { }
            column(BuyFromVendorName; BuyFromVendorName) { }
            column(BuyFromAddress1; BuyFromAddress[1]) { }
            column(BuyFromAddress2; BuyFromAddress[2]) { }
            column(BuyFromAddress3; BuyFromAddress[3]) { }
            column(BuyFromAddress4; BuyFromAddress[4]) { }
            column(BuyFromPostCode; BuyFromPostCode) { }
            column(BuyFromCity; BuyFromCity) { }
            column(BuyFromCountry; BuyFromCountry) { }
            column(BuyFromPhoneNo; BuyFromPhoneNo) { }
            column(BuyFromFaxNo; BuyFromFaxNo) { }

            // Partita IVA / codice fiscale -> Vendor."VAT Registration No." (table 23, id 86)
            column(VendorVatRegistrationNo; VendorVatRegistrationNo) { }

            // Vs. ordine -> Purchase Header."Your Reference" (id 11)
            column(YourReference; "Your Reference") { }

            // Nr. ordine -> Purchase Header."No." (id 3)
            column(No_; "No.") { }

            // Data ordine -> Purchase Header."Document Date" (id 99)
            column(DocumentDate; "Document Date") { }

            // Codice e descrizione pagamento -> Purchase Header."Payment Method Code" (id 104) + Payment Method.Description
            column(PaymentMethodCode; "Payment Method Code") { }
            column(PaymentMethodDescription; PaymentMethodDescription) { }
            column(PaymentMethodDisplay; PaymentMethodDisplay) { }

            // Codici condizione pagamento -> Purchase Header."Payment Terms Code" (id 23)
            column(PaymentTermsCode; "Payment Terms Code") { }

            // Banca d'appoggio -> Purchase Header."Bank Account" (id 12172) + Vendor Bank Account.Name (id 3) / .IBAN (id 24)
            column(BankAccountCode; "Bank Account") { }
            column(BankAccountName; BankAccountName) { }
            column(BankAccountIBAN; BankAccountIBAN) { }
            column(BankAccountDisplay; BankAccountDisplay) { }

            // Resa -> Purchase Header."Shipment Method Code" (id 27) + Shipment Method.Description (table 10, id 2)
            column(ShipmentMethodCode; "Shipment Method Code") { }
            column(ShipmentMethodDescription; ShipmentMethodDescription) { }

            // Magazzino -> Purchase Header."Location Code" (id 28)
            column(LocationCode; "Location Code") { }

            // Valuta -> Purchase Header."Currency Code" (id 32)
            column(CurrencyCode; CurrencyCodeDisplay) { }

            // C/Lavoro -> Purchase Header."Subcontracting Order" (standard boolean field)
            column(SubcontractingOrder; SubcontractingOrderFlag) { }

            // Purchase Line - table 39
            dataitem(Line; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                // Nr. -> Purchase Line."No." (id 6)
                column(LineNo; "No.") { }
                // Descrizione -> Purchase Line.Description (id 11)
                column(LineDescription; Description) { }
                // Dis. -> Purchase Line."Drawing No." (custom field id 50201)
                column(DrawingNo; "Drawing No.") { }
                // Rev. -> Purchase Line."Drawing Revision" (custom field id 50203)
                column(DrawingRevision; "Drawing Revision") { }
                // Rif. Geom. -> nessun campo tecnico definito, riservato per uso futuro
                column(GeomRef; GeomRef) { }
                // UDM -> Purchase Line."Unit of Measure Code" (id 5407)
                column(UnitOfMeasureCode; "Unit of Measure Code") { }
                // Q.tà -> Purchase Line.Quantity (id 15)
                column(Quantity; Quantity) { }
                // Q.tà da ricevere -> Purchase Line."Qty. to Receive" (id 18)
                column(QtyToReceive; "Qty. to Receive") { }
                // Data ricev. -> Purchase Line."Expected Receipt Date" (id 10)
                column(ExpectedReceiptDate; "Expected Receipt Date") { }
                // Prezzo -> Purchase Line."Direct Unit Cost" (id 22)
                column(DirectUnitCost; "Direct Unit Cost") { }
                // Importo -> Purchase Line.Amount (id 29)
                column(Amount; Amount) { }
                column(VATBaseAmount; "VAT Base Amount") { }

                // Sezione "Lavorazioni da eseguire": componenti della Distinta Base di Produzione
                // dell'articolo indicato nella riga (Purchase Line."No." - id 6)
                dataitem(Item; Item)
                {
                    // Item - table 27
                    DataItemLink = "No." = field("No.");

                    column(ItemNo; "No.") { }
                    column(ItemDescription; Description) { }
                    // Testata DB produzione -> Item."Production BOM No." (id 99000751)
                    column(ItemProductionBOMNo; "Production BOM No.") { }

                    dataitem(ProdBOMLine; "Production BOM Line")
                    {
                        // Production BOM Line - table 99000772
                        DataItemLink = "Production BOM No." = field("Production BOM No.");
                        DataItemTableView = sorting("Line No.");

                        // Articoli componenti della DB Produzione -> Production BOM Line."No." (id 11)
                        column(ProdCompNo; "No.") { }
                        column(ProdCompDescription; Description) { }
                        column(ProdCompQty; Quantity) { }
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    GeomRef := '';
                end;
            }

            trigger OnPreDataItem()
            begin
                LoadCompanyData();
                Clear(DummyCompanyInfo.Picture);
                CompanyInfo.CalcFields(Picture);
                DummyCompanyInfo.Picture := CompanyInfo.Picture;
                Clear(VendorVatRegistrationNo);
                Clear(PaymentMethodDescription);
                Clear(PaymentMethodDisplay);
                Clear(BankAccountName);
                Clear(BankAccountIBAN);
                Clear(BankAccountDisplay);
                Clear(ShipmentMethodDescription);
                Clear(GeomRef);
                SubcontractingOrderFlag := false;
                CurrencyCodeDisplay := 'EUR';
            end;

            trigger OnAfterGetRecord()
            begin
                LoadVendorData("Buy-from Vendor No.");
                LoadPaymentMethodData("Payment Method Code");
                LoadBankAccountData("Buy-from Vendor No.", "Bank Account");
                LoadShipmentMethodData("Shipment Method Code");
                ShipToCountry := Format("Ship-to Country/Region Code");
                SubcontractingOrderFlag := HasSubcontractingOrder("No.");
                if "Currency Code" <> '' then
                    CurrencyCodeDisplay := "Currency Code"
                else
                    CurrencyCodeDisplay := 'EUR';
            end;
        }
    }


    var
        CompanyInfo: Record "Company Information";
        DummyCompanyInfo: Record "Company Information";
        VendorRec: Record Vendor;
        PaymentMethodRec: Record "Payment Method";
        BankAccountRec: Record "Vendor Bank Account";
        ShipmentMethodRec: Record "Shipment Method";
        PurchaseLineRec: Record "Purchase Line";
        CompanyAddress: array[8] of Text[100];
        BuyFromAddress: array[4] of Text[100];
        CompanyCountry: Text[50];
        CompanyFaxNo: Text[30];
        ShipToCountry: Text[50];
        BuyFromVendorName: Text[100];
        BuyFromPostCode: Text[20];
        BuyFromCity: Text[50];
        BuyFromCountry: Text[50];
        BuyFromPhoneNo: Text[30];
        BuyFromFaxNo: Text[30];
        VendorVatRegistrationNo: Text[50];
        PaymentMethodDescription: Text[100];
        PaymentMethodDisplay: Text[200];
        BankAccountName: Text[100];
        BankAccountIBAN: Text[50];
        BankAccountDisplay: Text[200];
        ShipmentMethodDescription: Text[100];
        GeomRef: Text[50];
        SubcontractingOrderFlag: Boolean;
        CurrencyCodeDisplay: Text[10];

    local procedure LoadCompanyData()
    begin
        if not CompanyInfo.Get() then
            exit;

        CompanyAddress[1] := CompanyInfo.Name;
        CompanyAddress[2] := CompanyInfo.Address;
        CompanyAddress[3] := CompanyInfo."Address 2";
        CompanyAddress[4] := StrSubstNo('%1 %2 %3', CompanyInfo."Post Code", CompanyInfo.City, CompanyInfo.County);
        CompanyAddress[5] := Format(CompanyInfo."Country/Region Code");
        CompanyAddress[6] := CompanyInfo."Phone No.";
        CompanyAddress[7] := CompanyInfo."E-Mail";
        CompanyAddress[8] := CompanyInfo."Home Page";
        CompanyCountry := Format(CompanyInfo."Country/Region Code");
        CompanyFaxNo := CompanyInfo."Fax No.";
    end;

    local procedure LoadVendorData(VendorNo: Code[20])
    begin
        Clear(VendorVatRegistrationNo);
        Clear(BuyFromVendorName);
        Clear(BuyFromAddress[1]);
        Clear(BuyFromAddress[2]);
        Clear(BuyFromAddress[3]);
        Clear(BuyFromAddress[4]);
        Clear(BuyFromPostCode);
        Clear(BuyFromCity);
        Clear(BuyFromCountry);
        Clear(BuyFromPhoneNo);
        Clear(BuyFromFaxNo);

        if VendorRec.Get(VendorNo) then begin
            BuyFromVendorName := VendorRec.Name;
            BuyFromAddress[1] := VendorRec.Address;
            BuyFromAddress[2] := VendorRec."Address 2";
            BuyFromPostCode := VendorRec."Post Code";
            BuyFromCity := VendorRec.City;
            BuyFromCountry := Format(VendorRec."Country/Region Code");
            VendorVatRegistrationNo := VendorRec."VAT Registration No.";
            BuyFromPhoneNo := VendorRec."Phone No.";
            BuyFromFaxNo := VendorRec."Fax No.";
        end;
    end;

        local procedure HasSubcontractingOrder(PurchaseOrderNo: Code[20]): Boolean
        begin
            PurchaseLineRec.Reset();
            PurchaseLineRec.SetRange("Document Type", PurchaseLineRec."Document Type"::Order);
            PurchaseLineRec.SetRange("Document No.", PurchaseOrderNo);
            PurchaseLineRec.SetFilter("Prod. Order No.", '<>%1', '');

            exit(not PurchaseLineRec.IsEmpty());
        end;
    local procedure LoadPaymentMethodData(PaymentMethodCode: Code[10])
    begin
        Clear(PaymentMethodDescription);
        Clear(PaymentMethodDisplay);

        if PaymentMethodCode = '' then
            exit;

        if PaymentMethodRec.Get(PaymentMethodCode) then
            PaymentMethodDescription := PaymentMethodRec.Description;

        PaymentMethodDisplay := CombineText(PaymentMethodCode, PaymentMethodDescription);
    end;

    local procedure LoadBankAccountData(VendorNo: Code[20]; BankAccountCode: Code[20])
    begin
        Clear(BankAccountName);
        Clear(BankAccountIBAN);
        Clear(BankAccountDisplay);

        if BankAccountCode = '' then
            exit;

        BankAccountRec.Reset();
        BankAccountRec.SetRange("Vendor No.", VendorNo);
        BankAccountRec.SetRange(Code, BankAccountCode);
        if BankAccountRec.FindFirst() then begin
            BankAccountName := BankAccountRec.Name;
            BankAccountIBAN := BankAccountRec.IBAN;
        end;

        BankAccountDisplay := CombineText(BankAccountIBAN, BankAccountName);
    end;

    local procedure LoadShipmentMethodData(ShipmentMethodCode: Code[10])
    begin
        Clear(ShipmentMethodDescription);

        if ShipmentMethodCode = '' then
            exit;

        if ShipmentMethodRec.Get(ShipmentMethodCode) then
            ShipmentMethodDescription := ShipmentMethodRec.Description;
    end;

    local procedure CombineText(FirstValue: Text; SecondValue: Text): Text
    begin
        if (FirstValue = '') and (SecondValue = '') then
            exit('');

        if FirstValue = '' then
            exit(SecondValue);

        if SecondValue = '' then
            exit(FirstValue);

        exit(FirstValue + ' - ' + SecondValue);
    end;
}