namespace Xview.Custom.Lazzerini;

table 50200 "App Log Entry"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(2; "Creation Date"; DateTime)
        {
            DataClassification = SystemMetadata;
        }
        field(3; "User ID"; Code[50])
        {
            DataClassification = EndUserIdentifiableInformation;
        }
        field(4; "Level"; Enum "XV App Log Level")
        {
            DataClassification = SystemMetadata;
        }
        field(5; "Message"; Text[250])
        {
            DataClassification = SystemMetadata;
        }
        field(6; "Source Object"; Text[100])
        {
            DataClassification = SystemMetadata;
        }
        field(7; "Source Function"; Text[100])
        {
            DataClassification = SystemMetadata;
        }
        field(8; "Record ID"; Text[250])
        {
            DataClassification = SystemMetadata;
        }
        field(9; "Session ID"; Integer)
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(Key2; "Creation Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Entry No." = 0 then
            "Entry No." := GetNextEntryNo();
    end;

    local procedure GetNextEntryNo(): Integer
    var
        LogEntry: Record "App Log Entry";
    begin
        if LogEntry.FindLast() then
            exit(LogEntry."Entry No." + 1);

        exit(1);
    end;
}