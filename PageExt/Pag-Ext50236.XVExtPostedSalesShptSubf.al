namespace Xview.Custom.Lazzerini;

using Microsoft.Sales.History;

pageextension 50236 "XV Ext Posted Sales Shpt. Subf" extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter("Description")
        {
            field("xv Kit Bus"; Rec."xv Kit Bus")
            {
                ApplicationArea = All;
                Caption = 'Kit Bus';
            }
            field("xv Progressivo Kit Bus"; Rec."xv Progressivo Kit Bus")
            {
                ApplicationArea = All;
                Caption = 'Progressivo Kit Bus';
            }
            field("Posizione Layout"; Rec."Posizione Layout")
            {
                ApplicationArea = All;
                Caption = 'Posizione Layout';
            }
            field("Nr. Layout"; Rec."Nr. Layout")
            {
                ApplicationArea = All;
                Caption = 'Nr. Layout';
            }
            field("Qta. Origine Layout"; Rec."Qta. Origine Layout")
            {
                ApplicationArea = All;
                Caption = 'Qta. Origine Layout';
            }
        }
    }
}