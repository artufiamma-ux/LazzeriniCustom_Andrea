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
                field("Item No."; Rec."Reference No.") { Caption = 'Codice Articolo'; }
                field(Description; Rec.Description) { Caption = 'Descrizione Articolo'; }
                field(Quantity; Rec."Reference Type No.") { Caption = 'Quantità da Spedire'; }
                field("Destination No."; CurrDestinationNo) { Caption = 'Destination No.'; }
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
                    TempRec: Record "Item Reference" temporary;
                    CurrDestinationIndex: Integer;
                    i: Integer;
                    KeyList: List of [Text[50]]; // Lista per evitare duplicati
                    KeyValue: Text[50];
                begin
                    if Rec.Count() = 0 then begin
                        Message('Nessun record da stampare.');
                        exit;
                    end;

                    if DestinationNos.Count() = 0 then begin
                        Message('Inserire almeno una destinazione.');
                        exit;
                    end;

                    TempRec.DeleteAll();
                    CurrDestinationIndex := 1;

                    if Rec.FindSet() then
                        repeat
                            for i := 1 to Copies do begin
                                // Genera chiave univoca per evitare duplicati
                                KeyValue := Rec."Reference No." + '|' + Format(Rec."Reference Type No.") + '|' + Format(CurrDestinationIndex);
                                if not KeyList.Contains(KeyValue) then begin
                                    KeyList.Add(KeyValue);

                                    TempRec.Init();
                                    TempRec."Reference No." := Rec."Reference No.";
                                    TempRec.Description := Rec.Description;
                                    TempRec."Reference Type No." := Rec."Reference Type No.";

                                    if CurrDestinationIndex <= DestinationNos.Count() then
                                        DestinationNos.Get(CurrDestinationIndex, CurrDestinationNo);

                                    CurrDestinationIndex += 1;
                                    if CurrDestinationIndex > DestinationNos.Count() then
                                        CurrDestinationIndex := 1;

                                    TempRec.Insert();
                                end;
                            end;
                        until Rec.Next() = 0;

                    LabelReport.SetTempTable(TempRec, DestinationNos, Format(Copies));
                    LabelReport.Run();
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        DestinationNos: List of [Code[20]];
        CurrDestinationNo: Code[20];
        Copies: Integer;

    procedure SetTempTable(var TempRec: Record "Item Reference" temporary; DestList: List of [Code[20]]; NumberOfCopies: Integer)
    var
        CurrIndex, i : Integer;
    begin
        DestinationNos := DestList;
        Copies := NumberOfCopies; // Ora NumberOfCopies è Integer, coerente con Copies

        Rec.DeleteAll();
        CurrIndex := 1;

        if TempRec.FindSet() then
            repeat
                for i := 1 to Copies do begin
                    Rec.Init();
                    Rec."Reference No." := TempRec."Reference No.";
                    Rec.Description := TempRec.Description;
                    Rec."Reference Type No." := TempRec."Reference Type No.";

                    if CurrIndex <= DestinationNos.Count() then
                        DestinationNos.Get(CurrIndex, CurrDestinationNo);

                    CurrIndex += 1;
                    if CurrIndex > DestinationNos.Count() then
                        CurrIndex := 1;

                    Rec.Insert();
                end;
            until TempRec.Next() = 0;
    end;
}