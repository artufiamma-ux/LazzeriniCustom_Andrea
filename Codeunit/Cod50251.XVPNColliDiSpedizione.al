namespace Xview.Custom.Lazzerini;

codeunit 50251 "XV PN Colli Di Spedizione" implements "XV PrintNode Report"
{

    procedure GeneratePdf(
        ParamInit: Text;
        var OutStr: OutStream)
    var
        ReportObj: Report "XV Colli Di Spedizione";
    begin
        ReportObj.SetInitParameter(ParamInit);
        ReportObj.SaveAs('', ReportFormat::Pdf, OutStr);
    end;

}
