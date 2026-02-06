namespace Lazzerini;

using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.History;

tableextension 50270 "XV Posted Whse Shipment Header"
    extends "Posted Whse. Shipment Header"
{
    fields
    {
        field(50200; "Progressivo Kit Bus"; Integer)
        {
            Caption = 'Progressivo Kit Bus';
            DataClassification = CustomerContent;
            ObsoleteState = Pending;
            ObsoleteReason = 'Campo non più utilizzato sulle spedizioni warehouse registrate.';
        }

        field(50201; "Kit Bus"; Boolean)
        {
            Caption = 'Kit Bus';
            DataClassification = CustomerContent;
            ObsoleteState = Pending;
            ObsoleteReason = 'Campo non più utilizzato sulle spedizioni warehouse registrate.';
        }

        field(50202; "Nr. Layout"; Code[20])
        {
            Caption = 'Nr. Layout';
            DataClassification = CustomerContent;
            ObsoleteState = Pending;
            ObsoleteReason = 'Campo non più utilizzato sulle spedizioni warehouse registrate.';
        }

        field(50203; "Posizione Layout"; Code[20])
        {
            Caption = 'Posizione Layout';
            DataClassification = CustomerContent;
            ObsoleteState = Pending;
            ObsoleteReason = 'Campo non più utilizzato sulle spedizioni warehouse registrate.';
        }

        field(50204; "Qta. Origine Layout"; Decimal)
        {
            Caption = 'Qta. Origine Layout';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            ObsoleteState = Pending;
            ObsoleteReason = 'Campo non più utilizzato sulle spedizioni warehouse registrate.';
        }
    }
}
