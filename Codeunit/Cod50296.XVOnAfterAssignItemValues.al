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
}