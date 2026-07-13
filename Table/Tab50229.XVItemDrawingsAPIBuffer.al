namespace Xview.Custom.Lazzerini;

table 50229 "XV Item Drawings API Buffer"
{
    TableType = Temporary;
    DataClassification = CustomerContent;

    fields
    {
        field(1; Id; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(2; ItemNo; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(4; Description2; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(5; ItemType; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(6; ItemCategoryCode; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(7; CategoryDescription; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(8; UnitVolume; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; UnitOfMeasureId; Guid)
        {
            DataClassification = CustomerContent;
        }
        field(10; VendorNo; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; VendorItemNo; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(12; DrawingNo; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13; DrawingDescription; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(14; DrawingRevision; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(15; DrawingComponentDescription; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(16; DrawingDesigner; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(17; DrawingModel; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }
}
