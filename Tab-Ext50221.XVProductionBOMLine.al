namespace Xview.Custom.Lazzerini;
using Microsoft.Manufacturing.ProductionBOM;



tableextension 50221 "XV Production BOM Line "
    extends "Production BOM Line"
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
