namespace Lazzerini;
using Microsoft.Inventory.Requisition;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Tracking;
using Microsoft.Manufacturing.Document;

codeunit 50219 "XV Production Order"
{

    local procedure GetSalesLineFromReservationEntry(NrMovimento: Integer): Record "Sales Line"
    var
        SalesLine: Record "Sales Line";
        ReservationEntry: Record "Reservation Entry";
    //Source Ref. No.

    begin
        ReservationEntry.SetRange("Source Type", DATABASE::"Sales Line");
        ReservationEntry.SetRange("Entry No.", NrMovimento);
        if ReservationEntry.FindSet() then
            repeat
                if SalesLine.Get(
                        SalesLine."Document Type"::Order,
                        ReservationEntry."Source ID",
                        ReservationEntry."Source Ref. No."
                    ) then
                    exit(SalesLine);
            until ReservationEntry.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Mfg. Carry Out Action", 'OnAfterInsertProdOrderLine', '', false, false)]
    local procedure OnAfterInsertProdOrderLine(ReqLine: Record "Requisition Line"; ProdOrder: Record Microsoft.Manufacturing.Document."Production Order"; var ProdOrderLine: Record Microsoft.Manufacturing.Document."Prod. Order Line"; Item: Record Item)
    var
        SalesLine: Record "Sales Line";
        ReservationEntry: Record "Reservation Entry";
        NrMovimento: Integer;
    begin

        ReservationEntry.SetRange("Source Type", DATABASE::"Prod. Order Line");
        ReservationEntry.SetRange("Source ID", ProdOrderLine."Prod. Order No.");
        ReservationEntry.SetRange("Source Prod. Order Line", ProdOrderLine."Line No.");

        if ReservationEntry.FindSet() then
            repeat
                NrMovimento := ReservationEntry."Entry No.";
                SalesLine := GetSalesLineFromReservationEntry(NrMovimento);
                if NOT SalesLine.IsEmpty() then begin
                    ProdOrderLine."XV Kit Bus" := SalesLine."xv Kit Bus";
                    ProdOrderLine."XV Progressivo Kit Bus" := SalesLine."xv Progressivo Kit Bus";
                    ProdOrderLine."Posizione Layout" := SalesLine."xv Posizione Layout";
                    ProdOrderLine."XV Document No." := SalesLine."Document No.";
                    ProdOrderLine."XV Line No." := SalesLine."Line No.";
                    ProdOrderLine.Modify(true);

                    ProdOrder."Posizione Layout" := SalesLine."xv Posizione Layout";
                    ProdOrder."Nr. Ordine di vendita" := SalesLine."Document No.";
                    ProdOrder."Rif. Ord. Vendita" := SalesLine."Document No.";
                    ProdOrder."Nr. Serie progressiva" := SalesLine."xv Progressivo Kit Bus";
                    ProdOrder.Modify(true);

                    break;
                end;
            until ReservationEntry.Next() = 0;
    end;

}
