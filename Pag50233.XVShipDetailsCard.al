page 50233 "XV Ship Details Card"
{
    ApplicationArea = All;
    Caption = 'XV Ship Details Card';
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
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        Rec."Modificato manualmente" := true;
    end;
}
