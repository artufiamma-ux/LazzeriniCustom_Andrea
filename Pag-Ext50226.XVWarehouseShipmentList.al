namespace Lazzerini;

using Microsoft.Warehouse.Document;
using Microsoft.Inventory.Item;

pageextension 50226 "XV Warehouse Shipment List" extends "Warehouse Shipment List"
{
    actions
    {
        addlast(Creation)
        {
            action("Stampa etichette ricambi")
            {
                Caption = 'Stampa etichette ricambi';
                Image = Print;
                ApplicationArea = All;

                trigger OnAction()
                var
                    WhseShipmentHeader: Record "Warehouse Shipment Header";
                    WhseShipmentLine: Record "Warehouse Shipment Line";
                    Item: Record Item;
                    Confirmed: Boolean;
                    PreviewMessage: Text;
                    LineCount: Integer;
                    TotalLabels: Decimal;
                begin
                    WhseShipmentHeader := Rec;

                    // Recupera tutte le righe della spedizione
                    WhseShipmentLine.SetRange("No.", WhseShipmentHeader."No.");

                    if WhseShipmentLine.FindSet() then begin
                        PreviewMessage := 'ANTEPRIMA STAMPA ETICHETTE RICAMBI\n' +
                                        '===============================\n\n';

                        repeat
                            LineCount += 1;
                            TotalLabels += WhseShipmentLine.Quantity;

                            // Ricerca l'articolo per descrizione
                            if Item.Get(WhseShipmentLine."Item No.") then
                                PreviewMessage += 'Articolo: ' + WhseShipmentLine."Item No." + '\n' +
                                                'Descrizione: ' + Item.Description + '\n' +
                                                'Quantità: ' + Format(WhseShipmentLine.Quantity) + '\n' +
                                                'Etichette: ' + Format(WhseShipmentLine.Quantity) + ' (' +
                                                'una per unità' + ')\n' +
                                                '---\n';
                        until WhseShipmentLine.Next() = 0;

                        PreviewMessage += '\n===============================\n' +
                                        'TOTALE ETICHETTE: ' + Format(TotalLabels) + '\n\n' +
                                        'Vuoi procedere con la stampa?';

                        Confirmed := Confirm(PreviewMessage, false);

                        if Confirmed then begin
                            // Lancia il report
                            Report.Run(
                                Report::"XV Etichetta Ricambi",
                                true,
                                true,
                                WhseShipmentHeader
                            );
                        end;
                    end else
                        Message('Non ci sono articoli in questa spedizione.');
                end;
            }
        }
    }
}