namespace Lazzerini;

page 50253 "XV IK Strumenti Doc List"
{
    PageType = ListPart;
    SourceTable = "XV IK Strumenti di Misura Doc";
    Caption = 'Documenti Strumento di Misura';
    ApplicationArea = All;
    AdditionalSearchTerms = 'Custom XView, Strumenti di Misura, Strumenti di taratura';
    CardPageId = 50254; // XV IK Strumenti Doc Card

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
                field("Tipo Documento"; Rec."Tipo Documento")
                {
                    ApplicationArea = All;
                }

                field("Nome Documento"; Rec."Nome Documento")
                {
                    ApplicationArea = All;
                }

                field("Data Ultimo Intervento"; Rec."Data Ultimo Intervento")
                {
                    ApplicationArea = All;
                }

                field("Periodicità (Mesi)"; Rec."Periodicità (Mesi)")
                {
                    ApplicationArea = All;
                }

                field("Data Prossimo Intervento"; Rec."Data Prossimo Intervento")
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
            action(DownloadSelectedAttachment)
            {
                Caption = 'Scarica Allegato';
                Image = ExportFile;
                ApplicationArea = All;
                ToolTip = 'Scarica il file allegato al record corrente.';

                trigger OnAction()
                var
                    InStr: InStream;
                    FileName: Text;
                begin
                    Rec.CalcFields("Allegato Contenuto");
                    if not Rec."Allegato Contenuto".HasValue then begin
                        Message('Nessun allegato da scaricare.');
                        exit;
                    end;

                    Rec."Allegato Contenuto".CreateInStream(InStr);

                    FileName := Rec."Nome File Originale";
                    if FileName = '' then FileName := Rec."Nome Documento";
                    if FileName = '' then FileName := 'Allegato.dat';

                    DownloadFromStream(InStr, 'Scarica', '', '', FileName);
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