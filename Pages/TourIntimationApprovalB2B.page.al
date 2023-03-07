page 33001344 "Tour Intimation Approval B2B"
{
    // version B2BHR1.00.00

    Caption = 'Tour Intimation Approval';
    Editable = false;
    PageType = Worksheet;
    SourceTable = "Attendance Header B2B";
    SourceTableView = WHERE(Status = FILTER(<> Approved));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee no in Tour intimation approval';
                }
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee code in Tour intimation approval';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee name in Tour intimation';
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee creation date in Tour intimation';
                }
                field(Month; Month)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee tour month in Tour intimation';
                }
                field(Year; Year)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee tour year in Tour intimation';
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee tour start date in Tour intimation';
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee tour end date in Tour intimation';
                }
                field("Places To Visit"; "Places To Visit")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee places to visit in Tour intimation';
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee department code in Tour intimation';
                }
                field("Shift Code"; "Shift Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee shift code in Tour intimation';
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
                action("Show Document")
                {
                    Caption = 'Show Document';
                    Image = Document;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee tour details in Tour intimation';

                    trigger OnAction();
                    begin
                        AttendanceHeader.RESET();
                        FILTERGROUP(2);
                        AttendanceHeader.SETRANGE("No.", "No.");
                        FILTERGROUP(0);
                        if AttendanceHeader.FINDFIRST() then
                            PAGE.RUNMODAL(33001342, AttendanceHeader);
                    end;
                }
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee tour approval details in Tour intimation';

                    trigger OnAction();
                    begin
                        ApproveOnDuty2();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        SETRANGE(Approver, USERID());
    end;

    var
        HRApproverSetup: Record "TourIntimation Setup B2B";
        Employee: Record "Employee B2B";
        HRApproverSetup2: Record "TourIntimation Setup B2B";
        AttendanceHeader: Record "Attendance Header B2B";
        Dept: Code[30];
        Text000Lbl: Label 'Document was approved and sent for further approval';
        Text003Lbl: Label 'Do you want to approve the entries';

    procedure ApproveOnDuty1();
    begin
        CLEAR(Dept);
        Employee.RESET();
        Employee.SETRANGE("User Id", USERID());
        if Employee.FINDFIRST() then
            Dept := Employee."Department Code";
        if Status = Status::"Pending for Approval HOD" then begin
            HRApproverSetup.RESET();
            HRApproverSetup.SETRANGE("Document Type", HRApproverSetup."Document Type"::"Tour Intimation");
            HRApproverSetup.SETRANGE(Department, Dept);
            HRApproverSetup.SETRANGE(HOD, USERID());
            if HRApproverSetup.FINDFIRST() then begin
                Employee.RESET();
                Employee.SETRANGE("User Id", USERID());
                if Employee.FINDFIRST() then
                    Dept := Employee."Department Code";
                SETRANGE("Department Code", Dept);

                SETRANGE(Status, Status::"Pending for Approval HOD");
                SETRANGE(Approver, USERID());
            end;
        end;
        if Status = Status::"Pending for Additional Approval" then begin

            HRApproverSetup.RESET();
            HRApproverSetup.SETRANGE("Document Type", HRApproverSetup."Document Type"::"Tour Intimation");
            HRApproverSetup.SETRANGE(Authoriser, USERID());
            if HRApproverSetup.FINDFIRST() then begin
                SETRANGE(Status, Status::"Pending for Additional Approval");
                SETRANGE(Approver, USERID());
            end;
        end;
        if Status = Status::"Pending for HR Approval" then begin
            HRApproverSetup.RESET();
            HRApproverSetup.SETRANGE("Document Type", HRApproverSetup."Document Type"::"Tour Intimation");
            HRApproverSetup.SETRANGE(Approver, USERID());
            if HRApproverSetup.FINDFIRST() then begin
                SETRANGE(Status, Status::"Pending for HR Approval");
                SETRANGE(Approver, USERID());
            end;
        end;
    end;

    procedure ApproveOnDuty();
    var
        AttApprovals: Codeunit "Attendance Approvals B2B";
    begin
        if CONFIRM(Text003Lbl) then begin
            CheckValidEntries();
            AttApprovals.ApproveOnDuty(Rec);
        end;
    end;

    procedure ApproveOnDuty2();
    begin
        CLEAR(Dept);
        Employee.RESET();
        Employee.SETRANGE("User Id", USERID());
        if Employee.FINDFIRST() then
            Dept := Employee."Department Code";
        HRApproverSetup.RESET();
        HRApproverSetup.SETRANGE("Document Type", HRApproverSetup."Document Type"::"Tour Intimation");
        HRApproverSetup.SETRANGE(Department, Dept);
        HRApproverSetup.SETRANGE(HOD, USERID());
        if HRApproverSetup.FINDFIRST() then begin
            HRApproverSetup2.RESET();
            HRApproverSetup2.SETRANGE("Document Type", HRApproverSetup."Document Type");
            HRApproverSetup2.SETRANGE(Department, HRApproverSetup.Department);
            HRApproverSetup2.SETRANGE("Line No.", HRApproverSetup."Line No.");
            if HRApproverSetup2.FINDFIRST() then
                if HRApproverSetup2.Authoriser <> '' then begin
                    Status := Status::"Pending for Additional Approval";
                    Approver := HRApproverSetup2.Authoriser;
                    MODIFY();
                end else begin
                    Status := Status::"Pending for HR Approval";
                    Approver := HRApproverSetup2.Approver;
                    MODIFY();
                    MESSAGE('%1', Text000Lbl);
                end;

        end;

        HRApproverSetup.RESET();
        HRApproverSetup.SETRANGE("Document Type", HRApproverSetup."Document Type"::"Tour Intimation");
        HRApproverSetup.SETRANGE(Authoriser, USERID());
        if HRApproverSetup.FINDFIRST() then begin
            Status := Status::"Pending for HR Approval";
            Approver := HRApproverSetup.Approver;
            MODIFY();
            MESSAGE('%1', Text000Lbl);
        end;
        HRApproverSetup.RESET();
        HRApproverSetup.SETRANGE("Document Type", HRApproverSetup."Document Type"::"Tour Intimation");
        HRApproverSetup.SETRANGE(Approver, USERID());
        if HRApproverSetup.FINDFIRST() then
            ApproveOnDuty();

    end;
}

