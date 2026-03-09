namespace Lazzerini;

using Microsoft.Sales.History;

pageextension 50225 "XV Posted Sales Shipment - Upd" extends "Posted Sales Shipment - Update"
{
    layout
    {
        addafter(Shipping)
        {
            group("Fattura Proforma")
            {
                field("Cod valuta proforma"; Rec."Cod valuta proforma")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
