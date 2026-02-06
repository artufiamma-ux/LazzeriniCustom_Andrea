namespace Lazzerini;

page 50253 "XV IK Strumenti Doc List"
{
    PageType = ListPart;
    SourceTable = "XV IK Strumenti di Misura Doc";
    Caption = 'Documenti Strumento di Misura';
    ApplicationArea = All;

    // 👉 sola lettura
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
                field("Data Ultimo Intervento"; Rec."Data Ultimo Intervento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Data dell’ultimo intervento eseguito per questo documento.';
                }
                field("Tipo Documento"; Rec."Tipo Documento")
                {
                    ApplicationArea = All;
                }
                field("Nome Documento"; Rec."Nome Documento")
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
        // Nessuna azione di inserimento qui (solo lettura).
        // L'utente userà i comandi nella Card padre per creare/modificare.
    }

    trigger OnOpenPage()
    begin
        // Ordina per data (desc) e, a parità di data, per Documento Entry No. (desc)
        Rec.SetCurrentKey("Data Ultimo Intervento", "Documento Entry No.");
        Rec.SetAscending("Data Ultimo Intervento", false);
        Rec.SetAscending("Documento Entry No.", false);
    end;
}
