namespace Lazzerini;

using Microsoft.Sales.History;

pageextension 50223 "XV Posted Sales Invoices" extends "Posted Sales Invoices"
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
