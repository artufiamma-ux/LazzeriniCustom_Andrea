namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Document;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Warehouse.History;

pageextension 50223 "XV Production BOM Lines"
    extends "Production BOM Lines"
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
