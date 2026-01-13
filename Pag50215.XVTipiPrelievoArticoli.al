
namespace Lazzerini;

page 50215 "XV Tipi Prelievo Articoli"
{
    Caption = 'Tipi Prelievo Articoli';
    PageType = List;
    ApplicationArea = All;
    SourceTable = "XV Tipo Prelievo Articoli";
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
