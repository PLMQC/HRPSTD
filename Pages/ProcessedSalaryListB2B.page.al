page 33001244 "Processed Salary List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Processed Salary List';
    CardPageID = "Processed Salary B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Processed Salary B2B";
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Employee Code"; "Employee Code")
                {
                    ToolTip = 'Specify in the processed salary list of the employee code';
                    ApplicationArea = all;
                }
                field("Add/Deduct Code"; "Add/Deduct Code")
                {
                    ToolTip = 'Specifies the addition and dedcution code in the processed salary list';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Specifies the the year in the processed salary list';
                    ApplicationArea = all;
                }
                field("Pay Slip Month"; "Pay Slip Month")
                {
                    Caption = 'Month';
                    ToolTip = 'specify month on the processed salary list';
                    ApplicationArea = all;
                }
                field(Days; Days)
                {
                    ToolTip = 'specifie the days on th eprocessed salary list';
                    ApplicationArea = all;
                }
                field(Attendance; Attendance)
                {
                    ToolTip = 'specifies the attendence on processed salary list';
                    ApplicationArea = all;
                }
                field("Add/Deduct"; "Add/Deduct")
                {
                    ToolTip = 'specifies the add or decuction of the processes salary list';
                    ApplicationArea = all;
                }
                field("Computation Type"; "Computation Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'specifies the computation type on the processed salary list';
                }
                field("Earned Amount"; "Earned Amount")
                {
                    ToolTip = 'Specifies the earned amount on the processed salary list';
                    ApplicationArea = all;
                }
                field("Co. Contributions"; "Co. Contributions")
                {
                    ToolTip = 'Specifies the co contribution on the processed slary list';
                    ApplicationArea = all;
                }
                field("Co. Contribution2"; "Co. Contribution2")
                {
                    ToolTip = 'Specifies the co contribution on the porcessed salary list';
                    ApplicationArea = all;
                }
                field("Arrear Amount"; "Arrear Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Arrear Amount of the Employee';
                }
                field("Arrears Not Posted"; "Arrears Not Posted")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Arrears which are Not Posted ';
                }
                field("Arrear Co. Contribution"; "Arrear Co. Contribution")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Arrear Co Contribution ';
                }
                field("Arrear Co. Contribution2"; "Arrear Co. Contribution2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Arrear Co Contribution ';
                }
                field("Arrear Salary"; "Arrear Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Arrear Salary';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Dimension)
            {
                Caption = 'Dimension';
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    ToolTip = 'Dimension';
                    trigger OnAction();
                    begin

                        ShowDimensions();
                        CurrPage.SAVERECORD();
                    end;
                }
            }
        }
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

