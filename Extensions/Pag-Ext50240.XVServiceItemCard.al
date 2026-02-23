namespace Lazzerini;

using Microsoft.Service.Item;

pageextension 50240 "XV ServiceItem Card" extends "Service Item Card"
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
