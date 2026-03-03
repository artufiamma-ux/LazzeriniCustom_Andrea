report 50202 "XV Etichette UDC"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/Etichette UDC.rdl';
    Caption = 'Etichette UDC';

    dataset
    {
        dataitem(Header; "Warehouse Shipment Header")
        {
            // Filtra solo per record validi, se serve
            // DataItemTableView = ...

            column(No_; "No.") { }
            column(ShippingNo; "Shipping No.") { }

            column(Barcode; EncodedText) { }
            column(SerieNo; SerieNo) { }
            column(PalletNo; PalletNo) { }

            trigger OnAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::Code39;

                // Barcode basato su No., SerieNo e PalletNo
                BarcodeString := Format("No.") + '-' + Format(SerieNo) + '-' + Format(PalletNo);

                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                EncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
            end;
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
                    field(NrTotaleSerie; NrTotaleSerie) { Caption = 'Nr Totale Serie'; ApplicationArea = All; }
                    field(NrTotalePallet; NrTotalePallet) { Caption = 'Nr Totale Pallet'; ApplicationArea = All; }
                    field(NrCopieUDC; NrCopieUDC) { Caption = 'Numero Copie UDC'; ApplicationArea = All; }
                    field(StampaBasamenti; StampaBasamenti) { Caption = 'Stampa Basamenti'; ApplicationArea = All; }
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
}