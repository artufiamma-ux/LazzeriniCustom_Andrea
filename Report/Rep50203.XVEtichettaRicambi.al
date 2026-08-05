
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

            trigger OnPreDataItem()
            begin
                // Copia i valori dalla temp table nella dataitem
                ItemReference.Copy(TempItemReference, true);
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

    trigger OnPreReport()
    var
        i: Integer;
    begin
        // Numero di etichette da generare (puoi renderlo dinamico)
        if QtaEtichette = 0 then
            QtaEtichette := 5;

        // Popolo la tabella temporanea con X righe
        TempItemReference.DeleteAll();
        for i := 1 to QtaEtichette do begin
            TempItemReference.Init();
            TempItemReference."Reference No." := ItemNo;
            TempItemReference.Insert();
        end;

        CurrIndex := 1;
    end;

    var
        TempItemReference: Record "Item Reference" temporary;
        DestinationNos: List of [Code[20]];
        CurrIndex: Integer;
        CurrDestinationNo: Code[20];
        ReferenceTypeFilterValue: Code[20]; // Variabile per il parametro manuale
        QtaEtichette: Integer;
        ItemNo: Code[20];

    procedure SetTempTable(var TempRec: Record "Item Reference" temporary; DestList: List of [Code[20]]; ReferenceType: Code[20]; NumEtichette: Integer)
    begin
        // Imposta i parametri della stampa dal page
        QtaEtichette := NumEtichette;
        DestinationNos := DestList;
        CurrIndex := 1;
        ReferenceTypeFilterValue := ReferenceType;

        // Pulizia tabella temporanea e copia dei record
        TempItemReference.DeleteAll();
        TempRec.FindSet();
        repeat
            TempItemReference.Init();
            TempItemReference := TempRec;
            TempItemReference.Insert();
        until TempRec.Next() = 0;

        // Imposta il primo DestinationNo se presente
        if DestinationNos.Count() > 0 then
            DestinationNos.Get(1, CurrDestinationNo);

        // Imposta ItemNo per il ciclo OnPreReport se vuoi generare più etichette
        if TempItemReference.FindFirst() then
            ItemNo := TempItemReference."Reference No.";
    end;

    procedure SetInitParameter(ParamInit: Text)
    begin
        Error('Procedure SetInitParameter not implemented.');
    end;
}