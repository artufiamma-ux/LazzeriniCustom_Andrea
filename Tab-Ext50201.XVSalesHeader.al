
namespace Lazzerini;

using Microsoft.Sales.Document;

tableextension 50201 "XV Sales Header" extends "Sales Header"
{
    fields
    {
        field(50201; "Nr Layout"; Code[20]) { Caption = 'Nr Layout'; }
        field(50202; "Ordine con kit"; Boolean) { Caption = 'Ordine con kit'; }
        field(50203; "Nr serie"; Code[20]) { Caption = 'Nr serie'; }
        field(50204; "Nr posti per serie"; Integer) { Caption = 'Nr posti per serie'; }
        field(50205; "Non duplicabile"; Boolean) { Caption = 'Non duplicabile'; }
        field(50206; "Sezione Iknow"; Code[20]) { Caption = 'Sezione Iknow'; }
        field(50207; "Azzera data spedizione"; Boolean) { Caption = 'Azzera data spedizione'; }
    }
}
