report 50202 "XV Etichette UDC"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/Etichette UDC.rdl';
    Caption = 'Etichette UDC';

    dataset
    {
        // HEADER: spedizione
        dataitem(Header; "Warehouse Shipment Header")
        {
            RequestFilterFields = "No.";

            column(ShipmentNo; "No.") { }
            column(Customer; "External Document No.") { }
            column(LocationCode; "Location Code") { }
            column(ShipTo; "Shipping Agent Code") { }
            column(Carrier; "Shipping Agent Service Code") { }

            // LINE: articoli dentro la spedizione
            dataitem(Line; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = field("No.");

                column(OrderNo; "Source No.") { }

                column(PalletNo; PalletNo) { }
                column(SerieNo; SerieNo) { }

                column(Barcode; EncodedText) { }

            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Opzioni)
                {
                    field(NrTotaleSerie; NrTotaleSerie)
                    {
                        Caption = 'Nr Totale Serie';
                        ApplicationArea = All;
                    }

                    field(NrTotalePallet; NrTotalePallet)
                    {
                        Caption = 'Nr Totale Pallet';
                        ApplicationArea = All;
                    }

                    field(NrCopieUDC; NrCopieUDC)
                    {
                        Caption = 'Numero Copie UDC';
                        ApplicationArea = All;
                    }

                    field(NrPallettAccessori; NrPallettAccessori)
                    {
                        Caption = 'Nr Pallet Accessori';
                        ApplicationArea = All;
                    }
                    field(DescrPallettAccessori; DescrPallettAccessori)
                    {
                        Caption = 'Descrizione Pallet Accessori';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        EncodedText: Text;
        SerieNo: Integer;
        PalletNo: Integer;

        NrTotaleSerie: Integer;
        NrTotalePallet: Integer;
        NrCopieUDC: Integer;
        NrPallettAccessori: Integer;
        DescrPallettAccessori: Text[100];

    local procedure GenerateBarcode(BarcodeString: Text): Text
    var
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProvider: Interface "Barcode Font Provider";
    begin
        BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;

        BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
        exit(BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology));
    end;
}