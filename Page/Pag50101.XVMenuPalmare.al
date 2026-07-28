namespace Xview.Custom.Lazzerini;

using Microsoft.Foundation.Company;
using Microsoft.Inventory.Item;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Structure;
page 50101 "XV Menu Palmare"
{
    PageType = CardPart;

    layout
    {
        area(Content)
        {
            usercontrol(Home; "XV Zebra Home")
            {
                ApplicationArea = All;

                trigger ActionSelected(ActionName: Text)
                begin
                    case ActionName of
                        'PRELIEVI_SPED':
                            Page.Run(Page::"XVWarehouseShipmentMob");
                        'PRELIEVI_PROD':
                            Page.Run(Page::"Warehouse Shipment List");

                        'MAGAZZINO':
                            Page.Run(Page::"Bin List");

                        'STAMPA_ETICHETTA':
                            Page.Run(Page::"Item List");
                        'DIVIDI_SCATOLE':
                            Page.Run(Page::"Item List");
                        'COMPATTA_SCATOLE':
                            Page.Run(Page::"Item List");
                        'SPOSTA_ARTICOLO':
                            Page.Run(Page::"Item List");
                    end;
                end;
            }
        }
    }
}