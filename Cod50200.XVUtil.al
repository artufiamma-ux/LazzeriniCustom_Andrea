namespace Lazzerini;
using Microsoft.Inventory.Item;
using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.PaymentTerms;
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
                    exit('Amount');
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
                'VATId.':
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
                    DDTLine.SetRange("Document No.", DocNo);
                    DDTLine.SetFilter("Order No.", '<>%1', '');

                    if DDTLine.FindSet() then
                        repeat
                            // Lettura diretta testata ordine
                            if SalesHeader.Get(SalesHeader."Document Type"::Order, DDTLine."Order No.") then
                                if SalesHeader."Ordine con kit" then
                                    exit(true);  // appena trovato → fine
                        until DDTLine.Next() = 0;
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
        RecAssignm: Record "EOS055 Handling Unit Assignm.";//70491906
        RecInfo: Record "EOS055 Handling Unit"; // scatola
        RecInfoFK: Record "EOS055 Handling Unit"; //pallet
        NrColli: Integer;
        PesoNetto: Decimal;
        PesoLordo: Decimal;
        AspettoDeiBeni: Text[100];
        AspettoDeiBeniFK: Text[100];
        FK: Code[20];
        TmpFK: Text[100];
        TmpAspetto: Text[100];
    begin
        NrColli := 0;
        PesoNetto := 0;
        PesoLordo := 0;
        AspettoDeiBeniFK := '';
        AspettoDeiBeni := '';
        RecAssignm.Reset();
        RecAssignm.SetRange("Source No.", DocNo);
        if RecAssignm.FindSet() then
            repeat
                if RecInfo.Get(RecAssignm."Handling Unit No.") then begin
                    FK := RecInfo."Parent Handling Unit No.";
                    if NOT TmpFK.Contains(FK) then begin
                        TmpFK := TmpFK + ', ' + FK;
                        if RecInfoFK.Get(FK) then begin
                            PesoNetto := PesoNetto + RecInfoFK."Calc. Net Weight";
                            PesoLordo := PesoLordo + RecInfoFK."Calc. Gross Weight";
                            TmpAspetto := RecInfoFK."HU Type Code";
                            if AspettoDeiBeniFK = '' then
                                AspettoDeiBeniFK := 'PALLET'
                            else if IsForeign then
                                AspettoDeiBeniFK := 'PALLETS'
                        end;
                    end;
                    NrColli := NrColli + 1;
                    PesoNetto := PesoNetto + RecInfo."Calc. Net Weight";
                    PesoLordo := PesoLordo + RecInfo."Calc. Gross Weight";
                    TmpAspetto := RecInfo."HU Type Code";
                    if AspettoDeiBeni = '' then
                        if IsForeign then
                            AspettoDeiBeni := 'BOX'
                        else
                            AspettoDeiBeni := 'SCATOLA'
                    else if IsForeign then
                        AspettoDeiBeni := 'BOXES'
                    else
                        AspettoDeiBeni := 'SCATOLE'

                end;
            until RecAssignm.Next() = 0;
        info[1] := Format(NrColli);
        info[2] := Format(PesoNetto);
        info[3] := Format(PesoLordo);
        info[4] := 'BOX';
        /* DA ATTIVARE QUANDO VORRANNO UNA DESCRIZIONE PUNTUALE
        if AspettoDeiBeniFK = '' then
            info[4] := AspettoDeiBeni
        else if IsForeign then
            info[4] := AspettoDeiBeniFK + ' AND ' + AspettoDeiBeni
        else
            info[4] := AspettoDeiBeniFK + ' E ' + AspettoDeiBeni
        */

    end;
    /*
        Nr colli Int
        Peso Netto Dec
        Peso Lordo Dec
        BOX Text
    */
    procedure GetInfoPackagingInvoice(DocNo: Code[20]; var info: array[4] of Text[100]; IsForeign: Boolean)
    var
        RecAssignm: Record "EOS055 Handling Unit Assignm.";//70491906
        RecInfo: Record "EOS055 Handling Unit"; // scatola
        RecInfoFK: Record "EOS055 Handling Unit"; //pallet
        RecSalesInvoiceHeader: Record "Sales Invoice Header";
        RecSalesInvoiceLine: Record "Sales Invoice Line";
        //       RecSalesShipmentLine : Record "Sales Shipment Line";
        ShipNo: Code[20];
        ShipLine: Integer;

        NrColli: Integer;
        PesoNetto: Decimal;
        PesoLordo: Decimal;
        AspettoDeiBeni: Text[100];
        AspettoDeiBeniFK: Text[100];
        FK: Code[20];
        TmpFK: Text[100];
        TmpAspetto: Text[100];
    begin
        NrColli := 0;
        PesoNetto := 0;
        PesoLordo := 0;
        AspettoDeiBeniFK := '';
        AspettoDeiBeni := '';
        RecSalesInvoiceLine.Reset();
        RecSalesInvoiceLine.SetRange("Document No.", DocNo);
        RecSalesInvoiceLine.SetFilter("Shipment Line No.", '>0');
        if RecSalesInvoiceLine.FindSet() then
            repeat
                RecAssignm.Reset();
                RecAssignm.SetRange("Source No.", RecSalesInvoiceLine."Shipment No.");
                RecAssignm.SetRange("Source Line No.", RecSalesInvoiceLine."Shipment Line No.");
                if RecAssignm.FindSet() then
                    repeat
                        if RecInfo.Get(RecAssignm."Handling Unit No.") then begin
                            FK := RecInfo."Parent Handling Unit No.";
                            if NOT TmpFK.Contains(FK) then begin
                                TmpFK := TmpFK + ', ' + FK;
                                if RecInfoFK.Get(FK) then begin
                                    PesoNetto := PesoNetto + RecInfoFK."Calc. Net Weight";
                                    PesoLordo := PesoLordo + RecInfoFK."Calc. Gross Weight";
                                    TmpAspetto := RecInfoFK."HU Type Code";
                                    if AspettoDeiBeniFK = '' then
                                        AspettoDeiBeniFK := 'PALLET'
                                    else if IsForeign then
                                        AspettoDeiBeniFK := 'PALLETS'
                                end;
                            end;
                        end;
                        NrColli := NrColli + 1;
                        PesoNetto := PesoNetto + RecInfo."Calc. Net Weight";
                        PesoLordo := PesoLordo + RecInfo."Calc. Gross Weight";
                        TmpAspetto := RecInfo."HU Type Code";
                        if AspettoDeiBeni = '' then
                            if IsForeign then
                                AspettoDeiBeni := 'BOX'
                            else
                                AspettoDeiBeni := 'SCATOLA'
                        else if IsForeign then
                            AspettoDeiBeni := 'BOXES'
                        else
                            AspettoDeiBeni := 'SCATOLE'

                until RecAssignm.Next() = 0;

            until RecSalesInvoiceLine.Next() = 0;
        info[1] := Format(NrColli);
        info[2] := Format(PesoNetto);
        info[3] := Format(PesoLordo);
        info[4] := 'BOX';
        /* DA ATTIVARE QUANDO VORRANNO UNA DESCRIZIONE PUNTUALE
        if AspettoDeiBeniFK = '' then
            info[4] := AspettoDeiBeni
        else if IsForeign then
            info[4] := AspettoDeiBeniFK + ' AND ' + AspettoDeiBeni
        else
            info[4] := AspettoDeiBeniFK + ' E ' + AspettoDeiBeni
        */

    end;

    procedure SetShipInfo(var SalesInvoiceHeaderNo: Code[20])
    var
        XUtil: Codeunit XVUtil;
        info: array[4] of Text[100];
        TInt: Integer;
        TDec: Decimal;
        ShipInfo: Record "XV Posted Invoice Ship Info";
    begin
        XUtil.GetInfoPackagingInvoice(SalesInvoiceHeaderNo, info, false);


        if not ShipInfo.Get(SalesInvoiceHeaderNo) then begin
            ShipInfo.Init();
            ShipInfo."Invoice No." := SalesInvoiceHeaderNo;
            if (Evaluate(TInt, info[1])) then
                ShipInfo."Nr. Colli" := TInt;
            if (Evaluate(TDec, info[2])) then
                ShipInfo."Peso Netto" := TDec;
            if (Evaluate(TDec, info[3])) then
                ShipInfo."Peso Lordo" := TDec;
            ShipInfo."Aspetto Beni" := info[4];
            ShipInfo.Insert();
        end;

    end;

    procedure GetPostedPayments(DocNo: Code[20]; PaymentMethod: Text[100]; var info: array[9] of Text[100])
    var
        RecPostedPaymentLines: Record "Posted Payment Lines";
        i: Integer;
    begin
        RecPostedPaymentLines.Reset();
        RecPostedPaymentLines.SetRange("Code", DocNo);
        i := 1;
        if RecPostedPaymentLines.FindSet() then
            repeat
                info[i] := PaymentMethod;
                info[i + 1] := Format(RecPostedPaymentLines."Due Date", 0, '<Day,2>/<Month,2>/<Year4>');
                info[i + 2] := Format(
                                        RecPostedPaymentLines.Amount,
                                        0,
                                        '<Precision,2:2><Standard Format,0>'
                                    );
                i := i + 3;
            until RecPostedPaymentLines.Next() = 0;
    end;
}

