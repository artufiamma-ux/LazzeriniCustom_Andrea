namespace Xview.Custom.Lazzerini;

using Microsoft.Sales.History;

tableextension 50219 "XV Sales Invoice Line"
    extends "Sales Invoice Line"
{
    fields
    {
        field(50200; "Progressivo Kit Bus"; Integer)
        {
            Caption = 'Progressivo Kit Bus';
            DataClassification = CustomerContent;
        }

        field(50201; "Kit Bus"; Code[20])
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

        field(50204; "Qta. Origine Layout"; Code[20])
        {
            Caption = 'Qta. Origine Layout';
            DataClassification = CustomerContent;

        }
    }
}
