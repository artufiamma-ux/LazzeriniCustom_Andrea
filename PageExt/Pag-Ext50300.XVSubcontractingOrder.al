namespace Xview.Custom.Lazzerini;

using Microsoft.Purchases.Document;
using Microsoft.Manufacturing.Document;

#pragma warning disable AL0432
pageextension 50300 "XV Subcontracting Order Ext" extends "Subcontracting Order"
#pragma warning restore AL0432
{
    actions
    {
        addbefore(CreateTransfOrdToSubcontractor)
        {
            action(PrintXVContoLavoro)
            {
                Caption = 'Stampa Ordini Conto Lavoro';
                Image = Print;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchaseHeaderRec: Record "Purchase Header";
                begin
                    PurchaseHeaderRec := Rec;
                    PurchaseHeaderRec.SetRecFilter();
                    Report.Run(Report::"XV Ordine Conto Lavoro", true, false, PurchaseHeaderRec);
                end;
            }
        }

        addafter("Re&lease_Promoted")
        {
            actionref(PrintXVContoLavoro_Promoted; PrintXVContoLavoro)
            {
            }
        }
    }
}