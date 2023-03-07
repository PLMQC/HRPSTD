page 33001533 "HR & Payroll Activities B2B"
{
    // version B2BHR1.00.00

    Caption = 'HR & Payroll Activities';
    PageType = CardPart;
    SourceTable = "Hr & Payroll Cue B2B";


    layout
    {
        area(content)
        {
            cuegroup("Employee Information")
            {
                Caption = 'Employee Information';
                field(Blocked; Blocked)
                {
                    ToolTip = 'Shows the count of number employees blocked.';
                    ApplicationArea = all;
                }
                field(Probation; Probation)
                {
                    ToolTip = 'Shows the count of number employees in probation.';
                    ApplicationArea = all;
                }
                field("Total Employees"; "Total Employees")
                {
                    ToolTip = 'Shows the count of number employees.';
                    ApplicationArea = all;
                }
                field("BirthDay's TODAY()"; "BirthDay's TODAY()")
                {
                    ToolTip = 'Shows number of employees birthdays TODAY().';
                    Caption = 'BirthDay''s TODAY()';
                    ApplicationArea = all;

                    trigger OnDrillDown();
                    begin
                        Employee.RESET();
                        Employee.SETRANGE(Blocked, false);
                        Employee.SETFILTER("Birth Date", '<>%1', 0D);
                        if Employee.FINDFIRST() then
                            repeat
                                Employee.MARK(false);
                                if (DMY2DATE(DATE2DMY(Employee."Birth Date", 1), DATE2DMY(Employee."Birth Date", 2), DATE2DMY("Current Date", 3))
                                    = "Current Date") then
                                    Employee.MARK(true);
                            until Employee.NEXT() = 0;
                        Employee.MARKEDONLY(true);
                        PAGE.RUNMODAL(0, Employee);
                    end;
                }

                // actions
                // {
                //     action("<Action1102152010>")
                //     {
                //         ToolTip = 'On clciking creates the new employee.';
                //         Caption = 'Create New Employee';
                //         Image = TileNew;
                //         RunObject = Page "Employee Card B2B";
                //         RunPageMode = Create;
                //         ApplicationArea = all;
                //     }
                // }
            }
            cuegroup("Leave Information")
            {
                Caption = 'Leave Information';
                field("Employees On Leave"; "Employees On Leave")
                {
                    ToolTip = 'Shows the count of number employees in Leave TODAY().';
                    Caption = 'Employees On Leave';
                    ApplicationArea = all;

                    trigger OnDrillDown();
                    begin
                        DailyAttendance.RESET();
                        DailyAttendance.SETRANGE(Date, "Current Date");
                        DailyAttendance.SETRANGE("Not Joined", 0);
                        DailyAttendance.SETFILTER("Attendance Type", Text33001Lbl);
                        PAGE.RUNMODAL(0, DailyAttendance);
                    end;
                }
                field("Leave Application Not Approved"; "Leave Application Not Approved")
                {
                    Caption = 'Leave Application Not Approved';
                    ApplicationArea = all;
                    ToolTip = 'Leave Application Not approved';
                    trigger OnDrillDown();
                    begin
                        PostLeaveApp.RESET();
                        PostLeaveApp.SETRANGE("Location Code", "Location Code");
                        if PostLeaveApp.FINDFIRST() then
                            repeat
                                PostLeaveApp.MARK(false);
                                PostedLeaveLine.RESET();
                                PostedLeaveLine.SETRANGE("Location Code", "Location Code");
                                PostedLeaveLine.SETRANGE("Document No.", PostLeaveApp."Document No.");
                                PostedLeaveLine.SETRANGE("Set For Approval", true);
                                if PostedLeaveLine.FINDFIRST() then
                                    PostLeaveApp.MARK(true);
                            until PostLeaveApp.NEXT() = 0;
                        PostLeaveApp.MARKEDONLY(true);
                        PAGE.RUNMODAL(0, PostLeaveApp)
                    end;
                }
                field("Leave Cancellled Not Approved"; "Leave Cancellled Not Approved")
                {
                    ToolTip = 'Shows the count of number employees Leave not Approved.';
                    Caption = 'Leave Cancellled Not Approved';
                    ApplicationArea = all;

                    trigger OnDrillDown();
                    begin
                        PostLeaveApp.RESET();
                        PostLeaveApp.SETRANGE("Location Code", "Location Code");
                        if PostLeaveApp.FINDFIRST() then
                            repeat
                                PostLeaveApp.MARK(false);
                                PostedLeaveLine.RESET();
                                PostedLeaveLine.SETRANGE("Location Code", "Location Code");
                                PostedLeaveLine.SETRANGE("Document No.", PostLeaveApp."Document No.");
                                PostedLeaveLine.SETRANGE("Pending For Cancellation", true);
                                if PostedLeaveLine.FINDFIRST() then
                                    PostLeaveApp.MARK(true);
                            until PostLeaveApp.NEXT() = 0;
                        PostLeaveApp.MARKEDONLY(true);
                        PAGE.RUNMODAL(0, PostLeaveApp)
                    end;
                }

                // actions
                // {
                //     action("Leave Application")
                //     {
                //         ToolTip = 'Specifies the leave Application.';
                //         Caption = 'Leave Application';
                //         RunObject = Page "Leave Application";
                //         Image = TileRed;
                //         RunPageMode = Create;
                //         ApplicationArea = all;

                //     }
                // }
            }
            cuegroup("Training Information")
            {
                Caption = 'Training Information';
                field("Trainings Scheduled TODAY()"; "Trainings Scheduled TODAY()")
                {
                    ToolTip = 'Shows the count of number employees Training scheduled TODAY().';
                    Caption = 'Trainings Scheduled TODAY()';
                    ApplicationArea = all;
                }
            }
            cuegroup(Recruitment)
            {
                Caption = 'Recruitment';
                field("Resumes In Hand"; "Resumes In Hand")
                {
                    ToolTip = 'Shows the number Resumes in hand.';
                    Caption = 'Resumes In Hand';
                    ApplicationArea = all;
                }
                field("Res. Indent Pending"; "Res. Indent Pending")
                {
                    ToolTip = 'Shows the count resource indent pending.';
                    Caption = 'Res. Indent Pending';
                    ApplicationArea = all;
                }
                field("Res. Indent Pending  Approval"; "Res. Indent Pending  Approval")
                {
                    ToolTip = 'Shows the count resource indent pending for Approval.';
                    Caption = 'Res. Indent Pending  Approval';
                    ApplicationArea = all;
                }

                // actions
                // {
                //     action("<Action1102152023>")
                //     {
                //         ToolTip = 'Specifies the new resume of the employee.';
                //         Caption = 'New Resume';
                //         RunObject = Page "Resume Database Card B2B";
                //         RunPageMode = Create;
                //         ApplicationArea = all;

                //     }
                //     action("<Action1102152024>")
                //     {
                //         ToolTip = 'Specifies the new man power requistion made.';
                //         Caption = 'New Man Power Requisition';
                //         RunObject = Page "Resource Indent";
                //         RunPageMode = Create;
                //         Image = TileSettings;
                //         ApplicationArea = all;
                //     }
                // }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        RESET();
        if not GET() then begin
            INIT();
            INSERT();
        end;

        "Location Code" := LocWiseMiscGCU.ReturnUserLocationCode();
        "Current Date" := workdate();
        MODIFY();

        SETRANGE("Date Filter", 0D, WORKDATE() - 1);
        SETFILTER("Date Filter2", '>=%1', WORKDATE());

        Employee.RESET();
        Employee.SETRANGE(Blocked, false);
        Employee.SETFILTER("Birth Date", '<>%1', 0D);
        if Employee.FINDFIRST() then
            repeat
                if (DMY2DATE(DATE2DMY(Employee."Birth Date", 1), DATE2DMY(Employee."Birth Date", 2), DATE2DMY("Current Date", 3))
                    = "Current Date") then
                    EmpCount += 1;
            until Employee.NEXT() = 0;
        "BirthDay's TODAY()" := EmpCount;
        MODIFY();
    end;

    var
        Employee: Record "Employee B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        PostLeaveApp: Record "Posted Leave App Header B2B";
        PostedLeaveLine: Record "Posted Leave App Line B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        EmpCount: Integer;
        Text33001Lbl: Label 'Absent|Leave';
}

