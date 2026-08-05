namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Item.Catalog;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Customer;
report 50204 "XV Etichette Ricambi Cliente"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Stampa Etichette Articolo';
    RDLCLayout = './ReportLayouts/XVEtichetteRicambiCliente.rdl';

    dataset
    {
        dataitem(LabelBuffer; "XV Label Buffer")
        {
            UseTemporary = true;
            DataItemTableView = sorting("Entry No.");

            column(ItemNo; "Item No.") { }
            column(CustomerNo; "Customer No.") { }
            column(ItemReference; "Item Reference") { }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Parameters)
                {
                    field(ItemNo; ItemNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Codice Articolo';
                        TableRelation = Item;
                    }
                    field(CustomerNo; CustomerNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Cliente';
                        TableRelation = Customer;
                    }
                    field(QtaEtichette; QtaEtichette)
                    {
                        ApplicationArea = All;
                        Caption = 'Quantità Etichette';
                    }
                }
            }
        }
    }

    var
        ItemNo: Code[20];
        CustomerNo: Code[20];
        QtaEtichette: Integer;
        ItemRef: Record "Item Reference";
        ItemReference: Code[50];

    trigger OnPreReport()
    var
        TempBuffer: Record "XV Label Buffer" temporary;
        i: Integer;
    begin
        // Recupera item reference
        ItemRef.Reset();
        ItemRef.SetRange("Item No.", ItemNo);
        ItemRef.SetRange("Reference Type", ItemRef."Reference Type"::Customer);
        ItemRef.SetRange("Reference Type No.", CustomerNo);

        if ItemRef.FindFirst() then
            ItemReference := ItemRef."Reference No."
        else
            ItemReference := '';
        // Popolazione temporanea
        for i := 1 to QtaEtichette do begin
            TempBuffer.Init();
            TempBuffer."Entry No." := i;
            TempBuffer."Item No." := ItemNo;
            TempBuffer."Customer No." := CustomerNo;
            TempBuffer."Item Reference" := ItemReference;
            TempBuffer.Insert();
        end;

        // Copio la temporanea dentro il dataset del report
        LabelBuffer.Copy(TempBuffer, true);
    end;

    procedure SetParameters(ItemNoP: Code[20]; CustomerNoP: Code[20])
    begin
        ItemNo := ItemNoP;
        CustomerNo := CustomerNoP;
    end;

    procedure SetInitParameter(ParamInit: Text)
    var
        CodeValue: Code[20];
        CustomerValue: Code[20];
        Parts: List of [Text];
    begin
        Parts := ParamInit.Split('|');
        CodeValue := CopyStr(Parts.Get(1), 1, MaxStrLen(CodeValue));
        CustomerValue := CopyStr(Parts.Get(2), 1, MaxStrLen(CodeValue));
        SetParameters(CodeValue, CustomerValue);
    end;

}