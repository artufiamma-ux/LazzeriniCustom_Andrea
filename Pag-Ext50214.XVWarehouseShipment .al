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
                begin
                    AllShipped := true;

                    WhseShptLine.Reset();
                    WhseShptLine.SetRange("No.", Rec."No."); // stesso Warehouse Shipment

                    if WhseShptLine.FindSet() then
                        repeat
                            Residuo := WhseShptLine.Quantity - WhseShptLine."Qty. Shipped";

                            if Residuo > 0 then begin
                                AllShipped := false;
                                break;
                            end;
                        until WhseShptLine.Next() = 0;

                    if AllShipped then
                        Message('Tutta la merce è già stata spedita.')
                    else
                        Message('Manca della merce da spedire.');
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
                    ParamPage: Page "XV Parametri Etichette";
                begin
                    ParamPage.SetShipmentNo(Rec."No.");
                    ParamPage.RunModal();
                end;
            }
        }
    }

}
