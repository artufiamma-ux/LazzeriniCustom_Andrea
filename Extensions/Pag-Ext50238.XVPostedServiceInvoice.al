namespace Lazzerini;

using Microsoft.Service.History;

pageextension 50238 "XV PostedService Invoice" extends "Posted Service Invoice"
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
