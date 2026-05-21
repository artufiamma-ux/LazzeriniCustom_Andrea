namespace Xview.Custom.Lazzerini;
using Microsoft.Sales.History;

pageextension 50229 "XV Sales Posted Ship Summary" extends "EOS Sales Posted Ship Summary"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Nr Fattura Proforma"; GetNrFatturaProforma(Rec."Document No."))
            {
                ApplicationArea = All;
                Caption = 'Nr Fattura Proforma';
            }
            field("Nr Fattura"; GetNrFattura(Rec."Document No."))
            {
                ApplicationArea = All;
                Caption = 'Nr Fattura';
            }
        }
    }
    local procedure GetNrFatturaProforma(ShipmentNo: Code[20]): Code[20]
    var
        Shipment: Record "Sales Shipment Header";
    begin
        if Shipment.Get(ShipmentNo) then
            exit(Shipment."Nr fattura proforma")
        else
            exit('');
    end;

    local procedure GetNrFattura(ShipmentNo: Code[20]): Code[20]
    var
        Shipment: Record "Sales Shipment Header";
    begin
        if Shipment.Get(ShipmentNo) then
            exit(Shipment."Nr fattura")
        else
            exit('');
    end;
}
