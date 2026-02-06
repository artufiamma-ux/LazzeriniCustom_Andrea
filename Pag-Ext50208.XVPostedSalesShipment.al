namespace Lazzerini;
using Microsoft.Sales.History;

pageextension 50208 "XV Posted Sales Shipment Ext" extends "Posted Sales Shipment"
{
    layout
    {
        addlast(General)
        {
            field("Nr fattura proforma"; Rec."Nr fattura proforma")
            {
                ApplicationArea = All;
            }

            field("Cod valura proforma"; Rec."Cod valura proforma")
            {
                ApplicationArea = All;
            }

            field("Costi di trasporto"; Rec."Costi di trasporto")
            {
                ApplicationArea = All;
            }
        }
    }
}
