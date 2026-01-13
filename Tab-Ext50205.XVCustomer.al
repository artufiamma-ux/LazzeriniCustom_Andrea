namespace Lazzerini;

using Microsoft.Sales.Customer;

tableextension 50205 XVCustomer extends Customer
{
    fields
    {
        field(50100; "Tipo Etichetta Spedizione"; Code[20])
        {
            Caption = 'Tipo Etichetta Spedizione';
            DataClassification = ToBeClassified;
            TableRelation = "XV Tipo Etichetta Spedizione";
        }
        field(50101; "Codice EORI"; Code[20])
        {
            Caption = 'Codice EORI';
            DataClassification = ToBeClassified;
        }
    }
}
