namespace Xview.Custom.Lazzerini;

tableextension 50227 "XV Ext EOS055 Handling Unit As" extends "EOS055 Handling Unit Assignm."
{
    fields
    {
        field(50050; "Nr Scatola"; Integer)
        {
            Caption = 'Nr Scatola';
            DataClassification = ToBeClassified;
        }
        field(50051; "Progressivo Serie Spedizione"; Integer)
        {
            Caption = 'Progressivo Serie Spedizione';
            DataClassification = ToBeClassified;
        }
        field(50052; "Warehouse Shipment No."; Code[20])
        {
            Caption = 'Warehouse Shipment No.';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(ReportColliKey; "Progressivo Serie Spedizione", "Nr Scatola")
        {
        }
    }
}
