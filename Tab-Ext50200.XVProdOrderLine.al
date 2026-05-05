namespace Lazzerini;

Using Microsoft.Manufacturing.Document;


tableextension 50200 "XV Prod. Order Line" extends "Prod. Order Line"
{
    fields
    {
        field(50064; "Status Materiali"; Enum "XV Status Materiali") { Caption = 'Status Materiali'; DataClassification = ToBeClassified; }
        field(50065; "Posizione Layout"; code[20]) { Caption = 'Posizione Layout'; DataClassification = ToBeClassified; }
        field(50066; "XV Kit Bus"; Code[20]) { Caption = 'Kit Bus'; DataClassification = ToBeClassified; }
        field(50067; "XV Progressivo Kit Bus"; Integer) { Caption = 'Progressivo Kit Bus'; DataClassification = ToBeClassified; }
        field(50068; "XV Document No."; Code[20]) { Caption = 'Document No.'; DataClassification = ToBeClassified; }
        field(50069; "XV Line No."; Integer) { Caption = 'Line No.'; DataClassification = ToBeClassified; }
    }
}