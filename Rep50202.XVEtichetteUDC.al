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
            RequestFilterFields = "No.";

            column(ShipmentNo; "No.") { }
            column(Customer; "External Document No.") { }
            column(LocationCode; "Location Code") { }

            column(Serie; NrTotaleSerie) { }
            column(Pallet; NrTotalePallet) { }

            dataitem(Line; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = field("No.");

                column(ItemNo; "Item No.") { }

                column(OrderNo; "Source No.") { }

                column(Barcode; EncodedText) { }

                trigger OnAfterGetRecord()
                var
                    BarcodeString: Text;
                    BarcodeSymbology: Enum "Barcode Symbology";
                    BarcodeFontProvider: Interface "Barcode Font Provider";
                begin
                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbology := Enum::"Barcode Symbology"::Code39;

                    BarcodeString := "Item No.";

                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    EncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
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

        NrTotaleSerie: Integer;
        NrTotalePallet: Integer;
        NrCopieUDC: Integer;
        StampaBasamenti: Boolean;
}