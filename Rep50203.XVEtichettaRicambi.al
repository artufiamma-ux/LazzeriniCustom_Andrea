report 50203 "XV Etichetta Ricambi"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/XVEtichettaRicambi.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(ShipmentHeader; "Warehouse Shipment Header")
        {
            RequestFilterFields = "No.";

            dataitem(ShipmentLine; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = field("No.");

                column(ItemNo; ShipmentLine."Item No.") { }
                column(ItemReference; ItemReferenceNo) { }
                column(Quantity; ShipmentLine.Quantity) { }

                trigger OnAfterGetRecord()
                var
                    ItemReference: Record "Item Reference";
                begin
                    ItemReferenceNo := '';

                    // Ricerca Item Reference per articolo
                    ItemReference.SetRange("Item No.", ShipmentLine."Item No.");
                    ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::Customer);

                    if ItemReference.FindFirst() then
                        ItemReferenceNo := ItemReference."Reference No.";
                end;
            }
        }
    }

    var
        ItemReferenceNo: Code[50];
}