namespace Xview.Custom.Lazzerini;
table 50281 "Whse. Line Mob"
{
    Caption = 'Whse. Line Mob';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Record No."; Integer)
        {
        }

        field(2; "No."; Code[50])
        {
        }

        field(3; Description; Text[100])
        {
        }

        field(4; "Unit of Measure Code"; Code[10])
        {
        }

        field(5; Qty; Decimal)
        {
        }
    }

    keys
    {
        key(PK; "Record No.")
        {
            Clustered = true;
        }
    }
}