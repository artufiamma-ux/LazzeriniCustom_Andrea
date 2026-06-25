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


                Editable = false; // resta non editabile
                DrillDown = true;
                trigger OnDrillDown()
                var
                    WhseShpt: Record "Warehouse Shipment Header";
                begin
                    WhseShpt.Get(Rec."No.");
                    // toggle
                    WhseShpt."Verifica Pagamenti" := not WhseShpt."Verifica Pagamenti";
                    WhseShpt.Modify(true);
                    // sync UI
                    Rec."Verifica Pagamenti" := WhseShpt."Verifica Pagamenti";
                    CurrPage.Update(false);
                end;
            }
            field("Fattura Richiesta"; Rec."Fattura Richiesta")
            {
                ApplicationArea = All;
                Editable = false; // resta non editabile
                DrillDown = true;
                trigger OnDrillDown()
                var
                    WhseShpt: Record "Warehouse Shipment Header";
                begin
                    WhseShpt.Get(Rec."No.");
                    // toggle
                    WhseShpt."Fattura Richiesta" := not WhseShpt."Fattura Richiesta";
                    WhseShpt.Modify(true);
                    // sync UI
                    Rec."Fattura Richiesta" := WhseShpt."Fattura Richiesta";
                    CurrPage.Update(false);
                end;
            }

            field("Pagamento Effettuato"; Rec."Pagamento Effettuato")
            {
                ApplicationArea = All;
                Editable = false; // resta non editabile
                DrillDown = true;
                trigger OnDrillDown()
                var
                    WhseShpt: Record "Warehouse Shipment Header";
                begin
                    WhseShpt.Get(Rec."No.");
                    // toggle
                    WhseShpt."Pagamento Effettuato" := not WhseShpt."Pagamento Effettuato";
                    WhseShpt.Modify(true);
                    // sync UI
                    Rec."Pagamento Effettuato" := WhseShpt."Pagamento Effettuato";
                    CurrPage.Update(false);
                end;
            }

            field("Da Spedire"; Rec."Da Spedire")
            {
                ApplicationArea = All;
                Editable = false; // resta non editabile
                DrillDown = true;
                trigger OnDrillDown()
                var
                    WhseShpt: Record "Warehouse Shipment Header";
                begin
                    WhseShpt.Get(Rec."No.");
                    // toggle
                    WhseShpt."Da Spedire" := not WhseShpt."Da Spedire";
                    WhseShpt.Modify(true);
                    // sync UI
                    Rec."Da Spedire" := WhseShpt."Da Spedire";
                    CurrPage.Update(false);
                end;
            }

            field("Quotazione Trasporto Acc."; Rec."Quotazione Trasporto Acc.")
            {
                ApplicationArea = All;
                Editable = false; // resta non editabile
                DrillDown = true;
                trigger OnDrillDown()
                var
                    WhseShpt: Record "Warehouse Shipment Header";
                begin
                    WhseShpt.Get(Rec."No.");
                    // toggle
                    WhseShpt."Quotazione Trasporto Acc." := not WhseShpt."Quotazione Trasporto Acc.";
                    WhseShpt.Modify(true);
                    // sync UI
                    Rec."Quotazione Trasporto Acc." := WhseShpt."Quotazione Trasporto Acc.";
                    CurrPage.Update(false);
                end;
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