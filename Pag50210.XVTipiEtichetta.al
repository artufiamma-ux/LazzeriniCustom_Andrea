
namespace Lazzerini;

page 50210 "XV Tipi Etichetta"
{
    Caption = 'Tipi Etichetta';
    PageType = List;
    ApplicationArea = All;
    SourceTable = "XV Tipo Etichetta";
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
