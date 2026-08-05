namespace Xview.Custom.Lazzerini;

page 50201 "XV PrintNode Page"
{
    ApplicationArea = All;
    Caption = 'XV PrintNode Page';
    PageType = List;
    SourceTable = "XV PrintNode Config";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Report Type"; Rec."Report Type")
                {
                    ToolTip = 'Specifies the value of the Report ID field.', Comment = '%';
                }
                field("Printer Id"; Rec."Printer Id")
                {
                    ToolTip = 'Specifies the value of the Printer Id field.', Comment = '%';
                }
                field("Title"; Rec."Job Title")
                {
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Print Node Account"; Rec."Print Node Account")
                {
                    ToolTip = 'Specifies the value of the Print Node Account field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SetApiKey)
            {
                ApplicationArea = All;
                Caption = 'Imposta Print Node Api Key', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PrintVoucher;

                trigger OnAction()
                var
                    pag: Page "XV PN Api Key";
                begin
                    pag.RunModal();
                end;
            }
            action(GetApiKey)
            {
                ApplicationArea = All;
                Caption = ' Print Node Api Key', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PrintVoucher;

                trigger OnAction()
                begin
                    Message(PN.GetApiKey());
                end;
            }

        }
    }
    var
        PN: Codeunit "XV PrintNode Mgt";

}
