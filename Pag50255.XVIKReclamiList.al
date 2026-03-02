namespace Lazzerini;

page 50255 "XV IK Reclami List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "XV IK Reclami";
    UsageCategory = Lists;
    Caption = 'MD31 Improvement plan (IP) reclamo non conformità';

    CardPageId = 50256;
    DelayedInsert = true;

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
                    ToolTip = 'Stabilimento in cui è stato aperto il reclamo/IP.';
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
                    ToolTip = 'Tipologia del reclamo/IP.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cliente coinvolto.';
                }
                field("Supplier No."; Rec."Supplier No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fornitore coinvolto.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Articolo collegato.';
                }
                field("Problem Description"; Rec."Problem Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Descrizione sintetica del problema.';
                }
                field("Severity"; Rec."Severity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Gravità della non conformità.';
                }
                field("Detection"; Rec."Detection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Punto del processo in cui è stata rilevata la non conformità.';
                }
                field("Deadline"; Rec."Deadline")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Scadenza prevista per la chiusura del reclamo.';
                }
                field("PDCA"; Rec."PDCA")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Stato PDCA delle azioni correttive.';
                }
            }
        }
    }
}