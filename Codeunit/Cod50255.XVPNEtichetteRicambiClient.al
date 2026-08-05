namespace Xview.Custom.Lazzerini;

codeunit 50255 "XV PN Etichette Ricambi Client" implements "XV PrintNode Report"
{

    procedure GeneratePdf(
        ParamInit: Text;
        var OutStr: OutStream)
    var
        ReportObj: Report "XV Etichette Ricambi Cliente";
    begin
        ReportObj.SetInitParameter(ParamInit);
        ReportObj.SaveAs('', ReportFormat::Pdf, OutStr);
    end;

}