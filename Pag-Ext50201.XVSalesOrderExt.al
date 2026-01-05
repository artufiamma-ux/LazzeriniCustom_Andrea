
namespace Lazzerini;

using Microsoft.Sales.Document;

pageextension 50201 "XV Sales Order Ext" extends "Sales Order"
{
    AdditionalSearchTerms = 'Custom XView';


    layout
    {
        // Aggiungo campi nella FastTab 'General'
        addlast(General)
        {
            field("Nr Layout"; Rec."Nr Layout")
            {
                ApplicationArea = All;
                ToolTip = 'Specifica il numero del layout da utilizzare per la stampa del documento.';
            }
            field("Ordine con kit"; Rec."Ordine con kit")
            {
                ApplicationArea = All;
                ToolTip = 'Specifica se l''ordine include articoli kit.';
            }
            field("Non duplicabile"; Rec."Non duplicabile")
            {
                ApplicationArea = All;
                ToolTip = 'Se selezionato, l''ordine non può essere duplicato.';
            }
            field("Nr serie"; Rec."Nr serie")
            {
                ApplicationArea = All;
                ToolTip = 'Specifica il numero di serie correlato all''ordine.';
            }
            field("Nr posti per serie"; Rec."Nr posti per serie")
            {
                ApplicationArea = All;
                ToolTip = 'Specifica il numero di posti disponibili per la serie.';
            }
            field("Tipo Ordine"; Rec."Tipo Ordine")
            {
                ApplicationArea = All;
                ToolTip = 'Specifica il tipo di ordine.';
            }
        }

    }
}
