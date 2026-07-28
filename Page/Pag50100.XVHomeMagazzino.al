namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Item;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Structure;

page 50100 "XV Home Magazzino"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Menu; "XV Menu Palmare")
            {
                ApplicationArea = All;
            }
        }
    }
}