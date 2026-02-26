namespace Lazzerini;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.BOM;



tableextension 50222 "XV BOM Component "
    extends "BOM Component"
{
    fields
    {
        field(50203; "Posizione Layout"; Code[20])
        {
            Caption = 'Posizione Layout';
            DataClassification = CustomerContent;
        }
    }
}
