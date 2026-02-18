namespace Lazzerini;

using Microsoft.Sales.History;
using Microsoft.Sales.Customer;
using Microsoft.Inventory.Item;

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
            column(Notes_lbl; GetCustomLabel('Notes')) { }
            //  column(VATBase_lbl; GetCustomLabel('VAT Base')) { }
            column(VATandTax_lbl; GetCustomLabel('VAT and Tax')) { }
            //          column(DueDateLbl; GetCustomLabel('DueDateLbl')) { }
            column(TypePaymentCaptionLbl; GetCustomLabel('TypePaymentCaptionLbl')) { }
            column(AmountLbl; GetCustomLabel('AmountLbl')) { }
            column(VATBaseLbl; GetCustomLabel('VATBaseLbl')) { }
            column(VATTotalLbl; GetCustomLabel('VATTotalLbl')) { }
            column(CurrencyLbl; GetCustomLabel('CurrencyLbl')) { }
            column(TotalAmountLbl; GetCustomLabel('TotalAmountLbl')) { }


            column(ShippingNotes; GetCustomValue('ShippingNotes')) { }
            column(VAT_Base1; GetCustomValue('VAT_Base1')) { }
            column(VAT_Description1; GetCustomValue('VAT_Description1')) { }
            column(VAT_Amount1; GetCustomValue('VAT_Amount1')) { }
            column(VAT_Base2; GetCustomValue('VAT_Base2')) { }
            column(VAT_Description2; GetCustomValue('VAT_Description2')) { }
            column(VAT_Amount2; GetCustomValue('VAT_Amount2')) { }
            column(VAT_Base3; GetCustomValue('VAT_Base3')) { }
            column(VAT_Description3; GetCustomValue('VAT_Description3')) { }
            column(VAT_Amount3; GetCustomValue('VAT_Amount3')) { }

            column(TPaymentMethod1; GetCustomValue('TPaymentMethod1')) { }
            column(DatScadenze1; GetCustomValue('DatScadenze1')) { }
            column(DecImportoRate1; GetCustomValue('DecImportoRate1')) { }
            column(TPaymentMethod2; GetCustomValue('TPaymentMethod2')) { }
            column(DatScadenze2; GetCustomValue('DatScadenze2')) { }
            column(DecImportoRate2; GetCustomValue('DecImportoRate2')) { }
            column(TPaymentMethod3; GetCustomValue('TPaymentMethod3')) { }
            column(DatScadenze3; GetCustomValue('DatScadenze3')) { }
            column(DecImportoRate3; GetCustomValue('DecImportoRate3')) { }

            column(TotalAmount; GetCustomValue('TotalAmount')) { }
            column(TotalAmountVAT; GetCustomValue('TotalAmountVAT')) { }
            column(TotalAmountInclVAT; GetCustomValue('TotalAmountInclVAT')) { }
            column(SalesInvoiceHeader_CurrencyCode; GetCustomValue('SalesInvoiceHeader_CurrencyCode')) { }


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
        }


    }
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
    begin
        if LabelName = 'Tariff No.' then
            exit('Tariff No.');
        exit(LabelName);
    end;

    local procedure GetCustomValue(LabelName: Text): Text
    begin
        exit('   ');
    end;

}
