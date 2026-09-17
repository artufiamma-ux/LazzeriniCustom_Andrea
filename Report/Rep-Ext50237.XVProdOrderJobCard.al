namespace Xview.Custom.Lazzerini;

using System.Text;


reportextension 50237 "XV ProdOrderJobCard" extends "EOS 07000 MES ProdOrderJobCard"
{
    RDLCLayout = './ReportLayouts/XVEOS07000ProdOrderJobCard.rdl';
    dataset
    {
        add("Prod. Order Line")
        {
            column(QtyDaProdurre; Quantity)
            {
            }
        }
        add("Prod. Order Component")
        {
            column(Descrizione; "Description")
            {
            }
            column(ArticoloComponente; "Item No.")
            {
            }
            column(Barcode; EncodedText)
            {
            }
        }
        modify("Prod. Order Component")
        {
            trigger OnAfterAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface System.Text."Barcode Font Provider";

            begin
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
        EncodedText: Text;
}

