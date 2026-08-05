namespace Xview.Custom.Lazzerini;

using Microsoft.Manufacturing.Document;
using Microsoft.Warehouse.Worksheet;

tableextension 50232 "XV Whse. Worksheet Line" extends "Whse. Worksheet Line"
{
    fields
    {
        field(50050; "Nr. area di produzione OP"; Code[20])
        {
            Caption = 'Nr. area di produzione OP';
            FieldClass = FlowField;
            CalcFormula = lookup(
                "Production Order"."Nr. area di produzione OP"
                where(
                    Status = const(Released),
                    "No." = field("Whse. Document No.")
                )
            );
            Editable = false;

        }
    }
}
