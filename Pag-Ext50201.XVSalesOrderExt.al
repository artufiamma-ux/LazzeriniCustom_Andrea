
namespace Xview.Custom.Lazzerini;

using Microsoft.Sales.Document;

pageextension 50201 "XV Sales Order Ext" extends "Sales Order"
{
    AdditionalSearchTerms = 'Custom XView';


    layout
    {
        // Aggiungo campi nella FastTab 'General'
        addlast(General)
        {
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = All;
                NotBlank = true;
                ShowMandatory = Rec."Reason Code" = '';
            }
            field("Nr Layout"; Rec."Nr Layout")
            {
                ApplicationArea = All;
                ToolTip = 'Specifica il numero del layout da utilizzare per la stampa del documento.';
            }
            field("Ordine con kit"; Rec."Ordine con kit")
            {
                ApplicationArea = All;
                Editable = false;
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

    actions
    {
        addfirst("Processing")
        {
            action(StampaKitBus)
            {
                ApplicationArea = All;
                Caption = 'Stampa Personalizzata';
                ToolTip = 'Stampa personalizzata dell''ordine';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    KBReport: Report "XV Custom Sales Order";
                begin
                    KBReport.SetParameters(Rec."No.");
                    //                    KBReport.SetTableView(Rec);
                    KBReport.Run();
                end;
            }

        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (CloseAction in [Action::OK, Action::LookupOK]) then begin
            if Rec."Reason Code" = '' then
                Message('Il campo Causale è obbligatorio per salvare l’ordine.');//Error
            if Rec."Activity Code" = '' then
                Message('Il campo Codice Attività è obbligatorio per salvare l’ordine.');//Error
        end;
    end;



}

