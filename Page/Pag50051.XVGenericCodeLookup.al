namespace Custom.Custom;

page 50051 "XV Generic Code Lookup"
{
    ApplicationArea = All;
    Caption = 'Seleziona un valore';
    PageType = List;
    SourceTable = "XV Generic Code Lookup";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Value"; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.', Comment = '%';
                }
            }
        }
    }
    var
        PageCaptionLbl: Text;

    procedure SetCaption(NewCaption: Text)
    begin
        PageCaptionLbl := NewCaption;
    end;

    trigger OnOpenPage()
    begin
        if PageCaptionLbl <> '' then
            CurrPage.Caption(PageCaptionLbl);
    end;
}
