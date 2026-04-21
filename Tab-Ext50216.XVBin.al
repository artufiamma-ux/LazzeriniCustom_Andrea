namespace Lazzerini;

using Microsoft.Warehouse.Structure;

tableextension 50054 "XV Bin" extends "Bin"
{
    fields
    {
        field(50094; "Tipo Prelievo"; Text[25])
        {
            Caption = 'Tipo Prelievo';
            Editable = false;
        }
    }
}