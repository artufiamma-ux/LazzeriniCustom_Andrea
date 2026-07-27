namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Item;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Structure;

page 50100 "XV Home Magazzino"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    Caption = 'Home Magazzino';

    actions
    {
        area(Sections)
        {
            group(Operazioni)
            {
                action(PrelieviSpedizioni)
                {
                    Caption = 'Prelievi spedizioni';
                    Image = Shipment;
                    RunObject = page "Warehouse Shipment List";
                }

                action(PrelieviProduzione)
                {
                    Caption = 'Prelievi produzione';
                    Image = PickLines;
                    RunObject = page "Item List";
                }

                action(StampaEtichetta)
                {
                    Caption = 'Stampa etichetta';
                    Image = Print;
                    RunObject = page "Item List";
                }

                action(DividiScatole)
                {
                    Caption = 'Dividi scatole';
                    Image = Splitlines;
                    RunObject = page "Item List";
                }

                action(Magazzino)
                {
                    Caption = 'Magazzino';
                    Image = Warehouse;
                    RunObject = page "Bin List";
                }

                action(SpostaArticolo)
                {
                    Caption = 'Sposta articolo';
                    Image = TransferOrder;
                    RunObject = page "Item List";
                }

                action(CompattaScatole)
                {
                    Caption = 'Compatta scatole';
                    Image = Calculate;
                    RunObject = page "Item List";
                }
            }
        }
    }
}