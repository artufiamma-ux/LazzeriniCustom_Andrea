namespace Xview.Custom.Lazzerini;

codeunit 50254 "XV PN WCP Label" implements "XV PrintNode Report"
{

    procedure GeneratePdf(
        ParamInit: Text;
        var OutStr: OutStream)
    var
        ReportObj: Report "XV WCP Label";
    begin
        ReportObj.SetInitParameter(ParamInit);
        ReportObj.SaveAs('', ReportFormat::Pdf, OutStr);
    end;

}