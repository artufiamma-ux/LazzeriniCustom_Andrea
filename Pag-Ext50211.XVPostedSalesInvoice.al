namespace Lazzerini;

using Microsoft.Sales.Document;
using Microsoft.Sales.History;
pageextension 50211 XVPostedSalesInvoice extends "Posted Sales Invoice"
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
        }

    }
}
