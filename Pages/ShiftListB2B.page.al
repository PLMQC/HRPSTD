page 33001223 "Shift List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Shift List';
    CardPageID = "Shift Card B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Shift Master B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Shift Code"; "Shift Code")
                {
                    ToolTip = 'Specifies the In and Out time assigned to an Employee or Employee''s based on a time slot.';
                    ApplicationArea = all;
                }
                field(Decription; Decription)
                {
                    ToolTip = 'Specifies the Shift name associated with a shift Code';
                    ApplicationArea = all;
                }
                field("Starting Time"; "Starting Time")
                {
                    ToolTip = 'Specifies the Shift start time applicable to all employee''s';
                    ApplicationArea = all;
                }
                field("Ending Time"; "Ending Time")
                {
                    ToolTip = 'Specifies the Shift end time applicable to all employee''s';
                    ApplicationArea = all;
                }
                field("Location Code"; "Location Code")
                {
                    ToolTip = 'A work location is the place or building where you run your organisation. If your business has offices in different locations, it is important that you add all your work locations. The location classify your employees and affect the contributions towards the Professional Tax and Labour Welfare Fund.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
    end;

    var
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";

}

