namespace Xview.Custom.Lazzerini;

codeunit 50252 "XV PN Colli Carico" implements "XV PrintNode Report"
{

    procedure GeneratePdf(
        ParamInit: Text;
        var OutStr: OutStream)
    var
        ReportObj: Report "XV Colli Carico";
    begin
        ReportObj.SetInitParameter(ParamInit);
        ReportObj.SaveAs('', ReportFormat::Pdf, OutStr);
    end;

}