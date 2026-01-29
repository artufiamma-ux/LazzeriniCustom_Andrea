namespace Lazzerini;

using Microsoft.Inventory.Requisition;

tableextension 50198 "XV Requisition Line" extends "Requisition Line"
{
    fields
    {
        field(50065; "Posizione Layout"; code[20]) { Caption = 'Posizione Layout'; DataClassification = ToBeClassified; }
    }
}