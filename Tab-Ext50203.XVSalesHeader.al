namespace Lazzerini;

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
        field(50101; "Tipo Ordine"; Code[20])
        {
            Caption = 'Tipo Ordine';
            TableRelation = "XV Tipo Ordine";
            DataClassification = ToBeClassified;
        }
    }
}
