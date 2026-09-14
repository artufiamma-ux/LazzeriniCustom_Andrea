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
        if Rec."Line No." = 5000 then begin

        end;


    end;

    [EventSubscriber(ObjectType::Table, Database::"EOS CWS Shipment Line", 'OnAfterInsertEvent', '', false, false)]
    //   procedure BeforeInsertEOSShipmentLine(var Rec: Record "EOS CWS Shipment Line")
    local procedure AddLineRefToEOSCWSShipmentLine(var Rec: Record "EOS CWS Shipment Line")
    var
        SalesLine: Record "Sales Line";
        CWSLine: Record "EOS CWS Shipment Line";
    begin
        if Rec."Order No." = '' then
            exit;
        if Rec."Line No." = 5000 then begin
            if SalesLine.Get(SalesLine."Document Type"::Order, Rec."Order No.", Rec."Order Line No.") then begin
                CWSLine.Init();
                CWSLine.Description := SalesLine."Description";
                CWSLine."Document No." := Rec."Document No.";
                CWSLine."Posted Source Document" := Rec."Posted Source Document";
                CWSLine."xv Kit Bus" := Rec."xv Kit Bus";
                CWSLine."xv Progressivo Kit Bus" := Rec."xv Progressivo Kit Bus";
                CWSLine."Line No." := 5010;
                message('Line Ref added to EOS CWS Shipment Line for Order No: %1', CWSLine.Description);
                CWSLine.Insert(false);
            end;

        end;


    end;

}