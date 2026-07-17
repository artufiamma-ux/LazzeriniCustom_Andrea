table 50051 "XV Generic Code Lookup"
{
    Caption = 'XV Generic Code Lookup';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Value"; Code[20])
        {
            Caption = 'Value';
        }
    }
    keys
    {
        key(PK; "Value")
        {
            Clustered = true;
        }
    }
}
