namespace Lazzerini;

using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.History;

tableextension 50310 "XV Posted Whse. Shipment Line"
    extends "Posted Whse. Shipment Line"
{
    fields
    {
        field(50200; "Progressivo Kit Bus"; Integer)
        {
            Caption = 'Progressivo Kit Bus';
            DataClassification = CustomerContent;
        }

        field(50201; "Kit Bus"; Boolean)
        {
            Caption = 'Kit Bus';
            DataClassification = CustomerContent;
        }

        field(50202; "Nr. Layout"; Code[20])
        {
            Caption = 'Nr. Layout';
            DataClassification = CustomerContent;
        }

        field(50203; "Posizione Layout"; Code[20])
        {
            Caption = 'Posizione Layout';
            DataClassification = CustomerContent;
        }

        field(50204; "Qta. Origine Layout"; Decimal)
        {
            Caption = 'Qta. Origine Layout';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
    }
}
