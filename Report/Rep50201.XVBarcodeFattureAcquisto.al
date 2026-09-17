namespace Xview.Custom.Lazzerini;

using Microsoft.Purchases.Document;
using System.Text;


report 50201 "XV Barcode Fattura Acquisto"
{
    UsageCategory = Administration;
    ApplicationArea = All;

    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/BarcodeFatAcquisto.rdl';

    Caption = 'Barcode Fattura Acquisto';
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Purchase Header")
        {
            // Filtra solo Fatture Acquisto (se vuoi includere anche Ordini rimuovi il filtro)
            DataItemTableView = where("Document Type" = const(Invoice));

            // Campi di business
            column(DocumentType; "Document Type") { }
            column(No_; "No.") { }
            column(Barcode; EncodedText)
            {
            }

            trigger OnAfterGetRecord()
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
                BarcodeString := "No.";

                // Validate the input. This method is not available for 2D provider
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);

                // Encode the data string to the barcode font
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
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }

    }


    var
        // Variable for the barcode encoded string
        EncodedText: Text;

}
