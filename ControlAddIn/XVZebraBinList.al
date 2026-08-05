controladdin "XV Zebra Bin List"
{
    StartupScript = 'xvbinlist.js';
    StyleSheets = 'xvbinlist.css';

    procedure ClearCards();

    procedure AddCard(
        RecordNo: Integer;
        No: Text;
        Description: Text;
        UOM: Text;
        Qty: Decimal);
    procedure AddCardContainer(
        Title: Text;
        Type: Text
);

    event MoveRequested(No: Text);
    event ControlReady();
}