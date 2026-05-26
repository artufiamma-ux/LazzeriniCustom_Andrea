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

        field(6; "Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(7; "Component Description"; Text[100])
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
    end;
}