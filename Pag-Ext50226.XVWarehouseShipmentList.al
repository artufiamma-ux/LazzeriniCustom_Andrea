pageextension 50226 "XV Warehouse Shipment List" extends "Warehouse Shipment List"
{
    actions
    {
        addlast(Creation)
        {
            action("Stampa etichette ricambi")
            {
                Caption = 'Stampa etichette ricambi';
                Image = Print;
                ApplicationArea = All;

                trigger OnAction()
                var
                    WhseShipmentHeader: Record "Warehouse Shipment Header";
                    WhseShipmentLine: Record "Warehouse Shipment Line";
                    Item: Record Item;
                    TempPreviewRec: Record "Item Reference" temporary;
                    PreviewPage: Page 50227;
                    TotalLabels: Decimal;
                    DestinationNos: List of [Code[20]]; // lista parallela dei Destination No.
                begin
                    WhseShipmentHeader := Rec;

                    WhseShipmentLine.SetRange("No.", WhseShipmentHeader."No.");

                    if WhseShipmentLine.FindSet() then begin
                        repeat
                            TotalLabels += WhseShipmentLine.Quantity;

                            if Item.Get(WhseShipmentLine."Item No.") then begin
                                TempPreviewRec.Init();
                                TempPreviewRec."Reference No." := WhseShipmentLine."Item No.";
                                TempPreviewRec.Description := Item.Description;
                                TempPreviewRec."Reference Type No." := Format(WhseShipmentLine.Quantity);
                                TempPreviewRec.Insert();

                                // memorizza Destination No. nella lista parallela
                                DestinationNos.Add(WhseShipmentLine."Destination No.");
                            end;

                        until WhseShipmentLine.Next() = 0;

                        // Passa la lista parallela e il record temporaneo alla pagina preview
                        PreviewPage.SetTempTable(TempPreviewRec, DestinationNos, TotalLabels);
                        PreviewPage.RunModal();

                    end else
                        Message('Non ci sono articoli in questa spedizione.');
                end;
            }
        }
    }
}