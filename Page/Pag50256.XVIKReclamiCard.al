namespace Xview.Custom.Lazzerini;
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
    // UsageCategory = Tasks;

    DelayedInsert = true;
    InsertAllowed = true;
    /*
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Valori di default visibili subito all’utente
        if Rec."Date of the document" = 0D then
            Rec.Validate("Date of the document", WorkDate()); // o Today()

        if Rec."IP opened by" = '' then
            Rec.Validate("IP opened by", UserId());
    end;
    */

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Plant"; Rec."Plant")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Stabilimento in cui è stato aperto il reclamo.';
                }
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Id';
                    ToolTip = '-> Identificativo univoco generato automaticamente (YYYYMMDD + sequenza).';
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
                field("Problem Description"; Rec."Problem Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Descrizione dettagliata del problema.';
                }
                field("Reported by (User)"; Rec."IP opened by")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Utente che ha aperto il reclamo.';
                }
                field("Source/reason of the IP"; Rec."Source/reason of the IP")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Origine/motivo del reclamo.';
                }
                field("Assigned to (User)"; Rec."IP assigned to.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Utente incaricato della risoluzione del reclamo.';
                }
                field("Deadline"; Rec."Deadline")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Scadenza prevista per chiudere il reclamo.';
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
                field("Warranty and/or Reworking"; Rec."Warranty and/or Reworking")
                {
                    ApplicationArea = All;
                    ToolTip = 'Garanzia e/o rilavorazione.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cliente coinvolto.';
                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                    begin
                        Clear(DescCustomerName);
                        if (Rec."Customer No." <> '') and CustomerRec.Get(Rec."Customer No.") then
                            DescCustomerName := CustomerRec.Name;
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CustomerRec: Record Customer;
                    begin
                        if PAGE.RunModal(PAGE::"Customer List", CustomerRec) = ACTION::LookupOK then begin
                            Text := CustomerRec."No.";
                            Rec.Validate("Customer No.", CustomerRec."No.");
                            exit(true);
                        end;
                        exit(false);
                    end;
                }
                field("Customer Name"; DescCustomerName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nome del cliente coinvolto.';
                    Editable = false;
                }
                field("Supplier No."; Rec."Supplier No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fornitore coinvolto.';
                    trigger OnValidate()
                    var
                        SupplierRec: Record Vendor;
                    begin
                        Clear(DescSupplierName);
                        if (Rec."Supplier No." <> '') and SupplierRec.Get(Rec."Supplier No.") then
                            DescSupplierName := SupplierRec.Name;
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        VendorRec: Record Vendor;
                    begin
                        if PAGE.RunModal(PAGE::"Vendor List", VendorRec) = ACTION::LookupOK then begin
                            Text := VendorRec."No.";
                            Rec.Validate("Supplier No.", VendorRec."No.");
                            exit(true);
                        end;
                        exit(false);
                    end;
                }
                field("Supplier Name"; DescSupplierName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nome del fornitore coinvolto.';
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Articolo correlato.';
                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                    begin
                        Clear(DescItemDescription);
                        if (Rec."Item No." <> '') and ItemRec.Get(Rec."Item No.") then begin
                            DescItemDescription := ItemRec.Description;
                            if (Rec."Quantities of the NC parts" <> 0) then
                                TotalCostsOfTheComponents := Rec."Quantities of the NC parts" * ItemRec."Last Direct Cost";
                        end;
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemRec: Record Item;
                    begin
                        if PAGE.RunModal(PAGE::"Item List", ItemRec) = ACTION::LookupOK then begin
                            Text := ItemRec."No.";
                            Rec.Validate("Item No.", ItemRec."No.");
                            exit(true);
                        end;
                        exit(false);
                    end;
                }
                field("Item Description"; DescItemDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descrizione dell''articolo correlato.';
                    Editable = false;
                }
                field("Product family"; Rec."Product family")
                {
                    ApplicationArea = All;
                    ToolTip = 'Famiglia di prodotto.';
                }
                field("List of the defects"; Rec."List of the defects")
                {
                    ApplicationArea = All;
                    ToolTip = 'Difetto rilevato.';
                }
                field("4M+D Analysis"; Rec."4M+D Analysis")
                {
                    ApplicationArea = All;
                    ToolTip = 'Analisi 4M+D del problema.';
                }
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Note aggiuntive.';
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
                field("Quantities of the NC parts"; Rec."Quantities of the NC parts")
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantità non conformi rilevate.';
                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                    begin
                        Clear(TotalCostsOfTheComponents);
                        if (Rec."Item No." <> '') and ItemRec.Get(Rec."Item No.") then
                            TotalCostsOfTheComponents := Rec."Quantities of the NC parts" * ItemRec."Last Direct Cost";
                    end;
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
                field("Closing date of the IP"; Rec."Closing date of the IP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Data di chiusura del reclamo/IP.';
                }
                field("Total costs of the components"; TotalCostsOfTheComponents)
                {
                    ApplicationArea = All;
                    ToolTip = 'Costo totale dei componenti.';
                    Editable = false;
                }
                field("Cost of the component (euro)"; Rec."Cost of the component (euro)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costo del singolo componente.';
                }
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
                field("Total costs of the IP"; Rec."Total costs of the IP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costo totale del reclamo/IP.';
                }
                field("B - Benefit/Cost (B/C)"; Rec."B - Benefit/Cost (B/C)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Analisi benefici/costi - Sezione B.';
                }
                field("C - Benefit/Cost (B/C)"; Rec."C - Benefit/Cost (B/C)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Analisi benefici/costi - Sezione C.';
                }
                field("Debit note and/or Ret goods"; Rec."Debit note and/or Ret goods")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nota di debito e/o reso.';
                }
            }
            group("Allegati Reclamo")
            {
                part(Allegati; "XV IK Reclami Doc ListPart")
                {
                    ApplicationArea = All;
                    Visible = Rec.ID <> '';
                    SubPageLink = "Reclamo ID" = field(ID);
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SaveIP)
            {
                Caption = 'Salva Reclamo/IP';
                Image = Save;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Salva il reclamo/IP e genera automaticamente l''ID.';


                trigger OnAction()
                begin
                    //                    Rec.TestField("Plant");
                    Rec.TestField("Date of the document");
                    //                   Rec.TestField("Type");
                    Rec.TestField("Problem Description");
                    Rec.TestField("IP assigned to.");
                    Rec.TestField("IP opened by");
                    // Rec.TestField("Source/reason of the IP");
                    //Rec.TestField("Problem solving tool");
                    //Rec.TestField("PDCA");
                    Rec.TestField("Deadline");
                    CurrPage.SaveRecord();
                    Message('Reclamo/IP salvato correttamente.');
                end;
                /*
                                trigger OnAction()
                                begin
                                    CurrPage.SaveRecord();
                                    Message('Reclamo/IP salvato correttamente.');
                                end;
                */
            }
            action(OpenDocuments)
            {
                Enabled = Rec.ID <> '';
                Caption = 'Aggiungi documento';
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Inserisce i documenti allegati al reclamo/IP.';


                trigger OnAction()
                var
                    DocPage: Page "XV IK Reclami Card Doc";
                begin
                    DocPage.SetReclamoID(Rec.ID);    // PASSA l'ID del reclamo
                    DocPage.RunModal();
                end;
            }
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

            action(OpenCustomerOrder)
            {
                Caption = 'Apri Ordini Cliente';
                ApplicationArea = All;
                Image = OrderList;
                Enabled = Rec."Customer No." <> '';
                trigger OnAction()
                var
                    SO: Record "Sales Header";
                begin
                    SO.SetRange("Bill-to Customer No.", Rec."Customer No.");
                    //SO.SetRange("Document Type", SO."Document Type"::Order);
                    //SO.SetRange("No.", Rec."Rif. Customer NC");
                    if SO.FindFirst() then
                        Page.Run(Page::"Sales Order List", SO)
                    else
                        Message('Nessun ordine cliente trovato per il cliente %1.', Rec."Customer No.");
                end;
            }
        }
    }
    var
        ParentReclamoID: Code[100];
        DescCustomerName: Text[100];
        DescItemDescription: Text[100];
        DescSupplierName: Text[100];
        TotalCostsOfTheComponents: Decimal;

    procedure SetReclamoID(NewID: Code[100])
    begin
        ParentReclamoID := NewID;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Valori di default visibili subito all’utente
        if Rec."Date of the document" = 0D then
            Rec.Validate("Date of the document", WorkDate()); // o Today()

        if Rec."IP opened by" = '' then
            Rec.Validate("IP opened by", UserId());
        if Rec."IP assigned to." = '' then
            Rec.Validate("IP assigned to.", UserId());
    end;

    trigger OnOpenPage()
    begin
        //DeleteOrphanDocs();
        if Rec."IP opened by" = '' then
            Rec."IP opened by" := UserId();
        if Rec."IP assigned to." = '' then
            Rec."IP assigned to." := UserId();
        if Rec."Date of the document" = 0D then begin
            Rec."Date of the document" := WorkDate();
        end;
    end;

    procedure DeleteOrphanDocs()
    var
        Doc: Record "XV IK Reclami Doc";
    begin
        Doc.Reset();

        if Doc.FindSet(true) then
            repeat
                Doc.Delete(true);
            until Doc.Next() = 0;

        Message('Record orfani eliminati.');
    end;

    trigger OnAfterGetCurrRecord()
    var
        CustomerRec: Record Customer;
        ItemRec: Record Item;
        SupplierRec: Record Vendor;

    begin
        if Rec."Customer No." <> '' then
            if (CustomerRec.Get(Rec."Customer No.")) then
                DescCustomerName := CustomerRec."Name";
        if Rec."Item No." <> '' then
            if (ItemRec.Get(Rec."Item No.")) then begin
                DescItemDescription := ItemRec.Description;
                if (Rec."Quantities of the NC parts" <> 0) then
                    TotalCostsOfTheComponents := Rec."Quantities of the NC parts" * ItemRec."Last Direct Cost";
            end;
        if Rec."Supplier No." <> '' then
            if (SupplierRec.Get(Rec."Supplier No.")) then
                DescSupplierName := SupplierRec."Name";
    end;

}