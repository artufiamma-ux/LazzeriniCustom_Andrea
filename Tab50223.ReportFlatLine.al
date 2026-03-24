namespace Lazzerini;
table 50223 "Report Flat Line"
{
    Caption = 'Report Flat Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer) { }
        field(2; "Document No"; Code[20]) { }
        field(3; "Table Line"; Text[100]) { }

        field(4; "Int Code"; Code[50]) { }
        field(5; "Ext Code"; Code[50]) { }
        field(6; "Description"; Text[100]) { }
        field(7; "UoM"; Text[50]) { }
        field(8; "Qty"; Decimal) { }
        field(9; "Unit Price"; Decimal) { }
        field(10; Amount; Decimal) { }
        field(11; VAT; Code[20]) { }
        field(12; "Delivery Date"; Date) { }
    }

    keys
    {
        key(PK; "Line No.") { Clustered = true; }
    }
}