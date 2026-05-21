namespace Xview.Custom.Lazzerini;
using Microsoft.Manufacturing.Document;


pageextension 50195 "XV Planned Prod. Order Lines" extends "Planned Prod. Order Lines"
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