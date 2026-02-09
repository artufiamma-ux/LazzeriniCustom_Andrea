namespace Lazzerini;

table 50252 "XV IK Strumenti di Misura Doc"
{
    Caption = 'XV IK Strumenti di Misura Documenti';
    DataClassification = ToBeClassified;

    fields
    {
        // Chiave tecnica univoca del documento (nuova)
        field(2; "Documento Entry No."; Integer)
        {
            Caption = 'Documento Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(1; "Strumento di misura Entry No."; Integer)
        {
            Caption = 'Strumento di misura';
            DataClassification = CustomerContent;
            TableRelation = "XV IK Strumenti di Misura"."Entry No.";
        }

        field(10; "Tipo Documento"; Text[100])
        {
            Caption = 'Tipo Documento';
            DataClassification = CustomerContent;
        }

        field(20; "Nome Documento"; Text[100])
        {
            Caption = 'Nome Documento';
            DataClassification = CustomerContent;
        }

        field(30; "Data Ultimo Intervento"; Date)
        {
            Caption = 'Data Ultimo Intervento';
            DataClassification = CustomerContent;
        }

        field(40; "Periodicità (Mesi)"; Integer)
        {
            Caption = 'Periodicità (Mesi)';
            DataClassification = CustomerContent;
        }

        field(45; "Data Prossimo Intervento"; Date)
        {
            Caption = 'Data Prossimo Intervento';
            DataClassification = CustomerContent;
        }
        field(70; "Note"; Text[500])
        {
            Caption = 'Note';
            DataClassification = CustomerContent;
        }

        field(50; "Allegato"; Media)
        {
            Caption = 'Allegato';
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
            ObsoleteReason = 'Campo non più utilizzato';
            ObsoleteTag = '2024.01';

        }
        field(60; "Allegati"; MediaSet)
        {
            Caption = 'Allegato';
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
            ObsoleteReason = 'Campo non più utilizzato';
            ObsoleteTag = '2024.01';

        }
        field(50100; "Allegato Contenuto"; Blob)
        {
            Caption = 'Allegato';
            DataClassification = CustomerContent;
        }
        field(50101; "Nome File Originale"; Text[250])
        {
            Caption = 'Nome File';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        // PK su chiave tecnica per permettere duplicati di Nome Documento per lo stesso Strumento
        key(PK; "Documento Entry No.")
        {
            Clustered = true;
        }

        // Chiavi utili a filtri/ordinamenti nelle pagine e report
        key(Strumento; "Strumento di misura Entry No.") { }
        key(StrumentoNome; "Strumento di misura Entry No.", "Nome Documento") { }
        key(StrumentoData; "Strumento di misura Entry No.", "Data Ultimo Intervento") { }
    }
}