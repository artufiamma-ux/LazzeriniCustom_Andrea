namespace Custom.Custom;

using Lazzerini;

page 50216 TipiEtichettaSpedizioni
{
    ApplicationArea = All;
    Caption = 'Tipi Etichetta Spedizioni';
    PageType = List;
    SourceTable = "XV Tipo Etichetta Spedizione";
    UsageCategory = Administration;
    AdditionalSearchTerms = 'Custom XView Tipo Etichetta Spedizioni';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Codice field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Descrizione field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Bloccato field.', Comment = '%';
                }
            }
        }
    }
}
