namespace Lazzerini;

using Microsoft.Sales.History;
using Microsoft.Sales.Customer;

reportextension 50230 XVStandardSalesInvoiceAcc extends "Standard Sales - Invoice"
{
    RDLCLayout = 'XVFatturaAccompagnatoria.rdl';

    dataset
    {

        add(Header)
        {
            column(ShipToName; "Ship-to Name") { }
            column(EORICode; GetEORICode("Sell-to Customer No.")) { }
            column(ACCOMPAGNATORIA; ACCOMPAGNATORIA) { }
            column(TipoDocumento; GetTipoDocumento(ACCOMPAGNATORIA, "Sell-to Country/Region Code")) { }
        }

    }

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
                exit('Fattura Accompagnatoria')
            else
                exit('Fattura')
        else
            if ACCOMPAGNATORIA then
                exit('Accompanying Invoice')
            else
                exit('Invoice');
        exit('');
    end;
}
