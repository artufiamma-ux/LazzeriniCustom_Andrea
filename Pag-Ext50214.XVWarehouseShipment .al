namespace Lazzerini;

using Microsoft.Warehouse.Document;

pageextension 50214 XVWarehouseShipment extends "Warehouse Shipment"
{
    layout
    {
        addlast(Content)
        {
            group("Campi Custom")
            {
                field("Tipo Prelievo"; Rec."Tipo Prelievo")
                {
                    ApplicationArea = All;
                }
                field("Tipo Ordine"; Rec."Tipo Ordine")
                {
                    ApplicationArea = All;
                }
                field("Numero Totale Serie"; Rec."Numero Totale Serie")
                {
                    ApplicationArea = All;
                }
                field("Numero Totale Pallet"; Rec."Numero Totale Pallet")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
