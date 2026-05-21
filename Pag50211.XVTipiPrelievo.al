
namespace Xview.Custom.Lazzerini;

page 50211 "XV Tipi Prelievo"
{
    Caption = 'Tipi Prelievo';
    PageType = List;
    ApplicationArea = All;
    SourceTable = "XV Tipo Prelievo";
    UsageCategory = Administration;
    AdditionalSearchTerms = 'Custom XView';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field("Description"; Rec."Description") { ApplicationArea = All; }
                field("Blocked"; Rec."Blocked") { ApplicationArea = All; }
            }
        }
    }
}
