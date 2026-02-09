namespace Lazzerini;

page 50253 "XV IK Strumenti Doc List"
{
    PageType = ListPart;
    SourceTable = "XV IK Strumenti di Misura Doc";
    Caption = 'Documenti Strumento di Misura';
    ApplicationArea = All;
    AdditionalSearchTerms = 'Custom XView, Strumenti di Misura, Strumenti di taratura';

    // Lascio Editable false come da tua impostazione originale, 
    // ma le azioni di download funzioneranno comunque.
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Data Ultimo Intervento"; Rec."Data Ultimo Intervento")
                {
                    ApplicationArea = All;
                }

                field("Tipo Documento"; Rec."Tipo Documento")
                {
                    ApplicationArea = All;
                }

                field("Nome Documento"; Rec."Nome Documento")
                {
                    ApplicationArea = All;
                }

                field("Periodicità (Mesi)"; Rec."Periodicità (Mesi)")
                {
                    ApplicationArea = All;
                }

                // Sostituito il campo MediaSet con un indicatore booleano 
                // per far vedere se l'allegato esiste
                field(HasAttachment; Rec."Allegato Contenuto".HasValue)
                {
                    Caption = 'Allegato Presente';
                    ApplicationArea = All;
                    ToolTip = 'Indica se è presente un file caricato.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(DownloadFile)
            {
                Caption = 'Scarica allegato';
                Image = ExportFile;
                ApplicationArea = All;
                ToolTip = 'Scarica il file salvato nel record selezionato.';

                trigger OnAction()
                var
                    InStr: InStream;
                    FileName: Text;
                begin
                    // Fondamentale: i campi Blob vanno calcolati prima dell'uso
                    Rec.CalcFields("Allegato Contenuto");

                    if not Rec."Allegato Contenuto".HasValue then begin
                        Message('Nessun allegato presente per questo record.');
                        exit;
                    end;

                    // Recupero il nome del file salvato o ne genero uno di backup
                    FileName := Rec."Nome File Originale";
                    if FileName = '' then
                        FileName := StrSubstNo('%1_%2.dat', Rec."Tipo Documento", Rec."Documento Entry No.");

                    // Estrazione del flusso di dati
                    Rec."Allegato Contenuto".CreateInStream(InStr);

                    // Download diretto senza passare da tabelle di sistema
                    DownloadFromStream(InStr, 'Scarica Allegato', '', '', FileName);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Data Ultimo Intervento", "Documento Entry No.");
        Rec.SetAscending("Data Ultimo Intervento", false);
        Rec.SetAscending("Documento Entry No.", false);
    end;
}