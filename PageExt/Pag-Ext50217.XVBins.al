namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Structure;
pageextension 50217 XVWBins extends "Bins"
{
    layout
    {
        addafter("Bin Type Code")
        {
            field("Tipo Prelievo"; Rec."Tipo Prelievo")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
