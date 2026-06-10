namespace Xview.Custom.Lazzerini;

table 50251 "XV IK Strumenti di Misura"
{
    Caption = 'XV IK Strumenti di Misura';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }

        // Utente leggibile (UPN / user name). Sempre assegnato automaticamente, mai editabile.
        field(10; "User ID"; Text[100])
        {
            Caption = 'Utente';
            Editable = false;
            DataClassification = SystemMetadata;
        }

        // (Opzionale ma utile) GUID tecnico dell’utente
        field(11; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            Editable = false;
            DataClassification = SystemMetadata;
        }

        field(20; "Descrizione"; Text[500])
        {
            Caption = 'Descrizione';
            NotBlank = true;
            DataClassification = CustomerContent;
        }

        field(30; "Ubicazione"; Text[100])
        {
            Caption = 'Ubicazione';
            DataClassification = CustomerContent;
        }

        field(40; "Tipo Strumento"; Enum "XV IK Tipo Strumento")
        {
            Caption = 'Tipo Strumento';
            DataClassification = CustomerContent;
        }

        field(50; "Bollino"; Enum "XV IK Bollino")
        {
            Caption = 'Bollino';
            DataClassification = CustomerContent;
        }

        field(60; "Stato"; Enum "XV IK Stato")
        {
            Caption = 'Stato';
            DataClassification = CustomerContent;
        }
        field(70; "Note"; Text[500])
        {
            Caption = 'Note';
            DataClassification = CustomerContent;
        }
        field(80; "Matricola"; Code[50])
        {
            Caption = 'Matricola';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }

    trigger OnInsert()
    begin
        // Assegna automaticamente l’utente che inserisce (mai editabile)
        if "User ID" = '' then
            "User ID" := UserId();            // UPN/nome dell’utente corrente (testo)
        if IsNullGuid("User Security ID") then
            "User Security ID" := UserSecurityId(); // GUID tecnico
    end;
}