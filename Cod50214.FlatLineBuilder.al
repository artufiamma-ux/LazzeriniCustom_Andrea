namespace Lazzerini;
using Microsoft.Sales.History;
codeunit 50214 "Flat Line Builder"
{
    SingleInstance = false;

    procedure BuildFromSalesInvoice(InvoiceNo: Code[20]; var Flat: Record "Report Flat Line" temporary)
    var
        SIL: Record "Sales Invoice Line";
        Agg: Record "Kit Bus Aggregate" temporary;
        i: Integer;
    begin
        Flat.DeleteAll();
        Agg.DeleteAll();

        SIL.SetRange("Document No.", InvoiceNo);

        if SIL.FindSet() then
            repeat
                // --------- RIGHE KIT ---------------
                if SIL."Kit Bus" <> '' then begin
                    if Agg.Get(SIL."Order No.", SIL."Kit Bus") then begin
                        Agg."Sum Amount" := Agg."Sum Amount" + (SIL."Unit Price" * SIL.Quantity);
                        Agg."Count Progressivo" += 1;
                        Agg.Modify();
                    end else begin
                        Agg.Init();
                        Agg."Order No." := SIL."Order No.";
                        Agg."Kit Bus" := SIL."Kit Bus";
                        Agg."Sum Amount" := (SIL."Unit Price" * SIL.Quantity);
                        Agg."Count Progressivo" := 1;
                        Agg."VAT" := SIL."VAT Identifier";
                        Agg."Description" := 'Kit ' + SIL."Kit Bus";
                        Agg.Insert();
                    end;
                end else begin
                    // --------- RIGHE NON KIT -----------
                    i += 10000;
                    Flat.Init();
                    Flat."Line No." := i;
                    Flat."Document No" := InvoiceNo;
                    Flat."Table Line" := 'Sales Invoice Line';

                    Flat."Int Code" := SIL."No.";
                    Flat."Ext Code" := SIL."Item Reference No.";
                    Flat.Description := SIL.Description;
                    Flat."UoM" := SIL."Unit of Measure Code";
                    Flat.Qty := SIL.Quantity;
                    Flat."Unit Price" := SIL."Unit Price";
                    Flat.Amount := SIL.Amount;
                    Flat.VAT := SIL."VAT Identifier";

                    Flat.Insert();
                end;

            until SIL.Next() = 0;

        // -------- INSERIMENTO RIGHE KIT ----------
        if Agg.FindSet() then
            repeat
                i += 10000;

                Flat.Init();
                Flat."Line No." := i;
                Flat."Document No" := InvoiceNo;
                Flat."Table Line" := 'Sales Invoice Line';

                Flat."Int Code" := Agg."Kit Bus";
                Flat.Description := Agg.Description;
                Flat.Qty := Agg."Count Progressivo";

                if Agg."Count Progressivo" > 0 then
                    Flat."Unit Price" := Agg."Sum Amount" / Agg."Count Progressivo"
                else
                    Flat."Unit Price" := 0;

                Flat.Amount := Agg."Sum Amount";
                Flat.VAT := Agg."VAT";

                Flat.Insert();

            until Agg.Next() = 0;
    end;
}
