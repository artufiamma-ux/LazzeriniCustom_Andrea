namespace Xview.Custom.Lazzerini;

using Microsoft.Purchases.Document;

tableextension 50230 "XV Purchase Line" extends "Purchase Line"
{
    fields
    {
        field(50201; "Drawing No."; Code[20])
        {
            Caption = 'Drawing No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50202; "Drawing Revision Id"; Integer)
        {
            Caption = 'Drawing Revision Id';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50203; "Drawing Revision"; Code[10])
        {
            Caption = 'Drawing Revision';
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }
}
