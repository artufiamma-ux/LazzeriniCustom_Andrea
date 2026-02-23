namespace Lazzerini;

using Microsoft.Purchases.Vendor;


pageextension 50227 "XV Vendor List" extends "Vendor List"
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
