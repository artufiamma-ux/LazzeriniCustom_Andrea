report 50230 "XV Etichetta Ricambi"
{
    Caption = 'Etichette Ricambi';
    UsageCategory = None;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/XVEtichettaRicambi.rdl';

    dataset
    {
        dataitem(ItemReference; "Item Reference")
        {
            UseTemporary = true;

            column(ItemNo; "Reference No.") { }

            column(Quantity; "Reference Type No.") { }

            column(ReferenceNo; CurrDestinationNo) { }

            trigger OnAfterGetRecord()
            begin
                if CurrIndex <= DestinationNos.Count() then begin
                    DestinationNos.Get(CurrIndex, CurrDestinationNo);
                    CurrIndex += 1;
                end;
            end;
        }
    }

    var
        TempItemReference: Record "Item Reference" temporary;
        DestinationNos: List of [Code[20]];
        CurrIndex: Integer;
        CurrDestinationNo: Code[20];

    procedure SetTempTable(var TempRec: Record "Item Reference" temporary; DestList: List of [Code[20]])
    begin
        DestinationNos := DestList;
        CurrIndex := 1;

        if TempRec.FindSet() then
            repeat
                TempItemReference := TempRec;
                TempItemReference.Insert();
            until TempRec.Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if TempItemReference.FindSet() then
            repeat
                ItemReference := TempItemReference;
                ItemReference.Insert();
            until TempItemReference.Next() = 0;
    end;
}