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
            action(UpdShipInfo)
            {
                ApplicationArea = All;
                Caption = 'Colli e Pesi';
                ToolTip = 'Aggiorna Pesi e Nr Colli.';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    Page.RunModal(Page::"XV Ship Details Card", ShipInfo);
                end;
            }
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
        ShipInfo: Record "XV Posted Invoice Ship Info";

    trigger OnAfterGetCurrRecord()
    var
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
