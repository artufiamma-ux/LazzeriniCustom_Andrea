namespace Lazzerini;

using Microsoft.Service.Contract;

pageextension 50242 "XV Service Contract" extends "Service Contract"
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
