namespace Xview.Custom.Lazzerini;
using Microsoft.Sales.History;

tableextension 50226 "XV Sales Shipment Line" extends "Sales Shipment Line"
{
    fields
    {/*
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
    */
        field(50200; "xv Progressivo Kit Bus"; Integer)
        {
            Caption = 'Progressivo Kit Bus';
        }

        field(50201; "Posizione Layout"; Code[20])
        {
            Caption = 'Posizione Layout';
        }

        field(50202; "Nr. Layout"; Code[20])
        {
            Caption = 'Nr. Layout';
        }

        field(50203; "Qta. Origine Layout"; Code[20])
        {
            Caption = 'Qta. Origine Layout';

        }

        field(50204; "xv Kit Bus"; Code[20])
        {
            Caption = 'Kit Bus';
        }

    }

}
