namespace Xview.Custom.Lazzerini;
using Microsoft.Warehouse.Document;
using Microsoft.Inventory.Ledger;
using System.Text;

reportextension 50198 WhseShipmentExt extends "Whse. - Shipment"
{
    RDLCLayout = './ReportLayouts/XVWhseShipment.rdl';

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
            column(Barcode; EncodedText)
            {
            }

        }

        modify("Warehouse Shipment Line")
        {
            trigger OnAfterAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";

            begin
                // calcola giacenza
                CalcInventory("Item No.", "Location Code");

                // imposta il testo della label
                InventoryQtyFormat := 'Giacenza Magazzino';
                // Declare the barcode provider using the barcode provider interface and enum
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;

                // Declare the font using the barcode symbology enum
                BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";

                // Set data string source
                BarcodeString := "Item No.";

                // Validate the input. This method is not available for 2D provider
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);

                // Encode the data string to the barcode font
                EncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
            end;
        }
    }

    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        InventoryQty: Decimal;
        InventoryQtyFormat: Text[50]; // campo per label
        EncodedText: Text;

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