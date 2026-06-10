namespace Xview.Custom.Lazzerini;

using Microsoft.Sales.Document;

pageextension 50204 "XV Sales Invoice List" extends "Sales Invoice List"
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