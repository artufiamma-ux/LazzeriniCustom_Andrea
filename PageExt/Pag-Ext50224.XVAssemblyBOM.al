namespace Xview.Custom.Lazzerini;
using Microsoft.Inventory.BOM;



pageextension 50224 "XV Assembly BOM"
    extends "Assembly BOM"
{
    layout
    {
        addafter(Description)
        {
            field("Posizione Layout"; Rec."Posizione Layout")
            {
                ApplicationArea = All;
            }
        }
    }
}
