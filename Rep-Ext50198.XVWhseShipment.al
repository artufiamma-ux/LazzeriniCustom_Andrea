reportextension 50198 WhseShipmentExt extends "Whse. - Shipment"
{
    RDLCLayout = './Warehouse/Document/XVWhseShipment.rdl';

    dataset
    {
        add("Warehouse Shipment Line")
        {
            // colonna per il valore
            column(InventoryQty; InventoryQty)
            {
            }

            // 👇 colonna per la label
            column(InventoryQtyLabel; InventoryQtyFormat)
            {
            }
        }

        modify("Warehouse Shipment Line")
        {
            trigger OnAfterAfterGetRecord()
            begin
                // calcola giacenza
                CalcInventory("Item No.", "Location Code");

                // imposta il testo della label
                InventoryQtyFormat := 'Giacenza Magazzino';
            end;
        }
    }

    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        InventoryQty: Decimal;
        InventoryQtyFormat: Text[50]; // campo per label

    local procedure CalcInventory(ItemNo: Code[20]; LocationCode: Code[10])
    begin
        InventoryQty := 0;

        if ItemNo = '' then
            exit;

        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetCurrentKey("Item No.", "Location Code");
        ItemLedgerEntry.SetRange("Item No.", ItemNo);
        ItemLedgerEntry.SetRange("Location Code", LocationCode);

        ItemLedgerEntry.CalcSums(Quantity);
        InventoryQty := ItemLedgerEntry.Quantity;
    end;
}