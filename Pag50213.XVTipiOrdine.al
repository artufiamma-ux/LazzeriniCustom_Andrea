
namespace Lazzerini;

page 50213 "XV Tipi Ordine"
{
    Caption = 'Tipi Ordine';
    PageType = List;
    ApplicationArea = All;
    SourceTable = "XV Tipo Ordine";
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
