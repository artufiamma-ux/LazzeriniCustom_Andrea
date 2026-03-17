namespace Lazzerini;

using Microsoft.Warehouse.Request;

tableextension 50223 "XV Warehouse Request" extends "Warehouse Request"
{
    fields
    {
        field(50208; "xv Nr Layout"; Code[20]) { Caption = 'Nr Layout'; DataClassification = ToBeClassified; }
        field(50209; "xv Posizione Layout"; Code[20])
        {
            Caption = 'Posizione Layout';
            DataClassification = ToBeClassified;
        }
        field(50210; "xv Progressivo Kit Bus"; Integer)
        {
            Caption = 'Progressivo Kit Bus';
            DataClassification = ToBeClassified;
        }
        field(50211; "xv Kit Bus"; Code[20])
        {
            Caption = 'Kit Bus';
            DataClassification = ToBeClassified;
        }
        field(50212; "Qta. Origine layout"; Code[20])
        {
            Caption = 'Qta. Origine layout';
            DataClassification = ToBeClassified;
        }
    }
}
