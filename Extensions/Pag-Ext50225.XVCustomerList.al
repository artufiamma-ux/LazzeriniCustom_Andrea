namespace Lazzerini;

using Microsoft.Sales.Customer;


pageextension 50225 "XV Customer List" extends "Customer List"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(EOSFactbox; "EOS069 DCS FactBox")
            {
                ApplicationArea = All;
            }
        }
    }
}
