namespace Xview.Custom.Lazzerini;

using Microsoft.Purchases.Document;

pageextension 50243 "XV Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        // Inserisce le colonne subito dopo "No." nel repeater principale
        addafter("Description")
        {

            field("Drawing No."; Rec."Drawing No.")
            {
                ApplicationArea = All;
                ToolTip = 'Drawing No.';
            }
            field("Drawing Revision Id"; Rec."Drawing Revision Id")
            {
                ApplicationArea = All;
                ToolTip = 'Drawing Revision Id';
                Visible = false; // Nasconde il campo "Drawing Revision Id" dalla visualizzazione
            }
            field("Drawing Revision"; Rec."Drawing Revision")
            {
                ApplicationArea = All;
                ToolTip = 'Drawing Revision';
            }
        }
    }
}