namespace Xview.Custom.Lazzerini;

using Microsoft.Sales.Document;
using Microsoft.Sales.History;

pageextension 50203 XVSalesInvoice extends "Sales Invoice"
{
    layout
    {
        addafter("Posting Date")
        {
            field(ACCOMPAGNATORIA; Rec.ACCOMPAGNATORIA)
            {
                ApplicationArea = All;
                Caption = 'Accompagnatoria';
                ToolTip = 'Indica se la fattura è accompagnatoria.';
            }
            field("Tipo Ordine"; Rec."Tipo Ordine")
            {
                ApplicationArea = All;
                Caption = 'Tipo Ordine';
                ToolTip = 'Specifica il tipo di ordine associato alla fattura.';
            }
        }
    }
}
