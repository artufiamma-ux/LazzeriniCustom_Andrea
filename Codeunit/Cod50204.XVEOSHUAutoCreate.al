namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Document;

codeunit 50204 "XV EOS HU Auto Create"

{
    procedure CreateEmptyHUFromWhseShipment(var WhseShptHeader: Record "Warehouse Shipment Header"; Qty: Integer)
    var
        PackingMgt: Codeunit "EOS055 Packing List Management";
        TempSourceItem: Record "EOS055 Handling Unit Buffer" temporary;
        TempHUContentModify: Record "EOS055 Handling Unit Buffer" temporary;
        HU: Record "EOS055 Handling Unit";
        Assignm: Record "EOS055 Handling Unit Assignm.";
        SourceDoc: Variant;
        i: Integer;
        ClusterNo: Code[20];
    begin
        // 1. Attivo contesto EOS (questo crea/aggancia il cluster)
        SourceDoc := WhseShptHeader;
        PackingMgt.CreatePackingList(SourceDoc, TempSourceItem, TempHUContentModify);

        // 2. Recupero il cluster direttamente dalle assignm esistenti
        ClusterNo := GetClusterNoFromAssignm(WhseShptHeader);

        if ClusterNo = '' then
            Error('Cluster HU non trovato. Aprire una volta la Packing List manualmente.');

        // 3. Creo le HU
        for i := 1 to Qty do begin

            // --- CREA HANDLING UNIT ---
            HU.Init();
            HU."HU Type Code" := 'SCATOLA';
            HU.Type := HU.Type::Package;
            HU.Status := HU.Status::Loaded;

            HU."Packaging Material No." := 'PADESTAL';
            HU."Location Code" := 'M01';

            HU."Creation Date-Time" := CurrentDateTime;
            HU."Created by" := UserId;
            HU."Has Content" := false;

            HU.Insert(true); // numerazione automatica EOS

            // --- CREA ASSIGNMENT ---
            Assignm.Init();
            Assignm.Validate("Handling Unit No.", HU."No.");
            Assignm.Validate("Source Type", 7321); // cluster HU
            Assignm.Validate("Source No.", ClusterNo);

            // eventuali campi importanti da propagare (dipende dalla tua configurazione)
            Assignm.Insert(true);
        end;
    end;


    local procedure GetClusterNoFromAssignm(WhseShptHeader: Record "Warehouse Shipment Header"): Code[20]
    var
        Assignm: Record "EOS055 Handling Unit Assignm.";
    begin
        // Cerca qualsiasi cluster già esistente (7321)
        Assignm.Reset();
        Assignm.SetRange("Source Type", 7321);

        if Assignm.FindFirst() then
            exit(Assignm."Source No.");

        exit('');
    end;
}
