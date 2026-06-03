namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Document;
using Microsoft.Sales.Document;

pageextension 50215 XVWhseShipmentSubform extends "Whse. Shipment Subform"
{
    layout
    {
        addafter("Description")
        {
            field("Progressivo Kit Bus"; Rec."Progressivo Kit Bus")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Kit Bus"; Rec."Kit Bus")
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

            }
        }

    }
    trigger OnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
    begin
        // Message('PASSATO NEL GETRECORD DELLA PAGINA DI RIGA DI SPEDIZIONE %1',Rec."Source Type");
        // Evita loop o ricarichi multipli
        if Rec."Kit Bus" <> '' then
            exit;

        // Se non viene da Sales Line → ignora
        if Rec."Source Type" <> Database::"Sales Line" then
            exit;

        // Recupera la riga Sales Line originale
        if SalesLine.Get(Rec."Source Subtype", Rec."Source No.", Rec."Source Line No.") then begin
            Rec."Kit Bus" := SalesLine."xv Kit Bus";
            // se non è impostato nell'ordine assegno di default 1, per permettere la stampa delle etichette
            if SalesLine."xv Progressivo Kit Bus" = 0 then
                Rec."Progressivo Kit Bus" := 1
            else
                Rec."Progressivo Kit Bus" := SalesLine."xv Progressivo Kit Bus";
            Rec."Nr. Layout" := SalesLine."xv Nr Layout";
            Rec."Posizione Layout" := SalesLine."xv Posizione Layout";

            Rec.Modify();
        end;
    end;
}
