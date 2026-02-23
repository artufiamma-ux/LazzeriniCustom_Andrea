namespace Lazzerini;

using Microsoft.Service.Item;

pageextension 50241 "XV ServiceItem List" extends "Service Item List"
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
