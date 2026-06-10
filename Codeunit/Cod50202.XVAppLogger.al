namespace Xview.Custom.Lazzerini;

codeunit 50202 "XV App Logger"

{
    SingleInstance = true;

    procedure LogInfo(Message: Text; SourceObject: Text; SourceFunction: Text)
    begin
        InsertLog(Message, Enum::"XV App Log Level"::Info, SourceObject, SourceFunction, '');
    end;

    procedure LogWarning(Message: Text; SourceObject: Text; SourceFunction: Text)
    begin
        InsertLog(Message, Enum::"XV App Log Level"::Warning, SourceObject, SourceFunction, '');
    end;

    procedure LogError(Message: Text; SourceObject: Text; SourceFunction: Text)
    begin
        InsertLog(Message, Enum::"XV App Log Level"::Error, SourceObject, SourceFunction, '');
    end;

    procedure LogDebug(Message: Text; SourceObject: Text; SourceFunction: Text)
    begin
        InsertLog(Message, Enum::"XV App Log Level"::Debug, SourceObject, SourceFunction, '');
    end;

    procedure LogWithRecord(Message: Text; Level: Enum "XV App Log Level"; RecVariant: Variant; SourceObject: Text; SourceFunction: Text)
    var
        RecRef: RecordRef;
        RecIdTxt: Text;
    begin
        if RecVariant.IsRecord() then begin
            RecRef.GetTable(RecVariant);
            RecIdTxt := Format(RecRef.RecordId);
        end;

        InsertLog(Message, Level, SourceObject, SourceFunction, RecIdTxt);
    end;

    local procedure InsertLog(Message: Text; Level: Enum "XV App Log Level"; SourceObject: Text; SourceFunction: Text; RecordIdTxt: Text)
    var
        LogEntry: Record "App Log Entry";
    begin
        LogEntry.Init();
        LogEntry."Creation Date" := CurrentDateTime();
        LogEntry."User ID" := UserId();
        LogEntry."Level" := Level;
        LogEntry."Message" := CopyStr(Message, 1, 250);
        LogEntry."Source Object" := SourceObject;
        LogEntry."Source Function" := SourceFunction;
        LogEntry."Record ID" := RecordIdTxt;
        LogEntry."Session ID" := SessionId();

        LogEntry.Insert(true);
    end;
}