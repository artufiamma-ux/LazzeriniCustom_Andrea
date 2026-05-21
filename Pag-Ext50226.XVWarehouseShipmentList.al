namespace Xview.Custom.Lazzerini;
using Microsoft.Warehouse.Document;

pageextension 50226 "XV Warehouse Shipment List" extends "Warehouse Shipment List"
{
    layout
    {
        addlast(Control1)
        {

            field("Verifica Pagamenti"; Rec."Verifica Pagamenti")
            {
                ApplicationArea = All;
            }

            field("Fattura Richiesta"; Rec."Fattura Richiesta")
            {
                ApplicationArea = All;
            }

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