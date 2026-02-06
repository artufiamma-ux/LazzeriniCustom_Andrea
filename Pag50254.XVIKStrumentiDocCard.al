namespace Lazzerini;

page 50254 "XV IK Strumenti Doc Card"
{
    PageType = Card;
    SourceTable = "XV IK Strumenti di Misura Doc";
    Caption = 'Documento Strumento di Misura';
    ApplicationArea = All;
    Editable = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Strumento di misura Entry No."; Rec."Strumento di misura Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false; // viene passato automaticamente dal padre
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

                field("Allegato"; Rec."Allegato")
                {
                    ApplicationArea = All;
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
                Image = Attach;
                ApplicationArea = All;

                trigger OnAction()
                var
                    InStr: InStream;
                    FileName: Text;
                begin
                    // Seleziona un file dal client e importalo nel campo Media
                    if UploadIntoStream('Seleziona file da allegare', '', '', FileName, InStr) then begin
                        Rec."Allegato".ImportStream(InStr, FileName);
                        // Se non è stato valorizzato "Nome Documento", lo suggerisco dal nome file
                        if Rec."Nome Documento" = '' then
                            Rec."Nome Documento" := FileName;
                        Rec.Modify(true);
                        Message('Allegato caricato correttamente: %1', FileName);
                    end;
                end;
            }

            action(DownloadFile)
            {
                Caption = 'Scarica allegato';
                Image = ExportFile;
                ApplicationArea = All;

                trigger OnAction()
                var
                    InStr: InStream;
                    SuggestedName: Text;
                begin
                    Rec.CalcFields("Allegato");


                    SuggestedName := Rec."Nome Documento";
                    if SuggestedName = '' then
                        SuggestedName :=
                            StrSubstNo('%1_%2', Rec."Tipo Documento", Format(Rec."Documento Entry No."));

                    // --- SAAS-COMPATIBLE ---
                    //                   Rec."Allegato".CreateInStream(InStr);
                    DownloadFromStream(InStr, '', '', SuggestedName, SuggestedName);
                end;
            }

            action(ClearAttachment)
            {
                Caption = 'Rimuovi allegato';
                Image = Delete;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.CalcFields("Allegato");

                    if Confirm('Vuoi rimuovere l''allegato?', false) then begin
                        Clear(Rec."Allegato");
                        Rec.Modify(true);
                        Message('Allegato rimosso.');
                    end;
                end;
            }
        }
    }
}