namespace Xview.Custom.Lazzerini;
table 50226 "XV Drawings Management"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(3; "Drawing No."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(15; "Revision ID"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(4; "Revision"; Code[10])
        {
            DataClassification = CustomerContent;
        }

        field(10; "Cancelled"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if Cancelled then begin
                    if Active then begin
                        Active := false;
                    end;
                end;

            end;
        }

        field(16; "Active"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(9; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(12; "Last Modified DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
        }

        field(6; "Description"; Text[500])
        {
            DataClassification = CustomerContent;
        }

        field(7; "Component Description"; Text[500])
        {
            DataClassification = CustomerContent;
        }

        field(14; "Designer"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(8; "Model"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(13; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
        }

        field(11; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }

        field(17; "Visible Supplier Portal"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Drawing No.", "Revision ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        Drawings: Record "XV Drawings Management";
    begin
        // Calcolo del prossimo Drawing No. se non specificato
        if "Drawing No." = '' then begin
            // Nota: FindLast si basa sulla PK. 
            // Per sicurezza, se vuoi l'ultimo numero, sarebbe meglio impostare un indice solo su "Drawing No."
            if Drawings.FindLast() then
                "Drawing No." := IncStr(Drawings."Drawing No.")
            else
                "Drawing No." := '10000';
        end;

        // Se la revisione non è specificata, parte da 1
        if "Revision ID" = 0 then
            "Revision ID" := 1;

        // Campi di tracciabilità (rimosse le duplicazioni)
        "Creation Date" := Today();
        "Created By" := UserId();
        "Active" := false;
    end;

    trigger OnModify()
    begin
        "Last Modified DateTime" := CurrentDateTime();
        "Modified By" := UserId();
        if "Active" then DeactivateOtherRevision();
    end;

    procedure SetNewRevision()
    var
        RecDrawings: Record "XV Drawings Management";
    begin
        RecDrawings.Reset();
        RecDrawings.SetRange("Drawing No.", Rec."Drawing No.");

        // Imposto la chiave (assicurati che includa Revision ID)
        RecDrawings.SetCurrentKey("Drawing No.", "Revision ID");

        // Ordinamento decrescente sulla Revision ID
        RecDrawings.SetAscending("Revision ID", false);

        // Prendo il record con la revisione più alta
        if RecDrawings.FindFirst() then
            Rec."Revision ID" := RecDrawings."Revision ID" + 1
        else
            Rec."Revision ID" := 1; // primo inserimento
    end;

    procedure DeactivateOtherRevision()
    var
        RecDrawings: Record "XV Drawings Management";
        CurrentRevision: Integer;
    begin
        CurrentRevision := Rec."Revision ID";
        RecDrawings.Reset();
        RecDrawings.SetRange("Drawing No.", Rec."Drawing No.");
        RecDrawings.SetFilter("Revision ID", '<>%1', Rec."Revision ID");
        if RecDrawings.FindSet() then
            repeat begin
                RecDrawings.Active := false;
                RecDrawings.Modify();
            end;
            until RecDrawings.Next() = 0;
        Rec.Cancelled := false;
    end;

}