namespace Lazzerini;

tableextension 50225 "XV EOS CWS Shipment Line" extends "EOS CWS Shipment Line"
{
    fields
    {
        field(50050; "xv Kit Bus"; Code[20])
        {
            Caption = 'xv Kit Bus';
            DataClassification = ToBeClassified;
        }
        field(50051; "xv Progressivo Kit Bus"; Integer)
        {
            Caption = 'xv Progressivo Kit Bus';
            DataClassification = ToBeClassified;
        }
    }
}
