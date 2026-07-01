namespace Xview.Custom.Lazzerini;
using Microsoft.Foundation.NoSeries;
using Microsoft.Warehouse.Document;

codeunit 50205 "XV Packing List"
{
    procedure CreateEmptyBox(SrcHu: Record "EOS055 Handling Unit";
                                SrcAs: Record "EOS055 Handling Unit Assignm.";
                                NumSerie: Integer
                            ): Code[20]
    var
        No: Code[20];
        ErrMsg: Text;
    begin
        if Not TryCreateEmptyBox(SrcHu, SrcAs, NumSerie, No) then begin

            ErrMsg := ErrMsg + '\' + GetLastErrorText();
            No := '';
        end;
    end;

    [TryFunction]
    local procedure TryCreateEmptyBox(SrcHu: Record "EOS055 Handling Unit"; SrcAs: Record "EOS055 Handling Unit Assignm.";
                                NumSerie: Integer;
                                 var ResultNo: Code[20]
                            )
    var
        HandlingUnit: Record "EOS055 Handling Unit";
        Assignment: Record "EOS055 Handling Unit Assignm.";
        UPallet: Text[1];
        NoSeriesMgt: Codeunit "No. Series";

        NextHU: Code[20];
        NextEntryNo: Integer;
    begin
        // ============================
        // 1. Recupero No. Series
        // ============================
        //        PackagingSetup.Get('');
        UPallet := CopyStr(SrcAs."Handling Unit No.", 1, 1);
        if UPallet = 'U' then
            NextHU := NoSeriesMgt.GetNextNo(
                HUMSequenceU,//Pallet
                WorkDate(),
                true
            );
        if UPallet = 'C' then
            NextHU := NoSeriesMgt.GetNextNo(
                HUMSequenceC,//Scatola
                WorkDate(),
                true
            );


        // ============================
        // 2. Creo Handling Unit (vuota)
        // ============================
        HandlingUnit.Init();
        HandlingUnit."No." := NextHU;

        HandlingUnit.Validate("HU Type Code", SrcHu."HU Type Code"); //SCATOLA o PALLET
        HandlingUnit.Validate(Type, SrcHu.Type);
        HandlingUnit.Validate(Status, SrcHu.Status);
        HandlingUnit.Validate("Packaging Material No.", SrcHu."Packaging Material No.");
        HandlingUnit.Validate("Location Code", SrcHu."Location Code");
        HandlingUnit.Validate("Created From Handling Unit No.", SrcHu."No.");
        HandlingUnit.Validate("Parent Handling Unit No.", GetParentHandlingUnitNo(SrcHu."Parent Handling Unit No.", NumSerie));
        HandlingUnit.Validate("Creation Date-Time", CurrentDateTime);
        HandlingUnit.Validate("Created by", UserId);
        HandlingUnit.Validate("Has Content", false);
        HandlingUnit.Validate("Nr Scatola", SrcHu."Nr Scatola");
        HandlingUnit.Validate("Progressivo Serie Spedizione", NumSerie);
        HandlingUnit.Validate("Warehouse Shipment No.", SrcHu."Warehouse Shipment No.");
        HandlingUnit.Insert(true);

        HandlingUnit.Validate("Net Weight", SrcHu."Net Weight");
        HandlingUnit.Validate("Gross Weight", SrcHu."Gross Weight");
        HandlingUnit.Validate("Unit Volume", SrcHu."Unit Volume");
        HandlingUnit.Validate("Calc. Net Weight", SrcHu."Calc. Net Weight");
        HandlingUnit.Validate("Calc. Gross Weight", SrcHu."Calc. Gross Weight");
        HandlingUnit.Validate("Calc. Unit Volume", SrcHu."Calc. Unit Volume");
        HandlingUnit.Modify(true);

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

        Assignment.Validate("Source Type", SrcAs."Source Type"); // Warehouse Shipment
        Assignment.Validate("Source Subtype", SrcAs."Source Subtype");
        Assignment.Validate("Source No.", SrcAs."Source No.");
        Assignment.Validate("Source Line No.", 0); // non è ancora associato alla merce nell'ordine
        Assignment.Validate("Source Subline No.", 0);
        Assignment.Validate("Handling Unit No.", HandlingUnit."No.");
        Assignment.Validate("Quantity (Base)", 0);

        Assignment.Insert();

        // ============================
        // RETURN
        // ============================
        ResultNo := HandlingUnit."No.";
    end;


    procedure MakePackingList(WhseShipmentHeader: Record "Warehouse Shipment Header"): Text
    var
        WhseShipmentLine: Record "Warehouse Shipment Line";
        HUAssignm: Record "EOS055 Handling Unit Assignm.";
        HU: Record "EOS055 Handling Unit";
        NScatola: Integer;
        Msg: Text;

        IntValue: Integer;
        CodeValue: Code[20]; // Chiave temporanea per creare scatole e pallet ancora non associati
        ItemCode: Code[20];
        PkgItemC: List of [Code[20]];
        PkgItemU: List of [Code[20]];
        UPallet: Text[1];
        i: Integer;
        TPadestal: Text[20];

    begin
        DeleteOldPackaging(WhseShipmentHeader);
        Msg := 'Processo concluso correttamente.';
        NScatola := 0;
        LocationCode := WhseShipmentHeader."Location Code";
        WhseShipmentLine.SetRange("No.", WhseShipmentHeader."No.");
        if WhseShipmentLine.FindFirst() then begin
            IntValue := WhseShipmentLine."EOS Group Entry No.";
            CodeValue :=
                PadStr('', 17 - StrLen(Format(IntValue)), '0') +
                Format(IntValue);

            HUAssignm.SetRange("Source No.", CodeValue);
            HUAssignm.SetCurrentKey("Entry No.");
            // nel primo ciclo assegno i valori custom alle sactole create come template
            // e divido pallet e scatole
            if HUAssignm.FindSet() then begin
                repeat
                    HU.Reset();
                    if HU.Get(HUAssignm."Handling Unit No.") then begin
                        HU."Warehouse Shipment No." := WhseShipmentHeader."No.";
                        HU."Progressivo Serie Spedizione" := 1;
                        UPallet := CopyStr(HUAssignm."Handling Unit No.", 1, 1);

                        if UPallet = 'C' then begin
                            PkgItemC.Add(HU."No.");
                            NScatola := NScatola + 1;
                            HU."Nr Scatola" := NScatola;
                            TPadestal := HU."Packaging Material No.";
                            if TPadestal.ToUpper().Contains('PADESTAL') then
                                NumPadestal := NumPadestal + 1;

                        end;
                        if UPallet = 'U' then
                            PkgItemU.Add(HU."No.");

                        HU.Modify();
                    end;
                until HUAssignm.Next() = 0;
                NumScatolePerSerie := NScatola;
            end else begin
                Msg := 'Nessuna riga di spedizione trovata per il documento ' + WhseShipmentHeader."No.";
                exit(Msg);
            end;
            for i := 2 to WhseShipmentHeader."Numero Totale Serie" do begin
                foreach ItemCode in PkgItemU do begin
                    Clona(ItemCode, i);
                end;
                foreach ItemCode in PkgItemC do begin
                    Clona(ItemCode, i);
                end;
            end;
            if ErrMsg = '' then begin
                WhseShipmentHeader."Nr Colli Accessori" := NumPadestal;
                WhseShipmentHeader."Numero Totale Pallet" := NScatola;
                WhseShipmentHeader."Scatole Chiuse" := true;
                WhseShipmentHeader.Modify();
            end
            else
                Msg := ErrMsg;

        end;
        exit(Msg);
    end;

    local procedure Clona(ItemCode: Code[20]; i: Integer)
    var
        HUAssignm: Record "EOS055 Handling Unit Assignm.";
        HU: Record "EOS055 Handling Unit";
    begin
        if HU.Get(ItemCode) then begin
            HUAssignm.SetRange("Handling Unit No.", ItemCode);
            if HUAssignm.FindFirst() then begin
                CreateEmptyBox(HU, HUAssignm, i);
            end;
        end;

    end;

    local procedure GetParentHandlingUnitNo(ParentHandlingUnitNo: Code[20]; NumSerie: Integer): Code[20]
    var
        HU: Record "EOS055 Handling Unit";
        No: Code[20];
    begin
        No := '';
        if ParentHandlingUnitNo <> '' then begin
            HU.SetRange("Created From Handling Unit No.", ParentHandlingUnitNo);
            HU.SetRange("Progressivo Serie Spedizione", NumSerie);
            if HU.FindFirst() then
                No := HU."No.";
        end;
        exit(No);
    end;

    local procedure DeleteOldPackaging(WhseShipmentHeader: Record "Warehouse Shipment Header")
    var
        HandlingUnit: Record "EOS055 Handling Unit";
        HandlingUnitAss: Record "EOS055 Handling Unit Assignm.";

    begin
        HandlingUnit.SetRange("Warehouse Shipment No.", WhseShipmentHeader."No.");
        HandlingUnit.SetFilter("Created From Handling Unit No.", '<>%1', '');

        if HandlingUnit.FindSet() then
            repeat
                HandlingUnitAss.SetRange("Handling Unit No.", HandlingUnit."No.");
                HandlingUnitAss.DeleteAll();
                HandlingUnit.Delete();
            until HandlingUnit.Next() = 0;
    end;

    var
        HUMSequenceC: Label 'BOXN';
        HUMSequenceU: Label 'UDC';
        ErrMsg: Text;
        LocationCode: Code[10];
        NumScatolePerSerie: Integer;
        NumPadestal: Integer;

}
