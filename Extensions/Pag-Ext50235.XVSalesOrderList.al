namespace Lazzerini;

using Microsoft.Sales.Document;
using Microsoft.Sales.History;

pageextension 50235 "XV Sales Order List" extends "Sales Order List"
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
