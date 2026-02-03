codeunit 50055 "XV Bin Events"
{
    [EventSubscriber(
    ObjectType::Table,
    Database::Bin, // qui va la codeunit corretta che solleva l'evento
    'OnBeforeOnModify',
    '',
    false,
    false)]
    local procedure UpdateTipoPrelievoOnModify(var Bin: Record Bin; var xBin: Record Bin; var IsHandled: Boolean)
    begin
        // controlla se il valore del campo "Zone Code" è cambiato
        if Bin."Zone Code" <> xBin."Zone Code" then
            case Bin."Zone Code" of
                'COOPE':
                    Bin."Tipo Prelievo" := 'PRELIEVO COOPERATIVA';
                'REPOU', 'REPIN':
                    Bin."Tipo Prelievo" := 'PRELIEVO INTERNO';
            end;
    end;

}
