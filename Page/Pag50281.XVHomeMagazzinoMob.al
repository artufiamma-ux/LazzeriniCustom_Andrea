namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Item;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Structure;

page 50281 "XV Home Magazzino Mob"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Menu; "XV Menu Palmare Mob")
            {
                ApplicationArea = All;
            }
        }
    }
}