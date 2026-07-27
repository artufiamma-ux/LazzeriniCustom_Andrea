namespace Xview.Custom.Lazzerini;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Tracking;
using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Bank.BankAccount;
using Microsoft.Sales.Customer;
using Microsoft.Warehouse.Document;


codeunit 50200 XVUtil
{
    procedure GetCustomLabel(LabelName: Text; isForeign: Boolean): Text
    var
        langLbl: Text[100];

    begin
        langLbl := LabelName;
        if isForeign then
            case LabelName of
                'sender':
                    exit('From');
                'Pie di pagina 1':
                    exit('Lazzerini S.r.l. S.B. - Capitale Sociale € 400.000,00 i.v. - N. Iscrizione Reg. Imprese Ancona C.F. e P.IVA 00091930420 - C.C.I.A.A. 58990');
                'Pie di pagina 2':
                    exit('Cod. EORI IT00091930420 - Cod. REX ITREXIT00091930420');
                'Ship Time':
                    exit('Shipment Date & Time');
                'Tariff No.':
                    exit('Tariff No.');
                'Type Payment Caption':
                    exit('Type Payment Caption');
                'Amount':
                    exit('Value');//exit('Amount');
                'VAT Base':
                    exit('VAT Base');
                else
                    exit(LabelName);
            end
        else
            case LabelName of
                'Payment Method':
                    exit('Metodo Pagamento');

                'Order No.':
                    exit('Nr. Ordine');
                'Invoice To':
                    exit('Fatturare a');
                'Notes':
                    exit('Note');
                'Total Amount':
                    exit('Totale Documento');
                'sender':
                    exit('Mittente');

                'ORDER CONFIRMATION':
                    exit('CONFERMA ORDINE');
                'VAT':
                    exit('C. IVA');
                'Delivery Date':
                    exit('Data Consegna');
                'Pie di pagina 1':
                    exit('Lazzerini S.r.l. S.B. - Capitale Sociale € 400.000,00 i.v. - N. Iscrizione Reg. Imprese Ancona C.F. e P.IVA 00091930420 - C.C.I.A.A. 58990');
                'Pie di pagina 2':
                    exit('Cod. EORI IT00091930420 - Cod. REX ITREXIT00091930420');

                'EORI Code':
                    exit('Cod. EORI');
                'VAT Amount':
                    exit('Importo IVA');
                'VAT Base':
                    exit('Imponibile');
                'Packaging':
                    exit('Aspetto esteriore dei beni');
                'Invoice No.':
                    exit('Nr. Fattura');
                'Invoice Date':
                    exit('Data Fattura');
                'Payment Terms':
                    exit('Codice e descrizione pagamento');
                'Bank':
                    exit('Banca d''appoggio');
                'Customer ID':
                    exit('Cliente ID');
                'Parc. No.':
                    exit('Nr. Colli');
                'Signature of forwarder':
                    exit('Firma del vettore');
                'Driver''s signature':
                    exit('Firma del conducente');
                'Consignee signature':
                    exit('Firma del destinatario');

                'Our Code No.':
                    exit('Codice Articolo');
                'Custom Code No.':
                    exit('Codice Cliente');
                'Description':
                    exit('Descrizione');
                'UoM':
                    exit('UdM');
                'Q.ty':
                    exit('Q.tà');
                'Unit Price':
                    exit('Prezzo Unitario');
                'VAT Id.':
                    exit('Id IVA');
                'Currency':
                    exit('Valuta');
                'Delivery':
                    exit('Destinazione Merce');
                'Delivery Terms':
                    exit('Condizioni di Consegna');
                'Freight':
                    exit('Trasporto');
                'Ship Time':
                    exit('Data e Ora di Spedizione');
                'Customer':
                    exit('Cliente');
                'Forwarder':
                    exit('Vettore');
                'Total VAT Base':
                    exit('Base IVA Totale');
                'Total VAT':
                    exit('IVA Totale');
                'Gross Weight':
                    exit('Peso Lordo');
                'Net Weight':
                    exit('Peso Netto');
                'Tariff No.':
                    exit('Numero Tariffa');
                'Type Payment Caption':
                    exit('Tipo Pagamento');
                'Amount':
                    exit('Importo');
                else
                    exit(LabelName);
            end
    end;

    procedure GetKitBusDescription(KitBus: Code[20]; Description: Text[100]): Text[120]
    var
        ItemRec: Record Item;
    begin
        if KitBus <> '' then begin
            if ItemRec.Get(KitBus) then
                Description := ItemRec.Description;
        end;
        exit(Description);
    end;

    procedure GetIsKitBus(DocType: Code[20]; DocNo: Code[20]): Boolean
    var
        SalesInvLine: Record "Sales Invoice Line";
        SalesOrderLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        DDTLine: Record "Sales Shipment Line";
    begin
        case DocType of
            'FATTURA':
                begin
                    // Filtra solo le righe con un Order No. valorizzato
                    // Il riferimento all'ordine va cercato nelle righe
                    SalesInvLine.SetRange("Document No.", DocNo);
                    SalesInvLine.SetFilter("Order No.", '<>%1', '');

                    if SalesInvLine.FindSet() then
                        repeat
                            // Lettura diretta testata ordine
                            if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesInvLine."Order No.") then
                                if SalesHeader."Ordine con kit" then
                                    exit(true);  // appena trovato → fine
                        until SalesInvLine.Next() = 0;
                end;
            'DDT':
                begin
                    // Filtra solo le righe con un Order No. valorizzato
                    // Il riferimento all'ordine va cercato nelle righe
                    DDTLine.SetRange("EOS Shipment No.", DocNo); //EOS Shipment No.
                    DDTLine.SetFilter("Order No.", '<>%1', '');

                    if DDTLine.FindSet() then
                        repeat
                            // Lettura diretta testata ordine
                            if SalesHeader.Get(SalesHeader."Document Type"::Order, DDTLine."Order No.") then
                                if SalesHeader."Ordine con kit" then
                                    exit(true);  // appena trovato → fine
                        until DDTLine.Next() = 0
                    else begin
                        DDTLine.SetRange("Document No.", DocNo); //EOS Shipment No.
                        DDTLine.SetFilter("Order No.", '<>%1', '');

                        if DDTLine.FindSet() then
                            repeat
                                // Lettura diretta testata ordine
                                if SalesHeader.Get(SalesHeader."Document Type"::Order, DDTLine."Order No.") then
                                    if SalesHeader."Ordine con kit" then
                                        exit(true);  // appena trovato → fine
                            until DDTLine.Next() = 0

                    end;
                end;
            'ORDINE':
                begin
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SetRange("No.", DocNo);
                    if SalesHeader.FindSet() then
                        repeat
                            if SalesHeader."Ordine con kit" then
                                exit(true);  // appena trovato → fine
                        until SalesHeader.Next() = 0;
                end;
        end;
        // Nessun ordine con kit
        exit(false);
    end;
    /*
        * Nr Colli
        * Peso Netto
        * Peso Lordo
        * Aspetto dei beni
    */
    procedure GetInfoPackaging(DocNo: Code[20]; var info: array[4] of Text[100])
    begin
        GetInfoPackaging(DocNo, Info, false);
    end;

    procedure GetCountry(CountryCod: Code[20]): Text[30]
    var
        Country: Record "Country/Region";
    begin
        Country.Get(CountryCod);
        exit(Country."Name");
    end;

    procedure GetInfoPackaging(DocNo: Code[20]; var info: array[4] of Text[100]; IsForeign: Boolean)
    var
        ShipInfo: Record "XV Posted Invoice Ship Info";
        NrColli: Integer;
        PesoNetto: Decimal;
        PesoLordo: Decimal;
        AspettoDeiBeni: Text[100];
    begin
        if ShipInfo.Get(DocNo) then // La prima volta la uso solo per vedere se hanno azzerato i colli per il ricalcolo
            NrColli := ShipInfo."Nr. Colli"
        else // se non esiste lo creo
            SetShipInfo(DocNo);
        if NrColli = 0 then // se i colli sono zero lo ricreo
            SetShipInfo(DocNo);
        if ShipInfo.Get(DocNo) then begin
            NrColli := ShipInfo."Nr. Colli";
            PesoNetto := ShipInfo."Peso Netto";
            PesoLordo := ShipInfo."Peso Lordo";
            AspettoDeiBeni := ShipInfo."Aspetto Beni";
        end;

        info[1] := Format(NrColli);
        info[2] := Format(PesoNetto);
        info[3] := Format(PesoLordo);
        info[4] := AspettoDeiBeni;
    end;
    /*
        Nr colli Int
        Peso Netto Dec
        Peso Lordo Dec
        BOX Text
    */
    procedure GetInfoPackagingInvoice(DocNo: Code[20]; var info: array[4] of Text[100]; IsForeign: Boolean)
    var
        RecLine: Record "Sales Invoice Line";
        SourceNos: List of [Code[20]];
    begin
        // Per le fatture, raccogliamo tutti i numeri di spedizione legati alle righe
        RecLine.Reset();
        RecLine.SetRange("Document No.", DocNo);
        RecLine.SetFilter("Shipment Line No.", '>0');
        if RecLine.FindSet() then
            repeat
                if not SourceNos.Contains(RecLine."Shipment No.") then
                    SourceNos.Add(RecLine."Shipment No.");
            until RecLine.Next() = 0;

        CalculatePackagingInfoFromSourceList(SourceNos, info, IsForeign);
    end;

    procedure GetInfoPackagingProforma(DocNo: Code[20]; var info: array[4] of Text[100]; IsForeign: Boolean)
    var
        RecProformaHeader: Record "Sales Header";
        SourceNos: List of [Code[20]];
    begin
        RecProformaHeader.SetRange("No.", DocNo);
        if RecProformaHeader.FindFirst() then begin
            if RecProformaHeader."XV Proforma Source" <> '' then
                SourceNos.Add(RecProformaHeader."XV Proforma Source");

            CalculatePackagingInfoFromSourceList(SourceNos, info, IsForeign);
        end;
    end;

    procedure GetInfoPackagingSpedizione(DocNo: Code[20]; var info: array[4] of Text[100]; IsForeign: Boolean)
    var
        SourceNos: List of [Code[20]];
    begin
        if DocNo <> '' then
            SourceNos.Add(DocNo);

        CalculatePackagingInfoFromSourceList(SourceNos, info, IsForeign);
    end;

    procedure SetShipInfo(var SalesInvoiceHeaderNo: Code[20])
    var
        info: array[4] of Text[100];
        TInt: Integer;
        TDec: Decimal;
        ShipInfo: Record "XV Posted Invoice Ship Info";
    begin
        // Nota: eliminata la dichiarazione locale del tipo XUtil: Codeunit XVUtil 
        // poiché siamo già all'interno della Codeunit stessa.
        if CopyStr(SalesInvoiceHeaderNo, 1, 4) = 'FVPF' then
            GetInfoPackagingProforma(SalesInvoiceHeaderNo, info, false)
        else if CopyStr(SalesInvoiceHeaderNo, 1, 3) = 'FV2' then
            GetInfoPackagingInvoice(SalesInvoiceHeaderNo, info, false)
        else if CopyStr(SalesInvoiceHeaderNo, 1, 4) = 'DDTP' then
            GetInfoPackagingSpedizione(SalesInvoiceHeaderNo, info, false);

        if not ShipInfo.Get(SalesInvoiceHeaderNo) then begin
            ShipInfo.Init();
            ShipInfo."Invoice No." := SalesInvoiceHeaderNo;
            if Evaluate(TInt, info[1]) then
                ShipInfo."Nr. Colli" := TInt;
            if Evaluate(TDec, info[2]) then
                ShipInfo."Peso Netto" := TDec;
            if Evaluate(TDec, info[3]) then
                ShipInfo."Peso Lordo" := TDec;
            ShipInfo."Aspetto Beni" := info[4];
            ShipInfo.Insert();
        end;
    end;


    /// <summary>
    /// Procedura generica interna che esegue il calcolo di pesi e colli 
    /// partendo da una lista di "Source No." per EOS055 Handling Unit Assignm.
    /// </summary>
    local procedure CalculatePackagingInfoFromSourceList(SourceNos: List of [Code[20]]; var info: array[4] of Text[100]; IsForeign: Boolean)
    var
        RecAssignm: Record "EOS055 Handling Unit Assignm.";
        RecInfo: Record "EOS055 Handling Unit";
        RecInfoFK: Record "EOS055 Handling Unit";
        SourceNo: Code[20];
        NrColli: Integer;
        PesoNetto: Decimal;
        PesoLordo: Decimal;
        FK: Code[20];
        WarehouseShipmentNo: Code[20];
        TmpBox: Text;
    begin
        NrColli := 0;
        PesoNetto := 0;
        PesoLordo := 0;
        TmpBox := '';
        WarehouseShipmentNo := '';

        foreach SourceNo in SourceNos do begin
            RecAssignm.Reset();
            RecAssignm.SetRange("Source No.", SourceNo);
            if RecAssignm.FindSet() then
                repeat
                    if RecInfo.Get(RecAssignm."Handling Unit No.") then begin
                        FK := RecInfo."Parent Handling Unit No.";
                        if FK = '' then begin // Scatola fuori dal pallet
                            FK := RecInfo."No.";
                            if not TmpBox.Contains(FK) then begin
                                NrColli := NrColli + 1;
                                TmpBox += ' ; ' + FK;
                                PesoNetto += RecInfo."Calc. Net Weight";
                                PesoLordo += RecInfo."Calc. Gross Weight";
                            end;
                        end else begin
                            if not TmpBox.Contains(FK) then begin
                                TmpBox += ' ; ' + FK;
                                if RecInfoFK.Get(FK) then begin
                                    PesoNetto += RecInfoFK."Calc. Net Weight";
                                    PesoLordo += RecInfoFK."Calc. Gross Weight";
                                end;
                            end;
                        end;
                    end;

                    if not TmpBox.Contains(RecInfo."No.") then begin //scatole nel pallett solo le scatole fanno collo, non conto le scatole già contate
                        NrColli += 1;
                        if RecInfo."Parent Handling Unit No." = '' then begin
                            PesoNetto += RecInfo."Calc. Net Weight";
                            PesoLordo += RecInfo."Calc. Gross Weight";
                        end;
                        if (RecInfo."Warehouse Shipment No." <> '') AND (WarehouseShipmentNo = '') then
                            WarehouseShipmentNo := RecInfo."Warehouse Shipment No.";
                        TmpBox += ' ; ' + RecInfo."No.";
                    end;
                until RecAssignm.Next() = 0;
        end;
        // Aggiungo i padestal non conteggiati
        if WarehouseShipmentNo <> '' then begin
            RecInfo.Reset();
            RecInfo.SetRange("Warehouse Shipment No.", WarehouseShipmentNo);
            Recinfo.SetFilter("Packaging Material No.", '=%1', 'PADESTAL');
            if RecInfo.FindSet() then
                repeat
                    FK := RecInfo."No.";
                    if NOT TmpBox.Contains(FK) then begin // solo le scatole fanno collo, non conto le scatole già contate
                        NrColli := NrColli + 1;
                        TmpBox += ' ; ' + FK;
                        if (RecInfo."Parent Handling Unit No." = '') then begin // se il padestal è sfuso aggiungo il peso, quello netto dovrebbe essere zero
                            PesoNetto := PesoNetto + RecInfo."Calc. Net Weight";
                            PesoLordo := PesoLordo + RecInfo."Calc. Gross Weight";
                        end;
                    end;
                until RecInfo.Next() = 0;
        end;

        info[1] := Format(NrColli);
        info[2] := Format(PesoNetto);
        info[3] := Format(PesoLordo);
        info[4] := 'BOX';
    end;

    procedure GetPostedPayments(DocNo: Code[20]; PaymentMethodCode: Code[20]; var info: array[9] of Text[100]; IsForeign: Boolean)
    var
        RecPostedPaymentLines: Record "Posted Payment Lines";
        i: Integer;
    begin
        RecPostedPaymentLines.Reset();
        RecPostedPaymentLines.SetRange("Code", DocNo);
        i := 1;
        if RecPostedPaymentLines.FindSet() then
            repeat
                info[i] := GetPaymentMethod(PaymentMethodCode, IsForeign);
                info[i + 1] := Format(RecPostedPaymentLines."Due Date", 0, '<Day,2>/<Month,2>/<Year4>');
                info[i + 2] := Format(
                                        RecPostedPaymentLines.Amount,
                                        0,
                                        '<Precision,2:2><Standard Format,0>'
                                    );
                i := i + 3;
            until RecPostedPaymentLines.Next() = 0;
    end;

    procedure GetPaymentMethodTerms(MethodCode: Code[20]; TermsCode: Code[10]; IsForeign: Boolean): Text[200]
    var
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        PaymentMethodTranslation: Record "Payment Method Translation";
        PaymentTermTranslation: Record "Payment Term Translation";

        PaymentDesc: Text[200];
        LanguageId: Code[10]; //English (United States)
    begin
        LanguageId := 'ING';
        if IsForeign then begin
            if PaymentMethodTranslation.Get(MethodCode, LanguageId) then PaymentDesc := PaymentMethodTranslation.Description;
            if PaymentTermTranslation.Get(TermsCode, LanguageId) then PaymentDesc := PaymentDesc + ' ' + PaymentTermTranslation.Description;
        end else begin
            if PaymentMethod.Get(MethodCode) then PaymentDesc := PaymentMethod.Description;
            if PaymentTerms.Get(TermsCode) then PaymentDesc := PaymentDesc + ' ' + PaymentTerms.Description;
        end;
        exit(PaymentDesc);
    end;

    procedure GetPaymentMethod(MethodCode: Code[20]; IsForeign: Boolean): Text[200]
    var
        PaymentMethod: Record "Payment Method";
        PaymentMethodTranslation: Record "Payment Method Translation";

        PaymentDesc: Text[200];
        LanguageId: Code[10]; //English (United States)
    begin
        LanguageId := 'ING';
        if IsForeign then begin
            if PaymentMethodTranslation.Get(MethodCode, LanguageId) then PaymentDesc := PaymentMethodTranslation.Description;
        end else begin
            if PaymentMethod.Get(MethodCode) then PaymentDesc := PaymentMethod.Description;
        end;
        exit(PaymentDesc);
    end;

    procedure GetPaymentTerms(TermsCode: Code[10]; IsForeign: Boolean): Text[200]
    var
        PaymentTerms: Record "Payment Terms";
        PaymentMethodTranslation: Record "Payment Method Translation";
        PaymentTermTranslation: Record "Payment Term Translation";

        PaymentDesc: Text[200];
        LanguageId: Code[10]; //English (United States)
    begin
        LanguageId := 'ING';
        if IsForeign then begin
            if PaymentTermTranslation.Get(TermsCode, LanguageId) then PaymentDesc := PaymentTermTranslation.Description;
        end else begin
            if PaymentTerms.Get(TermsCode) then PaymentDesc := PaymentTerms.Description;
        end;
        exit(PaymentDesc);
    end;

    procedure GetInfoCustomerByShipment(WarehouseShipmentNo: Code[20]; var info: array[5] of Text[100])
    var
        RecShipmentLine: Record "Warehouse Shipment Line";// "Sales Shipment Line";
        RecSalesHeader: Record "Sales Header";
        RecAddress: Record "Ship-to Address";
    begin
        RecShipmentLine.Reset();
        RecShipmentLine.SetRange("No.", WarehouseShipmentNo);
        if RecShipmentLine.FindSet() then
            repeat
                if RecSalesHeader.Get(RecSalesHeader."Document Type"::Order, RecShipmentLine."Source No.") then begin
                    info[1] := RecSalesHeader."Your Reference";
                    info[2] := RecSalesHeader."Ship-to Name" + ' ' + RecSalesHeader."Ship-to Name 2";
                    info[3] := RecSalesHeader."Ship-to Address" + ' ' + RecSalesHeader."Ship-to Address 2";
                    info[4] := RecSalesHeader."Ship-to City" + '(' + RecSalesHeader."Ship-to Country/Region Code" + ') ';
                    info[5] := RecSalesHeader."No.";
                end;
            until RecShipmentLine.Next() = 0;
    end;

    procedure GetPosizioneLayout(ItemNo: Code[20]; OrderNo: Code[20]): Code[20]
    var
        SalesLine: Record "Sales Line";
    begin
        if (OrderNo = '') OR (ItemNo = '') then
            exit('');
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", OrderNo);
        SalesLine.SetRange("No.", ItemNo);
        if SalesLine.FindFirst() then
            exit(SalesLine."xv Posizione Layout");
        exit('');
    end;

    procedure GetItemReference(ItemNo: Code[20]; OrderNo: Code[20]): Code[20]
    var
        SalesLine: Record "Sales Line";
    begin
        if (OrderNo = '') OR (ItemNo = '') then
            exit('');
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", OrderNo);
        SalesLine.SetRange("No.", ItemNo);
        if SalesLine.FindFirst() then
            exit(SalesLine."Item Reference No.");
        exit('');
    end;

}

