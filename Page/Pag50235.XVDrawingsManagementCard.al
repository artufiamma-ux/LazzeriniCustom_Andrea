namespace Xview.Custom.Lazzerini;

page 50235 "XV Drawings Management Card"
{
    ApplicationArea = All;
    Caption = 'Scheda Disegno'; // Cambiato in qualcosa di più leggibile per l'utente
    PageType = Card;
    SourceTable = "XV Drawings Management"; // <-- MANCAVA QUESTO: Collega la pagina alla tua tabella

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Generale';

                // Inserisci qui i campi principali che l'utente deve vedere o compilare
                field("Drawing No."; Rec."Drawing No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifica il numero del disegno.';
                    editable = false; // Rende il campo non modificabile, assumendo che sia un identificativo unico
                }
                field("Revision ID"; Rec."Revision ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifica l''ID della revisione.';
                    editable = false; // Rende il campo non modificabile, assumendo che sia un identificativo unico
                }
                field("Revision"; Rec."Revision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifica la revisione.';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Component Description"; Rec."Component Description")
                {
                    ApplicationArea = All;
                }
                field("Model"; Rec."Model")
                {
                    ApplicationArea = All;
                }
                field("Designer"; Rec."Designer")
                {
                    ApplicationArea = All;
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                }
                field("Cancelled"; Rec."Cancelled")
                {
                    ApplicationArea = All;
                }
            }

            group(Audit)
            {
                Caption = 'Tracciabilità';
                Editable = false; // Rende i campi di sistema non modificabili dall'utente

                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Last Modified DateTime"; Rec."Last Modified DateTime")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}