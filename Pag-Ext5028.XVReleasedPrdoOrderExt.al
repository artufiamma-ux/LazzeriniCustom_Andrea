namespace Lazzerini;

using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Routing;
using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.Document;
using Microsoft.Manufacturing.WorkCenter;
pageextension 50200 "XV Released Prod. Order Ext" extends "Released Production Order"
{
    layout
    {
        addlast(General)
        {
            field("Nr. Area di produzione OP"; Rec."Nr. Area di produzione OP")
            {
                ApplicationArea = All;
            }

            field("Nr. Ordine di vendita"; Rec."Nr. Ordine di vendita")
            {
                ApplicationArea = All;
            }

            field("Nr. Serie progressiva"; Rec."Nr. Serie progressiva")
            {
                ApplicationArea = All;
            }

            field("Tipo"; Rec."Tipo")
            {
                ApplicationArea = All;
            }

            field("Nr"; Rec."Nr")
            {
                ApplicationArea = All;
            }

            field("Nr. Area produzione (Ciclo)"; Rec."Nr. Area produzione (Ciclo)")
            {
                ApplicationArea = All;
            }

            field("Nome area produzione (Ciclo)"; Rec."Nome area produzione (Ciclo)")
            {
                ApplicationArea = All;
            }

            field("Tipo Ciclo"; Rec."Tipo Ciclo")
            {
                ApplicationArea = All;
            }

            field("Nr. Ciclo"; Rec."Nr. Ciclo")
            {
                ApplicationArea = All;
            }
        }
    }
}
