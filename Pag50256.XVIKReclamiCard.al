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
                    ToolTip = 'Stabilimento di riferimento in cui è stato aperto il reclamo/IP.';
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
                    ToolTip = 'Cliente coinvolto nel reclamo (se presente).';
                }
                field("Supplier No."; Rec."Supplier No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fornitore coinvolto nel reclamo (se presente).';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Articolo interessato dal reclamo.';
                }
                field("Product family"; Rec."Product family")
                {
                    ApplicationArea = All;
                    ToolTip = 'Famiglia di prodotto cui appartiene l’articolo coinvolto.';
                }
                field("Problem Description"; Rec."Problem Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Descrizione del problema riscontrato.';
                }
            }

            group(Assignment)
            {
                field("Reported by (User)"; Rec."IP opened by")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Utente che ha aperto il reclamo/IP.';
                }
                field("Assigned to (User)"; Rec."IP assigned to.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Utente incaricato della gestione e risoluzione del reclamo.';
                }
                field("Source/reason of the IP"; Rec."Source/reason of the IP")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Origine o motivo principale del reclamo/IP.';
                }
                field("Problem solving tool"; Rec."Problem solving tool")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Strumento/metodologia utilizzata per la risoluzione del problema (es. 8D, Kaizen, ecc.).';
                }
                field("PDCA"; Rec."PDCA")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Stadio di avanzamento PDCA dell’azione correttiva.';
                }
                field("Severity"; Rec."Severity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Livello di gravità associato al problema.';
                }
                field("Detection"; Rec."Detection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fase del processo in cui è stato rilevato il problema.';
                }
                field("Deadline"; Rec."Deadline")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Scadenza entro cui risolvere il reclamo.';
                }
                field("Closing date of the IP"; Rec."Closing date of the IP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Data in cui è stato chiuso il reclamo/IP.';
                }
            }

            group(Details)
            {
                field("List of the defects"; Rec."List of the defects")
                {
                    ApplicationArea = All;
                    ToolTip = 'Difetto rilevato sul prodotto o sul processo.';
                }
                field("Quantities of the NC parts"; Rec."Quantities of the NC parts")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantità di pezzi non conformi rilevati.';
                }
                field("Rif. Customer NC"; Rec."Rif. Customer NC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Riferimento alla nota di credito cliente collegata (se presente).';
                }
                field("SR N (warranty N assigned)"; Rec."SR N (warranty N assigned)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero di garanzia assegnato (se applicabile).';
                }
                field("Root Cause(s) - 8D"; Rec."Root Cause(s) - 8D")
                {
                    ApplicationArea = All;
                    ToolTip = 'Causa radice determinata nell’analisi del problema (non da compilare in caso di 8D strutturato).';
                }
                field("Corrective action(s)"; Rec."Corrective action(s)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Azioni correttive decise per risolvere il problema.';
                }
                field("Link to other IP"; Rec."Link to other IP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Collegamento ad altri reclami/IP correlati.';
                }
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Note aggiuntive relative al reclamo.';
                }
                field("Warranty and/or Reworking"; Rec."Warranty and/or Reworking")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicazione se il caso riguarda garanzia, rilavorazione o entrambi.';
                }
                field("Debit note and/or Ret goods"; Rec."Debit note and/or Ret goods")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicazione se è prevista nota di debito e/o restituzione merce.';
                }
            }

            group(Costs)
            {
                field("Extra trans costs for warranty"; Rec."Extra trans costs for warranty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Eventuali costi extra di trasporto imputabili alla garanzia.';
                }
                field("Various costs of the IP"; Rec."Various costs of the IP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costi vari associati al reclamo/IP.';
                }
                field("B - Benefit/Cost (B/C)"; Rec."B - Benefit/Cost (B/C)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sezione B dell’analisi benefici/costi.';
                }
                field("C - Benefit/Cost (B/C)"; Rec."C - Benefit/Cost (B/C)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sezione C dell’analisi benefici/costi.';
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
                ToolTip = 'Apre la scheda del cliente collegato.';
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
                ToolTip = 'Apre la scheda del fornitore collegato.';
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
                ToolTip = 'Apre la scheda dell’articolo interessato.';
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
                ToolTip = 'Apre la nota di credito cliente collegata (non contabilizzata).';
                Enabled = Rec."Rif. Customer NC" <> '';
                trigger OnAction()
                var
                    SH: Record "Sales Header";
                begin
                    SH.Reset();
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
                ToolTip = 'Apre la scheda dell’utente che ha aperto il reclamo.';
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
                ToolTip = 'Apre la scheda dell’utente incaricato alla risoluzione.';
                Enabled = Rec."IP assigned to." <> '';
                trigger OnAction()
                var
                    US: Record "User Setup";
                begin
                    if US.Get(Rec."IP assigned to.") then
                        Page.Run(Page::"User Setup", US);
                end;
            }
            /*
                        action(CreateNewIP)
                        {
                            Caption = 'Nuovo Reclamo/IP';
                            ApplicationArea = All;
                            Image = NewDocument;
                            ToolTip = 'Crea un nuovo reclamo/IP.';
                            trigger OnAction()
                            var
                                NewRec: Record "XV IK Reclami";
                            begin
                                NewRec.Init();
                                Page.Run(Page::"XV IK Reclami Card", NewRec);
                            end;
                        }
            */
        }
    }
}