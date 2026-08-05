namespace Custom.Custom;

using Microsoft.Inventory.Item;

report 50281 "XV Etichetta Mob"
{
    Caption = 'XV Etichetta Articolo Mobile';
    RDLCLayout = './ReportLayouts/XVEtichettaMob.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Description2; "Description 2")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        CurrentNo: Code[20];

    procedure SetParameters(ItemNo: Code[20])
    begin
        CurrentNo := ItemNo;
    end;

    procedure SetInitParameter(ParamInit: Text)
    var
        CodeValue: Code[20];
    begin
        CodeValue := CopyStr(ParamInit, 1, MaxStrLen(CodeValue));
        SetParameters(CodeValue);
    end;

    trigger OnPreReport()
    begin
        if Item.Get(CurrentNo) then;
    end;
}
