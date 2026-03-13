namespace Lazzerini;

using Microsoft.Sales.Document;

pageextension 50219 "XV Sales Invoice Subform"
    extends "Sales Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("*Kit Bus*"; Rec."BOM Item No.")
            {
                ApplicationArea = All;
            }
            field("Kit Bus"; Rec."xv Kit Bus")
            {
                ApplicationArea = All;
            }

            field("Progressivo Kit Bus"; Rec."xv Progressivo Kit Bus")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Nr. Layout"; Rec."xv Nr Layout")
            {
                ApplicationArea = All;
            }

            field("Posizione Layout"; Rec."xv Posizione Layout")
            {
                ApplicationArea = All;
            }

            field("Qta. Origine Layout"; Rec."Qta. Origine Layout")
            {
                ApplicationArea = All;
            }
        }
    }
}
