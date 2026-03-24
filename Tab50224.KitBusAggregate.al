namespace Lazzerini;
table 50224 "Kit Bus Aggregate"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Order No."; Code[20]) { }
        field(2; "Kit Bus"; Code[20]) { }

        field(3; "Sum Amount"; Decimal) { }
        field(4; "Count Progressivo"; Integer) { }
        field(5; "VAT"; Code[20]) { }
        field(6; "Description"; Text[100]) { }
    }

    keys
    {
        key(PK; "Order No.", "Kit Bus") { Clustered = true; }
    }
}