namespace Lazzerini;
using Microsoft.Warehouse.Document;
using System.Text;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Shipping;
using Microsoft.Sales.Document;


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
            column(YourReference; YourReference) { }

            // DATAITEM Line
            dataitem(WhseShptLine; "Warehouse Shipment Line")
            {
                DataItemLink =
                    "No." = field("No.");

                column(SourceNo; "Source No.") { }
                column(SourceLineNo; "Source Line No.") { }
                column(ProgressivoKitBus; ZeroValeUno("Progressivo Kit Bus")) { }

                // DATAITEM FIGLIO
                dataitem(HUAssignm; "EOS055 Handling Unit Assignm.")
                {
                    DataItemLink =
                    "Source No." = field("Source No."),
                    "Source Line No." = field("Source Line No.");

                    DataItemTableView =
                            SORTING("Nr Scatola", "Handling Unit No.")
                            ORDER(Ascending);


                    column(HandlingUnitNo; "Handling Unit No.") { }
                    column(HUSourceNo; "Source No.") { }
                    column(HUSourceLineNo; "Source Line No.") { }
                    column(HUItemNo; "Item No.") { }
                    column(HULotNo; "Lot No.") { }
                    column(Indirizzo_Spedizione1; Indirizzo_Spedizione1) { }
                    column(Indirizzo_Spedizione2; Indirizzo_Spedizione2) { }
                    column(Indirizzo_Spedizione3; Indirizzo_Spedizione3) { }

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
                    /*
                    trigger OnPreDataItem()
                    begin
                        if NrScatolaFilter <> '' then
                            SetFilter("Nr Scatola", NrScatolaFilter);
                    end;
*/

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
                        BarcodeString := "Handling Unit No.";

                        // Validate the input. This method is not available for 2D provider
                        BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);

                        // Encode the data string to the barcode font
                        EncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);

                        /*                       
                                                HUAssignm."Nr Scatola" := 0;
                                                if HUAssignm."Nr Scatola" = 0 then begin
                                                    if NOT Scatole.Contains(HUAssignm."Handling Unit No.") then begin
                                                        NScatola := NScatola + 1;
                                                        Scatole := Scatole + ';' + HUAssignm."Handling Unit No.";
                                                    end;
                                                    HUAssignm."Nr Scatola" := NScatola;
                                                    HUAssignm.Modify(true);
                                                end;
                        */
                    end;

                }
                trigger OnAfterGetRecord()
                var
                    ShipTo: Record "Ship-to Address";
                    SalesHeader: Record "Sales Header";
                begin
                    if SalesHeader.Get(SalesHeader."Document Type"::Order, WhseShptLine."Source No.") then begin
                        YourReference := SalesHeader."Your Reference";
                        if ShipTo.Get(SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code") then begin
                            Indirizzo_Spedizione1 := ShipTo.Name + ' ' + ShipTo."Name 2";
                            Indirizzo_Spedizione2 := ShipTo.Address + ' ' + ShipTo."Address 2";
                            Indirizzo_Spedizione3 := ShipTo.City + '(' + ShipTo."Location Code" + ') ';
                        end;
                    end;
                end;

            }
            trigger OnPreDataItem()
            begin
                SetRange("No.", WarehouseShipmentNo);
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

                    field(NrPalletAccessori; NrPalletAccessori)
                    {
                        ApplicationArea = All;
                        Caption = 'Nr Pallet Accessori';
                    }

                    field(DescrPalletAccessori; DescrPalletAccessori)
                    {
                        ApplicationArea = All;
                        Caption = 'Descrizione Pallet Accessori';
                    }
                    /*
                                        field(NrScatolaFilter; NrScatolaFilter)
                                        {
                                            Caption = 'Nr Scatola';
                                            ApplicationArea = All;
                                            ToolTip = 'Inserire uno o più numeri (es: 1 | 1|3 | 1..5). Lasciare vuoto per tutti.';
                                        }
                    */
                }
            }
        }
    }
    var
        Scatole: Text[250];
        NScatola: Integer;
        NrScatolaFilter: Text[100];
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

    procedure SetWarehouseShipmentNo(No: Code[20])
    begin
        WarehouseShipmentNo := No;
        // TODO DA provare
        XVUtil.SetNrScatola(No);
    end;

    local procedure ZeroValeUno(ProgressivoKitBus: Integer): Integer;
    begin
        if (ProgressivoKitBus = 0) then
            exit(1)
        else
            exit(ProgressivoKitBus);
    end;

}
