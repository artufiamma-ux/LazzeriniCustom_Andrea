namespace Xview.Custom.Lazzerini;

using Microsoft.Purchases.Document;

pageextension 50247 "XV Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addafter("Your Reference")
        {
            field("Ordine Pilota"; Rec."Ordine Pilota")
            {
                ApplicationArea = All;
                ToolTip = 'Indica se l''ordine acquisto è un ordine pilota.';
            }
        }
    }
    actions
    {
        addlast(Processing)
        {
            action(PrintXVAllOrders)
            {
                Caption = 'XV Print All Orders';
                Image = Print;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    // Run report without passing the current Purchase Header record
                    Report.Run(Report::"XV Ordine Conto Lavoro", true, false);
                end;
            }
            action(PrintXVContoLavoro)
            {
                Caption = 'XV Conto Lavoro (current)';
                Image = Print;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    PurchaseHeaderRec: Record "Purchase Header";
                begin
                    PurchaseHeaderRec := Rec;
                    PurchaseHeaderRec.SetRecFilter();
                    // Run report for current Purchase Header (pre-fills request page)
                    Report.Run(Report::"XV Ordine Conto Lavoro", true, false, PurchaseHeaderRec);
                end;
            }
            action(PrintXVOrdineAcquisto)
            {
                Caption = 'XV Ordine Acquisto (current)';
                Image = Print;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    PurchaseHeaderRec: Record "Purchase Header";
                begin
                    PurchaseHeaderRec := Rec;
                    PurchaseHeaderRec.SetRecFilter();
                    Report.Run(Report::"XV Ordine Acquisto", true, false, PurchaseHeaderRec);
                end;
            }
        }
    }
}