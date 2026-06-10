namespace Xview.Custom.Lazzerini;

using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.Finance.Currency;
tableextension 50206 "XV Spedizioni" extends "Sales Shipment Header"
{
    fields
    {
        field(50061; "Nr fattura proforma"; Code[20]) { Caption = 'Nr fattura proforma'; }
        field(50062; "Cod valuta proforma"; Code[20]) { Caption = 'Cod valuta proforma'; TableRelation = Currency.Code; }
        field(50063; "Costi di trasporto"; Decimal) { Caption = 'Costi di trasporto'; }
        field(50064; "Nr fattura"; Code[20]) { Caption = 'Nr fattura associata'; }
    }
}