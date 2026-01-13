namespace Lazzerini;

using Microsoft.Inventory.Item;


tableextension 50204 XVItem extends Item
{
    fields
    {
        field(50100; " Tipo Etichetta"; Enum "XV Tipo Etichetta Item")
        {
            Caption = ' Tipo Etichetta';
            DataClassification = ToBeClassified;

        }
        field(50101; "Tipo Prelievo"; Enum "XV Tipo Prelievo Item")
        {
            Caption = 'Tipo Prelievo';
            DataClassification = ToBeClassified;

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
    }
}
