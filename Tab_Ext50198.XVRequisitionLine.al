namespace Xview.Custom.Lazzerini;

using Microsoft.Inventory.Requisition;


tableextension 50198 "XV Requisition Line" extends "Requisition Line"
{
    fields
    {
        field(50065; "Posizione Layout"; code[20]) { Caption = 'Posizione Layout'; DataClassification = ToBeClassified; }

        field(50100; "XV Sales"; Code[20])
        {
            Caption = 'XV Sales Order No.';
            DataClassification = CustomerContent;
        }
        field(50101; "XV Sales Line"; Integer)
        {
            Caption = 'XV Sales Line No.';
            DataClassification = CustomerContent;
        }

    }
}