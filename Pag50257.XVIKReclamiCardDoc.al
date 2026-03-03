namespace Lazzerini;

page 50257 "XV IK Reclami Card Doc"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "XV IK Reclami Doc";
    Caption = 'Documento Reclamo';

    // Il record deve esistere PRIMA di scrivere nel BLOB
    DelayedInsert = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Documento Entry No."; Rec."Documento Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reclamo ID"; Rec."Reclamo ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field(HasAttachment; Rec."Attached File".HasValue)
                {
                    ApplicationArea = All;
                    Caption = 'Allegato Caricato';
                    Editable = false;
                }
            }

            group(Allegato)
            {
                field("Attached File"; Rec."Attached File")
                {
                    ApplicationArea = All;
                    AssistEdit = true;   // <-- forza la visualizzazione del "…"

                    trigger OnAssistEdit()
                    var
                        InStr: InStream;
                        OutStr: OutStream;
                        FileNameTxt: Text;
                        ok: Boolean;
                    begin
                        //Message('AssistEdit avviato.'); // diagnostica (puoi rimuoverlo a regime)

                        ok := UploadIntoStream('Seleziona file da allegare', '', '', FileNameTxt, InStr);
                        if not ok then begin
                            Message('Selezione file annullata.');
                            exit;
                        end;

                        if FileNameTxt = '' then begin
                            Message('Nessun file selezionato.');
                            exit;
                        end;

                        Rec."Attached File".CreateOutStream(OutStr);
                        CopyStream(OutStr, InStr);

                        Rec."File Name" := FileNameTxt;
                        Rec.Modify(true);

                        CurrPage.Update(false);
                        Message('Allegato caricato: %1', FileNameTxt);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(AttachFile)
            {
                Caption = 'Allega file';
                ApplicationArea = All;
                Image = Attach;
                ToolTip = 'Seleziona un file dal tuo computer per allegarlo.';

                trigger OnAction()
                var
                    InStr: InStream;
                    OutStr: OutStream;
                    FileNameTxt: Text;
                    ok: Boolean;
                begin
                    ok := UploadIntoStream('Seleziona file da allegare', '', '', FileNameTxt, InStr);
                    if not ok then begin
                        Message('Selezione file annullata.');
                        exit;
                    end;

                    if FileNameTxt = '' then begin
                        Message('Nessun file selezionato.');
                        exit;
                    end;

                    Rec."Attached File".CreateOutStream(OutStr);
                    CopyStream(OutStr, InStr);

                    Rec."File Name" := FileNameTxt;
                    Rec.Modify(true);

                    CurrPage.Update(false);
                    Message('Allegato caricato: %1', FileNameTxt);
                end;
            }

            action(DownloadFile)
            {
                Caption = 'Scarica Allegato';
                ApplicationArea = All;
                Image = ExportFile;

                trigger OnAction()
                var
                    InStr: InStream;
                begin
                    Rec.CalcFields("Attached File");
                    if not Rec."Attached File".HasValue then
                        Error('Nessun file allegato.');

                    Rec."Attached File".CreateInStream(InStr);

                    DownloadFromStream(
                        InStr,
                        'Scarica allegato',
                        '',
                        '',
                        Rec."File Name"
                    );
                end;
            }

            action(DeleteAttachment)
            {
                Caption = 'Rimuovi Allegato';
                ApplicationArea = All;
                Image = Delete;

                trigger OnAction()
                begin
                    Rec.CalcFields("Attached File");
                    if not Rec."Attached File".HasValue then
                        Error('Nessun allegato da rimuovere.');

                    if not Confirm('Rimuovere l''allegato?', false) then
                        exit;

                    Clear(Rec."Attached File");
                    Clear(Rec."File Name");
                    Rec.Modify(true);

                    CurrPage.Update(false);
                    Message('Allegato rimosso.');
                end;
            }
        }
    }
    // -----------------------------
    // Parametri passati dal padre
    // -----------------------------
    var
        ParentReclamoID: Code[100];

    procedure SetReclamoID(NewID: Code[100])
    begin
        ParentReclamoID := NewID;
    end;

    trigger OnOpenPage()
    begin
        // 1) Associa SEMPRE il reclamo
        if Rec."Reclamo ID" = '' then
            Rec."Reclamo ID" := ParentReclamoID;

        // 2) Inserisci SUBITO il record (serve per scrivere il BLOB)
        if Rec."Documento Entry No." = '' then
            Rec.Insert(true);

        // 3) Data documento di default
        if Rec."Document Date" = 0D then
            Rec.Validate("Document Date", WorkDate());
    end;

}