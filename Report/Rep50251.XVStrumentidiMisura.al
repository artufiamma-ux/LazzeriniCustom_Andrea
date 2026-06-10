namespace Xview.Custom.Lazzerini;

report 50251 "XV Strumenti di Misura"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Report Strumenti di Misura con Documenti';
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/StrumentiMisura.rdl';

    dataset
    {
        dataitem(Header; "XV IK Strumenti di Misura")
        {
            RequestFilterFields = "Entry No.", "Tipo Strumento", "Stato";

            column(Entry_No_; "Entry No.") { }
            column(Descrizione; Descrizione) { }
            column(Ubicazione; Ubicazione) { }

            // Qui dichiariamo le colonne passandogli le variabili globali
            column(Bollino; Bollino) { }
            column(Stato; Stato) { }

            dataitem(Line; "XV IK Strumenti di Misura Doc")
            {
                DataItemLink = "Strumento di misura Entry No." = FIELD("Entry No.");
                DataItemLinkReference = Header;

                column(Plant; Plant) { }
                column(Nome_Documento; "Nome Documento") { }
                column(Data_Ultimo_Intervento; "Data Ultimo Intervento") { }
                column(Note_Line; Note) { }
            }

        }
    }

    // Le variabili devono essere dichiarate qui, fuori dal dataset
}