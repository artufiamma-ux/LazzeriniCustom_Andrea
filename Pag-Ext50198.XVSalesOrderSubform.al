
namespace Lazzerini;
using Microsoft.Sales.Document;

pageextension 50198 "XV Sales Order Subform" extends "Sales Order Subform" // Page 9305
{
    AdditionalSearchTerms = 'Custom XView';

    layout
    {
        // Inserisce le colonne subito dopo "No." nel repeater principale
        addafter("Description")
        {
            field("Nr Layout"; Rec."xv Nr Layout")
            {
                ApplicationArea = All;
                ToolTip = 'Nr Layout';
            }
            field("Ordine con kit"; Rec."xv Posizione Layout")
            {
                ApplicationArea = All;
                ToolTip = 'Ordine con kit';
            }
            field("Progressivo Kit Bus"; Rec."xv Progressivo Kit Bus")
            {
                ApplicationArea = All;
                ToolTip = 'Progressivo Kit Bus';
            }
            field("Kit Bus"; Rec."xv Kit Bus")
            {
                ApplicationArea = All;
                ToolTip = 'Kit Bus';
            }
            field("Qta. Origine layout"; Rec."Qta. Origine layout")
            {
                ApplicationArea = All;
                ToolTip = 'Qta. Origine layout';
            }
        }
    }
}
