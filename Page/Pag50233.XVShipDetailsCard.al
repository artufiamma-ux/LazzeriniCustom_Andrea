namespace Xview.Custom.Lazzerini;
page 50233 "XV Ship Details Card"
{
    ApplicationArea = All;
    Caption = 'Modifica Dettagli - Colli e Pesi';
    PageType = StandardDialog;
    SourceTable = "XV Posted Invoice Ship Info";

    layout
    {
        area(Content)
        {


            group(Info)
            {
                ShowCaption = false;

                field(InfoText; 'Assegnando 0 (ZERO) al campo ''Nr. Colli'' i valori verranno ripresi dalla paccking list.')
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = StandardAccent;
                    ShowCaption = false;
                }
            }

            group(General)
            {
                Caption = 'General';

                field("Invoice No."; Rec."Invoice No.")
                {
                    Enabled = false;
                }
                field("Nr. Colli"; Rec."Nr. Colli") { }
                field("Peso Netto"; Rec."Peso Netto") { }
                field("Peso Lordo"; Rec."Peso Lordo") { }
                field("Aspetto Beni"; Rec."Aspetto Beni") { }
                field("Ora di partenza"; Rec."Ora di partenza") { }
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        Rec."Modificato manualmente" := true;
    end;

    trigger OnOpenPage()
    var
        Prefisso: Text;
    begin
        Prefisso := Rec."Invoice No.";
        if Evaluate(Prefisso, 'FVPF', 4) then;
        //Message('PROFORMA');
    end;
}
