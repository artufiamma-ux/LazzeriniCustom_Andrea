namespace Xview.Custom.Lazzerini;

query 50202 "XV Drawings Max Revision"
{
    elements
    {
        dataitem(Draw; "XV Drawings Management")
        {

            DataItemTableFilter =
                Active = const(true),
                Cancelled = const(false);
            column(DrawingNo; "Drawing No.") { }
            column(MaxRevisionID; "Revision ID")
            {
                Method = Max;
            }

        }
    }
}
