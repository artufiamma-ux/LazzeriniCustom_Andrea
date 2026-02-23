namespace Lazzerini;

using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;

pageextension 50231 "XV Purchase Order List" extends "Purchase Order List"
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
