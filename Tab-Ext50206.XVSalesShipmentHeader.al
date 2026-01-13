namespace Lazzerini;

using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.Finance.Currency;
tableextension 50206 "XV Spedizioni" extends "Sales Shipment Header"
{
    fields
    {
        field(50061; "Nr fattura proforma"; Code[20]) { Caption = 'Nr fattura proforma'; TableRelation = "Sales Header"."Fattura Project Code"; }
        field(50062; "Cod valura proforma"; Code[20]) { Caption = 'Cod valura proforma'; TableRelation = Currency.Code; }
        field(50063; "Costi di trasporto"; Decimal) { Caption = 'Costi di trasporto'; }
    }
}