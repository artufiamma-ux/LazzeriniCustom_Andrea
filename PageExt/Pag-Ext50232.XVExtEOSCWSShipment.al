namespace Xview.Custom.Lazzerini;

pageextension 50232 "XVExt EOS CWS Shipment" extends "EOS CWS Shipment"
{
    actions
    {
        addfirst("Processing")
        {
            action(StampaKitBus)
            {
                ApplicationArea = All;
                Caption = 'Stampa Personalizzata';
                ToolTip = 'Stampa personalizzata della spedizione.';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    SalesInvoiceReport: Report "XV Custom Sales - Shipment";
                    Rep: Integer;
                begin
                    SalesInvoiceReport.SetParameters(Rec."No.");
                    SalesInvoiceReport.Run();
                end;
            }

        }
    }
}
