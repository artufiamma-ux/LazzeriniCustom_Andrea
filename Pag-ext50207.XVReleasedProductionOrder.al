namespace Lazzerini;

using Microsoft.Manufacturing.Document;

pageextension 50207 "XV Released Prod Orders Ext" extends "Released Production Order"
{
    layout
    {
        addlast(General)
        {
            field("Rif. Ord. Vendita"; Rec."Rif. Ord. Vendita")
            {
                ApplicationArea = All;
            }

            field("Nr. Ordine vendita"; Rec."Nr. Ordine di vendita")
            {
                ApplicationArea = All;
            }

            field("Nr. Cliente"; Rec."Nr. cliente")
            {
                ApplicationArea = All;
            }

            field("Nr. Serie progressiva"; Rec."Nr. Serie progressiva")
            {
                ApplicationArea = All;
            }

            field("Nr. Area di produzione (OP)"; Rec."Nr. Area di produzione OP")
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

            field("Nome area di produzione (Ciclo)"; Rec."Nome area produzione (Ciclo)")
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
