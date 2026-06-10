
namespace Xview.Custom.Lazzerini;
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
                //Editable = false;
            }
            field("New Kit Bus"; Rec."BOM Item No.")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("OLD Kit Bus"; Rec."xv Kit Bus")
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
        modify("Net Weight")
        {
            ShowMandatory = (Rec.Type <> Rec.Type::" ") and (Rec."No." <> '');
            trigger OnBeforeValidate()
            begin
                if Rec."Net Weight" = 0 then
                    Error(MsgPeso);
            end;

        }
        modify("Unit Price")
        {
            ShowMandatory = (Rec.Type <> Rec.Type::" ") and (Rec."No." <> '');


            trigger OnBeforeValidate()
            begin
                if Rec."Unit Price" = 0 then
                    Error(MsgPrezzo);
            end;
        }
        modify("Quantity")
        {
            ShowMandatory = (Rec.Type <> Rec.Type::" ") and (Rec."No." <> '');


            trigger OnBeforeValidate()
            begin
                if Rec."Quantity" = 0 then
                    Error(MsgQta);
            end;
        }


    }

    actions
    {
        modify(ExplodeBOM_Functions)
        {
            Enabled =
                (Rec.Type = Rec.Type::Item) and
                (Rec.Quantity <> 0);
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (CloseAction in [Action::OK, Action::LookupOK]) then begin
            if Rec."Unit Price" = 0 then
                Error(MsgPrezzo);
            // if Rec."Unit Price" = 0 then
            //   Error('Il campo Prezzo Unitario è obbligatorio per salvare l’ordine.');
            if Rec."Net Weight" = 0 then
                Error(MsgPeso);
        end;
    end;

    var
        MsgPrezzo: Label 'Il campo Prezzo Unitario è obbligatorio per salvare l’ordine.';
        MsgPeso: Label 'Il campo Peso Netto è obbligatorio per salvare l’ordine.';
        MsgQta: Label 'Il campo Quantità è obbligatorio per salvare l’ordine.';
}

