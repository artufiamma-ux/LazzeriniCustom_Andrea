namespace Lazzerini;
using Microsoft.Sales.History;

tableextension 50226 "XV Sales Shipment Line" extends "Sales Shipment Line"
{
    fields
    {
        field(50050; "xv Kit Bus"; Code[20])
        {
            Caption = 'xv Kit Bus';
            DataClassification = ToBeClassified;
        }
        field(50051; "xv Progressivo Kit Bus"; Integer)
        {
            Caption = 'xv Progressivo Kit Bus';
            DataClassification = ToBeClassified;
        }
    }
}
