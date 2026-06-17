namespace Xview.Custom.Lazzerini;

using Microsoft.Manufacturing.Journal;

pageextension 50240 "XV Output Journal" extends "Output Journal"
{
    actions
    {
        addfirst("Processing")
        {
            action(StampaKitBus)
            {
                ApplicationArea = All;
                Caption = 'Stampa Etichetta';
                ToolTip = 'Stampa Etichetta';
                Image = PrintDocument;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    KBReport: Report "XV Item Journal";
                begin
                    KBReport.SetParameters(Rec);
                    //                    KBReport.SetTableView(Rec);
                    KBReport.Run();
                end;
            }

        }
    }
}
