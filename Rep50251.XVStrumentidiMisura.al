namespace Lazzerini;

report 50251 "XV Strumenti di Misura"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Report Strumenti di Misura con Documenti';
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/StrumentiMisura.rdl';

    dataset
    {
        dataitem(Header; "XV IK Strumenti di Misura")
        {
            RequestFilterFields = "Entry No.", "Tipo Strumento", "Stato";

            column(Entry_No_; "Entry No.") { }
            column(Descrizione; Descrizione) { }
            column(Ubicazione; Ubicazione) { }

            // Qui dichiariamo le colonne passandogli le variabili globali
            column(BollinoIndicator; BollinoIndicatorTxt) { }
            column(StatoIndicator; StatoIndicatorTxt) { }

            dataitem(Line; "XV IK Strumenti di Misura Doc")
            {
                DataItemLink = "Strumento di misura Entry No." = FIELD("Entry No.");
                DataItemLinkReference = Header;

                column(Plant; Plant) { }
                column(Nome_Documento; "Nome Documento") { }
                column(Data_Ultimo_Intervento; "Data Ultimo Intervento") { }
                column(Note_Line; Note) { }
            }

            trigger OnAfterGetRecord()
            begin
                // Svuota le variabili per ogni record per sicurezza
                BollinoIndicatorTxt := '';
                StatoIndicatorTxt := '';

                // Mappa Bollino
                case Header.Bollino of
                    Header.Bollino::Giallo:
                        BollinoIndicatorTxt := '🟨';
                    Header.Bollino::Verde:
                        BollinoIndicatorTxt := '🟩';
                    Header.Bollino::Blu:
                        BollinoIndicatorTxt := '🟦';
                    else
                        BollinoIndicatorTxt := '■';
                end;

                // Mappa Stato
                case Header.Stato of
                    Header.Stato::Attivo:
                        StatoIndicatorTxt := '🟩';
                    Header.Stato::Dismesso:
                        StatoIndicatorTxt := '🟥';
                    else
                        StatoIndicatorTxt := '■';
                end;
            end;
        }
    }

    // Le variabili devono essere dichiarate qui, fuori dal dataset
    var
        BollinoIndicatorTxt: Text[10];
        StatoIndicatorTxt: Text[10];
}