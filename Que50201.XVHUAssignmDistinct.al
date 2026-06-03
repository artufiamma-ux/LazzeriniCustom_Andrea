namespace Xview.Custom.Lazzerini;
using Microsoft.Warehouse.Document;
query 50201 "XV HUAssignmDistinct"
{
    QueryType = Normal;

    elements
    {
        dataitem(A; "EOS055 Handling Unit Assignm.")
        {
            column(HandlingUnitNo; "Handling Unit No.") { }
            column(EntryNo; "Entry No.") { }

            // Filtro su Source Type
            filter(SourceType; "Source Type") { }

            // Filtro su Handling Unit No. LIKE 'C%'
            filter(HandlingUnitFilter; "Handling Unit No.") { }

            dataitem(L; "Warehouse Shipment Line")
            {
                DataItemLink =
                    "Source No." = A."Source No.",
                    "Source Line No." = A."Source Line No.";

                column(No; "No.") { }
                column(LineNo; "Line No.") { }
            }
        }
    }
}
