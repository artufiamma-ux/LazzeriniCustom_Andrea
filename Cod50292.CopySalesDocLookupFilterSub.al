namespace Lazzerini;
using Microsoft.Sales.Document;


codeunit 50292 CopySalesDocLookupFilterSub
{
    Subtype = Normal;

    // Just-in-time: prima della PAGE.RunModal per la lista di selezione
    [EventSubscriber(ObjectType::Report, Report::"Copy Sales Document", 'OnLookupSalesDocOnBeforeRunLookup', '', true, true)]
    local procedure OnLookupSalesDocOnBeforeRunLookup(
        var FromSalesHeader: Record "Sales Header";
        var SalesHeader: Record "Sales Header";
        SalesDocumentTypeFrom: Enum "Sales Document Type From")
    begin
        // Applica SOLO per Ordine (rimuovi la guardia se vuoi per tutti)
        if SalesDocumentTypeFrom <> SalesDocumentTypeFrom::Order then
            exit;

        // Alcune routine usano FilterGroup 2 per isolare filtri “di sistema” nella lookup:
        FromSalesHeader.FilterGroup(2);
        FromSalesHeader.SetRange("Non duplicabile", false);
        FromSalesHeader.FilterGroup(0); // ripristina
    end;

    // (Consigliato) mantieni anche il filtro “anticipato” su OnBeforeLookupDocNo.
    [EventSubscriber(ObjectType::Report, Report::"Copy Sales Document", 'OnBeforeLookupDocNo', '', true, true)]
    local procedure OnBeforeLookupDocNo(
        var SalesHeader: Record "Sales Header";
        FromDocType: Enum "Sales Document Type From";
        var FromDocNo: Code[20])
    begin
        if FromDocType = FromDocType::Order then
            SalesHeader.SetRange("Non duplicabile", false);
    end;
}
