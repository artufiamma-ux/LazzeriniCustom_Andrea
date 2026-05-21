namespace Xview.Custom.Lazzerini;
using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.Sales.Posting;


codeunit 50216 "XV KitBus Ship Reg"
{
    Permissions =
        tabledata "Sales Shipment Line" = m;
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertEvent', '', false, false)]
    //   procedure BeforeInsertEOSShipmentLine(var Rec: Record "EOS CWS Shipment Line")
    local procedure CopyKitBusToShipmentLine(var Rec: Record "Sales Shipment Line")
    var
        SalesLine: Record "Sales Line";
    begin
        if Rec."Order No." = '' then
            exit;
        if SalesLine.Get(SalesLine."Document Type"::Order, Rec."Order No.", Rec."Order Line No.") then begin
            Rec."xv Kit Bus" := SalesLine."xv Kit Bus";
            Rec."xv Progressivo Kit Bus" := SalesLine."xv Progressivo Kit Bus";
            Rec."Nr. Layout" := SalesLine."xv Nr Layout";
            Rec."Posizione Layout" := SalesLine."xv Posizione Layout";
            Rec."Qta. Origine Layout" := SalesLine."Qta. Origine layout";
            // Rec.Modify(true);
        end;
    end;

}