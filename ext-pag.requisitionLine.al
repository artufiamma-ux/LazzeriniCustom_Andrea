namespace Xview.Custom.Lazzerini;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Requisition;


pageextension 50193 "XV Planning Worksheet" extends "Planning Worksheet"
{
    layout
    {
        addafter("Accept Action Message")
        {
            field("Posizione Layout"; Rec."Posizione Layout")
            {
                ApplicationArea = All;
            }
        }
    }
}