namespace Lazzerini;

using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;

pageextension 50230 "XV Purchase Order" extends "Purchase Order"
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
