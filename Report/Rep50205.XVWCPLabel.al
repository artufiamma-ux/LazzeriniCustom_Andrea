namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Document;
using System.Text;

report 50205 "XV WCP Label"
{
    ApplicationArea = All;
    Caption = 'Etichetta WCP';
    UsageCategory = Documents;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/XVEtichettaWCP.rdl';
    dataset
    {
        dataitem(WarehouseReceiptHeader; "Warehouse Receipt Header")
        {
            column(No; "No.")
            {
            }
            column(Barcode; EncodedText)
            {
            }
            trigger OnPreDataItem()
            begin
                if WCPNo <> '' then
                    SetRange("No.", WCPNo);

            end;

            trigger OnAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";

            begin
                // Declare the barcode provider using the barcode provider interface and enum
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;

                // Declare the font using the barcode symbology enum
                BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";

                // Set data string source
                BarcodeString := "No.";

                // Validate the input. This method is not available for 2D provider
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);

                // Encode the data string to the barcode font
                EncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
            end;

        }
    }
    procedure SetParameters(DocumentNo: Code[20])
    begin
        WCPNo := DocumentNo;
    end;

    var
        EncodedText: Text;
        WCPNo: Code[20];

}
