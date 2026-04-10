
namespace Lazzerini;
using Microsoft.Sales.Document;

pageextension 50202 "XV Sales List Ext" extends "Sales Order List" // Page 9305
{
    AdditionalSearchTerms = 'Custom XView';

    layout
    {
        // Inserisce le colonne subito dopo "No." nel repeater principale
        addafter("No.")
        {
            field("Nr Layout"; Rec."Nr Layout")
            {
                ApplicationArea = All;
                ToolTip = 'Nr Layout';
            }
            field("Ordine con kit"; Rec."Ordine con kit")
            {
                ApplicationArea = All;
                ToolTip = 'Ordine con kit';
            }
            field("Nr serie"; Rec."Nr serie")
            {
                ApplicationArea = All;
                ToolTip = 'Nr serie';
            }
            field("Non duplicabile"; Rec."Non duplicabile")
            {
                ApplicationArea = All;
                ToolTip = 'Non duplicabile';
            }
        }
    }
    actions
    {
        addlast(Processing)
        {
            action(StampaKitBus)
            {
                ApplicationArea = All;
                Caption = 'Stampa personalizzata';
                ToolTip = 'Stampa personalizzata della fattura.';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    SalesInvoiceReport: Report "XV Custom Sales Order";
                    Rep: Integer;
                begin
                    SalesInvoiceReport.SetParameters(Rec."No.");
                    SalesInvoiceReport.Run();
                end;
            }
        }
    }
}
