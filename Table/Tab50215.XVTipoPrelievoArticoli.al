
namespace Xview.Custom.Lazzerini;

table 50215 "XV Tipo Prelievo Articoli"
{
    Caption = 'Tipi Prelievo - Articoli';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20]) { Caption = 'Codice'; NotBlank = true; }
        field(2; "Description"; Text[100]) { Caption = 'Descrizione'; }
        field(3; "Blocked"; Boolean) { Caption = 'Bloccato'; }
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
