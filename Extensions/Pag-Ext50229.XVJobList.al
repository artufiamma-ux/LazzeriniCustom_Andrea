namespace Lazzerini;

using Microsoft.Projects.Project.Job;

pageextension 50229 "XV Job List" extends "Job List"
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
