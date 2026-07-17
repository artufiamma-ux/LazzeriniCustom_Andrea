namespace Xview.Custom.Lazzerini;
table 50231 "XV Colli Carico Buffer"
{
    Caption = 'XV Colli Carico Buffer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Handling Unit No."; Code[20])
        {
            Caption = 'Handling Unit No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(3; "Description"; Text[500])
        {
            Caption = 'Description';
        }
        field(4; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
        }
        field(5; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
        }
        field(6; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date ';
        }
    }
    keys
    {
        key(PK; "Handling Unit No.")
        {
            Clustered = true;
        }
    }
}
