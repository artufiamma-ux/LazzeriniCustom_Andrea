
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
    var
        RecSalesLine: Record "Sales Line";
    begin
        if (CloseAction in [Action::OK, Action::LookupOK]) then begin
            // Controlla se l'ordine contiene righe con prezzo unitario o quantità a zero o peso netto a zero
            RecSalesLine.SetRange("Document No.", Rec."No.");
            if RecSalesLine.FindFirst() then begin
                repeat
                    if RecSalesLine."Unit Price" = 0 then begin
                        Error(RecSalesLine."No." + ' - ' + MsgPrezzo);
                        exit(false);
                    end;
                    if RecSalesLine.Quantity = 0 then begin
                        Error(RecSalesLine."No." + ' - ' + MsgQta);
                        exit(false);
                    end;
                    if RecSalesLine."Net Weight" = 0 then begin
                        Error(RecSalesLine."No." + ' - ' + MsgPeso);
                        exit(false);
                    end;
                until RecSalesLine.Next() = 0;
            end;
        end;
    end;

    var
        MsgPrezzo: Label 'Il campo Prezzo Unitario è obbligatorio per salvare l’ordine.';
        MsgPeso: Label 'Il campo Peso Netto è obbligatorio per salvare l’ordine.';
        MsgQta: Label 'Il campo Quantità è obbligatorio per salvare l’ordine.';



}

