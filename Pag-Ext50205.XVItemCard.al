namespace Lazzerini;

using Microsoft.Inventory.Item;

pageextension 50205 XVItemCad extends "Item Card"
{
    layout
    {
        addafter("Statistics Group")
        {
            field("Tipo Etichetta"; Rec." Tipo Etichetta")
            {
                ApplicationArea = All;
            }
            field("Tipo Prelievo"; Rec."Tipo Prelievo")
            {
                ApplicationArea = All;
            }
        }
    }
}
