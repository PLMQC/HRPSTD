page 33001342 "Tour Intimation Appli. B2B"
{
    // version B2BHR1.00.00
    //HRP1.22

    Caption = 'Tour Intimation Application';
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Attendance Header B2B";
    SourceTableView = SORTING("Document Type", "No.")
                      WHERE("Document Type" = CONST(Tour));
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ToolTip = 'Specifies number serices for Tour Infomration  Application';
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Creation Date"; "Creation Date")
                {
                    ToolTip = '"Specifies Tour Infomration Application Created Date "';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Specifies Phycial Location of theEmployee';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ToolTip = 'Specifies type as "EMployee" or "Department"';
                    ApplicationArea = all;
                }
                field("Code"; Code)
                {
                    ToolTip = 'Specifies Code for "Employee " Or "Departement"';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        TESTFIELD(Status, Status::Open);
                        if Type = Type::Employee then begin
                            if PayrollLoc.FINDFIRST() then
                                if USERID() <> PayrollLoc."Location Incharge" then begin
                                    EmployeeGrec.RESET();
                                    EmployeeGrec.SETRANGE("User Id", USERID());
                                    if EmployeeGrec.FINDFIRST() then begin
                                        LookUpGRec.RESET();
                                        LookUpGRec.SETFILTER("Lookup Type", '%1', 4);
                                        LookUpGRec.SETRANGE("Lookup Name", EmployeeGrec."Department Code");
                                        if LookUpGRec.FINDFIRST() then begin
                                            EmployeeGrec2.RESET();
                                            EmployeeGrec2.SETRANGE("Department Code", LookUpGRec."Lookup Name");
                                            if PAGE.RUNMODAL(33001195, EmployeeGrec2) = ACTION::LookupOK then begin
                                                Code := EmployeeGrec2."No.";
                                                "Employee Name" := CopyStr(EmployeeGrec2.FullName(), 1, 80);
                                                "Department Code" := EmployeeGrec2."Department Code";
                                                "Location Code" := EmployeeGrec2."Location Code";

                                            end;
                                        end;
                                    end;
                                end else
                                    if PAGE.RUNMODAL(33001195, EmployeeGrec2) = ACTION::LookupOK then begin
                                        Code := EmployeeGrec2."No.";
                                        "Employee Name" := CopyStr(EmployeeGrec2.FullName(), 1, 80);
                                        "Department Code" := EmployeeGrec2."Department Code";
                                        "Location Code" := EmployeeGrec2."Location Code";
                                    end;
                        end else begin
                            LookUpGRec.RESET();
                            LookUpGRec.SETFILTER("Lookup Type", '%1', 4);
                            if LookUpGRec.FINDFIRST() then
                                if PAGE.RUNMODAL(33001193, LookUpGRec) = ACTION::LookupOK then
                                    Code := LookUpGRec."Lookup Name";
                        end;
                    end;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Specifies Name of the Employee who fill the Tour Information Application';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Specifies the Month on whcih Tour Information Applications Filled';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Specifies Tour Inofrmation Application Year';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Specifies Tour Start Date in Tour Information Application';
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
                {
                    ToolTip = 'Specifies Tour End  Date in Tour Information Application';
                    ApplicationArea = all;
                }
                field("Shift Code"; "Shift Code")
                {
                    ToolTip = 'Specifies the shift details like "Morning" , ''Night " etc';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Specifies the status of the application like " Pending for Approval" , " Approval" etc';
                    ApplicationArea = all;
                }
            }
            part(OnDutySubForm; "Tour Intimation Subform B2B")
            {
                Caption = 'OnDutySubForm';
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                ApplicationArea = all;
            }
            group(Others)
            {
                Caption = 'Others';
                field("To Location"; "To Location")
                {
                    ToolTip = 'Specifies Location of the Emplyee';
                    ApplicationArea = all;
                }
                field("Places To Visit"; "Places To Visit")
                {
                    ToolTip = 'Specifies Pleasce to visit during the period';
                    ApplicationArea = all;
                }
                field("Advance Request"; "Advance Request")
                {
                    ToolTip = 'Specifies if Advance Request made';
                    ApplicationArea = all;
                }
                field("Assignment No."; "Assignment No.")
                {
                    ToolTip = '"Specifies the Assisgnemnet number "';
                    ApplicationArea = all;
                }
                field("Assignment Name"; "Assignment Name")
                {
                    ToolTip = '"Specifies Assignment Name "';
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies Global Dimention 1 in this field';
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies Global Dimention 2 in this feild';
                    ApplicationArea = all;
                }
                field("Mode Of Travel"; "Mode Of Travel")
                {
                    ToolTip = '"specifies mode of trvel like ""By Road"" , ""By Rail"" , ''By Flight"" etc "';
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
                action("Get &Dates")
                {
                    Caption = 'Get &Dates';
                    Image = GetLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Get Dates';

                    trigger OnAction();
                    begin
                        TESTFIELD("Places To Visit");
                        CurrPage.OnDutySubForm.PAGE.GetEmployeeOnDuty();
                        "Get Dates" := true;
                        MODIFY();
                    end;
                }
                action("Send for Approval")
                {
                    Caption = 'Send for Approval';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Send for approval';

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
                action(Post)
                {
                    ApplicationArea = All;
                    Image = Post;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ToolTip = 'Specifies the Post';
                    trigger OnAction()
                    begin
                        ApproveOnDuty();
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+p';
                ApplicationArea = all;
                ToolTip = 'Specifies the Print';

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

    trigger OnInit();
    begin
        "Employee CodeEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        CLEAR(Dept);
        if PayrollLoc.FINDFIRST() then
            if USERID() <> PayrollLoc."Location Incharge" then begin
                EmployeeGrec.RESET();
                EmployeeGrec.SETRANGE("User Id", USERID());
                if EmployeeGrec.FINDFIRST() then
                    Dept := EmployeeGrec."Department Code";
            end;

    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        if PayrollUsers."Multiple Locations" <> '' then
            "Location Code" := CopyStr(PayrollUsers."Multiple Locations", 1, 20)
        else
            "Location Code" := LocWiseMiscGCU.ReturnUserLocationCode();
        "Document Type" := "Document Type"::Tour;//HRP1.22
    end;

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
        AttendanceHeader: Record "Attendance Header B2B";
        EmployeeGrec: Record "Employee B2B";
        LookUpGRec: Record Lookup_B2B;
        EmployeeGrec2: Record "Employee B2B";
        AttendanceLines: Record "Attendance Lines B2B";
        TIsetup: Record "TourIntimation Setup B2B";
        TIsetup1: Record "TourIntimation Setup B2B";
        PayrollLoc: Record "Payroll Locations B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Dept: Code[30];
        [InDataSet]
        "Employee CodeEditable": Boolean;

        Text001Lbl: Label 'Please get dates first';
        Text002Lbl: Label 'Employee Detiails are not entered';
        Text003Lbl: Label 'Tour intimation Application %1 sent for approval', Comment = '%1 = No';
        Text004Lbl: Label 'Do you want to approve the entries';

    procedure ValidateType();
    begin
        case Type of
            Type::Employee:
                begin
                    CLEAR(Code);
                    "Employee CodeEditable" := false;
                end;
            Type::Department:
                "Employee CodeEditable" := true;
        end;
    end;

    procedure ReleaseOnDuty();

    begin
    end;

    procedure ApproveOnDuty();
    var
        AttApprovals: Codeunit "Attendance Approvals B2B";
    begin
        if CONFIRM(Text004Lbl) then begin
            CheckValidEntries();
            AttApprovals.ApproveOnDuty(Rec);
        end;
    end;
}

