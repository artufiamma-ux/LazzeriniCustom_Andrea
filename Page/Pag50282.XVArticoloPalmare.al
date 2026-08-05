namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Item;
using Microsoft.Warehouse.Structure;

page 50282 "XV Articolo Palmare Mob"
{
    PageType = Card;
    Caption = 'MAGAZZINO';


    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; RecNo)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Type"; RecType)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
            }
            usercontrol(Articolo; "XV Zebra Articolo")
            {
                ApplicationArea = All;

                trigger ActionSelected(ActionName: Text; Barcode: Text)
                begin
                    case ActionName of

                        'CERCA':
                            begin
                                Cerca();
                            end;

                        'STAMPA':
                            Message('Stampa %1', Barcode);

                    //'SPOSTA':                            Message('Sposta articolo %1', Barcode);
                    end;
                end;

                trigger BarcodeScanned(Barcode: Text)
                begin
                    CaricaArticolo(Barcode);
                end;
            }
        }
    }

    local procedure CaricaArticolo(Barcode: Text)
    begin
        CercaArticolo(Barcode);
    end;

    local procedure CercaArticolo(Barcode: Text)
    var
        Item: Record Item;
        Bin: Record Bin;
        Vuoto: Text;
    begin
        RecType := 'NULL';
        if Item.Get(Barcode) then begin
            RecType := 'ITEM';
            RecNo := Format(Item."No.");
            CurrPage.Articolo.SetItemData(
                Item."No.",
                Item.Description,
                Item."Description 2",
                'ARTICOLO',
                RecType
                );

        end
        else begin
            Bin.SetRange("Code", Barcode);
            if Bin.FindFirst() then begin
                Vuoto := 'NON VUOTO';
                RecType := 'BIN';
                RecNo := Bin.Code;
                if Bin.Empty then
                    Vuoto := 'VUOTO';
                CurrPage.Articolo.SetItemData(
                    Bin."Code",
                    Bin.Description,
                    Vuoto,
                    Bin."Location Code",
                    RecType
                    );
            end
        end;

    end;

    local procedure Cerca()
    var
        pag: Page "XV Bin Contents Mobile";
    begin
        pag.SetInit(RecNo, RecType);
        pag.RunModal();
    end;

    var
        RecType: Text[4];

    var
        RecNo: Text[20];
}