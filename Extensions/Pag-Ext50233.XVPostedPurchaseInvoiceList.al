namespace Lazzerini;

using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;

pageextension 50233 "XV PostedPurchase Invoice List" extends "Posted Purchase Invoices"
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
