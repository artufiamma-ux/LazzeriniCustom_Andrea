namespace Lazzerini;

using Microsoft.Sales.History;
using Microsoft.Sales.Document;

pageextension 50228 "XV Posted Sales Invoices" extends "Posted Sales Invoices"
{
    actions
    {
        addfirst("&Invoice")
        {  
            group("Custom Actions")
            {
                Caption = 'Custom Actions';
                Image = PrintDocument;
                action(StampaKitBus)
                    {
                        ApplicationArea = All;
                        Caption = '**Stampa**';
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
procedure GetReport(InvoiceNo: Code[20]): Code[30]
var
    SalesInvLine: Record "Sales Invoice Line";
    SalesHeader: Record "Sales Header";
begin
    // Filtra solo le righe con un Order No. valorizzato
    SalesInvLine.SetRange("Document No.", InvoiceNo);
    SalesInvLine.SetFilter("Order No.", '<>%1', '');

    if SalesInvLine.FindSet() then
        repeat
            // Lettura diretta testata ordine
            if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesInvLine."Order No.") then
                if SalesHeader."Ordine con kit" then
                    exit('Custom Sales - Invoice');  // appena trovato → fine
        until SalesInvLine.Next() = 0;

    // Nessun ordine con kit
    exit('Custom Sales - Invoice std');
end;

}
