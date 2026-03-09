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

                column(ItemNo; "Item No.") { }
                column(OrderNo; "Source No.") { }

                column(PalletNo; PalletNo) { }
                column(SerieNo; SerieNo) { }

                column(Barcode; EncodedText) { }

                trigger OnAfterGetRecord()
                var
                    BarcodeString: Text;
                    iPallet: Integer;
                    iSerie: Integer;
                begin
                    // Validazione parametri
                    if (NrTotaleSerie <= 0) or (NrTotalePallet <= 0) or (NrCopieUDC <= 0) then
                        exit;

                    // Loop per pallet e serie
                    for iPallet := 1 to NrTotalePallet do begin
                        for iSerie := 1 to NrTotaleSerie do begin
                            PalletNo := iPallet;
                            SerieNo := iSerie;

                            // Barcode = ItemNo-Serie-Pallet
                            BarcodeString := StrSubstNo('%1-%2-%3', "Item No.", SerieNo, PalletNo);
                            EncodedText := GenerateBarcode(BarcodeString);
                        end;
                    end;
                end;
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

                    field(StampaBasamenti; StampaBasamenti)
                    {
                        Caption = 'Stampa Basamenti';
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
        StampaBasamenti: Boolean;

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