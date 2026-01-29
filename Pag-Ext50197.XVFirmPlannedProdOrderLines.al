namespace Lazzerini;
using Microsoft.Manufacturing.Document;


pageextension 50197 "XVFirmPlannedProd.OrderLines" extends "Firm Planned Prod. Order Lines"
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