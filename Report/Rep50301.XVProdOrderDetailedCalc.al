namespace Xview.Custom.Lazzerini;

using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Routing;
using Microsoft.Sales.Document;
using System.Text;

report 50301 "XV Prod. Order Dtl Calc."
{
    RDLCLayout = './ReportLayouts/XVProdOrderDetailedCalc.rdlc';

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ProdOrderTableCaptionFilter; ProdOrderTableCaptionFilterTxt) { }
            column(Barcode_ProdOrder; BarcodeProdOrderTxt) { }
            column(Barcode_Font; BarcodeFontTxt) { }
            column(No_ProdOrder; "No.") { }
            column(Desc_ProdOrder; Description) { }
            column(SourceNo_ProdOrder; "Source No.") { }
            column(Qty_ProdOrder; Quantity) { }
            column(ProdOrderDetailedCalcCaption; ProdOrderDetailedCalcCaptionTxt) { }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionTxt) { }
            column(CompanyName; CompanyNameTxt) { }
            column(TodayFormatted; TodayFormattedTxt) { }
            column(ProdOrderFilter; ProdOrderFilterTxt) { }
            column(ShowBarcode; ShowBarcodeBool) { }
            column(IsFunctionAPI; IsFunctionAPIBool) { }
            column(ISQRCode; ISQRCodeBool) { }
            column(TotalMaterialCostCaption; TotalMaterialCostCaptionTxt) { }
            column(TotalProductionCostCaption; TotalProductionCostCaptionTxt) { }
            column(TotalProdCostCaption; TotalProdCostCaptionTxt) { }
            column(TotalMterlCostCaption; TotalMterlCostCaptionTxt) { }
            column(TotalCostCaption; TotalCostCaptionTxt) { }
            column(RifOrdVendita_ProdOrder; Format(GetRifOrdVendita("No."))) { }
            column(NrLayout_ProdOrder; Format(GetNrLayout("No."))) { }
            column(PosizioneLayout_ProdOrder; Format(GetPosizioneLayout("No."))) { }
            column(Fase_ProdOrder; GetFaseDescription("No.")) { }
            column(ProdOrderCompOPCostAmtFormat; ProdOrderCompOPCostAmtFormatTxt) { }

            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLink = "Prod. Order No." = field("No.");
                DataItemLinkReference = "Production Order";
                column(LineNo_ProdOrderLine; "Line No.") { }
                column(ItemNo; "Item No.") { }
                column(Item_Description; Description) { }
            }

            dataitem("Prod. Order Routing Line"; "Prod. Order Routing Line")
            {
                DataItemLink = "Prod. Order No." = field("No.");
                DataItemLinkReference = "Production Order";
                column(OPNo_ProdOrderRtngLineCaption; OPNo_ProdOrderRtngLineCaptionTxt) { }
                column(OPNo_ProdOrderRtngLine; "Operation No.") { }
                column(No_ProdOrderRtngLine; "No.") { }
                column(Desc_ProdOrderRtngLine; Description) { }
                column(InputQty_ProdOrderRtngLine; "Input Quantity") { }
                column(ExpecOPCostAmt_ProdOrderRtngLine; "Expected Operation Cost Amt.") { }
                column(Barcode_ProdOrderRtngLine; Barcode_ProdOrderRtngLineTxt) { }
                column(Barcode_Image_ProdOrderRtngLine; Barcode_Image_ProdOrderRtngLineTxt) { }
            }

            dataitem("Prod. Order Component"; "Prod. Order Component")
            {
                DataItemLink = "Prod. Order No." = field("No.");
                DataItemLinkReference = "Production Order";
                column(ItemNo_ProdOrderCompCaption; ItemNo_ProdOrderCompCaptionTxt) { }
                column(ItemNo_ProdOrderComp; "Item No.") { }
                column(Desc_ProdOrderCompCaption; Desc_ProdOrderCompCaptionTxt) { }
                column(Desc_ProdOrderComp; Description) { }
                column(ExpectedQty_ProdOrderCompCaption; ExpectedQty_ProdOrderCompCaptionTxt) { }
                column(ExpectedQty_ProdOrderComp; Quantity) { }
                column(UnitOfMeasure_ProdOrderComp; "Unit of Measure Code") { }
                column(UnitCost_ProdOrderComp; "Unit Cost") { }
                column(CostAmt_ProdOrderComp; "Cost Amount") { }
            }

            trigger OnAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface System.Text."Barcode Font Provider";
            begin
                ProdOrderTableCaptionFilterTxt := TableCaption();
                ProdOrderFilterTxt := GetFilters();
                CompanyNameTxt := CompanyName();
                TodayFormattedTxt := Format(Today, 0, 9);
                ProdOrderDetailedCalcCaptionTxt := ProdOrderDetailedCalcCaptionLbl;
                CurrReportPageNoCaptionTxt := CurrReportPageNoCaptionLbl;
                TotalMaterialCostCaptionTxt := TotalMaterialCostCaptionLbl;
                TotalProductionCostCaptionTxt := TotalProductionCostCaptionLbl;
                TotalProdCostCaptionTxt := TotalProdCostCaptionLbl;
                TotalMterlCostCaptionTxt := TotalMterlCostCaptionLbl;
                TotalCostCaptionTxt := TotalCostCaptionLbl;
                Fase_ProdOrderCaptionTxt := Fase_ProdOrderCaptionLbl;
                ShowBarcodeBool := true;
                IsFunctionAPIBool := false;
                ISQRCodeBool := false;
                BarcodeFontTxt := 'IDAutomationHC39M';
                ProdOrderCompOPCostAmtFormatTxt := '#,##0.00';

                Clear(BarcodeProdOrderTxt);
                BarcodeString := "No.";
                if BarcodeString = '' then
                    exit;

                BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                BarcodeProdOrderTxt := '*' + BarcodeString + '*';
            end;

            trigger OnPreDataItem()
            begin
                if SelectedProductionOrderNo <> '' then
                    SetRange("No.", SelectedProductionOrderNo);
            end;
        }
    }

    var
        ProductionOrder: Record "Production Order";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        StandardTask: Record "Standard Task";
        SelectedProductionOrderNo: Code[20];
        ProdOrderTableCaptionFilterTxt: Text;
        BarcodeProdOrderTxt: Text;
        BarcodeFontTxt: Text;
        CompanyNameTxt: Text;
        TodayFormattedTxt: Text;
        ProdOrderFilterTxt: Text;
        ShowBarcodeBool: Boolean;
        IsFunctionAPIBool: Boolean;
        ISQRCodeBool: Boolean;
        TotalMaterialCostCaptionTxt: Text;
        TotalProductionCostCaptionTxt: Text;
        TotalProdCostCaptionTxt: Text;
        TotalMterlCostCaptionTxt: Text;
        TotalCostCaptionTxt: Text;
        ProdOrderDetailedCalcCaptionTxt: Text;
        CurrReportPageNoCaptionTxt: Text;
        ProdOrderCompOPCostAmtFormatTxt: Text;
        Fase_ProdOrderCaptionTxt: Text;
        OPNo_ProdOrderRtngLineCaptionTxt: Text;
        ItemNo_ProdOrderCompCaptionTxt: Text;
        Desc_ProdOrderCompCaptionTxt: Text;
        ExpectedQty_ProdOrderCompCaptionTxt: Text;
        Qty_ProdOrderCaption: Label 'Qty.';
        No_ProdOrderRtngLineCaption: Label 'No.';
        Desc_ProdOrderRtngLineCaption: Label 'Description';
        InputQty_ProdOrderRtngLineCaption: Label 'Input Qty.';
        ExpecOPCostAmt_ProdOrderRtngLineCaption: Label 'Expected OP Cost Amt.';
        ItemNoCaption: Label 'Item No.';
        Desc_ProdOrderCompCaption: Label 'Description';
        ExpectedQty_ProdOrderCompCaption: Label 'Expected Qty.';
        UnitCost_ProdOrderCompCaption: Label 'Unit Cost';
        CostAmt_ProdOrderCompCaption: Label 'Cost Amt.';
        ProdOrderDetailedCalcCaptionLbl: Label 'Prod. Order - Detailed Calc.';
        CurrReportPageNoCaptionLbl: Label 'Page';
        TotalMaterialCostCaptionLbl: Label 'Total Material Cost';
        TotalProductionCostCaptionLbl: Label 'Total Production Cost';
        TotalProdCostCaptionLbl: Label 'Total Prod Cost';
        TotalMterlCostCaptionLbl: Label 'Total Material Cost';
        TotalCostCaptionLbl: Label 'Total Cost';
        Fase_ProdOrderCaptionLbl: Label 'Fase';
        Barcode_ProdOrderRtngLineTxt: Text;
        Barcode_Image_ProdOrderRtngLineTxt: Text;

    procedure SetSelectedProductionOrderNo(OrderNo: Code[20])
    begin
        SelectedProductionOrderNo := OrderNo;
    end;

    local procedure GetRifOrdVendita(ItemNo: Code[20]): Code[20]
    begin
        if TryGetProductionOrder(ItemNo) then
            exit(ProductionOrder."Rif. Ord. Vendita");

        exit('');
    end;

    local procedure GetNrLayout(ItemNo: Code[20]): Code[20]
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

    local procedure GetPosizioneLayout(ItemNo: Code[20]): Code[20]
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

        if ProductionOrder.Get(ItemNo) then
            exit(true);

        ProductionOrder.Reset();
        ProductionOrder.SetRange("Source No.", ItemNo);
        if ProductionOrder.FindFirst() then
            exit(true);

        exit(false);
    end;
}
