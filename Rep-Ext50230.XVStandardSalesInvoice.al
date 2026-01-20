namespace Lazzerini;

using Microsoft.Sales.History;
using Microsoft.Sales.Customer;

reportextension 50230 XVStandardSalesInvoice extends "Standard Sales - Invoice"
{
    RDLCLayout = 'XVFatturaAccompagnatoria.rdl';

    dataset
    {
        add(Header)
        {
            column(ShipToName; "Ship-to Name") { }
            column(EORICode; GetEORICode("Sell-to Customer No.")) { }
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
}

