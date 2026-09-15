namespace Xview.Custom.Lazzerini;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.Vendor;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Shipping;
using Microsoft.Bank.BankAccount;
using Microsoft.Foundation.Company;

report 50246 "XV Ordine Acquisto Kit Bus"
{
    Caption = 'XV Ordine Acquisto Kit Bus';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/XVShipmentKitBus_OrdineAcquisto_Empty.rdl';

    dataset
    {
        dataitem(Header; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));

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

            column(ShipToName; "Ship-to Name") { }
            column(ShipToName2; "Ship-to Name 2") { }
            column(ShipToAddress; "Ship-to Address") { }
            column(ShipToAddress2; "Ship-to Address 2") { }
            column(ShipToPostCode; "Ship-to Post Code") { }
            column(ShipToCity; "Ship-to City") { }
            column(ShipToCountryRegionCode; "Ship-to Country/Region Code") { }
            column(ShipToCountry; ShipToCountry) { }

            column(DocumentType; "Document Type") { }
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
            column(VendorVatRegistrationNo; VendorVatRegistrationNo) { }
            column(YourReference; "Your Reference") { }
            column(No_; "No.") { }
            column(DocumentDate; "Document Date") { }
            column(PaymentMethodCode; "Payment Method Code") { }
            column(PaymentMethodDescription; PaymentMethodDescription) { }
            column(PaymentMethodDisplay; PaymentMethodDisplay) { }
            column(PaymentTermsCode; "Payment Terms Code") { }
            column(BankAccountCode; "Bank Account") { }
            column(BankAccountName; BankAccountName) { }
            column(BankAccountIBAN; BankAccountIBAN) { }
            column(BankAccountDisplay; BankAccountDisplay) { }
            column(ShipmentMethodCode; "Shipment Method Code") { }
            column(ShipmentMethodDescription; ShipmentMethodDescription) { }
            column(LocationCode; "Location Code") { }
            column(CurrencyCode; "Currency Code") { }
            column(OrdinePilota; "Ordine Pilota") { }

            dataitem(Line; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                column(LineNo; "Line No.") { }
                column(LineDescription; Description) { }
                column(DrawingNo; "Drawing No.") { }
                column(DrawingRevision; "Drawing Revision") { }
                column(GeomRef; GeomRef) { }
                column(UnitOfMeasureCode; "Unit Of Measure Code") { }
                column(Quantity; Quantity) { }
                column(QtyToReceive; "Qty. to Receive") { }
                column(ExpectedReceiptDate; "Expected Receipt Date") { }
                column(DirectUnitCost; "Direct Unit Cost") { }
                column(Amount; Amount) { }
                column(VATBaseAmount; "VAT Base Amount") { }

                trigger OnAfterGetRecord()
                begin
                    // keep GeomRef as is (populate if present)
                end;
            }

            trigger OnPreDataItem()
            begin
                LoadCompanyData();
                Clear(DummyCompanyInfo.Picture);
                DummyCompanyInfo.Picture := CompanyInfo.Picture;
                Clear(VendorVatRegistrationNo);
                Clear(PaymentMethodDescription);
                Clear(PaymentMethodDisplay);
                Clear(BankAccountName);
                Clear(BankAccountIBAN);
                Clear(BankAccountDisplay);
                Clear(ShipmentMethodDescription);
                Clear(GeomRef);
            end;

            trigger OnAfterGetRecord()
            begin
                LoadVendorData("Buy-from Vendor No.");
                LoadPaymentMethodData("Payment Method Code");
                LoadBankAccountData("Buy-from Vendor No.", "Bank Account");
                LoadShipmentMethodData("Shipment Method Code");
                ShipToCountry := Format("Ship-to Country/Region Code");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }
    }

    var
        CompanyInfo: Record "Company Information";
        DummyCompanyInfo: Record "Company Information";
        VendorRec: Record Vendor;
        PaymentMethodRec: Record "Payment Method";
        BankAccountRec: Record "Vendor Bank Account";
        ShipmentMethodRec: Record "Shipment Method";
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

        BankAccountDisplay := CombineText(BankAccountName, BankAccountIBAN);
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

    trigger OnInitReport()
    begin
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
    end;
}