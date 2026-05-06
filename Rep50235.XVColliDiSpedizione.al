namespace Lazzerini;
using Microsoft.Warehouse.Document;
report 50235 "XV Colli Di Spedizione"
{
    Caption = 'XV Colli Di Spedizione';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/XVColliDiSpedizione.rdl';
    dataset
    {
        // DATAITEM PADRE
        dataitem(WhseShptLine; "Warehouse Shipment Line")
        {
            DataItemTableView = sorting("No.", "Line No.");

            column(ShipmentNo; "No.") { }
            column(SourceNo; "Source No.") { }
            column(SourceLineNo; "Source Line No.") { }

            // DATAITEM FIGLIO
            dataitem(HUAssignm; "EOS055 Handling Unit Assignm.")
            {
                DataItemLink =
                    "Source No." = field("Source No."),
                    "Source Line No." = field("Source Line No.");

                column(HandlingUnitNo; "Handling Unit No.") { }
                column(HUSourceNo; "Source No.") { }
                column(HUSourceLineNo; "Source Line No.") { }

                column(NrPalletAccessori; NrPalletAccessori)
                {
                    Caption = 'Nr Pallet Accessori';
                }

                column(DescrPalletAccessori; DescrPalletAccessori)
                {
                    Caption = 'Descrizione Pallet Accessori';
                }
            }
            trigger OnPreDataItem()
            begin
                SetRange("No.", WarehouseShipmentNo);
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
                    }

                    field(DescrPalletAccessori; DescrPalletAccessori)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    var
        NrPalletAccessori: Integer;
        DescrPalletAccessori: Text[100];
        WarehouseShipmentNo: Code[20];

    procedure SetWarehouseShipmentNo(No: Code[20])
    begin
        WarehouseShipmentNo := No;
    end;

}
