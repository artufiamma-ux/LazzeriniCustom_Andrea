namespace Xview.Custom.Lazzerini;

page 50202 "XV PN Api Key"
{
    ApplicationArea = All;
    Caption = 'XV PN Api Key';
    PageType = Card;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Print Node Api Key';
                field("Api Key"; VarApiKey)
                {
                    Caption = 'MyField', comment = 'NLB="YourLanguageText"';
                    ExtendedDatatype = Masked;
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
                begin
                    PN.SaveApiKey(VarApiKey);
                end;
            }

        }
    }
    var
        VarApiKey: Text;
        PN: Codeunit "XV PrintNode Mgt";
}
