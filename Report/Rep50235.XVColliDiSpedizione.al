namespace Xview.Custom.Lazzerini;
using Microsoft.Warehouse.Document;
using System.Text;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Shipping;


report 50235 "XV Colli Di Spedizione"
{
    Caption = 'XV Colli Di Spedizione';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/XVColliDiSpedizione.rdl';
    dataset
    {
        dataitem(WhseShpt; "Warehouse Shipment Header")
        {
            DataItemTableView = sorting("No.");

            column(ShipmentNo; "No.") { }
            column(Numero_Totale_Pallet; "Numero Totale Pallet") { }
            column(Numero_Totale_Serie; "Numero Totale Serie") { }
            column(Cliente; Cliente) { }
            column(Vettore; Vettore) { }

            // DATAITEM Line
            // DATAITEM FIGLIO
            dataitem(HU; "EOS055 Handling Unit")
            {
                DataItemLink =
                    "Warehouse Shipment No." = field("No.");


                DataItemTableView =
                            SORTING("Progressivo Serie Spedizione", "Nr Scatola")
                            ORDER(Ascending)
                            WHERE("Nr Scatola" = FILTER(> 0));


                column(HandlingUnitNo; "No.") { }
                column(HUSourceNo; SourceNo) { }
                column(HUSourceLineNo; SourceLineNo) { }
                column(HUItemNo; ItemNo) { }
                column(HULotNo; LotNo) { }
                column(Indirizzo_Spedizione1; Indirizzo_Spedizione1) { }
                column(Indirizzo_Spedizione2; Indirizzo_Spedizione2) { }
                column(Indirizzo_Spedizione3; Indirizzo_Spedizione3) { }
                column(YourReference; YourReference) { }
                column(FormattedSerie; FormattedSerie) { }
                column(FormattedBox; FormattedBox) { }
                column(Formatted_Indirizzo_Spedizione; Formatted_Indirizzo_Spedizione) { }
                column(Formatted_Padestal; Formatted_Padestal) { }

                column(NrPalletAccessori; NrPalletAccessori)
                {
                    Caption = 'Nr Pallet Accessori';
                }

                column(DescrPalletAccessori; DescrPalletAccessori)
                {
                    Caption = 'Descrizione Pallet Accessori';
                }
                column(Barcode; EncodedText)
                {
                }
                column(NScatola; "Nr Scatola") { }

                trigger OnPreDataItem()
                begin
                    if NrScatolaFilter <> '' then
                        SetFilter("Nr Scatola", NrScatolaFilter);
                    if NrSerieFilter <> '' then
                        SetFilter("Progressivo Serie Spedizione", NrSerieFilter);
                end;

                trigger OnAfterGetRecord()
                var
                    BarcodeString: Text;
                    BarcodeSymbology: Enum "Barcode Symbology";
                    BarcodeFontProvider: Interface "Barcode Font Provider";
                    CustomerInfo: array[4] of Text[100];
                    HUA: Record "EOS055 Handling Unit Assignm.";

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
                    XVUtil.GetInfoCustomerByShipment(WarehouseShipmentNo, CustomerInfo);
                    YourReference := CustomerInfo[1];
                    Indirizzo_Spedizione1 := CustomerInfo[2];
                    Indirizzo_Spedizione2 := CustomerInfo[3];
                    Indirizzo_Spedizione3 := CustomerInfo[4];
                    FormattedSerie :=
                        'Serie  ' +
                        Format("Progressivo Serie Spedizione") + '/' +
                        Format(whseShpt."Numero Totale Serie");

                    FormattedBox :=
                        'Box  ' +
                        Format("Nr Scatola") + '/' +
                        Format(whseShpt."Numero Totale Pallet");

                    Formatted_Indirizzo_Spedizione :=
                        Format(Indirizzo_Spedizione1) + Format(13) + Format(10) +
                        Format(Indirizzo_Spedizione2) + Format(13) + Format(10) +
                        Format(Indirizzo_Spedizione3);
                    Formatted_Padestal :=
                        'Vs Ordine / Your Purchase Order     ' +
                        'Nr Pallett Accessori: ' + Format(whseShpt."Nr Colli Accessori") +
                        ' ' + Format(whseShpt."Descrizione Colli Accessori");
                    HUA.SetRange("Handling Unit No.", HU."No.");
                    if HUA.FindFirst() then begin
                        SourceNo := HUA."Source No.";
                        LotNo := HUA."Lot No.";
                        ItemNo := HUA."Item No.";
                        SourceLineNo := HUA."Source Line No.";
                    end;

                end;

            }

            trigger OnPreDataItem()
            begin
                SetRange("No.", WarehouseShipmentNo);
                //XVUtil.SetNrScatola(WarehouseShipmentNo);
            end;

            trigger OnAfterGetRecord()
            var
                Customer: Record Customer;
                Carrier: Record "Shipping Agent";
            begin

                // Recupero dati per cliente
                if Customer.Get(WhseShpt."EOS Destination No.") then
                    Cliente := Customer.Name;

                // Recupero dati per vettore

                if Carrier.Get(WhseShpt."Shipping Agent Code") then
                    Vettore := Carrier.Name;
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
                    Caption = 'Opzioni';

                    field(NrSerieFilter; NrSerieFilter)
                    {
                        Caption = 'Nr Serie';
                        ApplicationArea = All;
                        ToolTip = 'Inserire uno o più numeri (es: 1 | 1|3 | 1..5). Lasciare vuoto per tutti.';
                    }
                    field(NrScatolaFilter; NrScatolaFilter)
                    {
                        Caption = 'Nr Scatola';
                        ApplicationArea = All;
                        ToolTip = 'Inserire uno o più numeri (es: 1 | 1|3 | 1..5). Lasciare vuoto per tutti.';
                    }
                }
            }
        }
    }
    var
        LotNo: Text;
        ItemNo: Code[20];
        SourceLineNo: Integer;
        SourceNo: Code[20];

        Scatole: Text[250];
        NScatola: Integer;
        NrScatolaFilter: Text;
        NrSerieFilter: Text;
        EncodedText: Text;
        NrPalletAccessori: Integer;
        DescrPalletAccessori: Text[100];
        WarehouseShipmentNo: Code[20];
        Cliente: Text[100];
        Vettore: Text[100];
        Indirizzo_Spedizione1: Text[100];
        Indirizzo_Spedizione2: Text[100];
        Indirizzo_Spedizione3: Text[100];
        YourReference: Text[100];
        XVUtil: Codeunit "XVUtil";
        FormattedSerie: Text[100];
        FormattedBox: Text[100];
        Formatted_Indirizzo_Spedizione: Text[900];
        Formatted_Padestal: Text[900];

    procedure SetWarehouseShipmentNo(No: Code[20])
    begin
        WarehouseShipmentNo := No;
        // TODO DA provare
    end;

    local procedure ZeroValeUno(ProgressivoKitBus: Integer): Integer;
    begin
        if (ProgressivoKitBus = 0) then
            exit(1)
        else
            exit(ProgressivoKitBus);
    end;


}
