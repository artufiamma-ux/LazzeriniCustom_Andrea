namespace Lazzerini;
using Microsoft.Manufacturing.Document;


pageextension 50194 "XV Finished Production Orders" extends "Finished Production Orders"
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