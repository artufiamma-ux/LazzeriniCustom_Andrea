namespace Xview.Custom.Lazzerini;
using System.Utilities;
using System.Text;

codeunit 50201 "XV PrintNode"
{
    var
        ApiKeyBarcode: Text[100];
        UrlPrintNode: Text[100];

    procedure SetApiKeyBarcode()
    begin
        ApiKeyBarcode := 'YLYYFR_jFppWy-PUJdYpWD0UWK5mas2pynourI3ZAnU';
        UrlPrintNode := 'https://api.printnode.com/printjobs';
    end;

    procedure PrintColliSpedizione(WarehouseShipmentNo: Code[20])
    var
        ReportObj: Report "XV Colli Di Spedizione";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;

        Base64Convert: Codeunit "Base64 Convert";
        PdfBase64: Text;

        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        Response: HttpResponseMessage;

        JsonObj: JsonObject;
        JsonText: Text;

        AuthString: Text;
        AuthBase64: Text;
    begin
        SetApiKeyBarcode();
        Clear(JsonObj);

        // ✅ 1. Genera PDF in memoria
        TempBlob.CreateOutStream(OutStr);

        ReportObj.SetWarehouseShipmentNo(WarehouseShipmentNo);
        ReportObj.SaveAs('', ReportFormat::Pdf, OutStr);

        // ✅ 2. Converti in Base64
        TempBlob.CreateInStream(InStr);
        PdfBase64 := Base64Convert.ToBase64(InStr);
        Message('Base64 length: %1', StrLen(PdfBase64));
        // ✅ 3. Costruisci JSON

        JsonObj.Add('printerId', 75481733);
        JsonObj.Add('title', StrSubstNo('Colli Spedizione %1', WarehouseShipmentNo));
        JsonObj.Add('contentType', 'pdf_base64');
        JsonObj.Add('content', PdfBase64);

        JsonObj.WriteTo(JsonText);
        Message('JSON length: %1', StrLen(JsonText));

        // ✅ 4. HTTP Content
        HttpContent.WriteFrom(JsonText);
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Clear();
        HttpHeaders.Add('Content-Type', 'application/json');

        // ✅ 5. Basic Auth (API Key)
        AuthString := ApiKeyBarcode + ':'; // password vuota
        AuthBase64 := Base64Convert.ToBase64(AuthString);

        HttpClient.DefaultRequestHeaders().Clear();
        HttpClient.DefaultRequestHeaders().Add('Authorization', 'Basic ' + AuthBase64);

        // ✅ 6. POST verso PrintNode
        if not HttpClient.Post(UrlPrintNode, HttpContent, Response) then
            Error('Errore chiamata HTTP %1', Response.ReasonPhrase);

        if not Response.IsSuccessStatusCode() then
            Error('Errore PrintNode: %1 %2',
                Response.HttpStatusCode(),
                Response.ReasonPhrase());
    end;
}