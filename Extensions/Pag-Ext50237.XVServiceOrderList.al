namespace Lazzerini;

using Microsoft.Service.Document;

pageextension 50237 "XV Service Order List" extends "Service Orders"
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
