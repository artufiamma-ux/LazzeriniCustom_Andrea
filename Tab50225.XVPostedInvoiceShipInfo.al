namespace Xview.Custom.Lazzerini;
table 50225 "XV Posted Invoice Ship Info"
{
    Caption = 'XV Posted Invoice Ship Info';



    DataClassification = CustomerContent;

    fields
    {
        field(1; "Invoice No."; Code[20]) { }
        field(2; "Nr. Colli"; Integer) { }
        field(3; "Peso Netto"; Decimal) { }
        field(4; "Peso Lordo"; Decimal) { }
        field(5; "Aspetto Beni"; Text[100]) { }
        field(6; "Modificato manualmente"; Boolean) { }
    }

    keys
    {
        key(PK; "Invoice No.") { Clustered = true; }
    }

}
