namespace Custom.Custom;

tableextension 50228 "XV EOS055 Handling Unit" extends "EOS055 Handling Unit"
{
    fields
    {
        field(50049; "Created From Handling Unit No."; Code[20])
        {
            Caption = 'Created From Handling Unit No.';
            DataClassification = ToBeClassified;
        }
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
