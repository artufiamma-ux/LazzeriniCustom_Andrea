namespace Xview.Custom.Lazzerini;

using Microsoft.Foundation.Company;
using Microsoft.Inventory.Item;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Structure;
page 50280 "XV Menu Palmare Mob"
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
                            Message('Prelievi Spedizione');
                        'PRELIEVI_PROD':
                            Message('Prelievi Produzione');
                        'CONTENUTO_COLLOCAZION':
                            Message('Contenuto Collocazione');
                        'DIVIDI_SCATOLE':
                            Message('Dividi Scatole');
                        'COMPATTA_SCATOLE':
                            Message('Compatta Scatole');
                        'ARTICOLO':
                            Page.Run(Page::"XV Articolo Palmare Mob"); // Stampa,Cerca,Sposta
                    end;
                end;
            }
        }
    }
}