
namespace Lazzerini;
using Microsoft.Manufacturing.Document;

reportextension 50197 XVProdOrderJobCardExt extends "Prod. Order - Job Card"
{
    // Qui puoi specificare un RDLC custom se vuoi
    // RDLCLayout = 'XVProdOrderJobCard.rdl';

    dataset
    {
        add("Production Order")
        {
            column(DueDate_ProdOrder; "Due Date") { }
            column(LocationCode_ProdOrder; "Location Code") { }
            column(Quantity_ProdOrder; Quantity) { }
            column(Description2_ProdOrder; "Description 2") { }
            column(AssignedUserID_ProdOrder; "Assigned User ID") { }
            column(ManualScheduling_ProdOrder; "Manual Scheduling") { }
        }
    }

    local procedure GetFormattedDueDate(ProdOrderNo: Code[20]): Date
    var
        ProdOrder: Record "Production Order";
    begin
        if ProdOrder.Get(ProdOrderNo) then
            exit(ProdOrder."Due Date");
        exit(0D);
    end;

    local procedure GetAssignedUser(ProdOrderNo: Code[20]): Code[50]
    var
        ProdOrder: Record "Production Order";
    begin
        if ProdOrder.Get(ProdOrderNo) then
            exit(ProdOrder."Assigned User ID");
        exit('');
    end;
}
