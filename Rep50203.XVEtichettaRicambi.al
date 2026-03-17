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
            var
                i: Integer;
            begin
                // Converti ReferenceTypeFilterValue in intero
                if not Evaluate(ReferenceTypeFilterValueInt, ReferenceTypeFilterValue) then
                    ReferenceTypeFilterValueInt := 1;

                // Ripeti record tante volte quanto indica ReferenceTypeFilterValueInt
                for i := 2 to ReferenceTypeFilterValueInt do begin
                    CurrIndex := 1;
                    if CurrIndex <= DestinationNos.Count() then
                        DestinationNos.Get(CurrIndex, CurrDestinationNo);
                    CurrIndex += 1;

                    // Inserisci un record temporaneo duplicato
                    TempItemReference.Insert();
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(General)
                {
                    field(ItemNoFilter; TempItemReference."Reference No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Numero Ricambio';
                    }

                    field(DestinationListParam; CurrDestinationNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Elenco Destinazioni';
                        Editable = false;
                    }

                    field(ReferenceTypeFilter; ReferenceTypeFilterValue)
                    {
                        ApplicationArea = All;
                        Caption = 'Quantità Etichette';
                        Editable = true;
                    }
                }
            }
        }
    }

    var
        TempItemReference: Record "Item Reference" temporary;
        DestinationNos: List of [Code[20]];
        CurrIndex: Integer;
        CurrDestinationNo: Code[20];
        ReferenceTypeFilterValue: Code[20];
        ReferenceTypeFilterValueInt: Integer;

    procedure SetTempTable(var TempRec: Record "Item Reference" temporary; DestList: List of [Code[20]]; ReferenceType: Code[20])
    begin
        TempItemReference.Copy(TempRec, true);
        DestinationNos := DestList;
        CurrIndex := 1;

        // Imposta ReferenceTypeFilterValue
        ReferenceTypeFilterValue := ReferenceType;

        // Primo valore della lista destinazioni
        if DestinationNos.Count() > 0 then
            DestinationNos.Get(1, CurrDestinationNo);
    end;
}