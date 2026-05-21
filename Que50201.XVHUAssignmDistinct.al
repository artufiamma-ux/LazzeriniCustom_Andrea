namespace Lazzerini;

query 50201 "XV HUAssignmDistinct"
{
    Caption = 'XV HUAssignmDistinct';
    QueryType = Normal;


    elements
    {
        dataitem(HU; "EOS055 Handling Unit Assignm.")
        {
            column(NrScatola; "Nr Scatola")
            {
            }

            column(HandlingUnitNo; "Handling Unit No.")
            {
            }

            column(DummyCount)
            {
                Method = Count;
            }
        }
    }
}
