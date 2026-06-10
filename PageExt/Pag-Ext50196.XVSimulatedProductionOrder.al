namespace Xview.Custom.Lazzerini;
using Microsoft.Manufacturing.Document;


pageextension 50196 "XV Simulated Prod. Order Lines" extends "Simulated Prod. Order Lines"
{
    layout
    {
        addafter("Description")
        {
            field("Posizione Layout"; Rec."Posizione Layout")
            {
                ApplicationArea = All;
            }
        }
    }
}