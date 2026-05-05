namespace Lazzerini;

using System.Security.User;
using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.Assembly.Document;
using Microsoft.Bank.BankAccount;
using Microsoft.CRM.Contact;
using Microsoft.CRM.Interaction;
using Microsoft.CRM.Segment;
using Microsoft.CRM.Team;
using Microsoft.Finance.Currency;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Finance.VAT.Clause;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Reporting;
using Microsoft.Foundation.Shipping;
using Microsoft.Foundation.UOM;
using Microsoft.Inventory.Location;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Posting;
using Microsoft.Sales.Setup;
using Microsoft.Utilities;
using System.Email;
using System.Globalization;
using System.Text;
using System.Utilities;

report 50232 "XV Custom Sales Order"
{
    Caption = 'XV Sales - Kit Bus';
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    RDLCLayout = './ReportLayouts/XVOrdineKitBus.rdl';
    UsageCategory = None;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("No.");
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
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoLbl)
            {
            }
            column(CompanyBankName; CompanyBankAccount.Name)
            {
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameLbl)
            {
            }
            column(CompanyBankBranchNo; CompanyBankAccount."Bank Branch No.")
            {
            }
            column(CompanyBankBranchNo_Lbl; CompanyBankAccount.FieldCaption("Bank Branch No."))
            {
            }
            column(CompanyBankAccountNo; CompanyBankAccount."Bank Account No.")
            {
            }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoLbl)
            {
            }
            column(CompanyIBAN; CompanyBankAccount.IBAN)
            {
            }
            column(CompanyIBAN_Lbl; CompanyBankAccount.FieldCaption(IBAN))
            {
            }
            column(CompanySWIFT; CompanyBankAccount."SWIFT Code")
            {
            }
            column(CompanySWIFT_Lbl; CompanyBankAccount.FieldCaption("SWIFT Code"))
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber())
            {
            }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl())
            {
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber())
            {
            }
            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl())
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber())
            {
            }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl())
            {
            }
            column(CompanyLegalOffice; LegalOfficeTxt)
            {
            }
            column(CompanyLegalOffice_Lbl; LegalOfficeLbl)
            {
            }
            column(CompanyCustomGiro; CustomGiroTxt)
            {
            }
            column(CompanyCustomGiro_Lbl; CustomGiroLbl)
            {
            }
            column(CompanyLegalStatement; LegalStatementLbl)
            {
            }
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
            column(SellToContactPhoneNoLbl; SellToContactPhoneNoLbl)
            {
            }
            column(SellToContactMobilePhoneNoLbl; SellToContactMobilePhoneNoLbl)
            {
            }
            column(SellToContactEmailLbl; SellToContactEmailLbl)
            {
            }
            column(BillToContactPhoneNoLbl; BillToContactPhoneNoLbl)
            {
            }
            column(BillToContactMobilePhoneNoLbl; BillToContactMobilePhoneNoLbl)
            {
            }
            column(BillToContactEmailLbl; BillToContactEmailLbl)
            {
            }
            column(SellToContactPhoneNo; SellToContact."Phone No.")
            {
            }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.")
            {
            }
            column(SellToContactEmail; SellToContact."E-Mail")
            {
            }
            column(BillToContactPhoneNo; BillToContact."Phone No.")
            {
            }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
            {
            }
            column(BillToContactEmail; BillToContact."E-Mail")
            {
            }
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(YourReference_Lbl; FieldCaption("Your Reference"))
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
            {
            }
            column(Shipment_Lbl; ShipmentLbl)
            {
            }
            column(ShipmentDate; Format("Shipment Date", 0, 4))
            {
            }
            column(ShipmentDate_Lbl; FieldCaption("Shipment Date"))
            {
            }
            column(ShowShippingAddress; ShowShippingAddr)
            {
            }
            column(ShipToAddress_Lbl; ShiptoAddrLbl)
            {
            }
            column(ShipToAddress1; ShipToAddr[1])
            {
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
            }
            column(ShipToPhoneNo; Header."Ship-to Phone No.")
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(PaymentMethodDescription_Lbl; PaymentMethodDescLbl)
            {
            }
            column(DocumentCopyText; StrSubstNo(DocumentCaption(), CopyText))
            {
            }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustomerNo_Lbl; FieldCaption("Bill-to Customer No."))
            {
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(DocumentDate_Lbl; FieldCaption("Document Date"))
            {
            }
            column(DueDate; Format("Due Date", 0, 4))
            {
            }
            column(DueDate_Lbl; FieldCaption("Due Date"))
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(DocumentNo_Lbl; GetCustomLabel(InvNoLbl))
            {
            }
            column(QuoteNo; "Quote No.")
            {
            }
            column(QuoteNo_Lbl; FieldCaption("Quote No."))
            {
            }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PricesIncludingVAT_Lbl; FieldCaption("Prices Including VAT"))
            {
            }
            column(PricesIncludingVATYesNo; Format("Prices Including VAT"))
            {
            }
            column(SalesPerson_Lbl; SalespersonLbl)
            {
            }
            column(SalesPersonText_Lbl; SalesPersonText)
            {
            }
            column(SalesPersonName; SalespersonPurchaser.Name)
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerNo_Lbl; FieldCaption("Sell-to Customer No."))
            {
            }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber())
            {
            }
            column(VATRegistrationNo_Lbl; GetCustomerVATRegistrationNumberLbl())
            {
            }
#if not CLEAN25
            column(GlobalLocationNumber; '')
            {
                ObsoleteState = Pending;
                ObsoleteReason = 'Not in use anymore.';
                ObsoleteTag = '25.0';
            }
            column(GlobalLocationNumber_Lbl; '')
            {
                ObsoleteState = Pending;
                ObsoleteReason = 'Not in use anymore.';
                ObsoleteTag = '25.0';
            }
#endif
            column(SellToFaxNo; '')
            {
            }
            column(SellToPhoneNo; "Sell-to Phone No.")
            {
            }
            column(LegalEntityType; Cust.GetLegalEntityType())
            {
            }
            column(LegalEntityType_Lbl; Cust.GetLegalEntityTypeLbl())
            {
            }
            column(Copy_Lbl; CopyLbl)
            {
            }
            column(EMail_Lbl; EMailLbl)
            {
            }
            column(HomePage_Lbl; HomePageLbl)
            {
            }
            column(InvoiceDiscountBaseAmount_Lbl; InvDiscBaseAmtLbl)
            {
            }
            column(InvoiceDiscountAmount_Lbl; InvDiscountAmtLbl)
            {
            }
            column(LineAmountAfterInvoiceDiscount_Lbl; LineAmtAfterInvDiscLbl)
            {
            }
            column(LocalCurrency_Lbl; LocalCurrencyLbl)
            {
            }
            column(CurrencyLbl; "Currency Code") { }
            column(ExchangeRateAsText; ExchangeRateText)
            {
            }
            column(Page_Lbl; PageLbl)
            {
            }
            column(SalesInvoiceLineDiscount_Lbl; SalesInvLineDiscLbl)
            {
            }
            column(Invoice_Lbl; SalesConfirmationLbl)
            {
            }
            column(Subtotal_Lbl; SubtotalLbl)
            {
            }
            column(Total_Lbl; TotalLbl)
            {
            }
            column(VATAmount_Lbl; VATAmtLbl)
            {
            }
            column(VATBase_Lbl; VATBaseLbl)
            {
            }
            column(VATAmountSpecification_Lbl; VATAmtSpecificationLbl)
            {
            }
            column(VATClauses_Lbl; VATClausesLbl)
            {
            }
            column(VATIdentifier_Lbl; VATIdentifierLbl)
            {
            }
            column(VATPercentage_Lbl; VATPercentageLbl)
            {
            }
            column(VATClause_Lbl; VATClause.TableCaption())
            {
            }
            column(ExtDocNo_SalesHeader; "External Document No.")
            {
            }
            column(ExtDocNo_SalesHeader_Lbl; FieldCaption("External Document No."))
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            column(sender; GetCustomLabel('sender'))
            {
            }
            column(TipoDocumento; GetCustomLabel('ORDER CONFIRMATION')) { }
            column(IsKitBus; XVUtil.GetIsKitBus('ORDINE', DocNo)) { }

            column(PiePag1_Lbl; GetCustomLabel('Pie di pagina 1'))
            {
            }
            column(PiePag2_Lbl; GetCustomLabel('Pie di pagina 2'))
            {
            }
            column(XVNote; GetNote())
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
            column(XVForwarder1Lbl; GetCustomLabel('Forwarder 1')) { }
            column(XVForwarder2Lbl; GetCustomLabel('Forwarder 2')) { }
            column(XVDateAndTimeLbl; GetCustomLabel('Date and Time')) { }


            column(XVReferenteNome; ReferenteNome) { }
            column(XVReferenteEmail; ReferenteEmail) { }
            column(XVReferenteTelefono; ReferenteTelefono) { }
            column(XVReferenteFax; ReferenteFax) { }
            column(XVBankAccount; GetBankAccount("Company Bank Account Code")) { }
            column(XVIsForeign; IsForeign) { }
            column(Forwarder; GetForwarder("Shipping Agent Code")) { }
            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
                column(LineNo; "Line No.")
                {
                }
                column(Item_No; "No.")
                {
                }
                column(Item_Reference_No; "Item Reference No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Description_Line_Lbl; FieldCaption(Description))
                {
                }
                column(Quantity; Format(Quantity, 0, 4))
                {
                }
                column(UnitOfMeasure; GetUOMText("Unit of Measure Code"))
                {
                }
                column(UnitPrice; Format("Unit Price", 0, 4))
                {
                }
                column(LineAmount; Format("Line Amount", 0, 4))
                {
                }
                column(DiscountPct; Format("Line Discount %", 0, 2))
                {
                }
                column(VATPercentage; Format("VAT %", 0, 2))
                {
                }
                column(Kit_Bus_Desc; XVUtil.GetKitBusDescription("xv Kit Bus", "Description"))
                {
                }
                column(xv_Kit_Bus; "xv Kit Bus") { }
                column(xv_Progressivo_Kit_Bus; "xv Progressivo Kit Bus") { }
                column(Shipment_Date; "Shipment Date") { }
            }
            trigger OnAfterGetRecord()
            var
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                Currency: Record Currency;
                GeneralLedgerSetup: Record "General Ledger Setup";
                SalespersonPurchaser: Record "Salesperson/Purchaser";
                //ArchiveManagement: Codeunit ArchiveManagement;
                SalesPost: Codeunit "Sales-Post";
                UserMgt: Codeunit "User Management";

                UserDetails: Record "User Details";
                UserSetup: Record "User Setup";
                UserGuid: Guid;
                uid: Text[50];

            begin
                if FirstLineHasBeenOutput then
                    Clear(DummyCompanyInfo.Picture);
                FirstLineHasBeenOutput := true;


                //               SalesPost.GetSalesLines(Header, Line, 0, false);

                if not IsReportInPreviewMode() then
                    CODEUNIT.Run(CODEUNIT::"Sales-Printed", Header);


                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                CurrReport.FormatRegion := LanguageMgt.GetFormatRegionOrDefault("Format Region");
                FormatAddr.SetLanguageCode("Language Code");

                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;

                FormatAddr.GetCompanyAddr("Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
                FormatAddr.SalesHeaderBillTo(CustAddr, Header);
                ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, Header);

                if not CompanyBankAccount.Get(Header."Company Bank Account Code") then
                    CompanyBankAccount.CopyBankFieldsFromCompanyInfo(CompanyInfo);


                if Cust.Get("Sell-to Customer No.") then
                    IsForeign := Cust."Country/Region Code" <> 'IT'
                else
                    IsForeign := false;

                if "Currency Code" = '' then
                    if GeneralLedgerSetup.Get() then begin
                        CurrCode := GeneralLedgerSetup."LCY Code";
                        CurrSymbol := GeneralLedgerSetup.GetCurrencySymbol();
                    end;

                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;


                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                TotalPaymentDiscOnVAT := 0;

                // Aggiunta per il referente interno

                Clear(ReferenteNome);
                Clear(ReferenteEmail);
                Clear(ReferenteTelefono);
                Clear(ReferenteFax);

                //               UserGuid := UserSecurityId();
                uid := UserId();
                if UserSetup.Get(uid) then begin
                    ReferenteNome := UserSetup."User ID";
                    if UserSetup."E-Mail" <> '' then
                        ReferenteEmail := UserSetup."E-Mail";

                    if UserSetup."Phone No." <> '' then
                        ReferenteTelefono := UserSetup."Phone No.";
                    ReferenteFax := ''; // se esiste (standard o custom)
                end;

            end;

            trigger OnPreDataItem()
            begin
                FirstLineHasBeenOutput := false;
                DummyCompanyInfo.Picture := CompanyInfo.Picture;

                if DocNo <> '' then
                    SetRange("No.", DocNo);

            end;

        }
    }

    requestpage
    {
        SaveValues = true;

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


    labels
    {
    }

    trigger OnInitReport()
    var
        SalesHeader: Record "Sales Header";
        IsHandled: Boolean;
    begin
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo();

        if SalesHeader.GetLegalStatement() <> '' then
            LegalStatementLbl := SalesHeader.GetLegalStatement();

        IsHandled := false;
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if Header.FindSet() then
                repeat
                    Header.CalcFields("No. of Archived Versions");
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          3, Header."No.", Header."Doc. No. Occurrence",
                          Header."No. of Archived Versions", DATABASE::Contact, Header."Bill-to Contact No."
                          , Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", Header."Opportunity No.")
                    else
                        SegManagement.LogDocument(
                          3, Header."No.", Header."Doc. No. Occurrence",
                          Header."No. of Archived Versions", DATABASE::Customer, Header."Bill-to Customer No.",
                          Header."Salesperson Code", Header."Campaign No.", Header."Posting Description", Header."Opportunity No.");

                until Header.Next() = 0;
    end;

    trigger OnPreReport()
    begin


        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var
        GLSetup: Record "General Ledger Setup";
        DummyCompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        AsmHeader: Record "Assembly Header";
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        LanguageMgt: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        AutoFormat: Codeunit "Auto Format";
        WorkDescriptionInstream: InStream;
        MoreLines: Boolean;
        CopyText: Text[30];
        TransHeaderAmount: Decimal;
        LogInteractionEnable: Boolean;
        AsmInfoExistsForLine: Boolean;
        CompanyLogoPosition: Integer;
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        VATClauseText: Text;
        PrevLineAmount: Decimal;
        PmtDiscText: Text;
        ShowWorkDescription: Boolean;
        WorkDescriptionLine: Text;
        CompanyInfoBankAccNoLbl: Label 'Account No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CopyLbl: Label 'Copy';
        EMailLbl: Label 'Email';
        HomePageLbl: Label 'Home Page';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'Order No.';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        PageLbl: Label 'Page';
        PostedShipmentDateLbl: Label 'Shipment Date';
        ShipmentLbl: Label 'Shipment';
        ShiptoAddrLbl: Label 'Ship-to Address';
        SubtotalLbl: Label 'Subtotal';
        TotalLbl: Label 'Total';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification';
        VATAmtLbl: Label 'VAT Amount';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)';
        VATBaseLbl: Label 'VAT Base';
        VATBaseLCYLbl: Label 'VAT Base (LCY)';
        VATClausesLbl: Label 'VAT Clause';
        VATIdentifierLbl: Label 'VAT Identifier';
        VATPercentageLbl: Label 'VAT %';
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidentally printing all documents.';
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a %2% payment discount.', Comment = '%1 Discount Due Date %2 = value of Payment Discount % ';
        BodyLbl: Label 'Thank you for your business. Your order confirmation is attached to this message.';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        LCYTxt: label ' (LCY)';
        LegalOfficeTxt, LegalOfficeLbl, CustomGiroTxt, CustomGiroLbl, LegalStatementLbl : Text;
        IsForeign: Boolean;
        ReferenteNome: Text[100];
        ReferenteEmail: Text[80];
        ReferenteTelefono: Text[30];
        ReferenteFax: Text[30];

    protected var
        XVUtil: Codeunit XVUtil;
        CompanyInfo: Record "Company Information";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        CompanyBankAccount: Record "Bank Account";
        VATClause: Record "VAT Clause";
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        //       ArchiveDocument: Boolean;
        DisplayAssemblyInformation: Boolean;
        LogInteraction: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        FirstLineHasBeenOutput: Boolean;
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        CurrCode: Text[10];
        CurrSymbol: Text[10];
        FormattedLineAmount: Text;
        FormattedQuantity: Text;
        FormattedUnitPrice: Text;
        FormattedVATPct: Text;
        LineDiscountPctText: Text;
        SalesPersonText: Text[50];
        ShowShippingAddr: Boolean;
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        PaymentTermsDescLbl: Label 'Payment Terms';
        PaymentMethodDescLbl: Label 'Payment Method';
        SalesConfirmationLbl: Label 'Order Confirmation';
        SalesInvLineDiscLbl: Label 'Discount %';
        SalespersonLbl: Label 'Sales person';
        ShptMethodDescLbl: Label 'Shipment Method';

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Ord. Cnfrmn.") <> '';
    end;

    local procedure DocumentCaption() DocCaption: Text[250]
    begin
        DocCaption := SalesConfirmationLbl;

    end;

    procedure InitializeRequest(NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    protected procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview() or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        FormatDocument.SetTotalLabels(SalesHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesHeader."Payment Method Code", SalesHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");

    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    var
        DocNo: Code[20];

    procedure SetParameters(DocumentNo: Code[20])
    begin
        DocNo := DocumentNo;
    end;

    local procedure GetBankAccount(CompanyBankAccountCode: Code[20]): Text[100]
    var
        BankAccount: Record "Bank Account";
    begin
        if BankAccount.Get(CompanyBankAccountCode) then
            exit('IBAN: ' + BankAccount.IBAN + ' SWIFT CODE: ' + BankAccount."SWIFT Code")
        else begin
            CompanyBankAccountCode := Header."EOS Our Bank Account";
            if BankAccount.Get(CompanyBankAccountCode) then
                exit('IBAN: ' + BankAccount.IBAN + ' SWIFT CODE: ' + BankAccount."SWIFT Code");
        end;
        exit('');
    end;

    local procedure GetEORICode(SellToCustomerNo: Code[20]): Code[50]
    var
        Customer: Record Customer;
    begin
        if Customer.Get(SellToCustomerNo) then
            exit(Customer."Codice EORI");
        exit('');
    end;

    local procedure GetForwarder(ShippingAgentCode: Code[10]): Text[100]
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        if ShippingAgent.Get(ShippingAgentCode) then
            exit(ShippingAgent.Name);
        exit('');
    end;

    local procedure GetCustomLabel(LabelName: Text): Text
    begin
        exit(XVUtil.GetCustomLabel(LabelName, IsForeign));
    end;

    local procedure GetNote(): Text[1000]
    var
        XVNote: Text[1000];
        ShippingNo: Code[20];
        ShipmentHeader: Record "Sales Shipment Header";

    begin

        XVNote := Header."Additional Notes";
        if ShipmentHeader.Get(Header."Shipping No.") then
            if ShipmentHeader."Additional Notes" <> '' then
                XVNote := XVNote + ' ' + ShipmentHeader."Additional Notes";
        exit(XVNote);
    end;


}

