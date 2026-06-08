namespace Xview.Custom.Lazzerini;
using Microsoft.Foundation.NoSeries;
using Microsoft.Warehouse.Document;

codeunit 50203 XVEosUtil
{
    procedure CreateEmptyBox(WhseShipmentNo: Code[20]; LocationCode: Code[10]; NumSerie: Integer): Code[20]
    var
        HandlingUnit: Record "EOS055 Handling Unit";
        Assignment: Record "EOS055 Handling Unit Assignm.";
        PackagingSetup: Record "EOS055 Packaging Setup";
        NoSeriesMgt: Codeunit "No. Series";

        NextHU: Code[20];
        NextEntryNo: Integer;
    begin
        // ============================
        // 1. Recupero No. Series
        // ============================
        //        PackagingSetup.Get('');

        NextHU := NoSeriesMgt.GetNextNo(
            HUMSequence,//PackagingSetup."Packaging Material Nos.",
            WorkDate(),
            true
        );

        // ============================
        // 2. Creo Handling Unit (vuota)
        // ============================
        HandlingUnit.Init();
        HandlingUnit."No." := NextHU;

        HandlingUnit."HU Type Code" := 'SCATOLA';
        HandlingUnit.Type := HandlingUnit.Type::Package;
        HandlingUnit.Status := HandlingUnit.Status::Draft;

        HandlingUnit."Packaging Material No." := 'PADESTAL';
        HandlingUnit."Location Code" := LocationCode;

        HandlingUnit."Creation Date-Time" := CurrentDateTime;
        HandlingUnit."Created by" := UserId;
        HandlingUnit."Has Content" := false;


        HandlingUnit.Insert(true);


        // ============================
        // 3. Calcolo Entry No.
        // ============================
        Assignment.Reset();
        if Assignment.FindLast() then
            NextEntryNo := Assignment."Entry No." + 1
        else
            NextEntryNo := 1;

        // ============================
        // 4. Creo Assignment (7321 = Whse Shipment)
        // ============================
        Assignment.Init();
        Assignment."Entry No." := NextEntryNo;

        Assignment."Source Type" := 7321; // Warehouse Shipment
        Assignment."Source Subtype" := 0;
        Assignment."Source No." := WhseShipmentNo;
        Assignment."Source Line No." := 0;
        Assignment."Source Subline No." := 0;

        Assignment."Handling Unit No." := HandlingUnit."No.";

        Assignment."Quantity (Base)" := 0;
        Assignment."Progressivo Serie Spedizione" := NumSerie;

        Assignment.Insert();

        // ============================
        // RETURN
        // ============================
        exit(HandlingUnit."No.");
    end;

    procedure SetNrScatoleOrder(WarehouseShipmentNo: Code[20])
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        HUAssignm: Record "EOS055 Handling Unit Assignm.";
        Scatole: Text[100];
        NScatola: Integer;

    begin
        WarehouseShipmentLine.Reset();
        WarehouseShipmentLine.SetRange("No.", WarehouseShipmentNo);
        // Ordinamento per Progressivo Kit Bus
        WarehouseShipmentLine.SetCurrentKey("Progressivo Kit Bus");
        WarehouseShipmentLine.Ascending(true);

        if WarehouseShipmentLine.FindSet() then
            repeat
                HUAssignm.Reset();
                HUAssignm.SetRange("Source No.", WarehouseShipmentLine."Source No.");
                HUAssignm.SetRange("Source Line No.", WarehouseShipmentLine."Source Line No.");
                if HUAssignm.FindSet() then
                    repeat
                        //                   HUAssignm."Nr Scatola" := 0;
                        // Recupero dati per indirizzo di spedizione dall'ordine
                        if HUAssignm."Nr Scatola" = 0 then begin
                            if NOT Scatole.Contains(HUAssignm."Handling Unit No.") then begin
                                NScatola := NScatola + 1;
                                Scatole := Scatole + ';' + HUAssignm."Handling Unit No.";
                            end;
                            HUAssignm."Nr Scatola" := NScatola;
                            HUAssignm.Modify(true);
                        end;
                    until HUAssignm.Next() = 0;

                WarehouseShipmentLine.Modify(true);
                NScatoleTotali := NScatola;
            until WarehouseShipmentLine.Next() = 0;

    end;

    procedure SetNrScatoleSpedizioneByOrder(WarehouseShipmentNo: Code[20])
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        HUAssignm: Record "EOS055 Handling Unit Assignm.";
        HUAssignmSpedizione: Record "EOS055 Handling Unit Assignm.";
        Scatole: Text[100];
        NScatola: Integer;
        NScatoleAccessorie: Integer;
    begin
        WarehouseShipmentLine.Reset();

        WarehouseShipmentLine.SetRange("No.", WarehouseShipmentNo);
        // Ordinamento per Progressivo Kit Bus
        WarehouseShipmentLine.SetCurrentKey("Progressivo Kit Bus");
        WarehouseShipmentLine.Ascending(true);

        if WarehouseShipmentLine.FindSet() then
            repeat
                //Recupero la scatola dall'ordine
                HUAssignm.Reset();
                HUAssignm.SetRange("Source No.", WarehouseShipmentLine."Source No.");
                HUAssignm.SetRange("Source Line No.", WarehouseShipmentLine."Source Line No.");
                if HUAssignm.FindSet() then
                    repeat
                        if HUAssignm."Nr Scatola" <> 0 then begin
                            HUAssignmSpedizione.SetRange("Source No.", WarehouseShipmentLine."No.");
                            HUAssignmSpedizione.SetRange("Handling Unit No.", HUAssignm."Handling Unit No.");
                            if HUAssignmSpedizione.FindSet() then begin
                                HUAssignmSpedizione."Nr Scatola" := HUAssignm."Nr Scatola";
                                HUAssignmSpedizione."Progressivo Serie Spedizione" := HUAssignm."Progressivo Serie Spedizione";
                                HUAssignmSpedizione.Modify(true);
                            end;
                        end;
                    until HUAssignm.Next() = 0;
            until WarehouseShipmentLine.Next() = 0;

    end;

    procedure SetNrScatoleSpedizioneByShipment(WarehouseShipmentNo: Code[20])
    var
        HUAssignmSpedizione: Record "EOS055 Handling Unit Assignm.";
        Scatole: Text[100];
        NScatola: Integer;
        NScatoleAccessorie: Integer;
    begin
        HUAssignmSpedizione.SetRange("Source No.", WarehouseShipmentNo);
        if HUAssignmSpedizione.FindSet() then
            repeat begin

                if NOT Scatole.Contains(HUAssignmSpedizione."Handling Unit No.") then begin
                    NScatola := NScatola + 1;
                    Scatole := Scatole + ';' + HUAssignmSpedizione."Handling Unit No.";
                end;
                HUAssignmSpedizione."Nr Scatola" := NScatola;
                HUAssignmSpedizione."Progressivo Serie Spedizione" := 0;
                HUAssignmSpedizione.Modify(true);
            end;
            until HUAssignmSpedizione.Next() = 0;

    end;


    /* ToDo procedura da rivedere 
    vanno prese le scatole warehouse e aggiunte quelle accessorie per i basamenti
     Per evitare di contare più volte le scatole accessorie o di sfalzare i numeri di serie
     il numero di serie è il count di progressivo kit bus
     la serie va rinumerata nella spedizione: es dall'ordine prendo la seri 1, 3 e 8 e nella spedizione le rinumero in 1, 2 e 3
     e non torna con i documenti di trasporto che dovrebbero prendere la numerazione della spedizione, che è quella che conta per la logistica
    aggiungere il flag Scatole Chiuse a Warehouse Shipment Header
        se il flag è false, chiudo le scatole e metto il flag a true
        se il flag è true, chiedo all'utente se vuole rieseguire il conteggio e chiudere nuovamente le scatole, se sì, 
        resetto tutte le scatole a 0 e rieseguo la procedura di chiusura
*/
    procedure ChiudiScatole(WarehouseShipmentNo: Code[20])
    var
        WhseShpt: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        HUAssignm: Record "EOS055 Handling Unit Assignm.";
        QueryHUAssignm: Query "XV HUAssignmDistinct";
        Scatole: Text[100];
        NScatola: Integer;
        NScatoleAccessorie: Integer;
        NSerie: Integer;
        CurrentSerie: Integer;
        i: Integer;
        YN: boolean;
    begin
        NSerie := 0;
        CurrentSerie := 0;
        WhseShpt.Get(WarehouseShipmentNo);
        YN := true;
        if (WhseShpt."Scatole Chiuse") then begin
            YN := Confirm('Le scatole sono già state chiuse. Vuoi rieseguire la procedura di chiusura?')
        end;
        if YN then begin
            ResetDatiChiusura(WhseShpt);
            WhseShpt.Reset();
            WhseShpt.Get(WarehouseShipmentNo);
            DeleteScatoleAccessorie(WarehouseShipmentNo);
            NScatoleAccessorie := WhseShpt."Nr Colli Accessori";
            WarehouseShipmentLine.SetRange("No.", WarehouseShipmentNo);
            WarehouseShipmentLine.SetCurrentKey("Progressivo Kit Bus");
            WarehouseShipmentLine.Ascending(true);
            // Calcolo numero serie della spedizione basato sul progressivo kit bus, in modo da rinumerare le serie in base alla spedizione e non all'ordine
            if WarehouseShipmentLine.FindSet() then begin
                repeat
                    if CurrentSerie <> WarehouseShipmentLine."Progressivo Kit Bus" then begin
                        CurrentSerie := WarehouseShipmentLine."Progressivo Kit Bus";
                        NSerie := NSerie + 1;
                    end;
                    WarehouseShipmentLine."Progressivo Serie Spedizione" := NSerie;
                    WarehouseShipmentLine.Modify(true);
                    SetNrSerieOrder(WarehouseShipmentLine."Source No.", WarehouseShipmentLine."Source Line No.", NSerie);
                until WarehouseShipmentLine.Next() = 0;
                // Creazione scatole accessorie per l'ultima serie

                /*
                                WarehouseShipmentLine.Reset();
                                WarehouseShipmentLine.SetRange("No.", WarehouseShipmentNo);
                                WarehouseShipmentLine.SetCurrentKey("Progressivo Serie Spedizione");
                                WarehouseShipmentLine.Ascending(true);
                */
            end;
            SetNrScatoleOrder(WarehouseShipmentNo);
            SetNrScatoleSpedizioneByOrder(WarehouseShipmentNo);
            CreateAllEmptyBox(WarehouseShipmentNo, WhseShpt."Location Code", NSerie);
            WhseShpt."Numero Totale Serie" := NSerie;
            WhseShpt."Numero Totale Pallet" := NScatoleTotali;
            WhseShpt."Scatole Chiuse" := true;
            WhseShpt.Modify(true);

            /*
                       QueryHUAssignm.SetFilter(HandlingUnitFilter, WarehouseShipmentNo);
                       while QueryHUAssignm.Read() do
                           Message('HU: %1 - WareLine: %2', QueryHUAssignm.HandlingUnitNo, QueryHUAssignm.LineNo);
                           begin

                       end;
           */
        end;
    end;

    procedure IsPadestal(HandlingUnitNo: Code[20]): Boolean
    var
        HandlingUnit: Record "EOS055 Handling Unit";
    begin
        HandlingUnit.Reset();
        HandlingUnit.SetRange("No.", HandlingUnitNo);
        if HandlingUnit.FindFirst() then
            exit(HandlingUnit."Packaging Material No." = 'PADESTAL');
        exit(false);
    end;

    local procedure ResetDatiChiusura(WhseShpt: Record "Warehouse Shipment Header")
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        HUAssignm: Record "EOS055 Handling Unit Assignm.";
    begin
        // Reset header
        WhseShpt."Numero Totale Serie" := 0;
        WhseShpt."Scatole Chiuse" := false;
        WhseShpt.Modify(true);

        // Reset righe spedizione
        WarehouseShipmentLine.SetRange("No.", WhseShpt."No.");
        if WarehouseShipmentLine.FindSet() then
            repeat
                WarehouseShipmentLine."Progressivo Serie Spedizione" := 0;
                WarehouseShipmentLine.Modify(true);
            until WarehouseShipmentLine.Next() = 0;

        // Reset assignment spedizione
        HUAssignm.SetRange("Source No.", WhseShpt."No.");
        if HUAssignm.FindSet() then
            repeat
                HUAssignm."Nr Scatola" := 0;
                HUAssignm."Progressivo Serie Spedizione" := 0;
                HUAssignm.Modify(true);
            until HUAssignm.Next() = 0;
    end;

    local procedure DeleteScatoleAccessorie(WarehouseShipmentNo: Code[20])
    var
        HUAssignm: Record "EOS055 Handling Unit Assignm.";
        HandlingUnit: Record "EOS055 Handling Unit";
    begin
        // Elimino tutte le scatole accessorie legate della spedizione
        HUAssignm.Reset();
        HUAssignm.SetRange("Source No.", WarehouseShipmentNo);
        if HUAssignm.FindSet() then
            repeat
                if IsPadestal(HUAssignm."Handling Unit No.") then begin
                    HandlingUnit.SetRange("No.", HUAssignm."Handling Unit No.");
                    if HandlingUnit.FindFirst() then
                        HandlingUnit.Delete();
                    HUAssignm.Delete();
                end;
            until HUAssignm.Next() = 0;
    end;

    local procedure SetNrSerieOrder(SourceNo: Code[20]; SourceLineNo: Integer; NSerie: Integer)
    var
        HUAssignm: Record "EOS055 Handling Unit Assignm.";
    begin
        HUAssignm.Reset();
        HUAssignm.SetRange("Source No.", SourceNo);
        HUAssignm.SetRange("Source Line No.", SourceLineNo);
        if HUAssignm.FindSet() then
            repeat begin
                HUAssignm."Progressivo Serie Spedizione" := NSerie;
                HUAssignm.Modify(true);
            end;
            until HUAssignm.Next() = 0;
    end;

    local procedure CreateAllEmptyBox(WarehouseShipmentNo: Code[20]; LocationCode: Code[10]; NSerie: Integer)
    var
        i: Integer;
    begin
        for i := 1 to NSerie do begin
            NScatoleTotali := NScatoleTotali + 1;
            CreateEmptyBox(WarehouseShipmentNo, LocationCode, NSerie);
        end;
    end;

    var
        HUMSequence: Label 'BOXN';
        NScatoleTotali: Integer;
}
