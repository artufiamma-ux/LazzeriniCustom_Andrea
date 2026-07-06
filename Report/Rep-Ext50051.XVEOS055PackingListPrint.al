namespace Xview.Custom.Lazzerini;

using Microsoft.Sales.Document;
using Microsoft.Sales.History;

// ID Report 
reportextension 50051 "XV EOS055 Packing List - Print" extends "EOS055 Packing List - Print"
{
    RDLCLayout = './ReportLayouts/XVEOS055PackingList.rdl';
    dataset
    {
        add(TmpPackingListHeader)
        {
            column(LblOrdineVendita; LblOrdineVendita) { }
            column(LblYourReference; LblYourReference) { }
            column(LblCrossReference; LblCrossReference) { }
            column(Header_No_CWS; Header_No_CWS) { Caption = 'Packing List No.'; }
        }

        add(TmpPackingListLine)
        {
            column(CrossReference; CrossReference)
            {
                Caption = 'Cross Reference';
            }
            column(OrdineVendita; OrdineVendita) { Caption = 'Order'; }
            column(YourReference; YourReference) { Caption = 'Your Reference'; }
        }
        modify(TmpPackingListHeader)
        {
            trigger OnAfterAfterGetRecord()
            var
                RecShipHeader: Record "Sales Shipment Header";
            begin
                RecShipHeader.SetRange("No.", "Packing List No.");
                if RecShipHeader.FindFirst() then begin
                    Header_No_CWS := 'Packing List ' + RecShipHeader."EOS Shipment No.";
                end else
                    Header_No_CWS := 'Packing List ' + "Packing List No.";
            end;
        }
        modify(TmpPackingListLine)
        {
            trigger OnAfterAfterGetRecord()
            var
                RecAssignment: Record "EOS055 Handling Unit Assignm.";
                RecSpedVenLine: Record "Sales Shipment Line";
                RecSalesHeader: Record "Sales Header";
                NrOrigine: Code[20];
                NrRigaOrigine: Integer;
            begin
                // valorizzazione variabili
                OrdineVendita := ' ';
                YourReference := ' ';
                CrossReference := ' ';
                RecAssignment.SetRange("Handling Unit No.", "Handling Unit No.");
                RecAssignment.SetRange("Item No.", "No.");
                if RecAssignment.FindFirst() then begin
                    NrOrigine := RecAssignment."Source No.";
                    NrRigaOrigine := RecAssignment."Source Line No.";
                    RecSpedVenLine.Reset();
                    RecSpedVenLine.SetRange("Document No.", NrOrigine);
                    RecSpedVenLine.SetRange("Line No.", NrRigaOrigine);
                    if RecSpedVenLine.FindFirst() then begin
                        OrdineVendita := RecSpedVenLine."Order No.";
                        RecSalesHeader.SetRange("No.", RecSpedVenLine."Order No.");
                        if RecSalesHeader.FindFirst() then begin
                            if RecSalesHeader."Your Reference" <> '' then
                                YourReference := RecSalesHeader."Your Reference";
                        end;

                        CrossReference := RecSpedVenLine."Item Reference No.";
                    end;
                end;
            end;
        }

    }
    var
        OrdineVendita: Code[20];
        YourReference: Code[35];
        CrossReference: Code[50];
        Header_No_CWS: Text[50];
        LblOrdineVendita: Label 'Order';
        LblYourReference: Label 'Your Reference';
        LblCrossReference: Label 'Cross Reference';
}
