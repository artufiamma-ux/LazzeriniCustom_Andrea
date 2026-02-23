namespace Lazzerini;

using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;

pageextension 50232 "XV PostedPurchase Invoice" extends "Posted Purchase Invoice"
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
