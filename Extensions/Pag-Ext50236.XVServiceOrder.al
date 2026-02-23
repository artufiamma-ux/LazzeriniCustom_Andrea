namespace Lazzerini;

using Microsoft.Service.Document;

pageextension 50236 "XV Service Order" extends "Service Order"
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
