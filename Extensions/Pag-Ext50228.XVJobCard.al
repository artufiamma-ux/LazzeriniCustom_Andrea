namespace Lazzerini;

using Microsoft.Projects.Project.Job;

pageextension 50228 "XV Job Card" extends "Job Card"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(EOSFactbox; "EOS069 DCS FactBox")
            {
                ApplicationArea = All;
            }
        }
    }
}
