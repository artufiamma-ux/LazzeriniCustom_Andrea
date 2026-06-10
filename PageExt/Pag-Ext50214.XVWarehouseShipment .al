namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Document;
using Microsoft.Sales.Document;

pageextension 50214 XVWarehouseShipment extends "Warehouse Shipment"
{
    layout
    {
        addafter("Sorting Method")
        {
            field("Tipo Prelievo"; Rec."Tipo Prelievo")
            {
                ApplicationArea = All;
            }
            field("Tipo Ordine"; Rec."Tipo Ordine")
            {
                ApplicationArea = All;
            }
            field("Numero Totale Serie"; Rec."Numero Totale Serie")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Numero Totale Pallet"; Rec."Numero Totale Pallet")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Box totali';
            }
            field(NrPalletAccessori; Rec."Nr Colli Accessori")
            {
                ApplicationArea = All;
                Caption = 'Box Accessori per serie';

                trigger OnValidate()
                begin
                    Message('Chiudi Scatole necessario');
                end;
            }
            field(DescrPalletAccessori; Rec."Descrizione Colli Accessori")
            {
                ApplicationArea = All;
            }
            field("Fattura Richiesta"; Rec."Fattura Richiesta")
            {
                ApplicationArea = All;
            }
        }
        addafter(General)
        {
            group(Filtri)
            {
                Caption = 'Filtri';


                field("Pagamento Effettuato"; Rec."Pagamento Effettuato")
                {
                    ApplicationArea = All;
                }

                field("Da Spedire"; Rec."Da Spedire")
                {
                    ApplicationArea = All;
                }

                field("Quotazione Trasporto Acc."; Rec."Quotazione Trasporto Acc.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        addafter("Action51")
        {
            action(ControllaIntegritaSerie)
            {
                Caption = 'Controlla integrità serie';
                ApplicationArea = All;
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WhseShptLine: Record "Warehouse Shipment Line";
                    SalesOrderLine: Record "Sales Line";
                    Residuo: Decimal;
                    AllShipped: Boolean;
                    ItemToCheck: Text;
                    ItemOrderMsg: Text;
                begin
                    AllShipped := true;
                    ItemToCheck := '';
                    ItemOrderMsg := '';
                    WhseShptLine.Reset();
                    WhseShptLine.SetRange("No.", Rec."No."); // stesso Warehouse Shipment

                    if WhseShptLine.FindSet() then // per ogni riga del documento
                        repeat
                            SalesOrderLine.Reset();
                            SalesOrderLine.SetRange("Document No.", WhseShptLine."Source No.");
                            SalesOrderLine.SetRange("Line No.", WhseShptLine."Source Line No.");
                            SalesOrderLine.SetRange("No.", WhseShptLine."Item No.");
                            if SalesOrderLine.FindSet() then begin
                                if WhseShptLine.Quantity <> SalesOrderLine.Quantity then begin
                                    AllShipped := false;
                                    ItemOrderMsg := '/' + ItemOrderMsg + 'Articolo ' + WhseShptLine."Item No." + ' con quantità diversa da ordine '
                                end
                            end
                            else begin
                                AllShipped := false;
                                ItemOrderMsg := ItemOrderMsg + '\Articolo ' + WhseShptLine."Item No." + ' non presente in ordine ';
                            end;
                            Residuo := WhseShptLine.Quantity - WhseShptLine."Qty. to Ship";
                            //Message('Riga %1: Quantità = %2, Quantità Spedita = %3, Residuo = %4, Ordine = %5', WhseShptLine."Line No.", WhseShptLine.Quantity, WhseShptLine."Qty. Shipped", Residuo, WhseShptLine."Source No.");
                            if Residuo <> 0 then begin
                                AllShipped := false;
                                ItemToCheck := ItemToCheck + '\Quantità non corrispondente all''ordine per l''articolo: ' + WhseShptLine."Item No.";
                                //break;
                            end;
                        until WhseShptLine.Next() = 0;
                    //verifico se tutte le righe ordinate sono nella spedizione
                    SalesOrderLine.Reset();
                    SalesOrderLine.SetRange("Document No.", WhseShptLine."Source No.");
                    //SalesOrderLine.SetRange("Line No.", WhseShptLine."Source Line No.");
                    if SalesOrderLine.FindSet() then begin
                        repeat
                            WhseShptLine.Reset();
                            WhseShptLine.SetRange("No.", Rec."No."); // stesso Warehouse Shipment
                            WhseShptLine.SetRange("Source Line No.", SalesOrderLine."Line No.");
                            if not WhseShptLine.FindSet() then begin
                                AllShipped := false;
                                ItemOrderMsg := ItemOrderMsg + '\Articolo ' + SalesOrderLine."No." + ' presente in ordine ma non presente in spedizione ';
                            end;
                        until SalesOrderLine.Next() = 0;
                    end;
                    if AllShipped then
                        Message('Controllo integrità serie completato con successo.')
                    else
                        Message('Controllo integrità serie Fallito: ' + ItemOrderMsg + ItemToCheck);
                end;
            }
            action(StampaEtichetteUdc)
            {
                Caption = 'Genera dettaglio colli spedizioni';
                ApplicationArea = All;
                Image = BarCode;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Rep: Report "XV Colli Di Spedizione";
                begin
                    Rep.SetWarehouseShipmentNo(Rec."No.");
                    Rep.Run();
                end;
            }

            action(ChiudiScatole)
            {
                Caption = 'Chiudi scatole';
                ApplicationArea = All;
                Image = Closed;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    XvEosUtil: Codeunit "XVEosUtil";
                begin
                    XvEosUtil.ChiudiScatole(Rec."No.");
                end;
            }
            action(EliminaScatoleAccessorie)
            {
                Caption = 'Elimina scatole accessorie';
                ApplicationArea = All;
                Image = BinContent;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    XvEosUtil: Codeunit "XVEosUtil";
                begin
                    XvEosUtil.DeleteScatoleAccessorie(Rec."No.");
                end;
            }

        }

    }

}
