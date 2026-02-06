namespace Lazzerini;

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
                    ToolTip = 'Note aggiuntive sullo strumento.';
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
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DocRec: Record "XV IK Strumenti di Misura Doc";
                begin
                    // Crea un nuovo documento già collegato allo strumento corrente
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
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    DocRec: Record "XV IK Strumenti di Misura Doc";
                    AnySelected: Boolean;
                begin
                    // Applica a DocRec il filtro della selezione corrente nella ListPart
                    CurrPage.DocumentiPart.PAGE.SetSelectionFilter(DocRec);

                    // Se l'utente ha selezionato una o più righe, il Record avrà dei filtri impostati.
                    // Proviamo a prenderne la prima (FindFirst rispetta i filtri correnti).
                    AnySelected := DocRec.FindFirst();

                    if not AnySelected then begin
                        // Nessuna selezione esplicita: apriamo l'ultimo (visto che la lista è ordinata discendente)
                        DocRec.Reset();
                        DocRec.SetRange("Strumento di misura Entry No.", Rec."Entry No.");
                        if DocRec.FindLast() then
                            AnySelected := true;
                    end;

                    if AnySelected then
                        PAGE.Run(PAGE::"XV IK Strumenti Doc Card", DocRec)
                    else
                        Message('Seleziona un documento dalla lista.');
                end;
            }
        }
    }
}
