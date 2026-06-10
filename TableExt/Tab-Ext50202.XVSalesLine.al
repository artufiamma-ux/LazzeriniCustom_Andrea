namespace Xview.Custom.Lazzerini;

using Microsoft.Sales.Document;


tableextension 50202 "XV Sales Line" extends "Sales Line"
{
    fields
    {
        field(50208; "xv Nr Layout"; Code[20]) { Caption = 'Nr Layout'; DataClassification = ToBeClassified; }
        field(50209; "xv Posizione Layout"; Code[20])
        {
            Caption = 'Posizione Layout';
            DataClassification = ToBeClassified;
        }
        field(50210; "xv Progressivo Kit Bus"; Integer)
        {
            Caption = 'Progressivo Kit Bus';
            DataClassification = ToBeClassified;
        }
        field(50211; "xv Kit Bus"; Code[20])
        {
            Caption = 'Kit Bus';
            DataClassification = ToBeClassified;
        }
        field(50212; "Qta. Origine layout"; Code[20])
        {
            Caption = 'Qta. Origine layout';
            DataClassification = ToBeClassified;
        }
    }
    /*
        trigger OnBeforeInsert()
        begin
            CheckMandatoryFields();
        end;

        trigger OnBeforeModify()
        begin
            CheckMandatoryFields();
        end;
    */
    local procedure CheckMandatoryFields()
    begin
        if (Rec.Type <> Rec.Type::" ") and (Rec."No." <> '') then begin
            if Rec."Net Weight" = 0 then
                Error(MsgPeso);

            if Rec."Unit Price" = 0 then
                Error(MsgPrezzo);
            if Rec."Quantity" = 0 then
                Error(MsgQta);
        end;
    end;

    var
        MsgPrezzo: Label 'Il campo Prezzo Unitario è obbligatorio per salvare l’ordine.';
        MsgPeso: Label 'Il campo Peso Netto è obbligatorio per salvare l’ordine.';
        MsgQta: Label 'Il campo Quantità è obbligatorio per salvare l’ordine.';

}
