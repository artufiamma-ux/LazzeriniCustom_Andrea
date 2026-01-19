namespace Lazzerini;
using Microsoft.Manufacturing.Document;


pageextension 50209 "XV Released Prod. Order Lines" extends "Released Prod. Order Lines"
{
    layout
    {
        addlast(content)
        {
            field("Status Materiali"; Rec."Status Materiali")
            {
                ApplicationArea = All;
            }
        }
    }
}
