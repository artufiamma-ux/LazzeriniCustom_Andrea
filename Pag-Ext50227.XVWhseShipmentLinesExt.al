namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Document;
using Microsoft.Sales.Document;

pageextension 50213 "XV Whse Shipment Lines Ext" extends "Whse. Shipment Subform"
{
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
            Rec."Progressivo Kit Bus" := SalesLine."xv Progressivo Kit Bus";
            Rec."Nr. Layout" := SalesLine."xv Nr Layout";
            Rec."Posizione Layout" := SalesLine."xv Posizione Layout";

            Rec.Modify();
        end;
    end;
}