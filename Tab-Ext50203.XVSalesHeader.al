namespace Custom.Custom;

using Microsoft.Sales.Document;

tableextension 50203 "XVSales Header" extends "Sales Header"
{
    fields
    {
        field(50100; ACCOMPAGNATORIA; Boolean)
        {
            Caption = 'Accompagnatoria';
            InitValue = false;
            DataClassification = ToBeClassified;
        }
    }
}
