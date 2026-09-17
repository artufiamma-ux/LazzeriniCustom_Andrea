namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Document;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
using System.Text;

report 50247 "XV Etich. Ricambi Packing List"
{
    Caption = 'Etichetta Ricambi Packing List';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/XVEtichettaRicambiPackingList.rdl';

    dataset
    {
        dataitem(WhseShpt; "Warehouse Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            dataitem(Line; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("Line No.")
                                    order(Ascending);

                column(ItemNo; ItemNo) { }
                column(ItemBarcode; ItemEncodedText) { }
                column(DescriptionIT; DescriptionIT) { }
                column(DescriptionEN; DescriptionEN) { }

                dataitem(Assignm; "EOS055 Handling Unit Assignm.")
                {
                    DataItemLink = "Source No." = field("Source No."),
                                   "Source Line No." = field("Line No.");
                    DataItemTableView = sorting("Entry No.")
                                        order(Ascending);

                    column(BoxNo; BoxNo) { }
                    column(BoxBarcode; BoxEncodedText) { }
                    column(Quantity; Quantity) { }

                    trigger OnAfterGetRecord()
                    var
                        BoxBarcodeString: Text;
                        BarcodeSymbology: Enum "Barcode Symbology";
                        BarcodeFontProvider: Interface System.Text."Barcode Font Provider";
                    begin
                        Clear(BoxEncodedText);
                        Clear(Quantity);

                        Quantity := "Quantity (Base)";
                        if Quantity = 0 then
                            CurrReport.Skip();

                        BoxNo := "Handling Unit No.";
                        BoxBarcodeString := NormalizeCode39Text(BoxNo);
                        if BoxBarcodeString <> '' then begin
                            BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                            BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
                            BarcodeFontProvider.ValidateInput(BoxBarcodeString, BarcodeSymbology);
                            BoxEncodedText := BarcodeFontProvider.EncodeFont(BoxBarcodeString, BarcodeSymbology);
                        end;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    if NrSerieFilter <> '' then
                        SetFilter("Progressivo Serie Spedizione", NrSerieFilter);
                end;

                trigger OnAfterGetRecord()
                var
                    CheckAssignm: Record "EOS055 Handling Unit Assignm.";
                    Item: Record Item;
                    ItemTranslation: Record "Item Translation";
                    ItemBarcodeString: Text;
                    BarcodeSymbology: Enum "Barcode Symbology";
                    BarcodeFontProvider: Interface System.Text."Barcode Font Provider";
                begin
                    CheckAssignm.Reset();
                    CheckAssignm.SetRange("Source No.", "Source No.");
                    CheckAssignm.SetRange("Source Line No.", "Line No.");
                    CheckAssignm.SetFilter("Quantity (Base)", '>0');

                    if not CheckAssignm.FindFirst() then
                        CurrReport.Skip();

                    ItemNo := "Item No.";
                    DescriptionIT := Description;
                    if DescriptionIT = '' then begin
                        if Item.Get("Item No.") then
                            DescriptionIT := Item.Description;
                    end;
                    DescriptionEN := GetEnglishItemTranslationDescription(ItemNo, ItemTranslation);
                    if DescriptionEN = '' then
                        DescriptionEN := DescriptionIT;

                    Clear(ItemEncodedText);

                    ItemBarcodeString := NormalizeCode39Text(ItemNo);
                    if ItemBarcodeString <> '' then begin
                        BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                        BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
                        BarcodeFontProvider.ValidateInput(ItemBarcodeString, BarcodeSymbology);
                        ItemEncodedText := BarcodeFontProvider.EncodeFont(ItemBarcodeString, BarcodeSymbology);
                    end;
                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange("No.", WarehouseShipmentNo);
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

                    field(NrSerieFilter; NrSerieFilter)
                    {
                        Caption = 'Nr Serie';
                        ApplicationArea = All;
                        ToolTip = 'Inserire uno o più numeri (es: 1 | 1|3 | 1..5). Lasciare vuoto per tutti.';
                    }
                    field(NrScatolaFilter; NrScatolaFilter)
                    {
                        Caption = 'Nr Scatola';
                        ApplicationArea = All;
                        ToolTip = 'Inserire uno o più numeri (es: 1 | 1|3 | 1..5). Lasciare vuoto per tutti.';
                    }
                }
            }
        }
    }

    var
        WarehouseShipmentNo: Code[20];
        NrScatolaFilter: Text;
        NrSerieFilter: Text;
        ItemNo: Code[20];
        DescriptionIT: Text[100];
        DescriptionEN: Text[100];
        Quantity: Decimal;
        ItemEncodedText: Text;
        BoxEncodedText: Text;
        BoxNo: Code[20];

    procedure SetWarehouseShipmentNo(No: Code[20])
    begin
        WarehouseShipmentNo := No;
    end;

    procedure SetInitParameter(ParamInit: Text)
    begin
        SetWarehouseShipmentNo(CopyStr(ParamInit, 1, MaxStrLen(WarehouseShipmentNo)));
    end;

    local procedure NormalizeCode39Text(InputText: Text): Text
    var
        AllowedCharacters: Text;
        ResultText: Text;
        CurrentChar: Text[1];
        Index: Integer;
    begin
        AllowedCharacters := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-.$ /+%';
        InputText := UpperCase(InputText);

        for Index := 1 to StrLen(InputText) do begin
            CurrentChar := CopyStr(InputText, Index, 1);
            if StrPos(AllowedCharacters, CurrentChar) > 0 then
                ResultText += CurrentChar;
        end;

        exit(ResultText);
    end;

    local procedure GetEnglishItemTranslationDescription(ItemNo: Code[20]; var ItemTranslation: Record "Item Translation"): Text[100]
    begin
        if TryGetItemTranslationDescription(ItemNo, 'ENG', ItemTranslation) then
            exit(ItemTranslation.Description);

        if TryGetItemTranslationDescription(ItemNo, 'ENU', ItemTranslation) then
            exit(ItemTranslation.Description);

        if TryGetItemTranslationDescription(ItemNo, 'ING', ItemTranslation) then
            exit(ItemTranslation.Description);

        exit('');
    end;

    local procedure TryGetItemTranslationDescription(ItemNo: Code[20]; LanguageCode: Code[10]; var ItemTranslation: Record "Item Translation"): Boolean
    begin
        ItemTranslation.Reset();
        ItemTranslation.SetRange("Item No.", ItemNo);
        ItemTranslation.SetRange("Language Code", LanguageCode);
        ItemTranslation.SetRange("Variant Code", '');

        if ItemTranslation.FindFirst() then
            if ItemTranslation.Description <> '' then
                exit(true);

        exit(false);
    end;
}
