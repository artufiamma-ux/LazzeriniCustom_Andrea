namespace Xview.Custom.Lazzerini;

using Microsoft.Sales.History;

pageextension 50230 "XV Posted Sales Shipments " extends "Posted Sales Shipments"
{
    layout
    {
        addafter("No.")
        {
            field("Nr Fattura Proforma"; Rec."Nr fattura proforma")
            {
                ApplicationArea = All;
                Caption = 'Nr Fattura Proforma';
            }
            field("Nr Fattura"; Rec."Nr fattura")
            {
                ApplicationArea = All;
                Caption = 'Nr Fattura';
            }
        }
    }
    actions
    {
        addlast(Processing)
        {

            action(Test)
            {
                ApplicationArea = All;
                Caption = 'TEST';
                ToolTip = 'TEST';
                Image = Action;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    XUtil: Codeunit XVUtil;
                    info: array[4] of Text[100];

                begin
                    //XUtil.GetInfoPackaging(Rec."No.", info);
                    Message('Ciao %1, %2, %3, %4', info[1], info[2], info[3], info[4]);

                end;
            }

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
        }
    }

}
