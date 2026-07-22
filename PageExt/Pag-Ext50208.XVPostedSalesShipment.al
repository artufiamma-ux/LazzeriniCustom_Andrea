namespace Xview.Custom.Lazzerini;
using Microsoft.Sales.History;

pageextension 50208 "XV Posted Sales Shipment Ext" extends "Posted Sales Shipment"
{
    layout
    {
        addlast(General)
        {
            field("Nr fattura proforma"; Rec."Nr fattura proforma")
            {
                ApplicationArea = All;
            }

            field("Cod valuta proforma"; Rec."Cod valuta proforma")
            {
                ApplicationArea = All;
            }

            field("Costi di trasporto"; Rec."Costi di trasporto")
            {
                ApplicationArea = All;
            }
            field("Riferimento CWS"; Rec."EOS Shipment No.")
            {
                ApplicationArea = All;
            }
        }
        addlast("Shipping")
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
            action(StampaKitBus)
            {
                ApplicationArea = All;
                Caption = 'Stampa personalizzata';
                ToolTip = 'Stampa personalizzata della spedizione.';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    SalesInvoiceReport: Report "XV Custom Sales - Shipment";
                    Rep: Integer;
                begin
                    SalesInvoiceReport.SetParameters(Rec."EOS Shipment No.");
                    SalesInvoiceReport.Run();
                end;
            }
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

            action(CreaProforma)
            {
                Caption = 'Crea proforma';
                Image = Save;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Crea una proforma dall''ordine corrente';
                Enabled = IsProformaEnabled;
                trigger OnAction()
                var
                    ProformaMgt: Codeunit "Proforma Management";
                begin
                    ProformaMgt.CreateProformaFromSR(Rec."No.");
                end;
            }
        }
    }

    var
        IsProformaEnabled: Boolean;
        NrColli: Integer;
        PesoNetto: Decimal;
        PesoLordo: Decimal;
        AspettoDeiBeni: Text[100];
        ShipInfo: Record "XV Posted Invoice Ship Info";
        OraPartenza: Time;

    trigger OnAfterGetCurrRecord()
    var
        XVUtil: Codeunit "XVUtil";
    begin
        if ShipInfo.Get(Rec."No.") then begin
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

    trigger OnAfterGetRecord()
    begin
        IsProformaEnabled :=
            (Rec."Nr fattura proforma" = '') and Rec."Reason Code" in ['15', '18', '23', '27', '01']
            ;
    end;
}
