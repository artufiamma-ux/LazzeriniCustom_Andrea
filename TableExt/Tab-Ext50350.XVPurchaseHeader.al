namespace Xview.Custom.Lazzerini;

using Microsoft.Purchases.Document;

tableextension 50231 "XV Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(5020; "Ordine Pilota"; Boolean)
        {
            Caption = 'Ordine Pilota';
            DataClassification = ToBeClassified;
        }
    }
}