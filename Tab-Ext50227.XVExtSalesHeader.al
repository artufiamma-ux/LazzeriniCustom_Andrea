namespace Lazzerini;

using Microsoft.Sales.Document;

tableextension 50227 "XV Ext Sales Header" extends "Sales Header"
{
    fields
    {
        field(50050; "XV Proforma Source"; Code[20])
        {
            Caption = 'XV Proforma Source';
            DataClassification = ToBeClassified;
        }
    }
}
