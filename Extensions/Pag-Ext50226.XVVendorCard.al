namespace Lazzerini;

using Microsoft.Purchases.Vendor;


pageextension 50226 "XV Vendor Card" extends "Vendor Card"
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
