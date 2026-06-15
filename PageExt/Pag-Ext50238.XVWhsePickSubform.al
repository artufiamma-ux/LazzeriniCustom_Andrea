namespace Custom.Custom;

using Microsoft.Inventory.Item;
using Microsoft.Warehouse.Activity;

pageextension 50238 "XV Whse. Pick Subform" extends "Whse. Pick Subform"
{

    layout
    {
        addafter("Item No.")
        {
            field("Inventory Posting Group"; InventoryPostingGroup)
            {
                ApplicationArea = All;

                CaptionML = ITA = 'Cat. reg. magazzino',
                ENU = 'Inventory Posting Group';

                Editable = false;
            }
        }
    }

    var
        InventoryPostingGroup: Code[20];

    trigger OnAfterGetRecord()
    var
        ItemRec: Record Item;
    begin
        InventoryPostingGroup := '';

        if ItemRec.Get(Rec."Item No.") then
            InventoryPostingGroup := ItemRec."Inventory Posting Group";
    end;
}
