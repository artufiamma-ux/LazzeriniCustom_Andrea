controladdin "XV Zebra Articolo"
{
    StartupScript = 'xvarticolo.js';
    StyleSheets = 'xvarticolo.css';

    RequestedWidth = 500;
    RequestedHeight = 800;

    HorizontalStretch = true;
    VerticalStretch = true;

    event ActionSelected(ActionName: Text; Barcode: Text);
    event BarcodeScanned(Barcode: Text);
    procedure SetItemData(
        Row1: Text;
        Row2: Text;
        Row3: Text;
        Row4: Text;
        RecType: Text
        );



}
