namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Document;
codeunit 50295 "XV On After Get Item"
{
    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Line", 'OnAfterGetItem', '', false, false)]
    local procedure CopyLayoutAfterGetItem(var Item: Record Item; var ProdOrderLine: Record "Prod. Order Line")
    var
        XVUtil: Codeunit "XVUtil";
    begin
        ProdOrderLine."Posizione Layout" := XVUtil.GetPosizioneLayout(Item."No.", ProdOrderLine."XV Document No.");
    end;
}