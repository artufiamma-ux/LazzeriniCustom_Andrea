namespace Lazzerini;

table 50254 "XV IK Reclami Doc"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Documento Entry No."; Code[120])
        {
            Caption = 'Documento Entry No.';
            Editable = false;
        }

        field(2; "Reclamo ID"; Code[100])
        {
            Caption = 'Reclamo ID';
            Editable = false;
        }

        field(3; "Document Type"; Enum "XV IK Tipo Allegato Reclami")
        {
            Caption = 'Document Type';
        }

        field(4; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Editable = false;
        }

        field(5; "File Name"; Text[250])
        {
            Caption = 'File Name';
            Editable = false;
        }

        field(6; "Description"; Text[100])
        {
            Caption = 'Description';
        }

        field(7; "Attached File"; Blob)
        {
            Caption = 'Attached File';
            Subtype = Memo;
        }
    }

    keys
    {
        key(PK; "Documento Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        R: Record "XV IK Reclami Doc";
        SeqTxt: Text;
        Seq: Integer;
    begin
        // Data documento
        if "Document Date" = 0D then
            "Document Date" := WorkDate();

        // PK generata automaticamente
        if "Documento Entry No." = '' then begin
            R.Reset();
            R.SetRange("Reclamo ID", "Reclamo ID");

            if R.FindLast() then begin
                // parte dopo il punto
                SeqTxt := CopyStr(
                    R."Documento Entry No.",
                    StrLen("Reclamo ID") + 2
                );
                Evaluate(Seq, SeqTxt);
            end;

            Seq += 1;
            SeqTxt := Format(Seq);
            if StrLen(SeqTxt) < 4 then
                SeqTxt := PadStr('', 4 - StrLen(SeqTxt), '0') + SeqTxt;

            "Documento Entry No." := "Reclamo ID" + '.' + SeqTxt;
        end;
    end;
}