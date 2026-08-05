namespace Custom.Custom;

using Microsoft.Manufacturing.Document;
using Microsoft.Warehouse.Worksheet;

pageextension 50245 "XV Pick Worksheet" extends "Pick Worksheet"
{
    layout
    {
        addlast("Control1")
        {
            field("Area produzione"; Rec."Nr. area di produzione OP")
            {
                ApplicationArea = All;

            }
        }
    }


}
