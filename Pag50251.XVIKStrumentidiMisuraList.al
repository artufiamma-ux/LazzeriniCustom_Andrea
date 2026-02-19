namespace Lazzerini;

page 50251 "XV IK Strumenti di Misura List"
{
    PageType = List;
    SourceTable = "XV IK Strumenti di Misura";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Strumenti di Misura';
    AdditionalSearchTerms = 'Strumento di misura, Strumenti di taratura, Instrument, Instruments';
    DelayedInsert = true;
    CardPageId = 50252; // XV IK Strumenti di Misura Card

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Matricola"; Rec."Matricola")
                {
                    Caption = 'Matricola';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Matricola dello strumento.';
                }
                field("Utente"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'Utente';
                    Editable = false;
                    ToolTip = 'Utente che ha inserito il record.';
                }

                field("Descrizione"; Rec."Descrizione")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descrizione dello strumento.';
                }

                field("Ubicazione"; Rec."Ubicazione")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ubicazione dello strumento.';
                }

                field("Tipo Strumento"; Rec."Tipo Strumento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipologia dello strumento.';
                }



                field("Bollino (Colore)"; BollinoIndicatorTxt)
                {
                    ApplicationArea = All;
                    Caption = 'Bollino';
                    Editable = false;
                    ToolTip = 'Indicatore colore del bollino (Giallo/Verde/Blu).';
                }
                field("Stato (Colore)"; StatoIndicatorTxt)
                {
                    ApplicationArea = All;
                    Caption = 'Stato';
                    Editable = false;
                    ToolTip = 'Indicatore colore dello stato (Attivo/Dismesso).';
                }
                /*

                field("Bollino"; Rec."Bollino")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valore del bollino.';
                }
                field("Stato"; Rec."Stato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Stato operativo dello strumento.';
                }

                
                */
            }
        }
    }

    var
        BollinoIndicatorTxt: Text[2];
        StatoIndicatorTxt: Text[2];

    trigger OnAfterGetRecord()
    begin
        // Mappa Bollino → quadrato colorato
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

        // Mappa Stato → quadrato colorato
        case Rec."Stato" of
            Rec."Stato"::Attivo:
                StatoIndicatorTxt := '🟩';
            Rec."Stato"::Dismesso:
                StatoIndicatorTxt := '🟥';
            else
                StatoIndicatorTxt := '■';
        end;
    end;
}