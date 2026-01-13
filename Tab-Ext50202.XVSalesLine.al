namespace Lazzerini;

using Microsoft.Sales.Document;

tableextension 50202 "XV Sales Line" extends "Sales Line"
{
    fields
    {
        field(50208; "xv Nr Layout"; Code[20]) { Caption = 'Nr Layout'; DataClassification = ToBeClassified; }
        field(50209; "xv Posizione Layout"; Code[20])
        {
            Caption = 'Posizione Layout';
            DataClassification = ToBeClassified;
        }
        field(50210; "xv Progressivo Kit Bus"; Code[20])
        {
            Caption = 'Progressivo Kit Bus';
            DataClassification = ToBeClassified;
        }
        field(50211; "xv Kit Bus"; Code[20])
        {
            Caption = 'Kit Bus';
            DataClassification = ToBeClassified;
        }
    }
}
