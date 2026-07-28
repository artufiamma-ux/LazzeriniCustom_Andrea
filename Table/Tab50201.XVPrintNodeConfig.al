namespace Xview.Custom.Lazzerini;
table 50201 "XV PrintNode Config"
{
    Caption = 'PrintNode Config';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Report ID"; Integer)
        {
            Caption = 'Report ID';
        }

        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
        }

        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }

        field(10; "Printer Id"; BigInteger)
        {
            Caption = 'Printer Id';
        }

        field(20; "Job Title"; Text[100])
        {
            Caption = 'Job Title';
        }
        /*
                field(30; "API Key"; Text[250])
                {
                    Caption = 'API Key';
                }

                field(40; "PrintNode Url"; Text[250])
                {
                    Caption = 'PrintNode Url';
                    InitValue = 'https://api.printnode.com/printjobs';
                }
        */
        field(50; Enabled; Boolean)
        {
            Caption = 'Enabled';
            InitValue = true;
        }
        field(60; Copies; Integer) { }
        field(70; "Print Node Computer Id"; BigInteger) { }
        field(80; "Print Node Account"; Code[20]) { }
        field(90; "Paper Source"; Text[50]) { }
    }

    keys
    {
        key(PK; "Report ID")
        {
            Clustered = true;
        }

        key(CodeKey; "Code")
        {
        }
    }
}