page 33001221 "Off days B2B"
{
    // version B2BHR1.00.00

    Caption = 'Off days';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Off Day B2B";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Location Code"; "Location Code")
                {
                    ToolTip = 'A work location is the place or building where you run your organisation. If your business has offices in different locations, it is important that you add all your work locations. The location classify your employees and affect the contributions towards the Professional Tax and Labour Welfare Fund.';
                    ApplicationArea = all;
                }
                field(Day; Day)
                {
                    ToolTip = 'Specifies Off-days as per the company policy can be specified in the Off-days setup. Select the Day for which Off-day is applicable along with Weekly Off type either as Full Day or Half Day, also specify the Week No. as required';
                    ApplicationArea = all;
                }
                field("Weekly Off"; "Weekly Off")
                {
                    ToolTip = 'Specifies the Week Off Days specific a shift  Shift master / in nature of General. They are attached to Employees in working scenario and act as Paid day.';
                    ApplicationArea = all;
                }
                field("Week No."; "Week No.")
                {
                    ToolTip = 'Specifies the name of week''s present in a month.';
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

        [InDataSet]
        Editablegroup: Boolean;
        [InDataSet]
        NonEditableGroup: Boolean;

    procedure SetLocEdit();
    begin
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then begin
            Editablegroup := true;
            NonEditableGroup := false;
        end else begin
            Editablegroup := false;
            NonEditableGroup := true;
        end;
        CurrPage.UPDATE();
    end;
}

