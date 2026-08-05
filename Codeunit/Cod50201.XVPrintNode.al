namespace Xview.Custom.Lazzerini;
using System.Utilities;
using System.Text;

codeunit 50201 "XV PrintNode Mgt"
{
    /*
            ApiKey: Text;
            PrintNode_Url: Text;
        begin
            PrintNode_Url := 'https://api.printnode.com/printjobs';
            IsolatedStorage.Get('PRINTNODE_APIKEY', ApiKey);
    */
    procedure GetImplementation(
        ReportType: Enum "XV PrintNode Report")
        Implementation: Interface "XV PrintNode Report"
    var
        R1: Codeunit "XV PN Colli Di Spedizione";
        R2: Codeunit "XV PN Colli Carico";
        R3: Codeunit "XV PN Etichetta Ricambi";
        R4: Codeunit "XV PN WCP Label";
        R5: Codeunit "XV PN Etichette Ricambi Client";

    begin
        case ReportType of

            ReportType::"XV Colli Di Spedizione":
                Implementation := R1;

            ReportType::"XV Colli Carico":
                Implementation := R2;

            ReportType::"XV Etichetta Ricambi":
                Implementation := R3;

            ReportType::"XV WCP Label":
                Implementation := R4;

            ReportType::"XV Etichette Ricambi Cliente":
                Implementation := R4;

            else
                Error(
                    'Implementazione non trovata per %1',
                    Format(ReportType));
        end;
    end;


    procedure PrintReport(
        ReportType: Enum "XV PrintNode Report";
        ParamInit: Text)
    var
        PrintNodeConfig: Record "XV PrintNode Config";

        PrintNodeReport: Interface "XV PrintNode Report";

        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";

        OutStr: OutStream;
        InStr: InStream;

        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        Response: HttpResponseMessage;

        JsonObj: JsonObject;
        JsonText: Text;

        ApiKey: Text;
        AuthString: SecretText;
        AuthBase64: Text;
        PdfBase64: Text;
    begin
        // Recupero configurazione

        if not PrintNodeConfig.Get(ReportType) then
            Error(
                'Configurazione PrintNode non trovata per il report %1.',
                Format(ReportType));

        if not PrintNodeConfig.Enabled then
            Error(
                'La configurazione PrintNode per il report %1 è disabilitata.',
                Format(ReportType));

        // Generazione PDF

        PrintNodeReport :=
            GetImplementation(ReportType);

        TempBlob.CreateOutStream(OutStr);

        PrintNodeReport.GeneratePdf(
            ParamInit,
            OutStr);

        TempBlob.CreateInStream(InStr);

        PdfBase64 := Base64Convert.ToBase64(InStr);

        // Costruzione JSON PrintNode

        Clear(JsonObj);

        JsonObj.Add(
            'printerId',
            PrintNodeConfig."Printer Id");

        JsonObj.Add(
            'title',
            PrintNodeConfig."Job Title");

        JsonObj.Add(
            'contentType',
            'pdf_base64');

        JsonObj.Add(
            'content',
            PdfBase64);

        JsonObj.WriteTo(JsonText);

        // HTTP Content

        HttpContent.WriteFrom(JsonText);

        HttpContent.GetHeaders(HttpHeaders);

        HttpHeaders.Clear();
        HttpHeaders.Add(
            'Content-Type',
            'application/json');

        // Authentication

        ApiKey := GetApiKey();

        AuthString := SecretStrSubstNo(
            '%1:',
            ApiKey);

        AuthBase64 := Base64Convert.ToBase64(ApiKey + ':');

        HttpClient.DefaultRequestHeaders().Clear();

        HttpClient.DefaultRequestHeaders().Add(
            'Authorization',
            'Basic ' + AuthBase64);

        // Chiamata PrintNode

        if not HttpClient.Post(
            GetPrintNodeUrl(),
            HttpContent,
            Response)
        then
            Error(
                'Errore durante la chiamata HTTP a PrintNode.');

        if not Response.IsSuccessStatusCode() then
            Error(
                'PrintNode ha restituito errore %1 - %2',
                Response.HttpStatusCode(),
                Response.ReasonPhrase());
    end;

    procedure GetApiKey() ApiKey: Text
    begin
        if not IsolatedStorage.Get(
            'PRINTNODE_APIKEY',
            ApiKey)
        then
            Error(
                'PrintNode API Key non configurata.');
    end;

    procedure SaveApiKey(ApiKey: Text)
    begin
        IsolatedStorage.Set(
            'PRINTNODE_APIKEY',
            ApiKey);
    end;

    local procedure GetPrintNodeUrl(): Text
    begin
        Exit('https://api.printnode.com/printjobs');
    end;

}