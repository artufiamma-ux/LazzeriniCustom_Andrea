page 50227 "XV Etichette Ricambi Preview"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Anteprima Etichette Ricambi';
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Item Reference";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(Items)
            {
                Caption = 'Dettagli Articoli da Stampare';

                field("Item No."; Rec."Reference No.")
                {
                    Caption = 'Codice Articolo';
                    ApplicationArea = All;
                    Style = Standard;
                    Width = 15;
                }

                field(Description; Rec.Description)
                {
                    Caption = 'Descrizione Articolo';
                    ApplicationArea = All;
                    Style = Standard;
                    Width = 30;
                }

                field(Quantity; Rec."Reference Type No.")
                {
                    Caption = 'Quantità da Spedire';
                    ApplicationArea = All;
                    Style = StandardAccent;
                    Width = 10;
                }

                field(Labels; Rec."Reference Type No.")
                {
                    Caption = 'N° Etichette';
                    ApplicationArea = All;
                    Style = Attention;
                    Width = 10;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Print)
            {
                Caption = 'Conferma e Stampa';
                Image = Print;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    LabelReport: Report "XV Etichetta Ricambi";
                begin
                    // Passa i dati della pagina al report

                    LabelReport.Run();

                    CurrPage.Close();
                end;
            }
        }
    }

    var
        TotalLabels: Decimal;

    procedure SetTempTable(var TempRec: Record "Item Reference" temporary; Total: Decimal)
    begin
        TotalLabels := Total;

        if TempRec.FindSet() then begin
            repeat
                Rec := TempRec;
                Rec.Insert();
            until TempRec.Next() = 0;
        end;
    end;
}