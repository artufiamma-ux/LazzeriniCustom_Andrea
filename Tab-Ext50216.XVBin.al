namespace Lazzerini;

using Microsoft.Warehouse.Structure;

tableextension 50054 "XV Bin" extends "Bin"
{
    fields
    {
        field(50095; "Cod zona"; Code[20])
        {
            Caption = 'Cod zona';
            TableRelation = Zone.Code;
        }
        field(50094; "Tipo Prelievo"; code[20])
        {
            Caption = 'Tipo Prelievo';
            TableRelation = Zone."Bin Type Code";
        }
    }
}