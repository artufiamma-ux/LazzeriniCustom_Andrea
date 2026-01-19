namespace Lazzerini;

using Microsoft.Warehouse.Structure;
pageextension 50217 XVWBins extends "Bins"
{
    layout
    {
        addafter("Bin Type Code")
        {
            field("Cod zona"; Rec."Cod zona")
            {
                ApplicationArea = All;
            }
            field("Tipo Prelievo"; Rec."Tipo Prelievo")
            {
                ApplicationArea = All;
            }
        }
    }
}
