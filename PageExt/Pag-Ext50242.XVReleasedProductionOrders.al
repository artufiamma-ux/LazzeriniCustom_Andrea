namespace Xview.Custom.Lazzerini;

using Microsoft.Manufacturing.Document;

pageextension 50242 "XV Released Production Orders" extends "Released Production Orders"
{

    actions
    {
        addlast(Processing)
        {
            action(StampaBasamentiTelai)
            {
                ApplicationArea = All;
                Caption = 'Etichette Basamenti e Telai';
                ToolTip = 'STAMPA ETICHETTE BASAMENTI E TELAI';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    BasamentiTelaiReport: Report "XV Etichette Basamenti Telai";

                begin
                    BasamentiTelaiReport.SetParameters(Rec);
                    //                    BasamentiTelaiReport.SetTableView(Rec);
                    BasamentiTelaiReport.Run();
                end;
            }
        }
    }
}
