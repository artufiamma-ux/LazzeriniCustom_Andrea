namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Item;

query 50204 "XV Item Drawings"
{
    QueryType = API;
    APIGroup = 'custom';
    APIPublisher = 'xv';
    APIVersion = 'v1.0';
    EntityName = 'qitemDrawing';
    EntitySetName = 'qitemDrawings';

    elements
    {
        dataitem(Item; Item)
        {
            column(id; SystemId) { }
            column(itemNo; "No.") { }
            column(description; Description) { }
            column(description2; "Description 2") { }
            column(itemType; Type) { }
            column(itemCategoryCode; "Item Category Code") { }
            column(unitVolume; "Unit Volume") { }
            column(unitOfMeasureId; "Unit of Measure Id") { }
            column(vendorNo; "Vendor No.") { }
            column(vendorItemNo; "Vendor Item No.") { }
            column(picture; Picture) { }

            // Inner Join nativo sulla seconda tabella
            dataitem(DrawingRec; "XV Drawings Management")
            {
                DataItemLink = "Drawing No." = Item."Drawing No.";
                SqlJoinType = InnerJoin;

                // Condizioni / Filtri fissi richiesti
                DataItemTableFilter = Active = const(true),
                                      Cancelled = const(false),
                                      "Visible Supplier Portal" = const(true);

                column(drawingNo; "Drawing No.") { }
                column(revision; Revision) { }
                column(componentDescription; "Component Description") { }
                column(designer; Designer) { }
                column(model; Model) { }

            }
        }
    }
}