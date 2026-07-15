namespace Xview.Custom.Lazzerini;
page 50234 "XV Drawings Management"
{
    PageType = List;
    SourceTable = "XV Drawings Management";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = 50235; // XV Drawings Management Card
    Caption = 'Disegni';
    AdditionalSearchTerms = 'Drawings, Disegni, Disegno, Drawing';
    DelayedInsert = true;
    InsertAllowed = false; // Impedisce l'inserimento diretto dalla lista, forzando l'uso della scheda per creare nuovi record
    ModifyAllowed = false; // Impedisce la modifica diretta dalla lista, forzando l'uso della scheda per modificare i record
    DeleteAllowed = false; // Impedisce la cancellazione diretta dalla lista, forzando l'uso della scheda per cancellare i record


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Disegno"; Rec."Drawing No.")
                {
                    CaptionML = ITA = 'Disegno';
                }
                field("ID Revisione"; Rec."Revision ID")
                {
                    CaptionML = ITA = 'ID Revisione';
                }
                field("Revisione"; Rec."Revision")
                {
                    CaptionML = ITA = 'Revisione';
                }
                field("Descrizione"; Rec."Description")
                {
                    CaptionML = ITA = 'Descrizione';
                }
                field("Descrizione Esponente"; Rec."Component Description")
                {
                    CaptionML = ITA = 'Descrizione Esponente';
                }
                field("Modello"; Rec."Model")
                {
                    CaptionML = ITA = 'Modello';
                }
                field("Data Creazione"; Rec."Creation Date")
                {
                    CaptionML = ITA = 'Data Creazione';
                }
                field("Annullato"; Rec."Cancelled")
                {
                    CaptionML = ITA = 'Annullato';
                }
                field("Creato Da"; Rec."Created By")
                {
                    CaptionML = ITA = 'Creato Da';
                }
                field("Data Ultima Modifica"; Rec."Last Modified DateTime")
                {
                    CaptionML = ITA = 'Data Ultima Modifica';
                }
                field("Modificato Da"; Rec."Modified By")
                {
                    CaptionML = ITA = 'Modificato Da';
                }
                field("Designer"; Rec."Designer")
                {
                    CaptionML = ITA = 'Designer';
                }
                field("Attivo"; Rec."Active")
                {
                    CaptionML = ITA = 'Attivo';
                }
                field("Visibile al Portale Fornitori"; Rec."Visible Supplier Portal")
                {
                    CaptionML = ITA = 'Visibile al Portale Fornitori';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(NewRevision)
            {
                Caption = 'Nuova Revisione';
                ApplicationArea = All;
                ToolTip = 'Crea una nuova revisione del disegno selezionato.';
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    NewDrawing: Record "XV Drawings Management";
                begin
                    if not Rec.IsEmpty() then begin
                        NewDrawing := Rec; // Copia i dati del disegno esistente
                        NewDrawing.SetNewRevision(); // Incrementa l'ID revisione
                        NewDrawing."Revision" := ''; // Resetta il campo revisione, l'utente lo compilerà nella scheda
                        NewDrawing.Insert(); // Inserisce il nuovo record, attivando la logica di creazione della revisione
                        PAGE.Run(PAGE::"XV Drawings Management Card", NewDrawing); // Apre la scheda del nuovo disegno per ulteriori modifiche
                    end else
                        Message('Seleziona un disegno per creare una nuova revisione.');
                end;
                // L'azione di creazione di una nuova revisione è gestita automaticamente da Business Central quando è collegata tramite CardPageId.
                // Non è necessario scrivere codice specifico per creare la revisione, a meno che tu non voglia eseguire logiche aggiuntive prima della creazione.
            }
        }
    }
}