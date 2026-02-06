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
                /*
                                field("Bollino (Colore)"; BollinoIndicatorTxt)
                                {
                                    ApplicationArea = All;
                                    Editable = false;
                                }


                                field("Stato (Colore)"; StatoIndicatorTxt)
                                {
                                    ApplicationArea = All;
                                    Editable = false;
                                }
                */
                field("Note"; Rec."Note")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Note aggiuntive sullo strumento.';
                }
            }
        }
    }
    /*
        var
            BollinoIndicatorTxt: Text[2];
            StatoIndicatorTxt: Text[2];

        trigger OnAfterGetRecord()
        begin
            // Colori Bollino
            case Rec."Bollino" of
                Rec."Bollino"::Giallo:
                    BollinoIndicatorTxt := '🟨';
                Rec."Bollino"::Verde:
                    BollinoIndicatorTxt := '🟩';
                Rec."Bollino"::Blu:
                    BollinoIndicatorTxt := '🟦';
                else
                    BollinoIndicatorTxt := '■';
            end;

            // Colori Stato
            case Rec."Stato" of
                Rec."Stato"::Attivo:
                    StatoIndicatorTxt := '🟩';
                Rec."Stato"::Dismesso:
                    StatoIndicatorTxt := '🟥';
                else
                    StatoIndicatorTxt := '■';
            end;
        end;
    */
}