page 50280 "XVWarehouseShipmentMob"
{
    PageType = List;
    SourceTable = "Warehouse Shipment Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Spedizioni Magazzino';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PrintColli)
            {
                Caption = 'Stampa';
                Image = Print;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PrintNode: Codeunit "XV PrintNode";
                begin
                    if Rec."No." = '' then
                        Error('Seleziona una spedizione');

                    PrintNode.PrintColliSpedizione(Rec."No.");

                    Message('Inviata');
                end;
            }
        }
    }

    views
    {
        view(SortNo)
        {
            Caption = 'Per Numero';
            OrderBy = ascending("No.");
        }
        view(SortDate)
        {
            Caption = 'Per Data';
            OrderBy = descending("Posting Date");
        }
    }
}