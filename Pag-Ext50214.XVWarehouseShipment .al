namespace Lazzerini;

using Microsoft.Warehouse.Document;

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
                begin
                    Message('Controllo integrità serie avviato');
                end;
            }
        }
    }

}
