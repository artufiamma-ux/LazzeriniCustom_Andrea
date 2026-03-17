namespace Lazzerini;
using Microsoft.Warehouse.Document;

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
                PreviewPage: Page "XV Etichette Ricambi Cliente";
            begin
                PreviewPage.SetShipmentHeader(Rec);  // passi la riga corrente
                PreviewPage.RunModal();
            end;
            }
        }
    }
}