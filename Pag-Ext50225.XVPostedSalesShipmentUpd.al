namespace Lazzerini;

using Microsoft.Sales.History;

pageextension 50225 "XV Posted Sales Shipment - Upd" extends "Posted Sales Shipment - Update"
{
    layout
    {
        addafter(Shipping)
        {
            group("Fattura Proforma")
            {
                field("Cod valuta proforma"; Rec."Cod valuta proforma")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {

        addlast(Processing)
        {

            action(CreaProforma)
            {
                Caption = 'Crea proforma';
                Image = Save;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Crea una proforma dall''ordine corrente';
                Enabled = Rec."Nr fattura proforma" = '';



                trigger OnAction()
                var
                    ProformaMgt: Codeunit "Proforma Management";
                begin
                    if (Rec."Cod valuta proforma" = '') then
                        Error('Il campo "Cod valuta proforma" non è valorizzato.')
                    else
                        ProformaMgt.CreateProformaFromShipment(Rec."No.", Rec."Cod valuta proforma");
                end;
            }
        }
    }
}
