namespace Xview.Custom.Lazzerini;

table 50216 "XV Tipo Etichetta Spedizione"
{
    Caption = 'Tipi Etichetta';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Codice';
            NotBlank = true;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Descrizione';
        }
        field(3; "Blocked"; Boolean)
        {
            Caption = 'Bloccato';
            ToolTip = 'Se selezionato, il valore non può essere usato nei documenti.';
        }
    }

    keys
    {
        key(PK; "Code") { Clustered = true; }
        key(DescIdx; "Description") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Description") { }
    }
}
