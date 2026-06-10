namespace Xview.Custom.Lazzerini;

using Microsoft.Purchases.Document;

pageextension 50222 "XV Purchase Invoices List " extends "Purchase Invoices"
{
    actions
    {
        addlast("navigation")
        {
            action("Stampa Barcode")
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                var
                    PurchaseInvoiceHeader: Record "Purchase Header";
                begin
                    CurrPage.SetSelectionFilter(PurchaseInvoiceHeader);
                    if PurchaseInvoiceHeader.FindFirst() then
                        Report.Run(50201, true, false, PurchaseInvoiceHeader);
                end;
            }
        }
    }
}
