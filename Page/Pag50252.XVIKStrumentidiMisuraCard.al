namespace Xview.Custom.Lazzerini;

page 50252 "XV IK Strumenti di Misura Card"
{
    PageType = Card;
    SourceTable = "XV IK Strumenti di Misura";
    ApplicationArea = All;
    Caption = 'XV IK Strumenti di Misura Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Utente"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Matricola"; Rec."Matricola")
                {
                    ApplicationArea = All;
                }

                field("Descrizione"; Rec."Descrizione")
                {
                    ApplicationArea = All;
                }

                field("Ubicazione"; Rec."Ubicazione")
                {
                    ApplicationArea = All;
                }

                field("Tipo Strumento"; Rec."Tipo Strumento")
                {
                    ApplicationArea = All;
                }

                field("Bollino"; Rec."Bollino")
                {
                    ApplicationArea = All;
                }

                field("Stato"; Rec."Stato")
                {
                    ApplicationArea = All;
                }

                field("Note"; Rec."Note")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }

            group(Documenti)
            {
                Caption = 'Documenti';

                part(DocumentiPart; "XV IK Strumenti Doc List")
                {
                    ApplicationArea = All;
                    SubPageLink = "Strumento di misura Entry No." = field("Entry No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(NewDocument)
            {
                Caption = 'Nuovo Documento';
                Image = NewDocument;
                ApplicationArea = All;

                trigger OnAction()
                var
                    DocRec: Record "XV IK Strumenti di Misura Doc";
                begin
                    DocRec.Init();
                    DocRec."Strumento di misura Entry No." := Rec."Entry No.";
                    DocRec.Insert(true);
                    PAGE.Run(PAGE::"XV IK Strumenti Doc Card", DocRec);
                end;
            }

            action(OpenSelectedDocument)
            {
                Caption = 'Apri Documento';
                Image = EditLines;
                ApplicationArea = All;

                trigger OnAction()
                var
                    DocRec: Record "XV IK Strumenti di Misura Doc";
                begin
                    CurrPage.DocumentiPart.PAGE.SetSelectionFilter(DocRec);

                    if not DocRec.FindFirst() then begin
                        Message('Seleziona un documento dalla lista.');
                        exit;
                    end;

                    PAGE.Run(PAGE::"XV IK Strumenti Doc Card", DocRec);
                end;
            }
        }
    }
}