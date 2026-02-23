namespace Lazzerini;

using Microsoft.Sales.Customer;


pageextension 50224 "XV Customer Card" extends "Customer Card"
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
