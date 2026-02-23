namespace Lazzerini;

using Microsoft.Service.History;

pageextension 50239 "XV PostedService Invoice List" extends "Posted Service Invoices"
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
