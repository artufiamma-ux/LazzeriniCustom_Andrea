namespace Custom.Custom;

using Microsoft.Sales.History;

pageextension 50230 "XV Posted Sales Shipments " extends "Posted Sales Shipments"
{
    layout
    {
        addafter("No.")
        {
            field("Nr Fattura Proforma"; Rec."Nr fattura proforma")
            {
                ApplicationArea = All;
                Caption = 'Nr Fattura Proforma';
            }
            field("Nr Fattura"; Rec."Nr fattura")
            {
                ApplicationArea = All;
                Caption = 'Nr Fattura';
            }
        }
    }

}
