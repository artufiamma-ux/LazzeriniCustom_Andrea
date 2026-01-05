namespace Custom.Custom;

using Microsoft.Sales.Document;

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
        }
    }
}
