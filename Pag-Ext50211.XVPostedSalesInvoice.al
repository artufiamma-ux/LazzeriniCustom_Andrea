namespace Lazzerini;

using Microsoft.Sales.Document;
using Microsoft.Sales.History;
pageextension 50211 XVPostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Posting Date")
        {
            field(ACCOMPAGNATORIA; Rec.ACCOMPAGNATORIA)
            {
                ApplicationArea = All;
                Caption = 'Accompagnatoria';
                ToolTip = 'Indica se la fattura è accompagnatoria.';
            }
        }

    }
    actions
    {
        addlast(Processing)
        {  
                action(StampaKitBus)
                    {
                        ApplicationArea = All;
                        Caption = 'Stampa personalizzata';
                        ToolTip = 'Stampa personalizzata della fattura.';
                        Image = Print;
                        Promoted = true;
                        PromotedCategory = Process;


                        trigger OnAction()
                        var
                            SalesInvoiceReport: Report "Custom Sales - Invoice";
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
