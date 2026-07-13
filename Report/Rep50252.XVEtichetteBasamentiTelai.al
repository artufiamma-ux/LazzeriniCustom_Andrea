namespace Xview.Custom.Lazzerini;

using Microsoft.Manufacturing.Document;

report 50252 "XV Etichette Basamenti Telai"
{
    Caption = 'Etichette Basamenti Telai';
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/XVEtichetteBasamentiTelai.rdl';

    dataset
    {
        dataitem(XVBasamentiTelaiBuffer; "XV Basamenti Telai Buffer")
        {
            column(DrawingNo; "Drawing No.")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(ItemReferenceNo; "Item Reference No.")
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(PosizioneLayout; "Posizione Layout")
            {
            }
            column(ProgressivoKitBus; "Progressivo Kit Bus")
            {
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
                    Caption = 'Opzioni';
                    field(Tipo; TipoEtichettaVar)
                    {
                        ApplicationArea = All;
                        Caption = 'Tipo Etichetta';
                        ToolTip = 'Selezionare il tipo di etichetta da stampare.';
                    }

                    field(NrSerieFilter; NrSerieFilter)
                    {
                        Caption = 'Nr Serie';
                        ApplicationArea = All;
                        ToolTip = 'Numero di copie.';
                    }
                }
            }
        }
    }
    var
        RecProductionOrder: Record "Production Order";
        NrSerieFilter: Integer;
        TipoEtichettaVar: Enum "XV Tipo Etichetta Item";

    procedure SetParameters(ProductionOrder: Record "Production Order")
    begin
        RecProductionOrder := ProductionOrder;
    end;

    trigger OnPreReport()
    var
        TempBuffer: Record "XV Basamenti Telai Buffer" temporary;
        i: Integer;
    begin
        for i := 1 to NrSerieFilter do begin
            TempBuffer.Init();
            TempBuffer."Item No." := RecProductionOrder."Source No.";
            TempBuffer."Posizione Layout" := RecProductionOrder."Posizione Layout";
            TempBuffer."Order No." := RecProductionOrder."Nr. Ordine di vendita";

            TempBuffer.Insert();
        end;
    end;
}
