page 33001454 "Posted Pay Rev. Headers B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Pay Rev. Header List';
    CardPageID = "Posted Pay Rev. Document B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Pay Revision Header B2B";
    SourceTableView = SORTING ()
                      WHERE (Posted = FILTER (true));
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Id."; "Id.")
                {
                    ToolTip = '"Specifies thepay reveiosn document Id number "';
                    ApplicationArea = all;
                }
                field("No."; "No.")
                {
                    ToolTip = 'Specifies the employee no from the drill down lsit';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Specifies the employee name against the employee number';
                    ApplicationArea = all;
                }
                field(Grade; Grade)
                {
                    ToolTip = 'Specifies the Grade in pay revision list';
                    ApplicationArea = all;
                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Specifies th eeffecitive date of the pay revison begins';
                    ApplicationArea = all;
                }
                field("New Grade"; "New Grade")
                {
                    ToolTip = '"Specifies the new grade of teh employee "';
                    ApplicationArea = all;
                }
                field("Revisied Date"; "Revisied Date")
                {
                    ToolTip = 'Specifies the revised date of pay revison header list';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {

    }

    trigger OnOpenPage();
    var
        PayrollUsers: Record "Payroll Location Users B2B";
    begin
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
    end;

    var
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
}

