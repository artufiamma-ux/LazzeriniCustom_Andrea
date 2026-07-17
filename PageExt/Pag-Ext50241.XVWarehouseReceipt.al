namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Document;

pageextension 50241 "XV Warehouse Receipt" extends "Warehouse Receipt"
{
    actions
    {
        addlast(Processing)
        {
            action(StampaEtichettaColli)
            {
                ApplicationArea = All;
                Caption = 'Etichetta Colli Carico';
                ToolTip = 'STAMPA ETICHETTA OLLI CARICO';
                Image = BinContent;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    WCPLabelReport: Report "XV Colli Carico";
                    Rep: Integer;
                begin
                    WCPLabelReport.SetParameters(Rec."No.");
                    //                    WCPLabelReport.SetTableView(Rec);
                    WCPLabelReport.Run();
                end;
            }
            action(StampaEtichettaWCP)
            {
                ApplicationArea = All;
                Caption = 'Etichetta WCP';
                ToolTip = 'STAMPA ETICHETTA WCP';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    WCPLabelReport: Report "XV WCP Label";
                    Rep: Integer;
                begin
                    WCPLabelReport.SetParameters(Rec."No.");
                    //                    WCPLabelReport.SetTableView(Rec);
                    WCPLabelReport.Run();
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec."Location Code" = '' then
            Rec.Validate("Location Code", 'M01');
    end;
}
