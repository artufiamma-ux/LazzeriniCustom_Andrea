namespace Lazzerini;

using System.Security.User;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;

table 50253 "XV IK Reclami"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Code[100])
        {
            Caption = 'ID';
            Editable = false;
            NotBlank = true;

            trigger OnValidate()
            begin
                // Impedisce all'utente (o integrazioni) di impostare manualmente l'ID.
                // Se il record è nuovo e l'ID è vuoto, andrà generato in OnInsert().
                if ("ID" <> xRec."ID") and (xRec."ID" <> '') then
                    Error('L''ID è generato automaticamente e non può essere modificato.');
            end;


        }
        field(2; "Plant"; Enum "XV IK Plant")
        {
            Caption = 'Plant';
            NotBlank = true;
        }
        field(3; "Date of the document"; Date)
        {
            Caption = 'Date of the document';
            NotBlank = true;
        }
        field(4; "Type"; Enum "XV IK Type")
        {
            Caption = 'Type';
            NotBlank = true;
        }
        field(5; "Problem Description"; Text[100])
        {
            Caption = 'Problem Description';
            NotBlank = true;
        }
        field(6; "IP opened by"; Code[50])
        {
            Caption = 'Reported by (User)';
            TableRelation = "User Setup"."User ID";
            NotBlank = true;
        }
        field(7; "Source/reason of the IP"; Enum "XV IK Source/reason of the IP")
        {
            Caption = 'Source/reason of the IP';
            NotBlank = true;
        }
        field(8; "IP assigned to."; Code[50])
        {
            Caption = 'Assigned to (User)';
            TableRelation = "User Setup"."User ID";
            NotBlank = true;
        }
        field(9; "Deadline"; Date)
        {
            Caption = 'Deadline';
            NotBlank = true;
        }
        field(10; "Problem solving tool"; Enum "XV IK Problem solving tool")
        {
            Caption = 'Problem solving tool';
            NotBlank = true;
        }
        field(11; "PDCA"; Enum "XV IK PDCA")
        {
            Caption = 'PDCA';
            NotBlank = true;
        }
        field(12; "Warranty and/or Reworking"; Enum "XV IK Warranty Reworking")
        {
            Caption = 'Warranty and/or Reworking';
        }
        field(13; "Customer No."; Code[20])
        {
            Caption = 'Customer';
            TableRelation = Customer."No.";
        }
        field(14; "Supplier No."; Code[20])
        {
            Caption = 'Supplier';
            TableRelation = Vendor."No.";
        }
        field(15; "Product family"; Enum "XV IK Product family")
        {
            Caption = 'Product family';
        }
        field(16; "Item No."; Code[20])
        {
            Caption = 'Part Number / Item';
            TableRelation = Item."No.";
        }
        field(17; "List of the defects"; Enum "XV IK List of the defects")
        {
            Caption = 'List of the defects';
        }
        field(18; "4M+D Analysis"; Enum "XV IK 4M+D Analysis")
        {
            Caption = '4M+D Analysis';
        }
        field(19; "Notes"; Text[100])
        {
            Caption = 'Notes';
        }
        field(20; "Severity"; Enum "XV IK Severity")
        {
            Caption = 'Severity';
        }
        field(21; "Detection"; Enum "XV IK Detection")
        {
            Caption = 'Detection';
        }
        field(22; "Quantities of the NC parts"; Text[100])
        {
            Caption = 'Quantities of the NC parts';
        }
        field(23; "Rif. Customer NC"; Code[20])
        {
            Caption = 'Rif. Customer NC';
            TableRelation = "Sales Header"."No." where("Sell-to Customer No." = field("Customer No."));
        }
        field(24; "SR N (warranty N assigned)"; Text[100])
        {
            Caption = 'SR N (warranty N assigned)';
        }
        field(25; "Root Cause(s) - 8D"; Text[100])
        {
            Caption = 'Root Cause(s) - not to fulfill in case of 8D';
        }
        field(26; "Corrective action(s)"; Text[100])
        {
            Caption = 'Corrective action(s)';
        }
        field(27; "Link to other IP"; Text[100])
        {
            Caption = 'link to other IP (ex: IP reference to the NC vs Supplier or NC received from the Customer)';
        }
        field(28; "Closing date of the IP"; Date)
        {
            Caption = 'Closing date of the IP';
        }
        field(29; "Extra trans costs for warranty"; Text[100])
        {
            Caption = 'Extra transports costs for the warranty';
        }
        field(30; "Various costs of the IP"; Text[100])
        {
            Caption = 'Various costs of the IP';
        }
        field(31; "B - Benefit/Cost (B/C)"; Text[100])
        {
            Caption = 'B - Benefit/Cost (B/C) Analysis';
        }
        field(32; "C - Benefit/Cost (B/C)"; Text[100])
        {
            Caption = 'C - Benefit/Cost (B/C) Analysis';
        }
        field(33; "Debit note and/or Ret goods"; Enum "XV IK Debit note Ret goods")
        {
            Caption = 'Debit note and/or Returned goods';
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        Rec2: Record "XV IK Reclami";
        TodayTxt: Text[8];
        LastID: Code[100];
        SeqTxt: Text[10];
        NextSeq: Integer;
    begin
        if ID = '' then begin
            TodayTxt := Format(Today(), 0, '<Year4><Month,2><Day,2>');
            Rec2.Reset();
            Rec2.SetCurrentKey(ID);
            Rec2.SetFilter(ID, TodayTxt + '*');
            if Rec2.FindLast() then begin
                LastID := Rec2.ID;
                SeqTxt := CopyStr(LastID, StrLen(TodayTxt) + 1);
                if SeqTxt <> '' then
                    Evaluate(NextSeq, SeqTxt);
            end;
            NextSeq += 1;
            SeqTxt := Format(NextSeq);
            if StrLen(SeqTxt) < 4 then
                SeqTxt := PadStr('', 4 - StrLen(SeqTxt), '0') + SeqTxt;
            ID := TodayTxt + SeqTxt;
        end;
    end;
}
