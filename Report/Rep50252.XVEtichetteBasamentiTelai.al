namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Sales.Document;

report 50252 "XV Etichette Basamenti Telai"
{
    Caption = 'Etichette Basamenti Telai';
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/XVEtichetteBasamentiTelai.rdl';

    dataset
    {
        dataitem(XVBasamentiTelaiBuffer; "XV Basamenti Telai Buffer")
        {
            UseTemporary = true;
            DataItemTableView = sorting("Progressivo Kit Bus");
            column(DrawingNo; "Drawing No.")
            {
                caption = 'DRAWING/P.N.';
            }
            column(ItemNo; "Item No.")
            {
                caption = 'LAZZERINI P.N.';
            }
            column(ItemReferenceNo; "Item Reference No.")
            {
                caption = 'CUSTOMER P.N.';
            }
            column(OrderNo; "Order No.")
            {
                caption = 'ORDINE';
            }
            column(PosizioneLayout; "Posizione Layout")
            {
                caption = 'POS.';
            }
            column(ProgressivoKitBus; "Progressivo Kit Bus")
            {
                caption = 'Progressivo Kit Bus';
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
                group(InformazioniOrdine)
                {
                    Caption = 'Informazioni Ordine';
                    field(POrderNo; RecProductionOrder."Nr. Ordine di vendita")
                    {
                        ApplicationArea = All;
                        Caption = 'Ordine di vendita';
                        ToolTip = 'Ordine di vendita per il quale si vogliono stampare le etichette.';
                        Editable = false;
                    }
                }
            }
        }
    }
    var
        RecProductionOrder: Record "Production Order";
        NrSerieFilter: Integer;
        TipoEtichettaVar: Enum "XV Tipo Etichetta Item";
        POrderNo: Code[20];

    procedure SetParameters(ProductionOrder: Record "Production Order")
    begin
        RecProductionOrder := ProductionOrder;
    end;

    trigger OnPreReport()
    var
        TempBuffer: Record "XV Basamenti Telai Buffer" temporary;
        RecAll: Record "Production Order";
        RecBomLine: Record "Production BOM Line";
        RecSalesLine: Record "Sales Line";
        XVUtils: Codeunit "XVUtil";
        i: Integer;
        RecItem: Record Item;
    begin
        POrderNo := RecProductionOrder."Nr. Ordine di vendita";
        if POrderNo <> '' then begin
            RecAll.SetRange("Nr. Ordine di vendita", POrderNo); // tutti gli ordini di produzione con lo stesso ordine di vendita
            if RecAll.FindSet() then
                repeat

                    for i := 1 to NrSerieFilter do begin // per ogni ordine di produzione, inserisco tante righe quante sono le copie richieste
                        RecBomLine.SetRange("Production BOM No.", RecAll."Source No.");
                        RecBomLine.SetRange("Type", RecBomLine."Type"::Item);
                        if RecBomLine.FindSet() then begin // per ogni riga distinta di distinta base, cerco il riferimento articolo
                            repeat
                                if RecItem.Get(RecBomLine."No.") then begin // se trovo l'articolo con il tipo etichetta richiesto, lo inserisco nel buffer
                                    if UpperCase(RecItem." Tipo Etichetta") = UpperCase(Format(TipoEtichettaVar)) then begin

                                        RecSalesLine.SetRange("Document Type", RecSalesLine."Document Type"::Order);
                                        RecSalesLine.SetRange("Document No.", POrderNo);
                                        RecSalesLine.SetRange("No.", RecAll."Source No.");// RecBomLine."No.");
                                        if RecSalesLine.FindFirst() then begin
                                            TempBuffer.Init();

                                            TempBuffer."Posizione Layout" := RecAll."Posizione Layout";
                                            TempBuffer."Order No." := POrderNo;
                                            TempBuffer."Item No." := RecItem."No.";
                                            TempBuffer."Item Reference No." := RecSalesLine."Item Reference No.";
                                            TempBuffer."Drawing No." := RecItem."Drawing No.";
                                            TempBuffer."Progressivo Kit Bus" := i;
                                            TempBuffer.Insert();
                                        end;
                                    end;
                                end;
                            until RecBomLine.Next() = 0;
                        end;


                    end;
                until RecAll.Next() = 0;
        end;
        XVBasamentiTelaiBuffer.Copy(TempBuffer, true);
    end;

}
