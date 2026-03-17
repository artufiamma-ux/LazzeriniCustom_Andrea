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
                // Aggiorniamo CurrDestinationNo con la lista Destinazioni
                if CurrIndex <= DestinationNos.Count() then begin
                    DestinationNos.Get(CurrIndex, CurrDestinationNo);
                    CurrIndex += 1;
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
                        Editable = false; // Solo visualizzazione
                    }

                    field(ReferenceTypeFilter; ReferenceTypeFilterValue)
                    {
                        ApplicationArea = All;
                        Caption = 'Tipo di Ricambio';
                        Editable = true; // Puoi scrivere manualmente il valore
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
        ReferenceTypeFilterValue: Code[20]; // Variabile per il parametro manuale

    procedure SetTempTable(var TempRec: Record "Item Reference" temporary; DestList: List of [Code[20]]; ReferenceType: Code[20])
    begin
        // Copia i record temporanei
        TempItemReference.Copy(TempRec, true);
        DestinationNos := DestList;
        CurrIndex := 1;

        // Imposta il parametro manuale
        ReferenceTypeFilterValue := '';

        // Imposta il primo valore della lista destinazioni
        if DestinationNos.Count() > 0 then
            DestinationNos.Get(1, CurrDestinationNo);
    end;
}