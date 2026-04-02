namespace Lazzerini;
using Microsoft.Sales.History;

using Microsoft.Assembly.History;
using Microsoft.Bank.BankAccount;
using Microsoft.Bank.Setup;
using Microsoft.CRM.Contact;
using Microsoft.CRM.Interaction;
using Microsoft.CRM.Segment;
using Microsoft.CRM.Team;
using Microsoft.Finance.Currency;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Finance.VAT.Clause;
using Microsoft.Foundation.Address;
using Microsoft.Sales.Document;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Reporting;
using Microsoft.Foundation.Shipping;
using Microsoft.Foundation.UOM;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Location;
using Microsoft.Projects.Project.Job;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Receivables;
using Microsoft.Sales.Reminder;
using Microsoft.Sales.Setup;
using Microsoft.Utilities;
using System.Email;
using System.Globalization;
using System.Reflection;
using System.Text;
using System.Utilities;

using Microsoft.Inventory.Item.Catalog;


using Microsoft.Warehouse.History;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Inventory.Item;
using Microsoft.Finance.VAT.Setup;


report 50231 "Custom Sales - Invoice"
{
    Caption = 'Sales - Invoice';
    EnableHyperlinks = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    RDLCLayout = './ReportLayouts/XVFatturaKitBus.rdl';
    UsageCategory = None;
    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            //RequestFilterFields = "No.";//, "Sell-to Customer No.", "No. Printed";
            //RequestFilterHeading = 'Fattura Lazzerini';
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
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
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
            column(ShipmentDate; Format("Shipment Date", 0, 4))
            {
            }
            column(ShipmentDate_Lbl; FieldCaption("Shipment Date"))
            {
            }
            column(Shipment_Lbl; ShipmentLbl)
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
            column(DocumentNo_Lbl; InvNoLbl)
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(OrderNo_Lbl; FieldCaption("Order No."))
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
            column(SalesPersonBlank_Lbl; SalesPersonText)
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
            column(GlobalLocationNumber; GetCustomerGlobalLocationNumber())
            {
            }
            column(GlobalLocationNumber_Lbl; GetCustomerGlobalLocationNumberLbl())
            {
            }
            column(SellToFaxNo; GetSellToCustomerFaxNo())
            {
            }
            column(SellToPhoneNo; "Sell-to Phone No.")
            {
            }
            column(PaymentReference; GetPaymentReference())
            {
            }
            column(From_Lbl; FromLbl)
            {
            }
            column(BilledTo_Lbl; BilledToLbl)
            {
            }
            column(ChecksPayable_Lbl; ChecksPayableText)
            {
            }
            column(PaymentReference_Lbl; GetPaymentReferenceLbl())
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
            column(EMail_Header_Lbl; EMailLbl)
            {
            }
            column(HomePage_Header_Lbl; HomePageLbl)
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
            column(ExchangeRateAsText; ExchangeRateText)
            {
            }
            column(Page_Lbl; PageLbl)
            {
            }
            column(SalesInvoiceLineDiscount_Lbl; SalesInvLineDiscLbl)
            {
            }
            column(Questions_Lbl; QuestionsLbl)
            {
            }
            column(Contact_Lbl; CompanyInfo.GetContactUsText())
            {
            }
            column(YourDocumentTitle_Lbl; YourSalesInvoiceLbl)
            {
            }
            column(Thanks_Lbl; ThanksLbl)
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            column(RemainingAmount; RemainingAmount)
            {
            }
            column(RemainingAmountText; RemainingAmountTxt)
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
            column(PackageTrackingNo; "Package Tracking No.")
            {
            }
            column(PackageTrackingNo_Lbl; FieldCaption("Package Tracking No."))
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(ShippingAgentCode_Lbl; FieldCaption("Shipping Agent Code"))
            {
            }
            column(PaymentInstructions_Txt; PaymentInstructionsTxt)
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(ExternalDocumentNo_Lbl; FieldCaption("External Document No."))
            {
            }
/*  Custom*/
            column(IsKitBus; GetIsKitBus()) {}         
            column(ShipToName; "Ship-to Name") { }
            column(EORICode; GetEORICode("Sell-to Customer No.")) { }
            column(ACCOMPAGNATORIA; ACCOMPAGNATORIA) { }
            column(TipoDocumento; GetTipoDocumento(ACCOMPAGNATORIA, "Sell-to Country/Region Code")) { }
            column(TariffNo_lbl; GetCustomLabel('Tariff No.')) { }
            column(VATBaseTotal_lbl; "TotalVATBaseLCY") { }
            column(TypePaymentCaptionLbl; GetCustomLabel('Type Payment Caption')) { }
            column(AmountLbl; GetCustomLabel('Amount')) { }
            column(VATBaseLbl; GetCustomLabel('VAT Base')) { }
            column(VATTotalLbl; "TotalAmountVAT") { }
            column(CurrencyLbl; "Currency Code") { }
            column(TotalAmountLbl; GetCustomLabel('Total Amount')) { }
            column(ShippingNotes; "Work Description") { }
            column(VAT_Base1; VAT_Base1) { }
            column(VAT_Description1; VAT_Description1) { }
            column(VAT_Amount1; VAT_Amount1) { }
            column(VAT_Base2; VAT_Base2) { }
            column(VAT_Description2; VAT_Description2) { }
            column(VAT_Amount2; VAT_Amount2) { }
            column(VAT_Base3; VAT_Base3) { }
            column(VAT_Description3; VAT_Description3) { }
            column(VAT_Amount3; VAT_Amount3) { }
            column(TPaymentMethod1; TPaymentMethod1) { }
            column(DatScadenze1; DatScadenze1) { }
            column(DecImportoRate1; DecImportoRate1) { }
            column(TPaymentMethod2; TPaymentMethod2) { }
            column(DatScadenze2; DatScadenze2) { }
            column(DecImportoRate2; DecImportoRate2) { }
            column(TPaymentMethod3; TPaymentMethod3) { }
            column(DatScadenze3; DatScadenze3) { }
            column(DecImportoRate3; DecImportoRate3) { }
            column(TotalAmount; "TotalAmount") { }
            column(TotalAmountVAT; GetCustomValue('Total Amount VAT/Importo Totale Iva')) { }
            column(TotalAmountInclVAT; "TotalAmountInclVAT") { }
            column(SalesInvoiceHeader_CurrencyCode; GetCustomValue('SalesInvoiceHeader_CurrencyCode')) { }
            column(CONAI; GetCustomValue('contributo CONAI assolto ove dovuto')) { }
            column(DESC; GetCustomValue('the exported of the products covered by this doc declares, except where otherwise clearly indicate, these products are of italian origin.')) { }
            column(Firma; GetCustomValue('Lazzareni S.r.l Ufficio AMM.VO')) { }
            column(NrColli; GetNrColli("No.")) { Caption = 'Numero colli'; }
            column(Freight; GetFreight("No.")) { Caption = 'Freight'; }
            column(Forwarder; GetForwarder("Shipping Agent Code")) { Caption = 'Spedizioniere'; }
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
            column(XVCurrencyLbl; GetCustomLabel('Currency')){}
            column(XVDeliveryTermsLbl; GetCustomLabel('Delivery Terms')){}
            column(XVFreightLbl; GetCustomLabel('Freight')){}
            column(XVShipTimeLbl; GetCustomLabel('Ship Time')){}
            column(XVForwarderLbl; GetCustomLabel('Forwarder')){}
            column(XVTotVatBaseLbl; GetCustomLabel('Total VAT Base')){}
            column(XVVatTotalLbl; GetCustomLabel('Total VAT')){}
            column(XVSignForwarderLbl; GetCustomLabel('Signature of forwarder')){}
            column(XVSignDriverLbl; GetCustomLabel('Driver''s signature')){}
            column(XVSignConsigneeLbl; GetCustomLabel('Consignee signature')){}
            column(XVParcNoLbl; GetCustomLabel('Parc. No.')){}
            column(XVCustomerIdLbl; GetCustomLabel('Customer ID')){}
            dataitem(Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
                column(LineNo_Line; "Line No.")
                {
                }
                //column(EOSPQ;"EOS055 Packaging Quantity"){}
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount))
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(Description_Line; Description)
                {
                }
                column(Description_Line_Lbl; FieldCaption(Description))
                {
                }
                column(LineDiscountPercent_Line; "Line Discount %")
                {
                }
                column(LineDiscountPercentText_Line; LineDiscountPctText)
                {
                }
                column(LineAmount_Line; "Line Amount")
                {
                    //AutoFormatExpression = GetCurrencyCode();
                    //AutoFormatType = 1;
                }
                column(LineAmount_Line_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(ItemNo_Line; "No.")
                {
                }
                column(ItemNo_Line_Lbl; FieldCaption("No."))
                {
                }
                column(ItemReferenceNo_Line; "Item Reference No.")
                {
                }
                column(ItemReferenceNo_Line_Lbl; FieldCaption("Item Reference No."))
                {
                }
                column(ShipmentDate_Line; Format("Shipment Date"))
                {
                }
                column(ShipmentDate_Line_Lbl; PostedShipmentDateLbl)
                {
                }
                column(Quantity_Line; Quantity)
                {
                }
                column(Quantity_Line_Lbl; FieldCaption(Quantity))
                {
                }
                column(Type_Line; Format(Type))
                {
                }
                column(UnitPrice; "Unit Price")
                {
                    //AutoFormatExpression = GetCurrencyCode();
                    //AutoFormatType = 2;
                }
                column(UnitPrice_Lbl; FieldCaption("Unit Price"))
                {
                }
                column(UnitOfMeasure; "Unit of Measure")
                {
                }
                column(UnitOfMeasure_Lbl; FieldCaption("Unit of Measure"))
                {
                }
                column(VATIdentifier_Line; "VAT Identifier")
                {
                }
                column(VATIdentifier_Line_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_Line; FormattedVATPct)
                {
                }
                column(VATPct_Line_Lbl; FieldCaption("VAT %"))
                {
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(JobTaskNo_Lbl; JobTaskNoLbl)
                {
                }
                column(JobTaskNo; JobTaskNo)
                {
                }
                column(JobTaskDescription; JobTaskDescription)
                {
                }
                column(JobTaskDesc_Lbl; JobTaskDescLbl)
                {
                }
                column(JobNo_Lbl; JobNoLbl)
                {
                }
                column(JobNo; JobNo)
                {
                }
                column(Unit_Lbl; UnitLbl)
                {
                }
                column(Qty_Lbl; QtyLbl)
                {
                }
                column(Price_Lbl; PriceLbl)
                {
                }
                column(PricePer_Lbl; PricePerLbl)
                {
                }
                column(Kit_Bus;"Kit Bus")
                {
                }
                column(Kit_Bus_Desc;getKitBusDescription("Kit Bus","Description"))
                {
                }
                column(Progressivo_Kit_Bus;"Progressivo Kit Bus")
                {
                }
                column(Service_Tariff_No;"Service Tariff No.")
                {
                }
                column(Tariff_No;GetTariffNo(Line."No."))
                {
                }
                column(NetWeight; "Net Weight")
                {
                    Caption = 'Net Weight';
                }
                column(NetWeight_Lbl; FieldCaption("Net Weight"))
                {
                }
                column(GrossWeight; "Gross Weight")
                {
                }
                column(GrossWeight_Lbl; FieldCaption("Gross Weight"))
                {
                }
                column(TariffList; TariffList){}

                dataitem(ShipmentLine; "Sales Shipment Buffer")
                {
                    DataItemTableView = sorting("Document No.", "Line No.", "Entry No.");
                    UseTemporary = true;
                    column(DocumentNo_ShipmentLine; "Document No.")
                    {
                    }
                    column(PostingDate_ShipmentLine; Format("Posting Date"))
                    {
                    }
                    column(PostingDate_ShipmentLine_Lbl; FieldCaption("Posting Date"))
                    {
                    }
                    column(Quantity_ShipmentLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Quantity_ShipmentLine_Lbl; FieldCaption(Quantity))
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        if not DisplayShipmentInformation then
                            CurrReport.Break();

                        SetRange("Line No.", Line."Line No.");
                    end;
                }
                dataitem(AssemblyLine; "Posted Assembly Line")
                {
                    DataItemTableView = sorting("Document No.", "Line No.");
                    UseTemporary = true;
                    column(LineNo_AssemblyLine; "No.")
                    {
                    }
                    column(Description_AssemblyLine; Description)
                    {
                    }
                    column(Quantity_AssemblyLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(VariantCode_AssemblyLine; "Variant Code")
                    {
                    }

                    trigger OnPreDataItem()
                    var
                        ValueEntry: Record "Value Entry";
                    begin
                        Clear(AssemblyLine);
                        if not DisplayAssemblyInformation then
                            CurrReport.Break();
                        GetAssemblyLinesForDocument(
                          AssemblyLine, ValueEntry."Document Type"::"Sales Invoice", Line."Document No.", Line."Line No.");
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    InitializeShipmentLine();
                    if Type = Type::"G/L Account" then
                        "No." := '';
                    TariffTemp := GetTariffNo(Line."No.");
                    if (TariffTemp <> '') and (not TariffList.Contains(TariffTemp)) then
                        TariffList := TariffList + TariffTemp + ', ';

 //                   OnBeforeLineOnAfterGetRecord(Header, Line);

                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := StrSubstNo('%1%', -Round("Line Discount %", 0.1));

//                    InsertVATAmountLine(VATAmountLine, Line);

                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    if FormatDocument.HideDocumentLine(HideLinesWithZeroQuantity, Line, FieldNo(Quantity)) then
                        CurrReport.Skip();
                    if FirstLineHasBeenOutput then
                        Clear(DummyCompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;

                    JobNo := "Job No.";
                    JobTaskNo := "Job Task No.";

                    if JobTaskNo <> '' then begin
                        JobTaskNoLbl := JobTaskNoLbl2;
                        JobTaskDescription := GetJobTaskDescription(JobNo, JobTaskNo);
                    end else begin
                        JobTaskDescription := '';
                        JobTaskNoLbl := '';
                    end;

                    if JobNo <> '' then
                        JobNoLbl := JobNoLbl2
                    else
                        JobNoLbl := '';

                    //FormatLineValues(Line);
                end;

                trigger OnPreDataItem()
                begin
                    VATAmountLine.DeleteAll();
                    VATClauseLine.DeleteAll();
                    ShipmentLine.Reset();
                    ShipmentLine.DeleteAll();
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    FirstLineHasBeenOutput := false;
                    DummyCompanyInfo.Picture := CompanyInfo.Picture;

//                    OnAfterLineOnPreDataItem(Header, Line);
                end;
            }
            
            dataitem(VATAmountLine; "VAT Amount Line")
            {
                DataItemTableView = sorting("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(InvoiceDiscountAmount_VATAmountLine; "Invoice Discount Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountAmount_VATAmountLine_Lbl; FieldCaption("Invoice Discount Amount"))
                {
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine; "Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(InvoiceDiscountBaseAmount_VATAmountLine_Lbl; FieldCaption("Inv. Disc. Base Amount"))
                {
                }
                column(LineAmount_VatAmountLine; "Line Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(LineAmount_VatAmountLine_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(VATAmount_VatAmountLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmount_VatAmountLine_Lbl; FieldCaption("VAT Amount"))
                {
                }
                column(VATAmountLCY_VATAmountLine; VATAmountLCY)
                {
                }
                column(VATAmountLCY_VATAmountLine_Lbl; VATAmountLCYLbl)
                {
                }
                column(VATBase_VatAmountLine; "VAT Base")
                {
                    AutoFormatExpression = Line.GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(VATBase_VatAmountLine_Lbl; FieldCaption("VAT Base"))
                {
                }
                column(VATBaseLCY_VATAmountLine; VATBaseLCY)
                {
                }
                column(VATBaseLCY_VATAmountLine_Lbl; VATBaseLCYLbl)
                {
                }
                column(VATIdentifier_VatAmountLine; "VAT Identifier")
                {
                }
                column(VATIdentifier_VatAmountLine_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_VatAmountLine; "VAT %")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(VATPct_VatAmountLine_Lbl; FieldCaption("VAT %"))
                {
                }
                column(NoOfVATIdentifiers; Count)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VATBaseLCY :=
                      GetBaseLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");
                    VATAmountLCY :=
                      GetAmountLCY(
                        Header."Posting Date", Header."Currency Code",
                        Header."Currency Factor");

                    TotalVATBaseLCY += VATBaseLCY;
                    TotalVATAmountLCY += VATAmountLCY;
                    TotalVATBaseOnVATAmtLine += "VAT Base";
                    TotalVATAmountOnVATAmtLine += "VAT Amount";

                    if ShowVATClause("VAT Clause Code") and ShouldInsertVATClauseLine() then begin
                        VATClauseLine := VATAmountLine;
                        if VATClauseLine.Insert() then;
                    end;
                    
                end;

                trigger OnPreDataItem()
                begin
                    Clear(VATBaseLCY);
                    Clear(VATAmountLCY);

                    TotalVATBaseLCY := 0;
                    TotalVATAmountLCY := 0;
                    TotalVATBaseOnVATAmtLine := 0;
                    TotalVATAmountOnVATAmtLine := 0;
                end;
            }
            dataitem(VATClauseLine; "VAT Amount Line")
            {
                DataItemTableView = sorting("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(VATClausesHeader; VATClausesText)
                {
                }
                column(VATIdentifier_VATClauseLine; "VAT Identifier")
                {
                }
                column(Code_VATClauseLine; VATClause.Code)
                {
                }
                column(Code_VATClauseLine_Lbl; VATClause.FieldCaption(Code))
                {
                }
                column(Description_VATClauseLine; VATClauseText)
                {
                }
                column(Description2_VATClauseLine; VATClause."Description 2")
                {
                }
                column(VATAmount_VATClauseLine; "VAT Amount")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(NoOfVATClauses; Count)
                {
                }

                trigger OnAfterGetRecord()
                    var
                        Item: Record Item;
                begin

                    if "VAT Clause Code" = '' then
                        CurrReport.Skip();
                    if not VATClause.Get("VAT Clause Code") then
                        CurrReport.Skip();
                    VATClauseText := VATClause.GetDescriptionText(Header);
                end;

                trigger OnPreDataItem()
                begin
                    if Count = 0 then
                        VATClausesText := ''
                    else
                        VATClausesText := VATClausesLbl;
                end;
                
            }
            dataitem(ReportTotalsLine; "Report Totals Buffer")
            {
                DataItemTableView = sorting("Line No.");
                UseTemporary = true;
                column(Description_ReportTotalsLine; Description)
                {
                }
                column(Amount_ReportTotalsLine; Amount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(FontBold_ReportTotalsLine; "Font Bold")
                {
                }
                column(FontUnderline_ReportTotalsLine; "Font Underline")
                {
                }

                trigger OnPreDataItem()
                begin
                    //CreateReportTotalLines();
                end;
            }
            dataitem(PaymentReportingArgument; "Payment Reporting Argument")
            {
                DataItemTableView = sorting(Key);
                UseTemporary = true;
                column(PaymentServiceLogo; Logo)
                {
                }
                column(PaymentServiceLogo_UrlText; "URL Caption")
                {
                }
                column(PaymentServiceLogo_Url; GetTargetURL())
                {
                }
                column(PaymentServiceText_UrlText; "URL Caption")
                {
                }
                column(PaymentServiceText_Url; GetTargetURL())
                {
                }
            }
            dataitem(LeftHeader; "Name/Value Buffer")
            {
                DataItemTableView = sorting(ID);
                UseTemporary = true;
                column(LeftHeaderName; Name)
                {
                }
                column(LeftHeaderValue; Value)
                {
                }
            }
            dataitem(RightHeader; "Name/Value Buffer")
            {
                DataItemTableView = sorting(ID);
                UseTemporary = true;
                column(RightHeaderName; Name)
                {
                }
                column(RightHeaderValue; Value)
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                PaymentServiceSetup: Record "Payment Service Setup";
                Currency: Record Currency;
                GeneralLedgerSetup: Record "General Ledger Setup";
           begin
                CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                CurrReport.FormatRegion := LanguageMgt.GetFormatRegionOrDefault("Format Region");
                FormatAddr.SetLanguageCode("Language Code");

//                if not IsReportInPreviewMode() then
//                    CODEUNIT.Run(CODEUNIT::"Sales Inv.-Printed", Header);

//                OnHeaderOnAfterGetRecordOnAfterUpdateNoPrinted(IsReportInPreviewMode(), Header);

                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;

                ChecksPayableText := StrSubstNo(ChecksPayableLbl, CompanyInfo.Name);

                FormatAddressFields(Header);
//                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

                if not CompanyBankAccount.Get(Header."Company Bank Account Code") then
                    CompanyBankAccount.CopyBankFieldsFromCompanyInfo(CompanyInfo);

//                FillLeftHeader();
//                FillRightHeader();


                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                    CurrCode := "Currency Code";
                    if Currency.Get("Currency Code") then
                        CurrSymbol := Currency.GetCurrencySymbol();
                end else
                    if GeneralLedgerSetup.Get() then begin
                        CurrCode := GeneralLedgerSetup."LCY Code";
                        CurrSymbol := GeneralLedgerSetup.GetCurrencySymbol();
                    end;
                CalculateVATTotals("No.");
                CalculatePaymentInstallments("No.");
            end;

            trigger OnPreDataItem()
            begin
                FirstLineHasBeenOutput := false;        
                
                if DocNo <> '' then
                    SetRange("No.", DocNo);

            end;
        }
  
    }

    requestpage
    {
//        SaveValues = true;

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

        actions
        {
        }

    }


    labels
    {
    }

    trigger OnInitReport()
    var
        IsHandled: Boolean;
    begin
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get();
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo();

        if SalesSetup.GetLegalStatement() <> '' then
            LegalStatementLbl := SalesSetup.GetLegalStatement();

        IsHandled := false;
    end;

    var
    /* RPCustom */
        IsForeign: Boolean;
        TariffList: Text;
        TariffTemp: Code[20];
        VAT_Description1: Text[100];
        VAT_Description2: Text[100];
        VAT_Description3: Text[100];

        VAT_Base1: Decimal;
        VAT_Base2: Decimal;
        VAT_Base3: Decimal;

        VAT_Amount1: Decimal;
        VAT_Amount2: Decimal;
        VAT_Amount3: Decimal;

        TPaymentMethod1: Code[20];
        TPaymentMethod2: Code[20];
        TPaymentMethod3: Code[20];

        DatScadenze1: Date;
        DatScadenze2: Date;
        DatScadenze3: Date;

        DecImportoRate1: Decimal;
        DecImportoRate2: Decimal;
        DecImportoRate3: Decimal;

    /* End RPCustom */ 
        GLSetup: Record "General Ledger Setup";
        DummyCompanyInfo: Record "Company Information";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        VATClause: Record "VAT Clause";
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        LanguageMgt: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        AutoFormat: Codeunit "Auto Format";
        WorkDescriptionInstream: InStream;
        JobNo: Code[20];
        JobTaskNo: Code[20];
        WorkDescriptionLine: Text;
        ChecksPayableText: Text;
        SalesPersonText: Text[50];
        RemainingAmountTxt: Text;
        JobNoLbl: Text;
        JobTaskNoLbl: Text;
        TotalAmountExclInclVATTextValue: Text;
        MoreLines: Boolean;
        ShowWorkDescription: Boolean;
        TransHeaderAmount: Decimal;
        LogInteractionEnable: Boolean;
        CompanyLogoPosition: Integer;
        CalculatedExchRate: Decimal;
        PaymentInstructionsTxt: Text;
        ExchangeRateText: Text;
        PrevLineAmount: Decimal;
        SalespersonLbl: Label 'Salesperson';
        CompanyInfoBankAccNoLbl: Label 'Account No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CopyLbl: Label 'Copy';
        EMailLbl: Label 'Email';
        HomePageLbl: Label 'Home Page';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'Invoice No.';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        PageLbl: Label 'Page';
        PaymentMethodDescLbl: Label 'Payment Method';
        PostedShipmentDateLbl: Label 'Shipment Date';
        SalesInvLineDiscLbl: Label 'Discount %';
        SalesInvoiceLbl: Label 'Invoice';
        YourSalesInvoiceLbl: Label 'Your Invoice';
        ShipmentLbl: Label 'Shipment';
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
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidentally printing all documents.';
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        PmtDiscTxt: Label 'If we receive the payment before %1, you are eligible for a %2% payment discount.', Comment = '%1 Discount Due Date %2 = value of Payment Discount % ';
        BodyLbl: Label 'Thank you for your business. Your invoice is attached to this message.';
        AlreadyPaidLbl: Label 'The invoice has been paid.';
        PartiallyPaidLbl: Label 'The invoice has been partially paid. The remaining amount is %1', Comment = '%1=an amount';
        FromLbl: Label 'From';
        BilledToLbl: Label 'Billed to';
        ChecksPayableLbl: Label 'Please make checks payable to %1', Comment = '%1 = company name';
        QuestionsLbl: Label 'Questions?';
        ThanksLbl: Label 'Thank You!';
#pragma warning disable AA0074
        JobNoLbl2: Label 'Project No.';
        JobTaskNoLbl2: Label 'Project Task No.';
#pragma warning restore AA0074
        JobTaskDescription: Text[100];
        JobTaskDescLbl: Label 'Project Task Description';
        UnitLbl: Label 'Unit';
        VATClausesText: Text;
        QtyLbl: Label 'Qty', Comment = 'Short form of Quantity';
        PriceLbl: Label 'Price';
        PricePerLbl: Label 'Price per';
        LCYTxt: label ' (LCY)';
        VATClauseText: Text;
        LegalOfficeTxt, LegalOfficeLbl, CustomGiroTxt, CustomGiroLbl, LegalStatementLbl : Text;

    protected var
        CompanyInfo: Record "Company Information";
        CompanyBankAccount: Record "Bank Account";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalesSetup: Record "Sales & Receivables Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        CompanyAddr: array[8] of Text[100];
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        FormattedLineAmount: Text;
        FormattedQuantity: Text;
        FormattedUnitPrice: Text;
        FormattedVATPct: Text;
        LineDiscountPctText: Text;
        PmtDiscText: Text;
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalSubTotal: Decimal;
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        DisplayAssemblyInformation: Boolean;
        DisplayShipmentInformation: Boolean;
        DisplayAdditionalFeeNote: Boolean;
        FirstLineHasBeenOutput: Boolean;
        ShowShippingAddr: Boolean;
        TotalText: Text[50];
        LogInteraction: Boolean;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        RemainingAmount: Decimal;
        TotalAmountExclInclVATValue: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        TotalVATBaseOnVATAmtLine: Decimal;
        TotalVATAmountOnVATAmtLine: Decimal;
        CurrCode: Text[10];
        CurrSymbol: Text[10];
        PaymentTermsDescLbl: Label 'Payment Terms';
        ShptMethodDescLbl: Label 'Shipment Method';
        ShiptoAddrLbl: Label 'Ship-to Address';
        HideLinesWithZeroQuantity: Boolean;
        LineTariffNo: Code[20];

/* RPCustom */
    local procedure GetTariffNo(ItemNo: Code[20]): Code[20]
    var
        Item: Record Item;
    begin
        if Item.Get(ItemNo) then
            exit(Item."Tariff No.");
        exit('');
    end;

    local procedure GetKitBusDescription(KitBus: Code[20]; Description: Text[100]): Text[120]
    var
        ItemRec: Record Item;
    begin
        if KitBus <> '' then begin
            if ItemRec.Get(KitBus) then
                Description := ItemRec.Description;
        end;
        exit(Description);
    end;

    local procedure GetEORICode(SellToCustomerNo: Code[20]): Code[50]
    var
        Customer: Record Customer;
    begin
        if Customer.Get(SellToCustomerNo) then
            exit(Customer."Codice EORI");
        exit('');
    end;
    local procedure GetTipoDocumento(ACCOMPAGNATORIA: Boolean; SellToCountryCode: Code[10]): Text[100]
    var
    begin
        IsForeign := SellToCountryCode <> 'IT';
        if SellToCountryCode = 'IT' then
            if ACCOMPAGNATORIA then
                exit('FATTURA ACCOMPAGNATORIA') // NON ESISTONO ITALIANI - SOLO DOGANA
            else
                exit('FATTURA')
        else
            if ACCOMPAGNATORIA then
                exit('INVOICE & DELIVERY NOTE')
            else
                exit('INVOICE');
        exit('');
    end;
    local procedure GetCustomLabel(LabelName: Text): Text
    var
        langLbl: Text[100];
        
    begin
        langLbl := LabelName;
        if isForeign then
            case LabelName of
                'Ship Time':
                    exit('Shipment Date & Time');
                'Tariff No.':
                    exit('Tariff No.');
                'Type Payment Caption':
                    exit('Type Payment Caption');
                'Amount':
                    exit('Amount');
                'VAT Base':
                    exit('VAT Base');
                else
                    exit(LabelName);
            end
        else
            case LabelName of
                'Customer ID':
                    exit('Cliente ID');
                'Parc. No.':
                    exit('Nr. Colli');
                'Signature of forwarder':
                    exit('Firma del vettore');
                'Driver''s signature':
                    exit('Firma del conducente');
                'Consignee signature':
                    exit('Firma del destinatario');

                'Our Code No.':
                    exit('Codice Articolo');
                'Custom Code No.':
                    exit('Codice Cliente');
                'Description':
                    exit('Descrizione');
                'UoM':
                    exit('UdM');
                'Q.ty':
                    exit('Quantità');
                'Unit Price':
                    exit('Prezzo Unitario');
                'VATId.':
                    exit('Id IVA');
                'Currency':
                    exit('Valuta');
                'Delivery Terms':
                    exit('Condizioni di Consegna');
                'Freight':
                    exit('Trasporto');
                'Ship Time':
                    exit('Data e Ora di Spedizione');
                'Forwarder':
                    exit('Vettore');
                'Total VAT Base':
                    exit('Base IVA Totale');
                'Total VAT':
                    exit('IVA Totale');
                'Gross Weight':
                    exit('Peso Lordo');
                'Net Weight':
                    exit('Peso Netto');
                'Tariff No.':
                    exit('Numero Tariffa');
                'Type Payment Caption':
                    exit('Tipo Pagamento');
                'Amount':
                    exit('Importo');
                'VAT Base':
                    exit('Base IVA');
                else
                    exit(LabelName);
            end
    end;
    local procedure GetCustomValue(LabelName: Text): Text
    begin
        exit(LabelName);
    end;
    local procedure GetDueDateFromPaymentTerms(PaymentTermsCode: Code[10]; Position: Integer): Date
    var
        PaymentLine: Record "Payment Lines";
        Counter: Integer;
    begin
        Counter := 0;

        PaymentLine.SetRange(Code, PaymentTermsCode);

        if PaymentLine.FindSet() then
            repeat
                if PaymentLine."Due Date" <> 0D then begin
                    Counter += 1;

                    if Counter = Position then
                        exit(PaymentLine."Due Date");
                end;
            until PaymentLine.Next() = 0;

        exit(0D);
    end;

    local procedure CalculateVATTotals(DocumentNo: Code[20])
    var
        SalesLine: Record "Sales Invoice Line";
        VATProdPostingGroup: Record "VAT Product Posting Group";
        CurrentVAT: Code[10];
        CurrentBase: Decimal;
        CurrentVATAmount: Decimal;
        Desc1: Text[50];
        Desc2: Text[50];
        Desc3: Text[50];
    begin
        Clear(VAT_Description1);
        Clear(VAT_Description2);
        Clear(VAT_Description3);
        VAT_Base1 := 0;
        VAT_Base2 := 0;
        VAT_Base3 := 0;
        VAT_Amount1 := 0;
        VAT_Amount2 := 0;
        VAT_Amount3 := 0;
        SalesLine.SetRange("Document No.", DocumentNo);
        if SalesLine.FindSet() then
            repeat
                CurrentVAT := SalesLine."VAT Identifier";
                if CurrentVAT <> '' then begin
                    CurrentBase := SalesLine."VAT Base Amount";
                    CurrentVATAmount := SalesLine."Amount Including VAT" - SalesLine."VAT Base Amount";
                    if CurrentVAT = Desc1 then begin
                        VAT_Base1 += CurrentBase;
                        VAT_Amount1 += CurrentVATAmount;
                    end else
                        if CurrentVAT = Desc2 then begin
                            VAT_Base2 += CurrentBase;
                            VAT_Amount2 += CurrentVATAmount;
                        end else
                            if CurrentVAT = Desc3 then begin
                                VAT_Base3 += CurrentBase;
                                VAT_Amount3 += CurrentVATAmount;
                            end else begin

                                if Desc1 = '' then begin
                                    Desc1 := CurrentVAT;
                                    VAT_Base1 := CurrentBase;
                                    VAT_Amount1 := CurrentVATAmount;
                                end else
                                    if Desc2 = '' then begin
                                        Desc2 := CurrentVAT;
                                        VAT_Base2 := CurrentBase;
                                        VAT_Amount2 := CurrentVATAmount;
                                    end else
                                        if Desc3 = '' then begin
                                            Desc3 := CurrentVAT;
                                            VAT_Base3 := CurrentBase;
                                            VAT_Amount3 := CurrentVATAmount;
                                        end;
                            end;
                end;
            until SalesLine.Next() = 0;
        if VATProdPostingGroup.Get(Desc1) then
            VAT_Description1 := VATProdPostingGroup.Description
        else
            VAT_Description1 := Desc1;

        if VATProdPostingGroup.Get(Desc2) then
            VAT_Description2 := VATProdPostingGroup.Description
        else
            VAT_Description2 := Desc2;

        if VATProdPostingGroup.Get(Desc3) then
            VAT_Description3 := VATProdPostingGroup.Description
        else
            VAT_Description3 := Desc3;
    end;

    local procedure CalculatePaymentInstallments(DocumentNo: Code[20])
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        PaymentTerms: Record "Payment Terms";
        Counter: Integer;
    begin
        // Reset variabili
        TPaymentMethod1 := '';
        TPaymentMethod2 := '';
        TPaymentMethod3 := '';

        DatScadenze1 := 0D;
        DatScadenze2 := 0D;
        DatScadenze3 := 0D;

        DecImportoRate1 := 0;
        DecImportoRate2 := 0;
        DecImportoRate3 := 0;

        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Document No.", DocumentNo);
        CustLedgEntry.SetRange("Document Type",
            CustLedgEntry."Document Type"::Invoice);

        Counter := 0;

        if CustLedgEntry.FindSet() then
            repeat
                Counter += 1;
                // Assegna data e importo
                case Counter of
                    1:
                        begin
                            DatScadenze1 := CustLedgEntry."Due Date";
                            DecImportoRate1 := CustLedgEntry."Remaining Amount";
                        end;
                    2:
                        begin
                            DatScadenze2 := CustLedgEntry."Due Date";
                            DecImportoRate2 := CustLedgEntry."Remaining Amount";
                        end;
                    3:
                        begin
                            DatScadenze3 := CustLedgEntry."Due Date";
                            DecImportoRate3 := CustLedgEntry."Remaining Amount";
                        end;
                end;

                // Lookup descrizione termini pagamento
                if CustLedgEntry."Payment Method Code" <> '' then
                    if PaymentTerms.Get(CustLedgEntry."Payment Method Code") then begin
                        case Counter of
                            1:
                                TPaymentMethod1 := PaymentTerms.Description;
                            2:
                                TPaymentMethod2 := PaymentTerms.Description;
                            3:
                                TPaymentMethod3 := PaymentTerms.Description;
                        end;
                    end;

            until (CustLedgEntry.Next() = 0) or (Counter = 3);
    end;



    local procedure GetNrColli(DocumentNo: Code[20]): Code[20]
    var
        ShipmentHeader: Record "Sales Shipment Header";
    begin
        if ShipmentHeader.Get(DocumentNo) then
            exit(ShipmentHeader."Package Tracking No.");
        exit('');
    end;

    local procedure GetFreight(DocumentNo: Code[20]): Text[100]
    var
        ReasonCode: Record "Reason Code";
    begin
        if ReasonCode.Get('231') then
            exit(ReasonCode.Description);
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
procedure GetIsKitBus(): Boolean
var
    InvoiceNo: Code[20];
    SalesInvLine: Record "Sales Invoice Line";
    SalesHeader: Record "Sales Header";
begin
    InvoiceNo := DocNo;
    // Filtra solo le righe con un Order No. valorizzato
    SalesInvLine.SetRange("Document No.", InvoiceNo);
    SalesInvLine.SetFilter("Order No.", '<>%1', '');

    if SalesInvLine.FindSet() then
        repeat
            // Lettura diretta testata ordine
            if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesInvLine."Order No.") then
                if SalesHeader."Ordine con kit" then
                    exit(true);  // appena trovato → fine
        until SalesInvLine.Next() = 0;

    // Nessun ordine con kit
    exit(false);
end;


/* End RPCustom */

    local procedure LogInteractionTemplateExists(): Boolean
    begin
        exit(SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Inv.") <> '');
    end;

    local procedure InitializeShipmentLine()
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        if not DisplayShipmentInformation then
            exit;

        if Line.Type = Line.Type::" " then
            exit;

        if Line."Shipment No." <> '' then
            if SalesShipmentHeader.Get(Line."Shipment No.") then
                exit;

        ShipmentLine.GetLinesForSalesInvoiceLine(Line, Header);

        ShipmentLine.Reset();
        ShipmentLine.SetRange("Line No.", Line."Line No.");
        if not ShipmentLine.IsEmpty() then begin
            ShipmentLine.CalcSums(Quantity);
            if ShipmentLine.Quantity <> Line.Quantity then begin
                ShipmentLine.DeleteAll();
                exit;
            end;
        end;
    end;


    procedure InitializeRequest(NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;


    local procedure FillNameValueTable(var NameValueBuffer: Record "Name/Value Buffer"; Name: Text; Value: Text)
    var
        KeyIndex: Integer;
    begin
        if Value <> '' then begin
            Clear(NameValueBuffer);
            if NameValueBuffer.FindLast() then
                KeyIndex := NameValueBuffer.ID + 1;

            NameValueBuffer.Init();
            NameValueBuffer.ID := KeyIndex;
            NameValueBuffer.Name := CopyStr(Name, 1, MaxStrLen(NameValueBuffer.Name));
            NameValueBuffer.Value := CopyStr(Value, 1, MaxStrLen(NameValueBuffer.Value));
            NameValueBuffer.Insert();
        end;
    end;

    local procedure FormatAddressFields(var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
        ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);
    end;

    local procedure GetJobTaskDescription(JobNo: Code[20]; JobTaskNo: Code[20]): Text[100]
    var
        JobTask: Record "Job Task";
    begin
        JobTask.SetRange("Job No.", JobNo);
        JobTask.SetRange("Job Task No.", JobTaskNo);
        if JobTask.FindFirst() then
            exit(JobTask.Description);

        exit('');
    end;

    local procedure ShowVATClause(VATClauseCode: Code[20]): Boolean
    begin
        if VATClauseCode = '' then
            exit(false);

        exit(true);
    end;


    local procedure ShouldInsertVATClauseLine(): Boolean
    var
        TempVATClauseLine: Record "VAT Amount Line" temporary;
    begin
        if VATAmountLine."VAT Amount" <> 0 then
            exit(true);

        TempVATClauseLine.Copy(VATClauseLine, true);
        TempVATClauseLine.SetRange("VAT Identifier", VATAmountLine."VAT Identifier");
        TempVATClauseLine.SetRange("VAT Clause Code", VATAmountLine."VAT Clause Code");
        TempVATClauseLine.SetRange("VAT Amount", VATAmountLine."VAT Amount");

        exit(TempVATClauseLine.IsEmpty());
    end;
    
var
        DocNo: Code[20];
        procedure SetParameters(DocumentNo: Code[20])
        begin
            DocNo := DocumentNo;
        end;

}

