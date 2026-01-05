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
    }
}
