namespace Lazzerini;

using Microsoft.Warehouse.Document;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Sales.Document;

page 50228 "XV Etichette Ricambi Cliente"
{
    ApplicationArea = All;
    Caption = 'XV Etichette Ricambi Cliente';
    PageType = List;
    SourceTable = "Warehouse Shipment Line";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the number of the item that should be shipped.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the item in the line.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity that should be shipped.';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
action(Print)
{
    ApplicationArea = All;
    Caption = 'Stampa Etichette';
    Image = Print;

    trigger OnAction()
    var
        CustomerNo: Code[20];
        ReportObj: Report "XV Etichette Ricambi Cliente";
    begin
        // 1️⃣ Ricavo il cliente dalla spedizione
        CustomerNo := GetCustomerFromShipment();

        // 2️⃣ Passo i parametri al report
        ReportObj.SetParameters(Rec."Item No.", CustomerNo);

        // 3️⃣ Avvio la stampa
        ReportObj.RunModal();
    end;
}        }
    }


    var
    WhseShptHeader: Record "Warehouse Shipment Header";

    procedure SetShipmentHeader(var Header: Record "Warehouse Shipment Header")
    begin
        WhseShptHeader := Header;

        // Filtra le righe in base al numero della spedizione
        Rec.Reset();
        Rec.SetRange("No.", WhseShptHeader."No.");

        CurrPage.Update(false);
    end;
 
    procedure GetCustomerFromShipment(): Code[20]
    var
        SalesHeader: Record "Sales Header";
    begin
        // Le righe di Warehouse Shipment derivano quasi sempre da Sales Order (Source Type = 37)
        if (Rec."Source Type" = DATABASE::"Sales Line") then begin
            if SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."Source No.") then
                exit(SalesHeader."Sell-to Customer No.")
            else
                Error('Non trovo la testata Sales per %1', Rec."Source No.");
        end;

        Error('Origine non supportata: Source Type = %1', Rec."Source Type");
    end;

}

