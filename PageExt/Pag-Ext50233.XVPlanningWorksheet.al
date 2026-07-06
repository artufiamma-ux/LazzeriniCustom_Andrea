namespace Custom.Custom;

using Microsoft.Inventory.Requisition;
using Microsoft.Inventory.Tracking;
using Microsoft.Sales.Document;

pageextension 50233 "XV Planning Worksheet" extends "Planning Worksheet"
{


    layout
    {
        addafter("Accept Action Message")
        {
            field("Posizione Layout"; GetPosizioneLayout())
            {
                ApplicationArea = All;
            }
        }
    }

    local procedure GetPosizioneLayout(): Code[20]
    var
        ReservationEntry: Record "Reservation Entry";
        SalesLine: Record "Sales Line";
    begin
        ReservationEntry.SetRange("Source Type", Database::"Sales Line");
        ReservationEntry.SetRange("Item No.", Rec."No.");

        ReservationEntry.SetCurrentKey("Creation Date");
        ReservationEntry.Ascending(false);

        if ReservationEntry.FindFirst() then
            if SalesLine.Get(
                    Enum::"Sales Document Type".FromInteger(
                        ReservationEntry."Source Subtype"),
                    ReservationEntry."Source ID",
                    ReservationEntry."Source Ref. No.") then
                exit(SalesLine."xv Posizione Layout");

        exit('');
    end;

}
