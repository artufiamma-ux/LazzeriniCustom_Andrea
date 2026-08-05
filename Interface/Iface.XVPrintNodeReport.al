namespace Xview.Custom.Lazzerini;

interface "XV PrintNode Report"
{
    procedure GeneratePdf(
        ParamInit: Text;
        var OutStr: OutStream
    );

}
