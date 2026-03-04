namespace Lazzerini;

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
            }
            field("Numero Totale Pallet"; Rec."Numero Totale Pallet")
            {
                ApplicationArea = All;
            }
            field("Fattura Richiesta"; Rec."Fattura Richiesta")
            {
                ApplicationArea = All;
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
                    Residuo: Decimal;
                    AllShipped: Boolean;
                    ItemToCheck: Text;
                begin
                    AllShipped := true;
                    ItemToCheck := '';
                    WhseShptLine.Reset();
                    WhseShptLine.SetRange("No.", Rec."No."); // stesso Warehouse Shipment

                    if WhseShptLine.FindSet() then
                        repeat
                            Residuo := WhseShptLine.Quantity - WhseShptLine."Qty. to Ship";
                            //Message('Riga %1: Quantità = %2, Quantità Spedita = %3, Residuo = %4, Ordine = %5', WhseShptLine."Line No.", WhseShptLine.Quantity, WhseShptLine."Qty. Shipped", Residuo, WhseShptLine."Source No.");
                            if Residuo > 0 then begin
                                AllShipped := false;
                                ItemToCheck := ItemToCheck + '\' + WhseShptLine."Item No.";
                                break;
                            end;
                        until WhseShptLine.Next() = 0;

                    if AllShipped then
                        Message('Controllo integrità serie completato con successo.')
                    else
                        Message('Manca della merce da spedire.' + '\Controlla le righe del documento per l''articolo: ' + ItemToCheck);
                end;
            }
        }

        addafter(ControllaIntegritaSerie) // lo mette accanto a Stampa e Invia
        {
            action(StampaEtichetteBasamenti)
            {
                Caption = 'Genera dettaglio colli spedizioni';
                ApplicationArea = All;
                Image = Print;

                trigger OnAction()
                var
                    Report50202: Report "XV Etichette UDC";
                begin
                    // Esegue il report
                    Report50202.Run();
                end;
            }
        }
    }

}
