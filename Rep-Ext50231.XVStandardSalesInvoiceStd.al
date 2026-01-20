namespace Lazzerini;

using Microsoft.Sales.History;
using Microsoft.Sales.Customer;

reportextension 50231 XVStandardSalesInvoiceStd extends "Standard Sales - Invoice"
{
    RDLCLayout = 'XVFatturaStandard.rdl';

    /*
        dataset
        {
            add(Header)
            {
                column(ShipToName; "Ship-to Name") { }
                column(EORICode; GetEORICode("Sell-to Customer No.")) { }
                column(ACCOMPAGNATORIA; ACCOMPAGNATORIA) { }
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
    */
}

