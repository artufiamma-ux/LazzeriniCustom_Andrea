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
                field("Disegno"; Rec."Drawing No.") { }
                field("ID Revisione"; Rec."Revision ID") { }
                field("Revisione"; Rec."Revision") { }
                field("Descrizione"; Rec."Description") { }
                field("Descrizione Componente"; Rec."Component Description") { }
                field("Modello"; Rec."Model") { }
                field("Data Creazione"; Rec."Creation Date") { }
                field("Annullato"; Rec."Cancelled") { }
                field("Creato Da"; Rec."Created By") { }
                field("Data Ultima Modifica"; Rec."Last Modified DateTime") { }
                field("Modificato Da"; Rec."Modified By") { }
                field("Designer"; Rec."Designer") { }
                field("Attivo"; Rec."Active") { }
                field("Visibile al Portale Fornitori"; Rec."Visible Supplier Portal") { }
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
                        NewDrawing."Revision ID" := NewDrawing."Revision ID" + 1; // Incrementa l'ID revisione
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