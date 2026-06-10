namespace Xview.Custom.Lazzerini;

using Microsoft.Sales.History;

pageextension 50220 "XV PostedSalesInvoiceSubform"
    extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter(Description)

        {
            field("Kit Bus"; Rec."Kit Bus")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Progressivo Kit Bus"; Rec."Progressivo Kit Bus")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Nr. Layout"; Rec."Nr. Layout")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Posizione Layout"; Rec."Posizione Layout")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Qta. Origine Layout"; Rec."Qta. Origine Layout")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
