namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Document;
using System.Text;
using Custom.Custom;

report 50237 "XV Colli Carico"
{
    ApplicationArea = All;
    Caption = 'Etichetta Colli Carico';
    UsageCategory = Documents;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/XVEtichettaColliCarico.rdl';
    dataset
    {
        dataitem(Colli; "XV Colli Carico Buffer")
        {
            DataItemTableView = sorting("Handling Unit No.");
            UseTemporary = true;
            column(HandlingUnitNo; "Handling Unit No.")
            {
                Caption = 'Handling Unit No.';
            }
            column(ItemNo; "Item No.")
            {
                Caption = 'Item No.';
            }
            column(Description; Description)
            {
                Caption = 'Description';
            }
            column(Quantity; Quantity)
            {
                Caption = 'Quantity';
            }
            column(BinCode; "Bin Code")
            {
                Caption = 'Bin Code';
            }
            column(Receipt_Date; Format("Receipt Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
                Caption = 'Receipt Date';
            }
            column(ItemBarcode; ItemEncodedText)
            {
            }
            column(BoxBarcode; BoxEncodedText)
            {
            }
            trigger OnPreDataItem()
            begin

                if CodScatolaFilter <> '' then
                    SetRange("Handling Unit No.", CodScatolaFilter);

            end;

            trigger OnAfterGetRecord()
            var
                ItemBarcodeString: Text;
                BoxBarcodeString: Text;
                BarcodeSymbology: Enum System.Text."Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";

            begin
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::System.Text."Barcode Symbology"::"Code39";
                ItemBarcodeString := "Item No.";
                BoxBarcodeString := "Handling Unit No.";

                // Item Bar Code
                BarcodeFontProvider.ValidateInput(ItemBarcodeString, BarcodeSymbology);
                ItemEncodedText := BarcodeFontProvider.EncodeFont(ItemBarcodeString, BarcodeSymbology);
                // Box Bar Code
                BarcodeFontProvider.ValidateInput(BoxBarcodeString, BarcodeSymbology);
                BoxEncodedText := BarcodeFontProvider.EncodeFont(BoxBarcodeString, BarcodeSymbology);
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Opzioni)
                {
                    Caption = 'Opzioni';

                    field(CodScatolaFilter; CodScatolaFilter)
                    {
                        Caption = 'Codice Scatola';
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            TempBoxes: Record "XV Generic Code Lookup" temporary;
                            BoxList: List of [Code[20]];
                            BoxCode: Code[20];
                            LookupPage: Page "XV Generic Code Lookup";
                        begin
                            BoxList := ParameterList();

                            foreach BoxCode in BoxList do begin
                                TempBoxes.Init();
                                TempBoxes."Value" := BoxCode;
                                TempBoxes.Insert();
                            end;

                            if Page.RunModal(Page::"XV Generic Code Lookup", TempBoxes) = Action::LookupOK then begin
                                //Message('Valore=%1', TempBoxes.Value);
                                Text := TempBoxes.Value;
                                exit(true);
                            end;

                            exit(false);
                        end;

                    }
                }
            }
        }
    }

    procedure SetParameters(DocumentNo: Code[20])
    begin
        WCPNo := DocumentNo;
    end;

    local procedure ParameterList(): List of [Code[20]]
    var
        // TempBuffer: Record "XV Colli Carico Buffer" temporary;
        RecAssignment: Record "EOS055 Handling Unit Assignm.";
        BoxList: List of [Code[20]];
    begin
        RecAssignment.SetRange("Source No.", WCPNo);
        if RecAssignment.FindSet() then begin // Tutte le scatole associate al documento
            repeat
                if not BoxList.Contains(RecAssignment."Handling Unit No.") then
                    BoxList.Add(RecAssignment."Handling Unit No.");
            until RecAssignment.Next() = 0;
        end;
        exit(BoxList);
    end;

    var
        ItemEncodedText: Text;
        BoxEncodedText: Text;
        WCPNo: Code[20];
        CodScatolaFilter: Code[20];


    trigger OnPreReport()
    var
        // TempBuffer: Record "XV Colli Carico Buffer" temporary;
        RecAssignment: Record "EOS055 Handling Unit Assignm.";
        RecItem: Record Microsoft.Inventory.Item.Item;
        RecWarehouseReceipt: Record "Warehouse Receipt Header";
        RecWarehouseReceiptLine: Record "Warehouse Receipt Line";
        XVUtils: Codeunit "XVUtil";
        BoxList: List of [Code[20]];
        BoxNo: Code[20];
        HUFilter: Text;
        i: Integer;
    begin
        if CodScatolaFilter = '' then begin
            // Popoliamo la lista dei box univoci
            RecAssignment.SetRange("Source No.", WCPNo);
            if RecAssignment.FindSet() then begin // Tutte le scatole associate al documento
                repeat
                    if not BoxList.Contains(RecAssignment."Handling Unit No.") then
                        BoxList.Add(RecAssignment."Handling Unit No.");
                until RecAssignment.Next() = 0;
            end;
        end
        else
            BoxList.Add(CodScatolaFilter);
        for i := 1 to BoxList.Count() do begin // Preparo il filtro
            BoxNo := BoxList.Get(i);
            if HUFilter <> '' then
                HUFilter += '|';
            HUFilter += BoxNo;
        end;
        RecAssignment.Reset();
        RecAssignment.SetFilter("Handling Unit No.", HUFilter);
        RecAssignment.SetFilter("Quantity (Base)", '>0');

        if RecAssignment.FindSet() then begin // Tutti i record associati alle scatole
            repeat
                Colli.Init();
                Colli."Handling Unit No." := RecAssignment."Handling Unit No.";
                Colli."Item No." := RecAssignment."Item No.";
                if RecItem.Get(RecAssignment."Item No.") then
                    Colli.Description := RecItem.Description
                else
                    Colli.Description := '';

                Colli.Quantity := RecAssignment."Quantity (Base)";
                if RecWarehouseReceipt.Get(WCPNo) then
                    Colli."Receipt Date" := RecWarehouseReceipt."Posting Date";
                RecWarehouseReceiptLine.SetRange("No.", WCPNo);
                RecWarehouseReceiptLine.SetRange("Item No.", RecAssignment."Item No.");
                if RecWarehouseReceiptLine.FindFirst() then
                    Colli."Bin Code" := RecWarehouseReceiptLine."Bin Code"
                else
                    Colli."Bin Code" := '';
                Colli.Insert();
            until RecAssignment.Next() = 0;
        end;
        //Colli.Copy(TempBuffer);


    end;

}
