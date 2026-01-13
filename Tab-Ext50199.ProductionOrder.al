namespace Lazzerini;

using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Routing;
using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.Document;
using Microsoft.Manufacturing.WorkCenter;
tableextension 50199 "XV Production Order" extends "Production Order"
{
    fields
    {
        field(50050; "Nr. Area di produzione OP"; Code[20])
        {
            Caption = 'Nr. Area di produzione OP';
            DataClassification = CustomerContent;
            TableRelation = "Work Center"."No.";
        }

        field(50051; "Nr. Ordine di vendita"; Code[20])
        {
            Caption = 'Nr. Ordine di vendita';
            DataClassification = CustomerContent;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }

        field(50052; "Nr. Serie progressiva"; Integer)
        {
            Caption = 'Nr. Serie progressiva';
            DataClassification = CustomerContent;
        }

        field(50053; "Tipo"; enum "OPTipo")
        {
            Caption = 'Tipo';
            DataClassification = CustomerContent;
        }

        field(50104; "Nr"; Code[20])
        {
            Caption = 'Nr.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series".Code;
        }

        field(50105; "Nr. Area produzione (Ciclo)"; Code[20])
        {
            Caption = 'Nr. Area produzione (Ciclo)';
            DataClassification = CustomerContent;
            TableRelation = "Work Center"."No.";
        }

        field(50106; "Nome area produzione (Ciclo)"; code[20])
        {
            Caption = 'Nome area produzione (Ciclo)';
            DataClassification = CustomerContent;
            TableRelation = "Work Center".Name;
        }

        field(50107; "Tipo Ciclo"; enum "OPTipoCiclo")
        {
            Caption = 'Tipo Ciclo';
            DataClassification = CustomerContent;
        }
        field(50108; "Nr. Ciclo"; code[20])
        {
            Caption = 'Nr. Ciclo';
            DataClassification = CustomerContent;
            TableRelation = "Routing Header"."No.";
        }
    }
}
