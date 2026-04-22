namespace Lazzerini;

using Microsoft.Sales.Document;

pageextension 50234 "XV Ext Sales Quotes" extends "Sales Quotes"
{
    Caption = 'Proforma Sales Quotes';
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
                    SalesInvoiceReport.Run();
                end;
            }
        }
    }


    trigger OnOpenPage()
    begin
        Rec.SetRange("EOS Document Class Code", 'PROFORMA');
    end;

}
