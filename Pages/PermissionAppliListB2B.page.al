page 33001541 "Permission Appli. List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Permission Application List';
    CardPageID = "Permission Application B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Attendance Header B2B";
    SourceTableView = WHERE("Document Type" = CONST(Permission),
                            Status = CONST(Open));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("No."; "No.")
                {
                    ToolTip = 'Choose the Permission number sereis.';
                    ApplicationArea = all;
                }
                field("Creation Date"; "Creation Date")
                {
                    ToolTip = 'Choose the Creation date.';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Select the month.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Select the year.';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Choose the permission Start Date.';
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
                {
                    ToolTip = 'Choose the Permission End date.';
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ToolTip = 'Choose the Dimension.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Choose the physical location of the employee.';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ToolTip = 'Choose the type Employee/Department.';
                    ApplicationArea = all;
                }
                field("Code"; Code)
                {
                    ToolTip = 'Choose the Employee No.';
                    ApplicationArea = all;
                }
                field("Shift Code"; "Shift Code")
                {
                    ToolTip = 'Choose the Employee Shift code.';
                    ApplicationArea = all;
                }
                field("Permission Type"; "Permission Type")
                {
                    ToolTip = 'Choose the permission Type Ex. Late coming/early leaving.';
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    ToolTip = 'Choose the  user ID.';
                    ApplicationArea = all;
                }
                field("Approved By"; "Approved By")
                {
                    ToolTip = 'Shows the name Permission Approved By.';
                    ApplicationArea = all;
                }
                field("Mode Of Travel"; "Mode Of Travel")
                {
                    ToolTip = 'Choose Mode of Travel.';
                    ApplicationArea = all;
                }
                field("Mode of Booking"; "Mode of Booking")
                {
                    ToolTip = 'Choose the mode of Booking.';
                    ApplicationArea = all;
                }
                field("Assignment No."; "Assignment No.")
                {
                    ToolTip = 'choose the Assignment No.';
                    ApplicationArea = all;
                }
                field("Assignment Name"; "Assignment Name")
                {
                    ToolTip = 'Choose the Assignment Name.';
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ToolTip = 'Choose the Dimension.';
                    ApplicationArea = all;
                }
                field("Places To Visit"; "Places To Visit")
                {
                    ToolTip = 'Enter the place of visit.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Get &Employees")
                {
                    Caption = 'Get &Employees';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the entries of the Employee';
                    trigger OnAction();
                    begin
                        InsertPermissionEmployees();
                    end;
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'Specify the Status of Re&lease';
                    trigger OnAction();
                    begin
                        ReleasePermission();
                    end;
                }
            }
        }
    }

    var
        Text001Lbl: Label 'Do you want to release the document';

    procedure ReleasePermission();
    var
        AttApprovals: Codeunit "Attendance Approvals B2B";
    begin
        CheckValidEntries();

        if CONFIRM(Text001Lbl) then
            AttApprovals.ReleaseOvertime(Rec);
    end;
}

