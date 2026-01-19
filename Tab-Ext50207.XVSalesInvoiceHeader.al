namespace Lazzerini;

using Microsoft.Sales.History;

tableextension 50207 "XV Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(50050; ACCOMPAGNATORIA; Boolean)
        {
            Caption = 'ACCOMPAGNATORIA';
            DataClassification = ToBeClassified;
        }
    }
}
