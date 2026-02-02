
codeunit 50294 "XV OnBeforeCopyFromItem"
{
    [EventSubscriber(ObjectType::Table, Database::"Requisition Line",
  'OnBeforeCopyFromItem', '', false, false)]
    local procedure BeforeCopyFromItem(
     var RequisitionLine: Record "Requisition Line";
     Item: Record Item)
    begin
        RequisitionLine."Posizione Layout" := Item."Posizione Layout";

    end;
}