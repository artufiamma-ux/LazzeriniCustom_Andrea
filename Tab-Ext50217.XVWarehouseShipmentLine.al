namespace Lazzerini;

using Microsoft.Warehouse.Document;

tableextension 50217 "XV Whse Shipment Line" extends "Warehouse Shipment Line"
{
    fields
    {
        field(50200; "Progressivo Kit Bus"; Integer)
        {
            Caption = 'Progressivo Kit Bus';
        }

        field(50201; "Posizione Layout"; Code[20])
        {
            Caption = 'Posizione Layout';
        }

        field(50202; "Nr. Layout"; Code[20])
        {
            Caption = 'Nr. Layout';
        }

        field(50203; "Qta. Origine Layout"; Decimal)
        {
            Caption = 'Qta. Origine Layout';
            DecimalPlaces = 0 : 5;
        }

        field(50204; "Kit Bus"; Code[20])
        {
            Caption = 'Kit Bus';
        }
    }
}
