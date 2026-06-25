namespace Xview.Custom.Lazzerini;

page 50236 "XV Drawings Lookup"
{
    PageType = List;
    SourceTable = "XV Drawing Lookup Buffer";
    SourceTableTemporary = true;

    ApplicationArea = All;
    UsageCategory = None;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Drawing No."; Rec."Drawing No.") { }
                field("Revision ID"; Rec."Revision ID") { }
                field("Revision"; Rec."Revision") { }
                field("Description"; Rec."Description") { }
                field("Component Description"; Rec."Component Description") { }
                field("Model"; Rec."Model") { }
            }
        }
    }

    trigger OnOpenPage()
    var
        Buffer: Record "XV Drawing Lookup Buffer" temporary;
    begin
        LoadData();
    end;

    local procedure LoadData()
    var
        Qry: Query "XV Drawings Max Revision";
        Draw: Record "XV Drawings Management";
    begin
        Rec.DeleteAll();

        Qry.Open();
        while Qry.Read() do begin
            Draw.Reset();
            Draw.SetRange("Drawing No.", Qry.DrawingNo);
            Draw.SetRange("Revision ID", Qry.MaxRevisionID);

            if Draw.FindFirst() then begin
                Rec.Init();
                Rec."Drawing No." := Draw."Drawing No.";
                Rec."Revision ID" := Draw."Revision ID";
                Rec."Revision" := Draw.Revision;
                Rec."Description" := Draw."Description";
                Rec."Component Description" := Draw."Component Description";
                Rec.Model := Draw.Model;

                Rec.Insert();
            end;
        end;
        Qry.Close();
    end;
}