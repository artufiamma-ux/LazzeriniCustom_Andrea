namespace Xview.Custom.Lazzerini;

using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Routing;
using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.Document;
using Microsoft.Manufacturing.WorkCenter;
pageextension 50210 "XV Released Prod. Order Ext" extends "Firm Planned Prod. Order"
{
    layout
    {
        addlast(General)
        {
            field("Nr. Area di produzione OP"; Rec."Nr. Area di produzione OP")
            {
                ApplicationArea = All;
            }

            field("Nr. Ordine di vendita"; Rec."Nr. Ordine di vendita")
            {
                ApplicationArea = All;
            }

            field("Nr. Serie progressiva"; Rec."Nr. Serie progressiva")
            {
                ApplicationArea = All;
            }

            field("Tipo"; Rec."Tipo")
            {
                ApplicationArea = All;
            }

            field("Nr"; Rec."Nr")
            {
                ApplicationArea = All;
            }

            field("Nr. Area produzione (Ciclo)"; Rec."Nr. Area produzione (Ciclo)")
            {
                ApplicationArea = All;
            }

            field("Nome area produzione (Ciclo)"; Rec."Nome area produzione (Ciclo)")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Tipo Ciclo"; Rec."Tipo Ciclo")
            {
                ApplicationArea = All;
            }

            field("Nr. Ciclo"; Rec."Nr. Ciclo")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(StampaProdOrderDetailedCalc)
            {
                ApplicationArea = All;
                Caption = 'Prod. Order - Detailed Calc.';
                ToolTip = 'Apre il report dettagliato dell''ordine di produzione.';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ProdOrderDetailedCalc: Report "EOS 07000 MES ProdOrderDetCalc";
                begin
                    ProdOrderDetailedCalc.SetTableView(Rec);
                    ProdOrderDetailedCalc.RunModal();
                end;
            }
        }
    }
}
