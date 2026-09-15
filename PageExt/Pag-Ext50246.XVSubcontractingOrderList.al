namespace Xview.Custom.Lazzerini;

using Microsoft.Manufacturing.Document;

#pragma warning disable AL0432
pageextension 50246 "XV Subcontracting Order List" extends "Subcontracting Order List"
#pragma warning restore AL0432
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