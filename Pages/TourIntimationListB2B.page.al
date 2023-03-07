page 33001538 "Tour Intimation List B2B"
{
    // version B2BHR1.00.00
    //HRP1.22

    Caption = 'Tour Intimation List';
    CardPageID = "Tour Intimation Appli. B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Attendance Header B2B";
    SourceTableView = SORTING("Document Type", "No.")
                      WHERE("Document Type" = CONST(Tour));
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("No."; "No.")
                {
                    Tooltip = 'Enter the Tour Intimation No.sereis. number';
                    ApplicationArea = all;
                }
                field("Creation Date"; "Creation Date")
                {
                    ToolTip = 'Choose the Creation date.';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Select the Month ';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Show the Year.';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    Tooltip = 'Choose the Start Date For Tour Intimation.';
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
                {
                    Tooltip = 'Choose the End Date For Tour Intimation.';
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ToolTip = 'Select the Dimension Value.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Choose the Physical location of the Employee.';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ToolTip = 'Choose Type from the Drop down list Ex. Employee/Department .';
                    ApplicationArea = all;
                }
                field("Code"; Code)
                {
                    ToolTip = 'Choose Code based on Selection made in Type.';
                    ApplicationArea = all;
                }
                field("Shift Code"; "Shift Code")
                {
                    ToolTip = 'Enter the Shift code of the Employee.';
                    ApplicationArea = all;
                }
                field("Permission Type"; "Permission Type")
                {
                    ToolTip = 'Choose the Permission type of Tour intamation.';
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    ToolTip = 'Shows the User Id of the Document Created.';
                    ApplicationArea = all;
                }
                field("Approved By"; "Approved By")
                {
                    ToolTip = 'Shows the person name who has approved Tour intimation.';
                    ApplicationArea = all;
                }
                field("Mode Of Travel"; "Mode Of Travel")
                {
                    ToolTip = 'Choose the Mode of Travel.';
                    ApplicationArea = all;
                }
                field("Mode of Booking"; "Mode of Booking")
                {
                    ToolTip = 'Enter the mode of Booking.';
                    ApplicationArea = all;
                }
                field("Assignment No."; "Assignment No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the assignment no.';
                }
                field("Assignment Name"; "Assignment Name")
                {
                    ToolTip = 'Enter the Assignment Name.';
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ToolTip = 'Enter the Dimension Value.';
                    ApplicationArea = all;
                }
                field("Places To Visit"; "Places To Visit")
                {
                    ToolTip = 'Enter the Place of Visit.';
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
                action("Send for Approval")
                {
                    ToolTip = ' on clciking the document is sent for Approval.';
                    Caption = 'Send for Approval';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        if not "Get Dates" then
                            ERROR(Text001Lbl);
                        TESTFIELD("Start Date");
                        TESTFIELD("End Date");
                        CLEAR(Dept);
                        EmployeeGrec.RESET();
                        EmployeeGrec.SETRANGE("User Id", USERID());
                        if EmployeeGrec.FINDFIRST() then
                            Dept := EmployeeGrec."Department Code";

                        TIsetup.RESET();
                        TIsetup.SETRANGE("Document Type", TIsetup."Document Type"::"Tour Intimation");
                        TIsetup.SETRANGE(Department, "Department Code");
                        TIsetup.SETRANGE("Department User", USERID());
                        if TIsetup.FINDFIRST() then begin
                            TIsetup1.RESET();
                            TIsetup1.SETRANGE("Document Type", TIsetup."Document Type");
                            TIsetup1.SETRANGE("Department User", TIsetup."Department User");
                            TIsetup1.SETRANGE("Line No.", TIsetup."Line No.");
                            if TIsetup1.FINDFIRST() then
                                if TIsetup1.HOD <> '' then begin
                                    Status := Status::"Pending for Approval HOD";
                                    Approver := TIsetup1.HOD;
                                    MODIFY();
                                end else
                                    if TIsetup1.Authoriser <> '' then begin
                                        Status := Status::"Pending for Additional Approval";
                                        Approver := TIsetup1.Authoriser;
                                        MODIFY();
                                    end else begin
                                        Status := Status::"Pending for HR Approval";
                                        Approver := TIsetup1.Approver;
                                        MODIFY();
                                    end;

                        end;

                        MODIFY();
                        MESSAGE(Text003Lbl, "No.");
                    end;
                }
            }
            action("&Print")
            {
                ToolTip = 'Prints the Tour intimation.';
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+p';
                ApplicationArea = all;

                trigger OnAction();
                begin
                    AttendanceLines.RESET();
                    AttendanceLines.SETRANGE("Document No.", "No.");
                    if not AttendanceLines.FINDFIRST() then
                        ERROR(Text002Lbl);
                    AttendanceHeader.RESET();
                    AttendanceHeader.SETRANGE("Document Type", "Document Type");
                    AttendanceHeader.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(33001272, true, false, AttendanceHeader);
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        CLEAR(Dept);
        if PayrollLoc.FINDFIRST() then
            if USERID() <> PayrollLoc."Location Incharge" then begin
                EmployeeGrec.RESET();
                EmployeeGrec.SETRANGE("User Id", USERID());
                if EmployeeGrec.FINDFIRST() then
                    Dept := EmployeeGrec."Department Code";

            end;



        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
    end;

    var
        PayrollLoc: Record "Payroll Locations B2B";
        EmployeeGrec: Record "Employee B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        TIsetup: Record "TourIntimation Setup B2B";
        TIsetup1: Record "TourIntimation Setup B2B";
        AttendanceLines: Record "Attendance Lines B2B";
        AttendanceHeader: Record "Attendance Header B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Dept: Code[30];
        Text001Lbl: Label 'Please get dates first';
        Text002Lbl: Label 'Employee Detiails are not entered';
        Text003Lbl: Label 'Tour intimation Application %1 sent for approval', Comment = '%1 = No';
}

