namespace Xview.Custom.Lazzerini;
table 50227 "XV Drawing Lookup Buffer"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Drawing No."; Code[20]) { }
        field(2; "Revision ID"; Integer) { }
        field(3; "Revision"; Code[10]) { }
        field(4; "Description"; Text[100]) { }
        field(5; "Component Description"; Text[100]) { }
        field(6; "Model"; Code[20]) { }
    }

    keys
    {
        key(PK; "Drawing No.")
        {
            Clustered = true;
        }
    }
}