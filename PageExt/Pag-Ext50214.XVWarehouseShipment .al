namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Document;
using Microsoft.Sales.Document;

pageextension 50214 XVWarehouseShipment extends "Warehouse Shipment"
{
    layout
    {
        addafter("Sorting Method")
        {
            field("Tipo Prelievo"; Rec."Tipo Prelievo")
            {
                ApplicationArea = All;
            }
            field("Tipo Ordine"; Rec."Tipo Ordine")
            {
                ApplicationArea = All;
            }
            field("Numero Totale Serie"; Rec."Numero Totale Serie")
            {
                ApplicationArea = All;
                //Editable = IsAperto;
            }
            field("Numero Totale Pallet"; Rec."Numero Totale Pallet")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Box totali per serie';
            }

            field(NrPalletAccessori; Rec."Nr Colli Accessori")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Box Accessori per serie';
            }

            field(DescrPalletAccessori; Rec."Descrizione Colli Accessori")
            {
                ApplicationArea = All;
            }

        }
        addafter(General)
        {
            group(Filtri)
            {
                Caption = 'Filtri';


                field("Pagamento Effettuato"; Rec."Pagamento Effettuato")
                {
                    ApplicationArea = All;
                }

                field("Da Spedire"; Rec."Da Spedire")
                {
                    ApplicationArea = All;
                }

                field("Quotazione Trasporto Acc."; Rec."Quotazione Trasporto Acc.")
                {
                    ApplicationArea = All;
                }
                field("Fattura Richiesta"; Rec."Fattura Richiesta")
                {
                    ApplicationArea = All;
                }
                field("Verifica Pagamenti"; Rec."Verifica Pagamenti")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        addlast(Processing)
        {
            action("Stampa etichette ricambi")
            {
                Caption = 'Stampa etichette ricambi';
                Image = Print;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PreviewPage: Page "XV Etichette Ricambi Cliente";
                begin
                    PreviewPage.SetShipmentHeader(Rec);
                    PreviewPage.RunModal();
                end;
            }
            action(StampaEtichetteUdc)
            {
                Caption = 'Genera dettaglio colli spedizioni';
                ApplicationArea = All;
                Image = BarCode;

                trigger OnAction()
                var
                    Rep: Report "XV Colli Di Spedizione";
                begin
                    Rep.SetWarehouseShipmentNo(Rec."No.");
                    Rep.Run();
                end;
            }
            action(StampaEtichettaRicambiPackingList)
            {
                Caption = 'Stampa Etichetta Ricambi Packing List';
                ApplicationArea = All;
                Image = BarCode;

                trigger OnAction()
                var
                    HU: Record "EOS055 Handling Unit";
                    XvPackingList: Codeunit "XV Packing List";
                    Msg: Text;
                    Rep: Report "XV Etich. Ricambi Packing List";
                begin
                    HU.SetRange("Warehouse Shipment No.", Rec."No.");
                    HU.SetFilter("Nr Scatola", '>0');
                    if not HU.FindFirst() then begin
                        Msg := XvPackingList.MakePackingList(Rec);
                        if (Msg <> '') and (Msg <> 'Processo concluso correttamente.') then begin
                            Message(Msg);
                            exit;
                        end;
                        Commit();
                    end;

                    Rep.SetInitParameter(Rec."No.");
                    Rep.Run();
                end;
            }
            /*
                        action(ChiudiScatole)
                        {
                            Caption = 'Chiudi scatole';
                            ApplicationArea = All;
                            Image = Closed;

                            trigger OnAction()
                            var
                                XvEosUtil: Codeunit "XVEosUtil";
                            begin
                                XvEosUtil.ChiudiScatole(Rec."No.");
                            end;
                        }
            */
            action(CreateEmptyHUFromWhseShipment)
            {
                Caption = 'Replica Packing List';
                ApplicationArea = All;
                Image = BinContent;
                //Enabled = IsAperto;


                trigger OnAction()
                var
                    XvEos: Codeunit "XV Packing List";
                    YN: Boolean;
                    Msg: Text;
                begin
                    YN := true;
                    if Rec."Scatole Chiuse" then
                        YN := Confirm('Sei sicuro di volere procedere nuovamente alla replica.\I colli generati dalla precedente replica verranno eliminati.\Intendi procedere?');
                    if YN then begin
                        Msg := XvEos.MakePackingList(Rec);
                        Message(Msg);
                        IsAperto := (NOT Rec."Scatole Chiuse");
                    end;
                end;
            }

        }
        addlast(Category_Category4)
        {
            actionref(StampaEtichetteRicambi_Promoted; "Stampa etichette ricambi")
            {
            }
        }

        addlast(Category_Process)
        {
            actionref(StampaEtichetteUdc_Promoted; StampaEtichetteUdc)
            {
            }
            actionref(StampaEtichettaRicambiPackingList_Promoted; StampaEtichettaRicambiPackingList)
            {
            }
            //            actionref(ChiudiScatole_Promoted; ChiudiScatole) { }
            actionref(CreateEmptyHUFromWhseShipment_Promoted; CreateEmptyHUFromWhseShipment)
            {
            }
        }

    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec."Location Code" = '' then
            Rec.Validate("Location Code", 'M01');
    end;

    trigger OnAfterGetRecord()
    begin
        IsAperto := (NOT Rec."Scatole Chiuse");
    end;

    var
        IsAperto: Boolean;

}
