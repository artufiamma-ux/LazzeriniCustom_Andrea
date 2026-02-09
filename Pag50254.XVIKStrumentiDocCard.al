namespace Lazzerini;

page 50254 "XV IK Strumenti Doc Card"
{
    PageType = Card;
    SourceTable = "XV IK Strumenti di Misura Doc";
    Caption = 'Documento Strumento di Misura';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Strumento di misura Descrizione"; GetDescrizioneStrumento(Rec."Strumento di misura Entry No."))
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Favorable;
                }

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
                field("Note"; Rec."Note")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }


                // Sostituisco il controllo MediaSet con un campo che indica se il file esiste
                field(HasAttachment; Rec."Allegato Contenuto".HasValue)
                {
                    Caption = 'Allegato Caricato';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Indica se è presente un file allegato.';
                }

                field("Nome File Originale"; Rec."Nome File Originale")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Nome File Allegato';
                }
            }
        }

    }


    actions
    {
        area(processing)
        {
            // --- CARICA ALLEGATO ---
            action(AttachFile)
            {
                Caption = 'Allega file';
                Image = Attach;
                ApplicationArea = All;
                ToolTip = 'Seleziona un file dal tuo computer per allegarlo.';

                trigger OnAction()
                var
                    InStr: InStream;
                    OutStr: OutStream;
                    FileName: Text;
                begin
                    if UploadIntoStream('Seleziona file da allegare', '', 'Tutti i file (*.*)|*.*', FileName, InStr) then begin
                        // Creiamo lo stream di uscita sul Blob
                        Rec."Allegato Contenuto".CreateOutStream(OutStr);
                        CopyStream(OutStr, InStr);

                        // Salviamo i metadati
                        Rec."Nome File Originale" := FileName;
                        if Rec."Nome Documento" = '' then
                            Rec."Nome Documento" := FileName;

                        Rec.Modify(true);
                        Message('Allegato caricato correttamente.');
                    end;
                end;
            }

            // --- SCARICA ALLEGATO ---
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

            // --- RIMUOVI ALLEGATO ---
            action(ClearAttachment)
            {
                Caption = 'Rimuovi allegato';
                Image = Delete;
                ApplicationArea = All;
                ToolTip = 'Elimina il file allegato da questo record.';

                trigger OnAction()
                begin
                    Rec.CalcFields("Allegato Contenuto");
                    if not Rec."Allegato Contenuto".HasValue then begin
                        Message('Nessun allegato da rimuovere.');
                        exit;
                    end;

                    if Confirm('Rimuovere l''allegato corrente?', false) then begin
                        Clear(Rec."Allegato Contenuto");
                        Clear(Rec."Nome File Originale");
                        Rec.Modify(true);
                        Message('Allegato rimosso.');
                    end;
                end;
            }
        }
    }
    local procedure GetDescrizioneStrumento(EntryNo: Integer): Text
    var
        StrumentiDiMisura: Record "XV IK Strumenti di Misura";
    begin
        if StrumentiDiMisura.Get(EntryNo) then
            exit(StrumentiDiMisura.Descrizione)
        else
            exit('');
    end;

}