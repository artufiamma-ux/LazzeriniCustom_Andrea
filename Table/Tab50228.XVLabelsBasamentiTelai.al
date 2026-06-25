table 50228 "XV Labels Basamenti Telai"
{
    Caption = 'XV Labels Basamenti Telai';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Progressivo Kit Bus"; Integer)
        {
            Caption = 'Progressivo Kit Bus';
        }
        field(2; "Posizione Layout"; Code[20])
        {
            Caption = 'Posizione Layout';
        }
        field(3; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(4; "Drawing No."; Code[20])
        {
            Caption = 'Drawing No.';
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(6; "Item Reference No."; Code[50])
        {
            Caption = 'Item Reference No.';
        }
    }
    keys
    {
        key(PK; "Progressivo Kit Bus","Posizione Layout")
        {
            Clustered = true;
        }
    }
}
