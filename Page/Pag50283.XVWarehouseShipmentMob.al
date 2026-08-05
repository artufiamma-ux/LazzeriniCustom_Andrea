namespace Xview.Custom.Lazzerini;

using Microsoft.Warehouse.Document;

page 50283 "XVWarehouseShipmentMob"
{
    PageType = List;
    SourceTable = "Warehouse Shipment Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Spedizioni Magazzino Mobile';
    AdditionalSearchTerms = 'XV Stampa Colli Spedizione';

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
                    //PrintNode: Codeunit "XV PrintNode";
                    Rep: Report "XV Colli Di Spedizione";
                begin
                    if Rec."No." = '' then
                        Error('Seleziona una spedizione');

                    //PrintNode.PrintColliSpedizione(Rec."No.");
                    Rep.SetWarehouseShipmentNo(Rec."No.");
                    Rep.RunModal();
                    //Message('Inviata');
                end;
            }
            action(ZPrintColli)
            {
                Caption = 'Stampa';
                Image = PrintForm;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PrintNode: Codeunit "XV PrintNode Mgt";
                begin
                    if Rec."No." = '' then
                        Error('Seleziona una spedizione');

                    PrintNode.PrintReport(Enum::"XV PrintNode Report"::"XV Colli Di Spedizione", Rec."No.");
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