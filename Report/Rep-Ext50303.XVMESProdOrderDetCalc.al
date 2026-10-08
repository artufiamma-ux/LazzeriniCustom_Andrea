namespace Xview.Custom.Lazzerini;

using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Routing;
using Microsoft.Sales.Document;
using System.Text;

reportextension 50303 "XV MES ProdOrderDetCalc Ext" extends "EOS 07000 MES ProdOrderDetCalc"
{
    RDLCLayout = './ReportLayouts/XVProdOrderDetailedCalc.rdlc';

    dataset
    {
        add("Production Order")
        {
            column(Barcode_ProdOrder; BarcodeProdOrderTxt) { }
            column(RifOrdVendita_ProdOrder; RifOrdVendita_ProdOrderTxt) { }
            column(NrLayout_ProdOrder; NrLayout_ProdOrderTxt) { }
            column(PosizioneLayout_ProdOrder; PosizioneLayout_ProdOrderTxt) { }
            column(Fase_ProdOrder; Fase_ProdOrderTxt) { }
        }

        add("Prod. Order Component")
        {
            column(UnitOfMeasure_ProdOrderComp; "Unit of Measure Code") { }
        }

        modify("Production Order")
        {
            trigger OnAfterAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface System.Text."Barcode Font Provider";
            begin
                RifOrdVendita_ProdOrderTxt := GetRifOrdVendita("No.");
                NrLayout_ProdOrderTxt := GetNrLayout("No.");
                PosizioneLayout_ProdOrderTxt := GetPosizioneLayout("No.");
                Fase_ProdOrderTxt := GetFaseDescription("No.");
                BarcodeFontTxt := 'IDAutomationHC39M';

                Clear(BarcodeProdOrderTxt);
                BarcodeString := "No.";
                if BarcodeString = '' then
                    exit;

                BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                BarcodeProdOrderTxt := '*' + BarcodeString + '*';
            end;
        }
    }

    var
        ProductionOrder: Record "Production Order";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        StandardTask: Record "Standard Task";
        BarcodeProdOrderTxt: Text;
        BarcodeFontTxt: Text;
        RifOrdVendita_ProdOrderTxt: Text;
        NrLayout_ProdOrderTxt: Text;
        PosizioneLayout_ProdOrderTxt: Text;
        Fase_ProdOrderTxt: Text;

    local procedure GetRifOrdVendita(ItemNo: Code[20]): Text[50]
    begin
        if TryGetProductionOrder(ItemNo) then
            exit(ProductionOrder."Rif. Ord. Vendita");

        exit('');
    end;

    local procedure GetNrLayout(ItemNo: Code[20]): Text[50]
    var
        OrderNo: Code[20];
    begin
        if not TryGetProductionOrder(ItemNo) then
            exit('');

        OrderNo := ProductionOrder."Nr. Ordine di vendita";
        if OrderNo = '' then
            OrderNo := ProductionOrder."Rif. Ord. Vendita";

        if OrderNo = '' then
            exit('');

        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("No.", OrderNo);
        if SalesHeader.FindFirst() then
            exit(SalesHeader."Nr Layout");

        exit('');
    end;

    local procedure GetPosizioneLayout(ItemNo: Code[20]): Text[50]
    var
        OrderNo: Code[20];
    begin
        if not TryGetProductionOrder(ItemNo) then
            exit('');

        if ProductionOrder."Posizione Layout" <> '' then
            exit(ProductionOrder."Posizione Layout");

        OrderNo := ProductionOrder."Nr. Ordine di vendita";
        if OrderNo = '' then
            OrderNo := ProductionOrder."Rif. Ord. Vendita";

        if (OrderNo <> '') and (ItemNo <> '') then begin
            SalesLine.Reset();
            SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
            SalesLine.SetRange("Document No.", OrderNo);
            SalesLine.SetRange(Type, SalesLine.Type::Item);
            SalesLine.SetRange("No.", ItemNo);
            if SalesLine.FindFirst() then
                exit(SalesLine."xv Posizione Layout");
        end;

        exit('');
    end;

    local procedure GetFaseDescription(OrderNo: Code[20]): Text[100]
    begin
        if OrderNo = '' then
            exit('');

        ProdOrderRoutingLine.Reset();
        ProdOrderRoutingLine.SetRange("Prod. Order No.", OrderNo);
        if ProdOrderRoutingLine.FindFirst() then
            exit(GetStandardTaskDescription(ProdOrderRoutingLine."Standard Task Code"));

        exit('');
    end;

    local procedure GetStandardTaskDescription(StandardTaskCode: Code[10]): Text[100]
    begin
        if StandardTaskCode = '' then
            exit('');

        StandardTask.Reset();
        if StandardTask.Get(StandardTaskCode) then
            exit(StandardTask.Description);

        exit('');
    end;

    local procedure TryGetProductionOrder(ItemNo: Code[20]): Boolean
    begin
        Clear(ProductionOrder);

        if ItemNo = '' then
            exit(false);

        ProductionOrder.Reset();
        ProductionOrder.SetRange("No.", ItemNo);
        if ProductionOrder.FindFirst() then
            exit(true);

        ProductionOrder.Reset();
        ProductionOrder.SetRange("Source No.", ItemNo);
        if ProductionOrder.FindFirst() then
            exit(true);

        exit(false);
    end;
}