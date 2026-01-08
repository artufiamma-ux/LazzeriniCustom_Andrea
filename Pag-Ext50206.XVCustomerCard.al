namespace Lazzerini;

using Microsoft.Sales.Customer;

pageextension 50206 XVCustomerCard extends "Customer Card"
{
    layout
    {
        addafter("Statistics Group")
        {
            field("Tipo Etichetta Spedizione"; Rec."Tipo Etichetta Spedizione")
            {
                ApplicationArea = All;
            }
            field("Codice EORI"; Rec."Codice EORI")
            {
                ApplicationArea = All;
            }
        }
    }
}
