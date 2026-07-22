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
