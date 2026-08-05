namespace Xview.Custom.Lazzerini;

codeunit 50253 "XV PN Etichetta Ricambi" implements "XV PrintNode Report"
{

    procedure GeneratePdf(
        ParamInit: Text;
        var OutStr: OutStream)
    var
        ReportObj: Report "XV Etichetta Ricambi";
    begin
        ReportObj.SetInitParameter(ParamInit);
        ReportObj.SaveAs('', ReportFormat::Pdf, OutStr);
    end;

}
