namespace Xview.Custom.Lazzerini;

using Microsoft.Manufacturing.Document;

pageextension 50246 "XV Subcontracting Order List" extends "Subcontracting Order List"
{
    actions
    {
        addlast(Processing)
        {
            action(StampaOrdiniContoLavoro)
            {
                ApplicationArea = All;
                Caption = 'Stampa Ordini Conto Lavoro';
                ToolTip = 'Stampa Ordini Conto Lavoro';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                //                  Report: Report "XV Ordine Conto Lavoro";
                begin
                    //                    Report.Run();
                end;
            }

        }
    }
}