namespace Xview.Custom.Lazzerini;
using Microsoft.Sales.Posting;
using Microsoft.Sales.History;
using Microsoft.Sales.Document;

codeunit 50213 "XV Kit Bus - Fat Reg"
{
    Permissions =
        tabledata "Sales Shipment Header" = m;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post",
        'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure CopyKitBusToInvoiceLines(
        var SalesInvLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesLine: Record "Sales Line";
        CommitIsSuppressed: Boolean;
        var IsHandled: Boolean;
        PostingSalesLine: Record "Sales Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesHeader: Record "Sales Header";
        var ReturnReceiptHeader: Record "Return Receipt Header")

    begin
        SalesInvLine."Kit Bus" := SalesLine."xv Kit Bus";
        SalesInvLine."Progressivo Kit Bus" := SalesLine."xv Progressivo Kit Bus";
        // agginta per gestire l'associazione tra fattura e spedizione
        if SalesLine."Shipment No." <> '' then begin
            SalesShipmentHeader.Get(SalesLine."Shipment No.");
            SalesShipmentHeader.Validate("Nr fattura", SalesInvHeader."No.");
            SalesShipmentHeader.Modify(true)
        end;
    end;
}
