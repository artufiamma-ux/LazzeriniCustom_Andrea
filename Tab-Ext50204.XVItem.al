namespace Lazzerini;

using Microsoft.Inventory.Item;


tableextension 50204 XVItem extends Item
{
    fields
    {
        field(50100; " Tipo Etichetta"; Code[20])
        {
            Caption = ' Tipo Etichetta';
            DataClassification = ToBeClassified;
            TableRelation = "XV Tipo Etichetta";

        }
        field(50101; "Tipo Prelievo"; Code[20])
        {
            Caption = 'Tipo Prelievo';
            DataClassification = ToBeClassified;
            TableRelation = "XV Tipo Prelievo Articoli";

        }
        field(50102; "Articolo CKD"; Boolean)
        {
            Caption = 'Articolo CKD';
            DataClassification = CustomerContent;
        }

        field(50103; "CKD-Nr. Art. origine"; Code[20])
        {
            Caption = 'CKD-Nr. Art. origine';
            TableRelation = item."CKD-Nr. Art. origine";
            DataClassification = CustomerContent;
        }
        field(50104; "In Packing CKD"; Enum "XV Packing CKD")
        {
            Caption = 'In Packing CKD';
            DataClassification = CustomerContent;
        }
        field(50065; "Posizione Layout"; code[20]) { Caption = 'Posizione Layout'; DataClassification = ToBeClassified; }
    }
}
