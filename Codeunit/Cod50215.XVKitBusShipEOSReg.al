namespace Xview.Custom.Lazzerini;
using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.Sales.Posting;


codeunit 50215 "XV KitBus ShipEOSReg"
{
    Permissions =
        tabledata "EOS CWS Shipment Line" = m;
    [EventSubscriber(ObjectType::Table, Database::"EOS CWS Shipment Line", 'OnBeforeInsertEvent', '', false, false)]
    //   procedure BeforeInsertEOSShipmentLine(var Rec: Record "EOS CWS Shipment Line")
    local procedure CopyKitBusToEOSCWSShipmentLine(var Rec: Record "EOS CWS Shipment Line")
    var
        SalesLine: Record "Sales Line";
    begin
        if Rec."Order No." = '' then
            exit;
        if SalesLine.Get(SalesLine."Document Type"::Order, Rec."Order No.", Rec."Order Line No.") then begin
            Rec."xv Kit Bus" := SalesLine."xv Kit Bus";
            Rec."xv Progressivo Kit Bus" := SalesLine."xv Progressivo Kit Bus";
            // Rec.Modify(true);
        end;
    end;

}