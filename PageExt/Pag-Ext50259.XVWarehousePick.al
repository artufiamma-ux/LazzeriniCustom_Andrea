namespace Custom.Custom;

using Microsoft.Warehouse.Activity;

pageextension 50259 "XV Warehouse Pick" extends "Whse. Pick Subform" // page 7320, table 7310
{
    layout
    {
        addafter("Whse. Document No.")
        {
            field("XV EOS Handling Unit No."; Rec."EOS055 Handling Unit No.")
            {
                ApplicationArea = All;
                ToolTip = 'Numero di Scatola.';
            }
        }
    }
}
