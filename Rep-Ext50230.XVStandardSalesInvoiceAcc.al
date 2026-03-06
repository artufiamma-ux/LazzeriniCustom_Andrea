namespace Lazzerini;

using Microsoft.Sales.History;
using Microsoft.Sales.Receivables;
using Microsoft.Sales.Customer;
using Microsoft.Warehouse.History;
using Microsoft.Foundation.Shipping;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Inventory.Item;
using Microsoft.Finance.VAT.Setup;
using Microsoft.Foundation.PaymentTerms;


reportextension 50230 XVStandardSalesInvoiceAcc extends "Standard Sales - Invoice"
{
    RDLCLayout = './ReportLayouts/XVV2FatturaAccompagnatoria.rdl';

    dataset
    {

        add(Header)
        {

            column(ShipToName; "Ship-to Name") { }
            column(EORICode; GetEORICode("Sell-to Customer No.")) { }
            column(ACCOMPAGNATORIA; ACCOMPAGNATORIA) { }
            column(TipoDocumento; GetTipoDocumento(ACCOMPAGNATORIA, "Sell-to Country/Region Code")) { }
            column(Tariff_No_; "Service Tariff No.") { }
            column(TariffNo_lbl; GetCustomLabel('Tariff No.')) { }

            column(VATBaseTotal_lbl; "TotalVATBaseLCY") { }

            // column(DueDateLbl; GetCustomLabel('Due Date/Data scadenza')) { }
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


        }

        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            begin
                CalculateVATTotals("No.");
                CalculatePaymentInstallments("No.");
            end;

        }

        add(Line)
        {
            column(TariffNo; GetTariffNo("No."))
            {
                Caption = 'Tariff No';
            }
            column(Value; "Amount")
            {
                Caption = 'Value';
            }
            column(NetWeight; "Net Weight")
            {
                Caption = 'Net Weight';
            }
            column(KitBus; GetKitBus("Line No.", "Document No.")) { Caption = 'Kit Bus'; }
        }


    }
    var
        IsForeign: Boolean;

    local procedure GetTariffNo(ItemNo: Code[20]): Code[20]
    var
        ItemRec: Record Item;
    begin
        if ItemRec.Get(ItemNo) then
            exit(ItemRec."Tariff No.");
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

    local procedure GetTipoDocumento(ACCOMPAGNATORIA: Boolean; SellToCountryCode: Code[10]): Text[100]
    var
    begin
        IsForeign := SellToCountryCode <> 'IT';
        if SellToCountryCode = 'IT' then
            if ACCOMPAGNATORIA then
                exit('INVOICE & DELIVERY NOTE') // NON ESISTONO ITALIANI - SOLO DOGANA
            else
                exit('Fattura')
        else
            if ACCOMPAGNATORIA then
                exit('INVOICE & DELIVERY NOTE')
            else
                exit('Invoice');
        exit('');
    end;

    local procedure GetCustomLabel(LabelName: Text): Text
    var
        langLbl: Text[100];
    begin
        langLbl := LabelName;
        if isForeign then
            case LabelName of
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

                    // 🔁 RAGGRUPPAMENTO SOLO PER CODICE (22 / N / 41)
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

        // 🔎 SOLO ALLA FINE trasformiamo il codice in descrizione (tab 324)

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

    var
        VAT_Description1: Text[100];
        VAT_Description2: Text[100];
        VAT_Description3: Text[100];

        VAT_Base1: Decimal;
        VAT_Base2: Decimal;
        VAT_Base3: Decimal;

        VAT_Amount1: Decimal;
        VAT_Amount2: Decimal;
        VAT_Amount3: Decimal;


    var
        TPaymentMethod1: Code[20];
        TPaymentMethod2: Code[20];
        TPaymentMethod3: Code[20];

        DatScadenze1: Date;
        DatScadenze2: Date;
        DatScadenze3: Date;

        DecImportoRate1: Decimal;
        DecImportoRate2: Decimal;
        DecImportoRate3: Decimal;

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

    local procedure GetKitBus(SalesLineNo: Integer; DocumentNo: Code[20]): Code[20]
    var
        PostedWhseShptLine: Record "Posted Whse. Shipment Line";
    begin
        // Pulisco eventuali filtri precedenti
        PostedWhseShptLine.Reset();

        // Filtro per collegamento al documento di vendita
        PostedWhseShptLine.SetRange("Posted Source No.", DocumentNo);
        PostedWhseShptLine.SetRange("Source Line No.", SalesLineNo);

        if PostedWhseShptLine.FindFirst() then
            exit(PostedWhseShptLine."Kit Bus");

        exit('');
    end;
}
