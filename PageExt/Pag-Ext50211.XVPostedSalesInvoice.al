namespace Xview.Custom.Lazzerini;

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
                /*
                Editable = false; // resta non editabile
                DrillDown = true;
                trigger OnDrillDown()
                var
                    Header: Record "Sales Invoice Header";
                begin
                    Header.Get(Rec."No.");
                    // toggle
                    Header."ACCOMPAGNATORIA" := not Header."ACCOMPAGNATORIA";
                    Header.Modify(true);
                    // sync UI
                    Rec."ACCOMPAGNATORIA" := Header."ACCOMPAGNATORIA";
                    CurrPage.Update(false);
                end;
                */
            }
        }
        addlast("Bill-to")
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
            action(StampaAccompagnatoriaCustom)
            {
                ApplicationArea = All;
                Caption = 'Stampa Fattura Accompagnatoria (Custom)';
                ToolTip = 'Stampa la fattura con il nuovo layout personalizzato per le fatture accompagnatorie.';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    AccompagnatoriaReport: Report "XV Fatt. Accompagnatoria Cust";
                begin
                    AccompagnatoriaReport.SetParameters(Rec."No.");
                    AccompagnatoriaReport.Run();
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
}
