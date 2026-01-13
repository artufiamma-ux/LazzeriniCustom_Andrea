namespace Lazzerini;

Using Microsoft.Manufacturing.Document;

tableextension 50200 "XV Prod. Order Line" extends "Prod. Order Line"
{
    fields
    {
        field(50064; "Status Materiali"; Enum "XV Status Materiali") { Caption = 'Status Materiali'; DataClassification = ToBeClassified; }

    }
}