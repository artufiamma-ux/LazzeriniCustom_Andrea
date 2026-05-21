namespace Xview.Custom.Lazzerini;
using Microsoft.Warehouse.Document;
using Microsoft.Sales.Document;

codeunit 50218 "XV Warehouse Shipment Header"
{
    Permissions =
        tabledata "Warehouse Shipment Header" = m;
    [EventSubscriber(ObjectType::Table, Database::"Warehouse Shipment Line", 'OnBeforeInsertEvent', '', false, false)]
    local procedure BeforeInsertXVWarehouseShipmentHeader(var Rec: Record "Warehouse Shipment Line")
    var
        ShipmentHeader: Record "Warehouse Shipment Header";
        SalesHeader: Record "Sales Header";
    begin
        if ShipmentHeader.Get(Rec."No.") then begin
            SalesHeader.SetRange("No.", Rec."Source No.");
            if SalesHeader.FindSet() then
                repeat begin
                    ShipmentHeader."Tipo Ordine" := SalesHeader."Tipo Ordine";
                    ShipmentHeader.Modify(true);
                end
                until SalesHeader.Next() = 0;
        end;


    end;
}
