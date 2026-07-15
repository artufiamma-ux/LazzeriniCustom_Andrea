namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Item;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Document;
codeunit 50296 "XV Posizione Layout Sub"
{
    [EventSubscriber(
        ObjectType::Table,
        Database::"Sales Line",
        'OnAfterAssignItemValues',
        '',
        false,
        false)]
    local procedure CopyLayoutAfterAssignItemValues(
        var SalesLine: Record "Sales Line";
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        var xSalesLine: Record "Sales Line";
        CurrentFieldNo: Integer)
    begin
        SalesLine."Xv Posizione Layout" := Item."Posizione Layout";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure PurchaseLineOnAfterValidateNo(
        var Rec: Record "Purchase Line";
        var xRec: Record "Purchase Line")
    var
        Item: Record Item;
        Drawing: Record "XV Drawings Management";
    begin
        if Rec.Type <> Rec.Type::Item then
            exit;
        Rec."Drawing No." := '';
        Rec."Drawing Revision Id" := 0;
        Rec."Drawing Revision" := '';

        if Rec."No." = '' then begin
            exit;
        end;

        if Item.Get(Rec."No.") then begin
            if Item."Drawing No." <> '' then begin
                Drawing.SetRange("Drawing No.", Item."Drawing No.");
                Drawing.SetRange(Active, true);
                Drawing.SetRange(Cancelled, false);
                if Drawing.FindFirst() then begin
                    Rec."Drawing No." := Item."Drawing No.";
                    Rec."Drawing Revision Id" := Drawing."Revision Id";
                    Rec."Drawing Revision" := Drawing."Revision";
                end;
            end;
        end;
    end;

}