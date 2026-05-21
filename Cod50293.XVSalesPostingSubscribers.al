namespace Xview.Custom.Lazzerini;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Sales.Posting;
codeunit 50293 "XV Sales Posting Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterUpdateWonOpportunities', '', false, false)]
    local procedure OnAfterUpdateWonOpportunities(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        SalesInvoiceHeader."Accompagnatoria" := SalesHeader."Accompagnatoria";

    end;
}
