report 50203 "XV Etichetta Ricambi"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/XVEtichettaRicambi.rdl';
    ApplicationArea = All;
    UseRequestPage = false;

    dataset
    {
        dataitem(LabelData; "Item Reference")
        {
            UseTemporary = true;

            column(ItemNo; LabelData."Reference No.") { }
            column(ItemReference; LabelData.Description) { }
            column(Quantity; LabelData."Reference Type No.") { }

            trigger OnPreDataItem()
            var
                QtyToPrint: Decimal;
                i: Integer;
                SourceRec: Record "Item Reference" temporary;
            begin
                // Copia i record dalla tabella temporanea globale
                LabelData.Copy(TempGlobalLabels, true);

                // Copia per iterare senza modificare l'originale
                SourceRec.Copy(TempGlobalLabels, true);

                // Espandi in base alla quantità
                if SourceRec.FindSet() then begin
                    repeat
                        // convert string quantity to decimal, se fallisce QtyToPrint resta 0
                        if NOT EVALUATE(QtyToPrint, SourceRec."Reference Type No.") then
                            QtyToPrint := 0;

                        for i := 1 to QtyToPrint do begin
                            TempLabels.Init();
                            TempLabels."Reference Type" := GlobalCounter;
                            TempLabels."Reference No." := SourceRec."Reference No.";
                            TempLabels."Reference Type No." := Format(QtyToPrint);
                            TempLabels.Description := SourceRec.Description;
                            TempLabels.Insert();
                            GlobalCounter += 1;
                        end;
                    until SourceRec.Next() = 0;
                end;

                // Copia finale in LabelData per il dataset
                LabelData.Copy(TempLabels, true);
            end;
        }
    }

    var
        TempLabels: Record "Item Reference" temporary;
        TempGlobalLabels: Record "Item Reference" temporary;
        GlobalCounter: Integer;

    procedure SetLabelData(var SourceData: Record "Item Reference" temporary)
    begin
        TempGlobalLabels.Copy(SourceData, true);
    end;
}