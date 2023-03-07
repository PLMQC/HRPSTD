page 33001260 "Pay Revision Header List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Pay Revision Header List';
    CardPageID = "Pay Revision Document B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Pay Revision Header B2B";
    SourceTableView = SORTING()
                      WHERE(Posted = FILTER(false));
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
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Pay Revision Document B2B";
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Process of Pay Revision Document';
                }
            }
        }
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

