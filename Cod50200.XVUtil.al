namespace Lazzerini;
using Microsoft.Inventory.Item;
using Microsoft.Sales.History;
using Microsoft.Sales.Document;

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

}
