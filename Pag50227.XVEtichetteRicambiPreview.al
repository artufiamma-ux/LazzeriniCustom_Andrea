page 50227 "XV Etichette Ricambi Preview"
{
    PageType = List;
    ApplicationArea = All;
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
                field("Item No."; Rec."Reference No.")
                {
                    Caption = 'Codice Articolo';
                }

                field(Description; Rec.Description)
                {
                    Caption = 'Descrizione Articolo';
                }

                field(Quantity; Rec."Reference Type No.")
                {
                    Caption = 'Quantità da Spedire';
                }

                field("Destination No."; CurrDestinationNo)
                {
                    Caption = 'Destination No.';
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

                trigger OnAction()
                var
                    LabelReport: Report "XV Etichetta Ricambi";
                begin
                    LabelReport.SetTempTable(Rec, DestinationNos);
                    LabelReport.Run();
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        TotalLabels: Decimal;
        DestinationNos: List of [Code[20]];
        CurrIndex: Integer;
        CurrDestinationNo: Code[20];

    procedure SetTempTable(var TempRec: Record "Item Reference" temporary; DestList: List of [Code[20]]; Total: Decimal)
    begin
        TotalLabels := Total;
        DestinationNos := DestList;
        CurrIndex := 1;

        if TempRec.FindSet() then
            repeat
                Rec := TempRec;

                if CurrIndex <= DestinationNos.Count() then begin
                    DestinationNos.Get(CurrIndex, CurrDestinationNo);
                    CurrIndex += 1;
                end;

                Rec.Insert();
            until TempRec.Next() = 0;
    end;
}