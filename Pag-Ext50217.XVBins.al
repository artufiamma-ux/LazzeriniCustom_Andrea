namespace Lazzerini;

using Microsoft.Warehouse.Structure;
pageextension 50217 XVWBins extends "Bins"
{
    layout
    {
        addafter("Bin Type Code")
        {
            field("Cod zona2"; Rec."Cod zona")
            {
                ApplicationArea = All;
                ObsoleteState = Pending;
                ObsoleteReason = 'Usare il campo Cod. Zona standard al suo posto';
            }
            field("Tipo Prelievo"; Rec."Tipo Prelievo")
            {
                ApplicationArea = All;
            }
        }
    }
}
