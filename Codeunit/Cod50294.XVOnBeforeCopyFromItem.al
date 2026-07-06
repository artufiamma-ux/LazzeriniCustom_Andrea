
codeunit 50294 "XV OnBeforeCopyFromItem"
{
    /*
    [EventSubscriber(ObjectType::Table, Database::"Requisition Line",
  'OnBeforeCopyFromItem', '', false, false)]
    local procedure BeforeCopyFromItem(
     var RequisitionLine: Record "Requisition Line";
     Item: Record Item)
    begin
        RequisitionLine."Posizione Layout" := Item."Posizione Layout";

    end;
*/
    [EventSubscriber(ObjectType::Table, Database::"Requisition Line",
  'OnAfterCopyFromItem', '', false, false)]
    local procedure AfterCopyFromItem(
     var
     RequisitionLine: Record "Requisition Line";
     Item: Record Item)
    var
        SalesLine: Record "Sales Line";
    begin
        if not GetFirstSalesLine(RequisitionLine, SalesLine) then
            exit;

        //     RequisitionLine."Posizione Layout" := SalesLine."xv Posizione Layout";

    end;



    procedure GetFirstSalesLineOLD(
        ReqLine: Record "Requisition Line";
        var SalesLine: Record "Sales Line"): Boolean
    var
        OrderTrackingMgt: Codeunit OrderTrackingManagement;
        TrackingEntry: Record "Order Tracking Entry";
        ReservEntry: Record "Reservation Entry";
    begin

        Message(
        '%1 - %2 - %3 - %4',
        ReqLine."Planning Line Origin",
        ReqLine."Ref. Order Type",
        ReqLine."Ref. Order No.",
        ReqLine."Ref. Line No.");

        Clear(SalesLine);

        OrderTrackingMgt.SetReqLine(ReqLine);

        ReqLine.SetReservationFilters(ReservEntry);
        Message('%1', ReservEntry.Count);

        //        if not OrderTrackingMgt.FindRecordsWithoutMessage() then
        //            exit(false);

        if not OrderTrackingMgt.FindRecord('-', TrackingEntry) then
            exit(false);

        repeat
            if TrackingEntry."From Type" = Database::"Sales Line" then
                if GetSalesLineFromTrackingEntry(
                    TrackingEntry."From Subtype",
                    TrackingEntry."From ID",
                    TrackingEntry."From Ref. No.",
                    SalesLine)
                then
                    exit(true);

            if TrackingEntry."For Type" = Database::"Sales Line" then
                if GetSalesLineFromTrackingEntry(
                    TrackingEntry."For Subtype",
                    TrackingEntry."For ID",
                    TrackingEntry."For Ref. No.",
                    SalesLine)
                then
                    exit(true);

        until OrderTrackingMgt.GetNextRecord(1, TrackingEntry) = 0;

        exit(false);
    end;

    local procedure GetSalesLineFromTrackingEntry(
        SourceSubtype: Integer;
        DocumentNo: Code[20];
        LineNo: Integer;
        var SalesLine: Record "Sales Line"): Boolean
    var
        SalesDocType: Enum "Sales Document Type";
    begin
        case SourceSubtype of
            1:
                SalesDocType := SalesDocType::Quote;
            2:
                SalesDocType := SalesDocType::Order;
            3:
                SalesDocType := SalesDocType::Invoice;
            4:
                SalesDocType := SalesDocType::"Credit Memo";
            5:
                SalesDocType := SalesDocType::"Blanket Order";
            6:
                SalesDocType := SalesDocType::"Return Order";
            else
                exit(false);
        end;

        exit(SalesLine.Get(SalesDocType, DocumentNo, LineNo));
    end;

    local procedure GetFirstSalesLine(
        var RequisitionLine: Record "Requisition Line";
        var SalesLine: Record "Sales Line"): Boolean
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        ReservationEntry.SetRange("Source Type", Database::"Sales Line");
        ReservationEntry.SetRange("Item No.", RequisitionLine."No.");

        ReservationEntry.SetCurrentKey("Creation Date");
        ReservationEntry.Ascending(false);

        if ReservationEntry.FindFirst() then
            exit(
                SalesLine.Get(
                    Enum::"Sales Document Type".FromInteger(
                        ReservationEntry."Source Subtype"),
                    ReservationEntry."Source ID",
                    ReservationEntry."Source Ref. No."));

        exit(false);
    end;

}