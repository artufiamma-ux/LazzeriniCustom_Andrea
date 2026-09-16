namespace Custom.Custom;

using Microsoft.Sales.History;

// ============================================================================
// Abilita DocSolutions (DCS) sulla pagina "Spedizioni Vendita Registrate"
// (Posted Sales Shipment, page 6640 / table 110 - Sales Shipment Header)
//
// Basato sul pattern ufficiale EOS Solutions per documenti registrati
// (vedi EOS-Solutions/Sample -> EX069.DocSolutions ->
//  "pageextension 132 Posted Sales Invoice.al"), che a differenza degli
// ordini (Sales Header, chiave Document Type + No.) usa una chiave singola
// (No.) - esattamente come Sales Shipment Header.
//
// NOTA: l'ID oggetto 50100 e' un placeholder: sostituirlo con un ID nel
// range di licenza/affix del cliente prima del deploy.
// ============================================================================

pageextension 50290 "EOS DCS Posted Sales Shpt" extends "Posted Sales Shipment" // page 6640, table 110
{
    layout
    {
        addfirst(factboxes)
        {
            part("XV EOS DCS FactBox"; "EOS069 DCS FactBox")
            {
                Enabled = isVisible;
                Visible = isVisible;
                ApplicationArea = All;
                UpdatePropagation = SubPart;
            }
        }
    }

    actions
    {
        addlast(reporting)
        {
            action("XV EOS Print & Upload")
            {
                Enabled = isVisible;
                ToolTip = 'Salva la stampa collegata su DocSolutions.';
                ApplicationArea = All;
                Caption = 'Stampa e carica (DCS)';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendToMultiple;

                trigger OnAction()
                var
                    DocSolutionsManagement: Codeunit "EOS069 DocSolutions Management";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocSolutionsManagement.PrintAndUpload(RecRef);
                    CurrPage.Update();
                    CurrPage."XV EOS DCS FactBox".Page.AddinRefresh();
                end;
            }
        }
    }

    var
        isVisible: Boolean;
        alreadyChecked: Boolean;

    trigger OnOpenPage()
    var
        DocSolutionsManagement: Codeunit "EOS069 DocSolutions Management";
    begin
        if not alreadyChecked then begin
            alreadyChecked := true;
            isVisible := DocSolutionsManagement.IsEnabledForRecord(Rec);
            CurrPage."XV EOS DCS FactBox".Page.SetCurrRecord(Database::"Sales Shipment Header", Rec.SystemId);
        end;
    end;

    trigger OnAfterGetRecord()
    var
        DocSolutionsManagement: Codeunit "EOS069 DocSolutions Management";
    begin
        if not alreadyChecked then begin
            alreadyChecked := true;
            isVisible := DocSolutionsManagement.IsEnabledForRecord(Rec);
            CurrPage."XV EOS DCS FactBox".Page.SetCurrRecord(Database::"Sales Shipment Header", Rec.SystemId);
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if isVisible then
            CurrPage."XV EOS DCS FactBox".Page.SetCurrRecord(Database::"Sales Shipment Header", Rec.SystemId);
    end;
}
