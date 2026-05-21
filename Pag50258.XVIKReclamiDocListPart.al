namespace Xview.Custom.Lazzerini;

page 50258 "XV IK Reclami Doc ListPart"
{
    PageType = ListPart;
    SourceTable = "XV IK Reclami Doc";
    ApplicationArea = All;
    Caption = 'Allegati';
    DelayedInsert = true;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type") { ApplicationArea = All; }
                field("Document Date"; Rec."Document Date") { ApplicationArea = All; }
                field("File Name"; Rec."File Name") { ApplicationArea = All; }
                field("Description"; Rec."Description") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Download)
            {
                Caption = 'Scarica';
                Image = Export;
                trigger OnAction()
                var
                    InStr: InStream;
                begin
                    Rec.CalcFields("Attached File");
                    if not Rec."Attached File".HasValue then
                        Error('Nessun file presente.');

                    Rec."Attached File".CreateInStream(InStr);
                    DownloadFromStream(InStr, 'Scarica', '', '', Rec."File Name");
                end;
            }
            /*
                        action(DeleteDoc)
                        {
                            Caption = 'Elimina Allegato';
                            Image = Delete;

                            trigger OnAction()
                            begin
                                if Confirm('Eliminare il documento e il relativo file?', false) then
                                    Rec.Delete(true);
                            end;
                        }
            */
        }
    }
}