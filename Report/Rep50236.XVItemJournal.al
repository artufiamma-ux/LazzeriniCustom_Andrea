namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Journal;
using Microsoft.Manufacturing.Document;
using Microsoft.Sales.Document;
using System.Text;

report 50236 "XV Item Journal"
{
    Caption = 'XV Item Journal';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/XVItemJournal.rdl';

    dataset
    {
        dataitem(ItemJournalLine; "Item Journal Line")
        {
            column(OrderNo; "Order No.")
            {
            }
            column(OrderLineNo; "Order Line No.")
            {
            }
            column(Qty; Quantity)
            {
            }


            /* InfoArray */
            column(EOS055HandlingUnitNo; EOSHandlingUnitNo) { }
            column(InformazioniSocieta; InformazioniSocieta) { }
            column(NomeCliente; NomeCliente) { }
            column(IdentificativoGaraProgetto; IdentificativoGaraProgetto) { }
            column(CodArticoloCliente; CodArticoloCliente) { }
            column(DescrizioneArticoloCliente; DescrizioneArticoloCliente) { }
            column(RifOrdineCliente; RifOrdineCliente) { }
            column(CodArticolo; "Item No.") { }
            column(KitBus; KitBus) { }
            column(OrdNo; OrdNo) { }
            column(OrdLineNo; OrdLineNo) { }
            /* End InfoArray */
            /* Labels */
            column(LblCliente; LblCliente) { }
            column(LblContratto; LblContratto) { }
            column(LblCup; LblCup) { }
            column(LblOrdine; LblOrdine) { }
            column(LblQta; LblQta) { }
            column(LblArticolo; LblArticolo) { }
            column(LblKitBus; LblKitBus) { }
            /* End Labels */
            column(Barcode; EncodedText)
            {
            }

            trigger OnPreDataItem()
            begin

                if (JournalTemplateName <> '') AND (JournalBatchName <> '') AND (LineNo <> 0) then begin
                    SetRange("Journal Template Name", JournalTemplateName);
                    SetRange("Journal Batch Name", JournalBatchName);
                    SetRange("Line No.", LineNo);
                end;

            end;

            trigger OnAfterGetRecord()
            var
                RecSalesLine: Record "Sales Line";
                RecProductionOrder: Record "Production Order";
                RecProOrdLine: Record "Prod. Order Line";
                RecSalesHeader: Record "Sales Header";
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";
                CodOrdVen: Code[20];

            begin

                InformazioniSocieta := 'Lazzerini S.r.l. S.B.';
                RecProductionOrder.SetRange("No.", "Order No.");
                if RecProductionOrder.FindFirst() then begin
                    CodOrdVen := RecProductionOrder."Nr. Ordine di vendita";
                    CodArticolo := RecProductionOrder."Source No.";
                    RecSalesHeader.SetRange("No.", CodOrdVen);
                    if RecSalesHeader.FindFirst() then begin
                        OrdNo := RecSalesHeader."No.";
                        NomeCliente := RecSalesHeader."Bill-to Name";
                        IdentificativoGaraProgetto :=
                                                'CIG: ' + Format(RecSalesHeader."Fattura Tender Code") +
                                                ' - CUP: ' + Format(RecSalesHeader."Fattura Project Code");
                        RecProOrdLine.SetRange("Prod. Order No.", "Order No.");
                        RecProOrdLine.SetRange("Line No.", "Order Line No.");
                        if RecProOrdLine.FindFirst() then begin
                            OrdLineNo := RecProOrdLine."XV Line No.";
                            KitBus := RecProOrdLine."XV Kit Bus";
                            EOSHandlingUnitNo := RecProOrdLine."EOS055 Handling Unit No.";
                        end;
                        RecSalesLine.SetRange("Document No.", "CodOrdVen");
                        RecSalesLine.SetRange("Line No.", OrdLineNo);

                        if RecSalesLine.FindFirst() then begin
                            RifOrdineCliente := RecSalesLine."Item Reference No.";
                            CodArticoloCliente := RecSalesLine."Item Reference No.";
                            DescrizioneArticoloCliente := RecSalesLine."Description";
                            CodArticolo := RecSalesLine."No.";
                        end;
                    end;
                    // Declare the barcode provider using the barcode provider interface and enum
                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    // Declare the font using the barcode symbology enum
                    BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
                    // Set data string source
                    BarcodeString := CodArticolo;
                    // Validate the input. This method is not available for 2D provider
                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    // Encode the data string to the barcode font
                    EncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
                end;
            end;
        }
    }
    var
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];
        LineNo: Integer;
        InformazioniSocieta: Text;
        NomeCliente: Text;
        IdentificativoGaraProgetto: Text;
        CodArticoloCliente: Text;
        DescrizioneArticoloCliente: Text;
        RifOrdineCliente: Text;
        OrdLineNo: Integer;
        OrdNo: Code[20];
        CodArticolo: Code[20];
        EOSHandlingUnitNo: Code[20];
        KitBus: Text;
        LblCliente: Label 'Customer / Cliente: ';
        LblContratto: Label 'Contract / Contratto: ';
        LblCup: Label 'CUP: ';
        LblOrdine: Label 'Purchase Order / Ordine Acquisto: ';
        LblQta: Label 'Q.ty / Q.tà: ';
        LblArticolo: Label 'Lazzerini Item / Articolo Lazzerini: ';
        LblKitBus: Label 'Kit Bus: ';
        EncodedText: Text;

    procedure SetParameters(ItemJournalLine: Record "Item Journal Line")
    begin
        JournalTemplateName := ItemJournalLine."Journal Template Name";
        JournalBatchName := ItemJournalLine."Journal Batch Name";
        LineNo := ItemJournalLine."Line No.";
    end;

}
