namespace Xview.Custom.Lazzerini;

using Microsoft.Sales.Document;

pageextension 50235 "XV Ext Sales Quote" extends "Sales Quote"
{
    layout
    {
        addlast("Shipping and Billing")
        {
            group(ShipDetailsXV)
            {
                Caption = 'Informazioni di spedizione';

                field("Nr. Colli"; NrColli) { ApplicationArea = All; Editable = false; }
                field("Peso Netto"; PesoNetto) { ApplicationArea = All; Editable = false; }
                field("Peso Lordo"; PesoLordo) { ApplicationArea = All; Editable = false; }
                field("Aspetto dei beni"; AspettoDeiBeni) { ApplicationArea = All; Editable = false; }
                field("Ora di partenza"; OraPartenza) { ApplicationArea = All; Editable = false; }
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
                Caption = 'Informazioni di Spedizione';
                ToolTip = 'Aggiorna Informazioni di Spedizione Ora di partenza, Pesi e Nr Colli.';
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
                ToolTip = 'Stampa personalizzata della fattura Proforma.';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    SalesInvoiceReport: Report "Custom Proforma - Invoice";
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
        OraPartenza: Time;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateShipmentInfo();
    end;




    local procedure UpdateShipmentInfo()
    var
        XVUtil: Codeunit "XVUtil";
    begin
        if ShipInfo.Get(Rec."No.") then begin //Rec."XV Proforma Source"
            if ShipInfo."Nr. Colli" = 0 then begin
                ShipInfo.Delete();
                XVUtil.SetShipInfo(Rec."No.");
                if ShipInfo.Get(Rec."No.") then;
            end;
            AspettoDeiBeni := ShipInfo."Aspetto Beni";
            NrColli := ShipInfo."Nr. Colli";
            PesoNetto := ShipInfo."Peso Netto";
            PesoLordo := ShipInfo."Peso Lordo";
            OraPartenza := ShipInfo."Ora di partenza";
        end
        else begin
            XVUtil.SetShipInfo(Rec."No.");
            if ShipInfo.Get(Rec."No.") then begin
                AspettoDeiBeni := ShipInfo."Aspetto Beni";
                NrColli := ShipInfo."Nr. Colli";
                PesoNetto := ShipInfo."Peso Netto";
                PesoLordo := ShipInfo."Peso Lordo";
                OraPartenza := ShipInfo."Ora di partenza";
            end;
        end;
    end;


}
