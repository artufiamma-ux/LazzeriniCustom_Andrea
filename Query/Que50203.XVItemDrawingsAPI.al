namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Item;

query 50203 "XV Item Drawings API"
{
    QueryType = Normal;

    elements
    {
        dataitem(Item; Item)
        {
            DataItemTableFilter =
                "Drawing No." = filter(<> '');

            column(SystemId; SystemId) { }
            column(ItemNo; "No.") { }
            column(Description; Description) { }
            column(Description2; "Description 2") { }
            column(ItemType; Type) { }
            column(ItemCategoryCode; "Item Category Code") { }
            column(UnitVolume; "Unit Volume") { }
            column(UnitOfMeasureId; "Unit of Measure Id") { }
            column(VendorNo; "Vendor No.") { }
            column(VendorItemNo; "Vendor Item No.") { }
            column(DrawingNo; "Drawing No.") { }

            dataitem(Draw; "XV Drawings Management")
            {
                DataItemLink =
                    "Drawing No." = Item."Drawing No.";

                DataItemTableFilter =
                    Active = const(true),
                    Cancelled = const(false),
                    "Visible Supplier Portal" = const(true);

                column(DrawingDescription; Description) { }
                column(DrawingRevision; Revision) { }
                column(DrawingComponentDescription; "Component Description") { }
                column(DrawingDesigner; Designer) { }
                column(DrawingModel; Model) { }
            }
        }
    }
}
