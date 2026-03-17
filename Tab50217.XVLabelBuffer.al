namespace Lazzerini;
table 50217 "XV Label Buffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer) { }
        field(2; "Item No."; Code[20]) { }
        field(3; "Customer No."; Code[20]) { }
        field(4; "Item Reference"; Code[50]) { }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }
}
