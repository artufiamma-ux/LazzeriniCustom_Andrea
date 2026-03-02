namespace Lazzerini;
using System.Security.User;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;

page 50256 "XV IK Reclami Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "XV IK Reclami";


    DelayedInsert = true;
    InsertAllowed = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Identificativo univoco generato automaticamente (YYYYMMDD + sequenza).';
                }
                field("Plant"; Rec."Plant")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Stabilimento in cui è stato aperto il reclamo.';
                }
                field("Date of the document"; Rec."Date of the document")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Data di apertura del reclamo/IP.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Tipologia del reclamo/IP.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cliente coinvolto.';
                }
                field("Supplier No."; Rec."Supplier No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fornitore coinvolto.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Articolo correlato.';
                }
                field("Product family"; Rec."Product family")
                {
                    ApplicationArea = All;
                    ToolTip = 'Famiglia di prodotto.';
                }
                field("Problem Description"; Rec."Problem Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Descrizione dettagliata del problema.';
                }
            }

            group(Assignment)
            {
                field("Reported by (User)"; Rec."IP opened by")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Utente che ha aperto il reclamo.';
                }
                field("Assigned to (User)"; Rec."IP assigned to.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Utente incaricato della risoluzione del reclamo.';
                }
                field("Source/reason of the IP"; Rec."Source/reason of the IP")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Origine/motivo del reclamo.';
                }
                field("Problem solving tool"; Rec."Problem solving tool")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Tecnica usata per il problem solving (es. 8D, Kaizen).';
                }
                field("PDCA"; Rec."PDCA")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Stadio PDCA del reclamo.';
                }
                field("Severity"; Rec."Severity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Gravità del problema.';
                }
                field("Detection"; Rec."Detection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fase di rilevamento della non conformità.';
                }
                field("Deadline"; Rec."Deadline")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Scadenza prevista per chiudere il reclamo.';
                }
                field("Closing date of the IP"; Rec."Closing date of the IP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Data di chiusura del reclamo/IP.';
                }
            }

            group(Details)
            {
                field("List of the defects"; Rec."List of the defects")
                {
                    ApplicationArea = All;
                    ToolTip = 'Difetto rilevato.';
                }
                field("Quantities of the NC parts"; Rec."Quantities of the NC parts")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantità non conformi rilevate.';
                }
                field("Rif. Customer NC"; Rec."Rif. Customer NC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Riferimento alla nota di credito cliente.';
                }
                field("SR N (warranty N assigned)"; Rec."SR N (warranty N assigned)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero garanzia assegnato.';
                }
                field("Root Cause(s) - 8D"; Rec."Root Cause(s) - 8D")
                {
                    ApplicationArea = All;
                    ToolTip = 'Causa radice determinata.';
                }
                field("Corrective action(s)"; Rec."Corrective action(s)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Azioni correttive applicate.';
                }
                field("Link to other IP"; Rec."Link to other IP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Collegamento ad altri reclami.';
                }
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Note aggiuntive.';
                }
                field("Warranty and/or Reworking"; Rec."Warranty and/or Reworking")
                {
                    ApplicationArea = All;
                    ToolTip = 'Garanzia e/o rilavorazione.';
                }
                field("Debit note and/or Ret goods"; Rec."Debit note and/or Ret goods")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nota di debito e/o reso.';
                }
            }

            group(Costs)
            {
                field("Extra trans costs for warranty"; Rec."Extra trans costs for warranty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costi extra trasporto garanzia.';
                }
                field("Various costs of the IP"; Rec."Various costs of the IP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costi vari.';
                }
                field("B - Benefit/Cost (B/C)"; Rec."B - Benefit/Cost (B/C)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Analisi benefici/costi – Sezione B.';
                }
                field("C - Benefit/Cost (B/C)"; Rec."C - Benefit/Cost (B/C)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Analisi benefici/costi – Sezione C.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OpenCustomer)
            {
                Caption = 'Apri Cliente';
                ApplicationArea = All;
                Image = Customer;
                Enabled = Rec."Customer No." <> '';
                trigger OnAction()
                var
                    Cust: Record Customer;
                begin
                    if Cust.Get(Rec."Customer No.") then
                        Page.Run(Page::"Customer Card", Cust);
                end;
            }

            action(OpenVendor)
            {
                Caption = 'Apri Fornitore';
                ApplicationArea = All;
                Image = Vendor;
                Enabled = Rec."Supplier No." <> '';
                trigger OnAction()
                var
                    Vend: Record Vendor;
                begin
                    if Vend.Get(Rec."Supplier No.") then
                        Page.Run(Page::"Vendor Card", Vend);
                end;
            }

            action(OpenItem)
            {
                Caption = 'Apri Articolo';
                ApplicationArea = All;
                Image = Item;
                Enabled = Rec."Item No." <> '';
                trigger OnAction()
                var
                    Itm: Record Item;
                begin
                    if Itm.Get(Rec."Item No.") then
                        Page.Run(Page::"Item Card", Itm);
                end;
            }

            action(OpenCustomerCreditMemo)
            {
                Caption = 'Apri Nota di Credito Cliente';
                ApplicationArea = All;
                Image = Navigate;
                Enabled = Rec."Rif. Customer NC" <> '';
                trigger OnAction()
                var
                    SH: Record "Sales Header";
                begin
                    SH.SetRange("Document Type", SH."Document Type"::"Credit Memo");
                    SH.SetRange("No.", Rec."Rif. Customer NC");
                    if SH.FindFirst() then
                        Page.Run(Page::"Sales Credit Memo", SH);
                end;
            }

            action(OpenReportedByUser)
            {
                Caption = 'Apri Utente (Segnalato da)';
                ApplicationArea = All;
                Image = User;
                Enabled = Rec."IP opened by" <> '';
                trigger OnAction()
                var
                    US: Record "User Setup";
                begin
                    if US.Get(Rec."IP opened by") then
                        Page.Run(Page::"User Setup", US);
                end;
            }

            action(OpenAssignedToUser)
            {
                Caption = 'Apri Utente (Assegnato a)';
                ApplicationArea = All;
                Image = User;
                Enabled = Rec."IP assigned to." <> '';
                trigger OnAction()
                var
                    US: Record "User Setup";
                begin
                    if US.Get(Rec."IP assigned to.") then
                        Page.Run(Page::"User Setup", US);
                end;
            }

            action(NewIP)
            {
                Caption = 'Nuovo Reclamo/IP';
                ApplicationArea = All;
                Image = NewDocument;
                trigger OnAction()
                begin
                    Page.RunModal(Page::"XV IK Reclami Card");
                end;
            }
        }
    }
}