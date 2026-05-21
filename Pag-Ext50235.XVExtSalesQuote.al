namespace Xview.Custom.Lazzerini;

using Microsoft.Sales.Document;

pageextension 50235 "XV Ext Sales Quote" extends "Sales Quote"
{
    actions
    {
        addlast(Processing)
        {
            action(StampaKitBus)
            {
                ApplicationArea = All;
                Caption = 'Stampa personalizzata';
                ToolTip = 'Stampa personalizzata della fattura Proforma.';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    SalesInvoiceReport: Report "Custom Proforma - Invoice";
                    Rep: Integer;
                begin
                    SalesInvoiceReport.SetParameters(Rec."No.");
                    //                    SalesInvoiceReport.SetTableView(Rec);
                    SalesInvoiceReport.Run();
                end;
            }
        }
    }
}
