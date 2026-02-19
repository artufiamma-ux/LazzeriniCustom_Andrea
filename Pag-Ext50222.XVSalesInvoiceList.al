namespace Lazzerini;

using Microsoft.Sales.Document;

pageextension 50222 "XV Sales Invoice List " extends "Sales Invoice List"
{
    actions
    {
        addafter(PostAndSend)
        {
            action("Stampa Barcode")
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Header";
                begin
                    CurrPage.SetSelectionFilter(SalesInvoiceHeader);
                    if SalesInvoiceHeader.FindFirst() then
                        Report.Run(50201, true, false, SalesInvoiceHeader);
                end;
            }
        }
    }
}
