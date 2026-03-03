page 50209 "XV Parametri Etichette"
{
    PageType = StandardDialog;
    Caption = 'Parametri Stampa Etichette';

    layout
    {
        area(content)
        {
            group(Generale)
            {
                field(NrTotaleSerie; NrTotaleSerie)
                {
                    ApplicationArea = All;
                    Caption = 'Nr Totale Serie';
                }

                field(NrTotalePallet; NrTotalePallet)
                {
                    ApplicationArea = All;
                    Caption = 'Nr Totale Pallet';
                }

                field(NumeroCopieUDC; NumeroCopieUDC)
                {
                    ApplicationArea = All;
                    Caption = 'Numero Copie UDC';
                }

                field(StampaBasamenti; StampaBasamenti)
                {
                    ApplicationArea = All;
                    Caption = 'Stampa Basamenti';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Anteprima)
            {
                Caption = 'Anteprima';
                Image = View;

                trigger OnAction()
                begin
                    LanciaReport(true);
                end;
            }

            action(Stampa)
            {
                Caption = 'Stampa';
                Image = Print;

                trigger OnAction()
                begin
                    LanciaReport(false);
                end;
            }
        }
    }

    var
        ShipmentNo: Code[20];
        NrTotaleSerie: Integer;
        NrTotalePallet: Integer;
        NumeroCopieUDC: Integer;
        StampaBasamenti: Boolean;

    procedure SetShipmentNo(No: Code[20])
    begin
        ShipmentNo := No;
    end;

    local procedure LanciaReport(Preview: Boolean)
    var
        WhseShipmentHeader: Record "Warehouse Shipment Header";
    begin
        WhseShipmentHeader.Get(ShipmentNo);

        // Qui passerai i parametri al report
        Report.Run(
            Report::"XV Barcode Fattura Acquisto",  // <-- nome del tuo report
            Preview,                        // true = anteprima
            false,
            WhseShipmentHeader);
    end;
}