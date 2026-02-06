namespace Lazzerini;

using Microsoft.Warehouse.Document;
using Microsoft.Sales.Document;

pageextension 50215 XVWhseShipmentSubform extends "Whse. Shipment Subform"
{
    layout
    {
        addafter("Description")
        {
            field("Progressivo Kit Bus"; Rec."Progressivo Kit Bus")
            {
                ApplicationArea = All;
            }

            field("Kit Bus"; Rec."Kit Bus")
            {
                ApplicationArea = All;
            }

            field("Nr. Layout"; Rec."Nr. Layout")
            {
                ApplicationArea = All;
            }

            field("Posizione Layout"; Rec."Posizione Layout")
            {
                ApplicationArea = All;
            }

            field("Qta. Origine Layout"; Rec."Qta. Origine Layout")
            {
                ApplicationArea = All;
            }
        }

    }
}
