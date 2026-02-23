namespace Lazzerini;

using Microsoft.Sales.Document;
using Microsoft.Sales.History;

pageextension 50234 "XV Sales Order" extends "Sales Order"
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
