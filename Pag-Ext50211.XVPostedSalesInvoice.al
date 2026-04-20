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
        addlast("Bill-to")
        {
            group(ShipDetailsXV)
            {
                Caption = 'Colli e Pesi';

                field("Nr. Colli"; NrColli) { ApplicationArea = All; Editable = false; }
                field("Peso Netto"; PesoNetto) { ApplicationArea = All; Editable = false; }
                field("Peso Lordo"; PesoLordo) { ApplicationArea = All; Editable = false; }
                field("Aspetto dei beni"; AspettoDeiBeni) { ApplicationArea = All; Editable = false; }
            }
        }
    }
    actions
    {
        addlast(Processing)
        {
            action(StampaKitBus)
            {
                ApplicationArea = All;
                Caption = 'Stampa personalizzata';
                ToolTip = 'Stampa personalizzata della fattura.';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    SalesInvoiceReport: Report "Custom Sales - Invoice";
                    Rep: Integer;
                begin
                    SalesInvoiceReport.SetParameters(Rec."No.");
                    //                    SalesInvoiceReport.SetTableView(Rec);
                    SalesInvoiceReport.Run();
                end;
            }
        }
    }
    var
        NrColli: Integer;
        PesoNetto: Decimal;
        PesoLordo: Decimal;
        AspettoDeiBeni: Text[100];

    trigger OnAfterGetCurrRecord()
    var
        ShipInfo: Record "XV Posted Invoice Ship Info";
        XVUtil: Codeunit "XVUtil";
    begin
        if ShipInfo.Get(Rec."No.") then begin
            AspettoDeiBeni := ShipInfo."Aspetto Beni";
            NrColli := ShipInfo."Nr. Colli";
            PesoNetto := ShipInfo."Peso Netto";
            PesoLordo := ShipInfo."Peso Lordo";
        end
        else begin
            XVUtil.SetShipInfo(Rec."No.");
            if ShipInfo.Get(Rec."No.") then begin
                AspettoDeiBeni := ShipInfo."Aspetto Beni";
                NrColli := ShipInfo."Nr. Colli";
                PesoNetto := ShipInfo."Peso Netto";
                PesoLordo := ShipInfo."Peso Lordo";
            end;
        end;

    end;
}
