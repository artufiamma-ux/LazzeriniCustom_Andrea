namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Document;

tableextension 50214 XVWarehouseShipmentHeader extends "Warehouse Shipment Header"
{
    fields
    {
        field(50100; "Tipo Prelievo"; Enum "XV Tipo Prelievo WSH")
        {
            Caption = 'Tipo Prelievo';
            DataClassification = ToBeClassified;
            InitValue = Standard;

        }
        field(50101; "Tipo Ordine"; Enum "XV Tipo Ordine")
        {
            Caption = 'Tipo Ordine';
            DataClassification = ToBeClassified;

        }
        field(50102; "Numero Totale Serie"; Integer)
        {
            Caption = 'Numero Totale Serie';
            DataClassification = ToBeClassified;
            InitValue = 1;
        }
        field(50103; "Numero Totale Pallet"; Integer)
        {
            Caption = 'Numero Totale Pallet';
            DataClassification = ToBeClassified;
        }

        field(50106; "Verifica Pagamenti"; Boolean)
        {
            Caption = 'Verifica pagamenti';
            DataClassification = ToBeClassified;
        }

        field(50107; "Fattura Richiesta"; Boolean)
        {
            Caption = 'Fattura richiesta';
            DataClassification = ToBeClassified;
        }

        field(50108; "Pagamento Effettuato"; Boolean)
        {
            Caption = 'Pagamento effettuato';
            DataClassification = ToBeClassified;
        }

        field(50109; "Da Spedire"; Boolean)
        {
            Caption = 'Da spedire';
            DataClassification = ToBeClassified;
        }

        field(50110; "Quotazione Trasporto Acc."; Boolean)
        {
            Caption = 'Quotazione trasporto accettata';
            DataClassification = ToBeClassified;
        }
        field(50111; "Nr Colli Accessori"; Integer)
        {
            Caption = 'Nr Colli Accessori';
            DataClassification = ToBeClassified;
        }
        field(50112; "Descrizione Colli Accessori"; Text[100])
        {
            Caption = 'Descrizione Colli Accessori';
            DataClassification = ToBeClassified;
        }

    }
}
