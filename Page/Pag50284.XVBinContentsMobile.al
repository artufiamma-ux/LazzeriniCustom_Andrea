namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Item;
using Microsoft.Warehouse.Structure;

page 50284 "XV Bin Contents Mobile"
{
    ApplicationArea = All;
    Caption = 'XV Bin Contents Mobile';
    PageType = NavigatePage;
    // SourceTable = "Bin Content";
    editable = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            usercontrol(MobileList; "XV Zebra Bin List")
            {
                ApplicationArea = All;

                trigger ControlReady()
                var
                    Descr: Text[150];

                begin
                    if CurrentType = 'BIN' then begin
                        Descr := XVUtil.GetBinDescription(CurrentNo);
                    end;
                    if CurrentType = 'ITEM' then begin
                        Descr := XVUtil.GetItemDescription(CurrentNo);
                    end;
                    CurrPage.MobileList.AddCardContainer(Descr, CurrentType);
                    CurrPage.MobileList.ClearCards();

                    if TempWhseLineMob.FindSet() then
                        repeat
                            CurrPage.MobileList.AddCard(
                                TempWhseLineMob."Record No.",
                                TempWhseLineMob."No.",
                                TempWhseLineMob.Description,
                                TempWhseLineMob."Unit of Measure Code",
                                TempWhseLineMob.Qty
                            );
                        until TempWhseLineMob.Next() = 0;

                end;

            }
        }
    }
    var
        CurrentNo: Text;
        CurrentType: Text;
        TempWhseLineMob: Record "Whse. Line Mob" temporary;
        RecBinContent: Record "Bin Content";
        XVUtil: Codeunit XVUtil;


    local procedure CaricaRigheMobile()
    var
        RecNumber: Integer;
        Cod: Code[50];
        Descr: Text[100];
    begin
        RecNumber := 0;
        TempWhseLineMob.DeleteAll();
        if CurrentType = 'BIN' then begin
            RecBinContent.SetRange("Bin Code", CurrentNo);
        end;
        if CurrentType = 'ITEM' then begin
            RecBinContent.SetRange("Item No.", CurrentNo);
        end;
        //       RecBinContent.SetFilter("Quantity", '<>0');

        if RecBinContent.FindSet() then
            repeat
                if CurrentType = 'BIN' then begin
                    Cod := RecBinContent."Bin Code";
                    Descr := XVUtil.GetBinDescription(RecBinContent."Bin Code");
                end;
                if CurrentType = 'ITEM' then begin
                    Cod := RecBinContent."Item No.";
                    Descr := XVUtil.GetItemDescription(RecBinContent."Item No.");
                end;
                RecNumber += 1;
                TempWhseLineMob.Init();
                TempWhseLineMob."Record No." := RecNumber;
                TempWhseLineMob."No." := Cod;
                TempWhseLineMob.Description := Descr;
                TempWhseLineMob."Unit of Measure Code" := RecBinContent."Unit of Measure Code";
                TempWhseLineMob.Qty := RecBinContent.Quantity;
                TempWhseLineMob.Insert();
            until RecBinContent.Next() = 0;

    end;

    trigger OnOpenPage()

    begin
        CaricaRigheMobile();
    end;

    procedure SetInit(No: Text; Type: Text)
    begin
        CurrentNo := No;
        CurrentType := Type;
    end;


}
