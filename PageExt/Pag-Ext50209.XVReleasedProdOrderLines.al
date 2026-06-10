namespace Xview.Custom.Lazzerini;
using Microsoft.Manufacturing.Document;


pageextension 50209 "XV Released Prod. Order Lines" extends "Released Prod. Order Lines"
{
    layout
    {
        addafter("Description")
        {
            field("Status Materiali"; Rec."Status Materiali")
            {
                ApplicationArea = All;
            }
            field("Posizione Layout"; Rec."Posizione Layout")
            {
                ApplicationArea = All;
            }
        }
    }
}
