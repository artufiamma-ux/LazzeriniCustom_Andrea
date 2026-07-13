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
                    CaptionML = ITA = 'Disegno';
                    ToolTip = 'Specifica il numero del disegno.';
                    editable = false; // Rende il campo non modificabile, assumendo che sia un identificativo unico
                }
                field("Revision ID"; Rec."Revision ID")
                {
                    ApplicationArea = All;
                    CaptionML = ITA = 'ID Revisione';
                    ToolTip = 'Specifica l''ID della revisione.';
                    editable = false; // Rende il campo non modificabile, assumendo che sia un identificativo unico
                }
                field("Revision"; Rec."Revision")
                {
                    ApplicationArea = All;
                    CaptionML = ITA = 'Revisione';
                    ToolTip = 'Specifica la revisione.';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    CaptionML = ITA = 'Descrizione';
                    ToolTip = 'Specifica la descrizione.';
                }
                field("Component Description"; Rec."Component Description")
                {
                    ApplicationArea = All;
                    CaptionML = ITA = 'Descrizione Componente';
                    ToolTip = 'Specifica la descrizione del componente.';
                }
                field("Model"; Rec."Model")
                {
                    ApplicationArea = All;
                    CaptionML = ITA = 'Modello';
                    ToolTip = 'Specifica il modello.';
                }
                field("Designer"; Rec."Designer")
                {
                    ApplicationArea = All;
                    CaptionML = ITA = 'Designer';
                    ToolTip = 'Specifica il designer.';
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    CaptionML = ITA = 'Attivo';
                    ToolTip = 'Specifica se il disegno è attivo.';
                }
                field("Cancelled"; Rec."Cancelled")
                {
                    ApplicationArea = All;
                    CaptionML = ITA = 'Annullato';
                    ToolTip = 'Specifica se il disegno è annullato.';
                }
                field("Visibile al Portale Fornitori"; Rec."Visible Supplier Portal")
                {
                    CaptionML = ITA = 'Visibile al Portale Fornitori';
                }
            }

            group(Audit)
            {
                Caption = 'Tracciabilità';
                Editable = false; // Rende i campi di sistema non modificabili dall'utente

                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    CaptionML = ITA = 'Data Creazione';
                    ToolTip = 'Specifica la data di creazione.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    CaptionML = ITA = 'Creato Da';
                    ToolTip = 'Specifica l''utente che ha creato il disegno.';
                }
                field("Last Modified DateTime"; Rec."Last Modified DateTime")
                {
                    ApplicationArea = All;
                    CaptionML = ITA = 'Data Ultima Modifica';
                    ToolTip = 'Specifica la data dell''ultima modifica.';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    CaptionML = ITA = 'Modificato Da';
                    ToolTip = 'Specifica l''utente che ha modificato il disegno.';
                }
            }
        }
    }
}