namespace Xview.Custom.Lazzerini;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Address;
using Microsoft.Sales.Customer;
using Microsoft.Utilities;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.UOM;
using Microsoft.Foundation.Shipping;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Sales.History;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Bank.BankAccount;
using Microsoft.Inventory.Intrastat;

report 50233 "XV Custom Sales - Shipment"

{
    Caption = 'XV Custom Sales - Shipment';
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    RDLCLayout = './ReportLayouts/XVShipmentKitBus.rdl';
    UsageCategory = None;

    dataset
    {
        dataitem(Header; "Sales Shipment Header")
        {
            column(EOSDocNo; "EOS Shipment No.") { }
            column(TipoDocumento; GetCustomLabel('Delivery Note')) { }

            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyAddress7; CompanyAddr[7])
            {
            }
            column(CompanyAddress8; CompanyAddr[8])
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPicture; DummyCompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl)
            {
            }
            column(CompanyCountry; XVUtil.GetCountry(CompanyInfo."Country/Region Code")) { }

            column(InvoiceTo1; Cust.Name) { }
            column(InvoiceTo2; Cust.Address) { }
            column(InvoiceTo3; Cust."Address 2") { }
            column(InvoiceTo4; Cust.City) { }
            column(InvoiceTo5; XVUtil.GetCountry(Cust."Country/Region Code")) { }

            column(CustomerAddress1; CustAddr[1])
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(CustomerAddress7; CustAddr[7])
            {
            }
            column(CustomerAddress8; CustAddr[8])
            {
            }
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            {
            }

            column(DocumentNo; "No.")
            {
            }
            column(BillPaytoAddress; "Bill-to Address")
            {
            }
            column(BillPaytoAddress2; "Bill-to Address 2")
            {
            }
            column(BillPaytoCity; "Bill-to City")
            {
            }
            column(BillPaytoContact; "Bill-to Contact")
            {
            }
            column(BillPaytoContactNo; "Bill-to Contact No.")
            {
            }
            column(BillPaytoCounty; "Bill-to County")
            {
            }
            column(BillPaytoName; "Bill-to Name")
            {
            }
            column(BillPaytoName2; "Bill-to Name 2")
            {
            }
            column(BillPaytoPostCode; "Bill-to Post Code")
            {
            }
            column(Customer_Id; Header."Sell-to Customer No.") { }
            column(CustomerVatNo; Cust."VAT Registration No.")
            {
            }
            column(CustomerPhoneNo; Cust."Phone No.")
            {
            }
            column(Comment; Comment)
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(LanguageCode; "Language Code")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(No; "No.")
            {
            }
            column(NoPrinted; "No. Printed")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(Packaging; ShipmentInfo[4])
            {
            }
            column(FreightType; GetTrasportType("Transport Method")) { }
            column(PostingDate; "Posting Date")
            {
            }
            column(PostingDescription; "Posting Description")
            {
            }
            column(ReasonCode; "Reason Code")
            {
            }
            column(ReasonDescription; GetReasonDescription("Reason Code"))
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(SalespersonCode; "Salesperson Code")
            {
            }
            column(ShiptoAddress; "Ship-to Address")
            {
            }
            column(ShiptoAddress2; "Ship-to Address 2")
            {
            }
            column(ShiptoCity; "Ship-to City")
            {
            }
            column(ShiptoCode; "Ship-to Code")
            {
            }
            column(ShiptoContact; "Ship-to Contact")
            {
            }
            column(ShiptoCountryRegionCode; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoCountry; XVUtil.GetCountry("Ship-to Country/Region Code"))
            {
            }
            column(ShiptoName; "Ship-to Name")
            {
            }
            column(ShiptoName2; "Ship-to Name 2")
            {
            }
            column(ShiptoPostCode; "Ship-to Post Code")
            {
            }
            column(ShipmentDate; "Shipment Date")
            {
            }
            column(ShipmentMethodCode; "Shipment Method Code")
            {
            }
            column(ShipmentMethodDescription; GetShipmentMethodDescription("Shipment Method Code"))
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(ShippingAgentServiceCode; "Shipping Agent Service Code")
            {
            }
            column(AdditionalNotes; GetNotes()) { }
            column(Forwarder; GetForwarder("Shipping Agent Code")) { }
            column(NrPackages; ShipmentInfo[1]) { }
            column(GrossWeight; ShipmentInfo[3]) { }
            column(NetWeight; ShipmentInfo[2]) { }
            column(EOSShippingStartingDateTime; GetShippingDateTime()) { }
            column(EOSNrShip; EOSShipHeader."Whse. Shipment No.") { }

            column(PiePag1_Lbl; GetCustomLabel('Pie di pagina 1'))
            {
            }
            column(PiePag2_Lbl; GetCustomLabel('Pie di pagina 2'))
            {
            }
            column(EORICode; Cust."EORI Number") { }
            column(XVOrderNoLbl; GetCustomLabel('Order No.')) { }
            column(XVOurCodeLbl; GetCustomLabel('Our Code No.')) { }
            column(XVCustomCodeLbl; GetCustomLabel('Custom Code No.')) { }
            column(XVDescItemLbl; GetCustomLabel('Description')) { }
            column(XVUomLbl; GetCustomLabel('UoM')) { }
            column(XVQtyLbl; GetCustomLabel('Q.ty')) { }
            column(XVUnitPriceLbl; GetCustomLabel('Unit Price')) { }
            column(XVAmountItemLbl; GetCustomLabel('Amount')) { }
            column(XVVatIdItemLbl; GetCustomLabel('VATId.')) { }
            column(XVGrossWeightLbl; GetCustomLabel('Gross Weight')) { }
            column(XVNetWeightLbl; GetCustomLabel('Net Weight')) { }
            column(XVCurrencyLbl; GetCustomLabel('Currency')) { }
            column(XVDeliveryTermsLbl; GetCustomLabel('Delivery Terms')) { }
            column(XVFreightLbl; GetCustomLabel('Freight')) { }
            column(XVShipTimeLbl; GetCustomLabel('Ship Time')) { }
            column(XVForwarderLbl; GetCustomLabel('Forwarder')) { }
            column(XVTotVatBaseLbl; GetCustomLabel('Total VAT Base')) { }
            column(XVVatTotalLbl; GetCustomLabel('Total VAT')) { }
            column(XVSignForwarderLbl; GetCustomLabel('Signature of forwarder')) { }
            column(XVSignDriverLbl; GetCustomLabel('Driver''s signature')) { }
            column(XVSignConsigneeLbl; GetCustomLabel('Consignee signature')) { }
            column(XVParcNoLbl; GetCustomLabel('Parc. No.')) { }
            column(XVCustomerIdLbl; GetCustomLabel('Customer ID')) { }
            column(XVPaymentTermsLbl; GetCustomLabel('Payment Terms')) { }
            column(XVBankAccountLbl; GetCustomLabel('Bank')) { }
            column(XVPackagingLbl; GetCustomLabel('Packaging')) { }
            column(XVEORILbl; GetCustomLabel('EORI Code')) { }
            column(XVTotalAmountLbl; GetCustomLabel('Total Amount')) { }
            column(XVNotesLbl; GetCustomLabel('Notes')) { }
            column(XVDeliveryLbl; GetCustomLabel('Delivery')) { }
            column(XVInvoiceToLbl; GetCustomLabel('Invoice To')) { }
            column(XVVatPercItemLbl; GetCustomLabel('VAT')) { }
            column(XVDeliveryDateLbl; GetCustomLabel('Delivery Date')) { }
            column(XVVatNoLbl; GetCustomLabel('VAT No.')) { }
            column(XVTelephoneNoLbl; GetCustomLabel('Telephone No.')) { }
            column(XVDeliveryNoteNoLbl; GetCustomLabel('Delivery Note No.')) { }
            column(XVDNDateLbl; GetCustomLabel('D.N. Date')) { }
            column(XVDeliveryReasonLbl; GetCustomLabel('Delivery Reason')) { }
            column(XVShipmentProvidedBy; GetCustomLabel('Shipment Provided By')) { }
            column(XVDateAndTimeLbl; GetCustomLabel('Date and Time')) { }
            column(XVDriverSSignatureLbl; GetCustomLabel('Driver''s Signature')) { }
            column(XVAddresseeSSignatureLbl; GetCustomLabel('Addressee''s Signature')) { }
            column(XVPaymentTerms; GetPaymentTerms()) { }

            column(IsKitBus; XVUtil.GetIsKitBus('DDT', DocNo)) { }

            dataitem(Line; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");// WHERE(Quantity = FILTER(> 0));


                column(LineNo_Line;
                "Line No.")
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(ItemReferenceNo_Line; "Item Reference No.")
                {
                }
                column(Description_Line; Description)
                {
                }
                column(Description_Line_Lbl; FieldCaption(Description))
                {
                }
                column(Quantity_Line; Format(Quantity, 0, 4))
                {
                }
                column(UnitOfMeasure; GetUOMText("Unit of Measure Code"))
                {
                }
                column(Kit_Bus_Desc; XVUtil.GetKitBusDescription("xv Kit Bus", "Description"))
                {
                }
                column(Kit_Bus; "xv Kit Bus") { }
                column(Progressivo_Kit_Bus; "xv Progressivo Kit Bus") { }
                column(Shipment_Date; "Shipment Date") { }

            }

            trigger OnPreDataItem()
            begin
                if DocNo <> '' then begin
                    SetRange("EOS Shipment No.", DocNo);
                    FindFirst(); // il rapporto dovrebbe essere uno a uno quindi questo non dovrebbe essere necessario ma non si sa mai
                end;

                FirstLineHasBeenOutput := false;
                DummyCompanyInfo.Picture := CompanyInfo.Picture;

            end;

            trigger OnAfterGetRecord()
            begin
                if FirstLineHasBeenOutput then
                    Clear(DummyCompanyInfo.Picture);
                Cust.Get(Header."Bill-to Customer No.");
                If EOSShipHeader.Get(Header."EOS Shipment No.") then;
                IsForeign := Cust."Country/Region Code" <> 'IT';
                XVUtil.GetInfoPackaging(Header."No.", ShipmentInfo, IsForeign);
                FormatAddressFields(Header);


            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Parameters)
                {
                    field("No."; DocNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Numero documento';
                        Editable = false;
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    var
        IsHandled: Boolean;
        test: Text[100];
    begin
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        test := CompanyInfo.Name;

        IsHandled := false;
    end;

    var
        DocNo: Code[20];

    var
        IsForeign: Boolean;
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        ShipmentInfo: array[4] of Text[100];
        FirstLineHasBeenOutput: Boolean;
        DummyCompanyInfo: Record "Company Information";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        EOSShipHeader: Record "EOS CWS Shipment Header";
        ShipmentMethod: Record "Shipment Method";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        CompanyInfoPhoneNoLbl: Label 'Phone No.';

    protected var
        XVUtil: Codeunit "XVUtil";
        CompanyInfo: Record "Company Information";

    local procedure FormatAddressFields(var ThisHeader: Record "Sales Shipment Header")
    begin
        FormatAddr.GetCompanyAddr(ThisHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.FormatAddr(
            CustAddr, Cust.Name, Cust."Name 2", Cust.Contact, Cust.Address, Cust."Address 2",
            Cust.City, Cust."Post Code", Cust.County, Cust."Country/Region Code"
            );

    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    local procedure GetCustomLabel(LabelName: Text): Text
    begin
        exit(Upper(XVUtil.GetCustomLabel(LabelName, IsForeign)));
    end;

    local procedure GetShipmentMethodDescription(ShipmentMethodCode: Code[10]): Text
    begin
        if not ShipmentMethod.Get(ShipmentMethodCode) then
            exit(ShipmentMethodCode);
        exit(ShipmentMethod.Description);
    end;

    local procedure GetForwarder(ShippingAgentCode: Code[10]): Text[100]
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        if ShippingAgent.Get(ShippingAgentCode) then
            exit(ShippingAgent.Name);
        exit('');
    end;

    local procedure GetReasonDescription(ReasonCode: Code[10]): Text
    var
        Reason: Record "Reason Code";
    begin
        if not Reason.Get(ReasonCode) then
            exit(ReasonCode);
        exit(Reason.Description);
    end;

    local procedure GetPaymentTerms(): Text[200]
    begin
        exit(XVUtil.GetPaymentMethodTerms(Header."Payment Method Code", Header."Payment Terms Code", IsForeign));
    end;

    local procedure GetShippingDateTime(): Text[30]
    begin
        exit(EOSShipHeader."Shipping Starting Date".ToText() + ' ' + EOSShipHeader."Shipping Starting Time".ToText());
    end;

    local procedure GetNotes(): Text[150]
    begin
        exit(EOSShipHeader."Shipping Notes" + ' ' + EOSShipHeader."Additional Notes");
    end;

    procedure GetTrasportType(Cod: Code[20]): Text[100]
    var
        Trasport: Record "Transport Method";
    begin
        if Trasport.Get(Cod) then
            exit(Trasport.Description);
        exit(Cod);
    end;

    procedure SetParameters(DocumentNo: Code[20])
    begin
        DocNo := DocumentNo;
    end;

    local procedure Upper(String: Text): Text
    begin
        exit(UpperCase(String));
    end;
}
