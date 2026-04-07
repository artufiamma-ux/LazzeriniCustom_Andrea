namespace Lazzerini;
using Microsoft.Sales.History;

pageextension 50208 "XV Posted Sales Shipment Ext" extends "Posted Sales Shipment"
{
    layout
    {
        addlast(General)
        {
            field("Nr fattura proforma"; Rec."Nr fattura proforma")
            {
                ApplicationArea = All;
            }

            field("Cod valuta proforma"; Rec."Cod valuta proforma")
            {
                ApplicationArea = All;
            }

            field("Costi di trasporto"; Rec."Costi di trasporto")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {

        addlast("EOS030_HUM")
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
                Enabled = IsProformaEnabled;
                trigger OnAction()
                var
                    ProformaMgt: Codeunit "Proforma Management";
                begin
                    ProformaMgt.CreateProformaFromSR(Rec."No.");
                end;
            }
        }
    }

    var
        IsProformaEnabled: Boolean;

    trigger OnAfterGetRecord()
    begin
        IsProformaEnabled :=
            (Rec."Nr fattura proforma" = '') and Rec."Reason Code" in ['15', '18', '23', '27']
            ;
    end;
}
