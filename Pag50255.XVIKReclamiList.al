namespace Lazzerini;

page 50255 "XV IK Reclami List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "XV IK Reclami";
    UsageCategory = Lists;
    Caption = 'MD31 Improvement plan (IP) reclamo non conformità';
    AdditionalSearchTerms = 'MD31 Improvement plan (IP) reclamo non conformità';
    DelayedInsert = true;
    CardPageId = 50256; // XV IK Reclami Card



    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Identificativo univoco generato automaticamente (YYYYMMDD + sequenza).';
                }
                field("Plant"; Rec."Plant")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Stabilimento di riferimento in cui è stato aperto il reclamo/IP.';
                }
                field("Date of the document"; Rec."Date of the document")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Data di apertura del reclamo/IP.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Tipologia di reclamo/IP.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cliente coinvolto nel reclamo (se applicabile).';
                }
                field("Supplier No."; Rec."Supplier No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fornitore coinvolto nel reclamo (se applicabile).';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Articolo interessato dal reclamo.';
                }
                field("Problem Description"; Rec."Problem Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Descrizione sintetica del problema rilevato.';
                }
                field("Severity"; Rec."Severity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Livello di gravità del problema.';
                }
                field("Detection"; Rec."Detection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Punto della catena in cui è stato individuato il problema.';
                }
                field("Deadline"; Rec."Deadline")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Scadenza per la risoluzione del reclamo.';
                }
                field("PDCA"; Rec."PDCA")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Avanzamento dell’azione correttiva secondo la metodologia PDCA.';
                }
            }
        }
    }
}