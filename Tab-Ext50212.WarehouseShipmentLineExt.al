namespace Lazzerini;

using Microsoft.Inventory.Document;

tableextension 50212 "Warehouse Shipment Line Ext" extends "Invt. Document Line"
{
    fields
    {
        field(50100; "Tipo Prelievo"; Code[20])
        {
            Caption = 'Tipo Prelievo';
            DataClassification = ToBeClassified;
            TableRelation = "XV Tipo Prelievo";
            ObsoleteState = Removed;
            ObsoleteReason = 'Campo non più utilizzato';
            ObsoleteTag = '2024.01';
        }
        field(50101; "Tipo Ordine"; Code[20])
        {
            Caption = 'Tipo Ordine';
            DataClassification = ToBeClassified;
            TableRelation = "XV Tipo Ordine";
            ObsoleteState = Removed;
            ObsoleteReason = 'Campo non più utilizzato';
            ObsoleteTag = '2024.01';
        }
        field(50102; "Numero Totale Serie"; Integer)
        {
            Caption = 'Numero Totale Serie';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'Campo non più utilizzato';
            ObsoleteTag = '2024.01';
        }
        field(50103; "Numero Totale Pallet"; Integer)
        {
            Caption = 'Numero Totale Pallet';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'Campo non più utilizzato';
            ObsoleteTag = '2024.01';
        }
        field(50104; "Rif. Ordine di vendita"; Code[30])
        {
            Caption = 'Rif. Ordine di vendita';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'Campo non più utilizzato';
            ObsoleteTag = '2024.01';
        }
        field(50105; "Fattura Richiesta"; Boolean)
        {
            Caption = 'Fattura Richiesta';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'Campo non più utilizzato';
            ObsoleteTag = '2024.01';
        }
    }
}
