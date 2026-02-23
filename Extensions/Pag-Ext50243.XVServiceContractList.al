namespace Lazzerini;

using Microsoft.Service.Contract;

pageextension 50243 "XV Service Contract List" extends "Service Contract List"
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
