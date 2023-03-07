table 33001221 "Leave Application B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Application';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            TableRelation = "Leave Master B2B";
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                CheckStatus();
                ;
                Employee.SETRANGE("No.", "Employee No.");
                Employee.SETRANGE(Probation, true);
                if Employee.FINDFIRST() then begin
                    LeaveMaster.SETFILTER("Leave Code", '<>%1', ELTxt);
                    LeaveMaster.SETFILTER("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                    if LeaveMaster.FINDFIRST() then
                        if PAGE.RUNMODAL(33001234, LeaveMaster) = ACTION::LookupOK then
                            VALIDATE("Leave Code", LeaveMaster."Leave Code");
                end else begin
                    LeaveMaster2.SETFILTER("Leave Code", CLLbl + '|' + ELTxt + '|' + SLTxt);
                    LeaveMaster2.SETFILTER("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                    if PAGE.RUNMODAL(33001234, LeaveMaster2) = ACTION::LookupOK then
                        VALIDATE("Leave Code", LeaveMaster2."Leave Code");
                end;
            end;

            trigger OnValidate();
            begin
                CheckStatus();
                ;
                Employee.RESET();
                Employee.SETRANGE("No.", "Employee No.");
                if Employee.FINDFIRST() then;
                if (Employee."ESI Applicable") and ("Leave Code" = SLTxt) then
                    ERROR(Text007Lbl);
            end;
        }
        field(3; "Leave Duration"; Option)
        {
            Caption = 'Leave Duration';
            OptionCaption = ' ,Half Day,Leave';
            OptionMembers = " ","Half Day",Leave;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckStatus();
                ;
            end;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                HRSetup.GET();

                StDate := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");
                StDate := CALCDATE(OneMonthExprLbl, StDate);
                StDate := CALCDATE(OneDayLessExprLbl, StDate);
                Exp := '-' + FORMAT(HRSetup."Att Reg Period");
                EdDate := CALCDATE(Exp, StDate);

                DailyAttendance.RESET();
                DailyAttendance.SETRANGE("Employee No.", "Employee No.");
                DailyAttendance.SETRANGE("Attendance Type", DailyAttendance."Attendance Type"::Absent,
                                                           DailyAttendance."Attendance Type"::Leave);

                DailyAttendance.SETRANGE(Date, EdDate, StDate);
                DailyAttendance.SETFILTER("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                if PAGE.RUNMODAL(0, DailyAttendance) = ACTION::LookupOK then begin
                    VALIDATE("From Date", DailyAttendance.Date);
                    VALIDATE("To Date", DailyAttendance.Date);
                    Year := HRSetup."Salary Processing Year";
                    Month := HRSetup."Salary Processing month";
                    if (DailyAttendance.Year <> HRSetup."Salary Processing Year") or
                       (DailyAttendance."Attendance Month" <> HRSetup."Salary Processing month") then
                        "Attandance Regularization" := true;
                end;
            end;

            trigger OnValidate();
            begin
                CheckStatus();
                ;
                if "Leave Duration" = "Leave Duration"::"Half Day" then begin
                    "To Date" := "From Date";
                    "No.of Days" := 0.5;
                end else
                    if "To Date" <> 0D then
                        "No.of Days" := ("To Date" - "From Date") + 1;


                if not "Attandance Regularization" then begin
                    Month := DATE2DMY("From Date", 2);
                    Year := DATE2DMY("From Date", 3);
                end;

                LeaveEntitle();
                Employee.SETRANGE("No.", "Employee No.");
                if Employee.FINDFIRST() then
                    if Employee.Probation then
                        if "From Date" < AvailableDate then
                            ERROR(Text004Lbl, "Leave Code", AvailableDate);


            end;
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckStatus();

                if "Leave Duration" = "Leave Duration"::"Half Day" then
                    if "From Date" <> "To Date" then
                        ERROR(Text000Lbl);

                if "To Date" < "From Date" then
                    ERROR(Text003Lbl);

                if "Leave Duration" = "Leave Duration"::"Half Day" then
                    "No.of Days" := 0.5
                else
                    "No.of Days" := ("To Date" - "From Date") + 1;
            end;
        }
        field(6; "Reason for Leave"; Text[50])
        {
            Caption = 'Reason for Leave';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckStatus();
                ;
            end;
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Application,Leave,Cancelled';
            OptionMembers = Application,Leave,Cancelled;
            DataClassification = CustomerContent;
        }
        field(8; Sanctioned; Boolean)
        {
            Caption = 'Sanctioned';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckStatus();
                ;
                if Sanctioned then
                    Status := Status::Leave
                else
                    Status := Status::Application;

                if Status = Status::Cancelled then
                    Sanctioned := false;
            end;
        }
        field(9; "Sanctioning Incharge"; Text[30])
        {
            Caption = 'Sanctioning Incharge';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckStatus();
                ;
                if "Sanctioning Incharge" = "Employee No." then
                    ERROR(Text002Lbl);
            end;
        }
        field(10; "Date of Sanction"; Date)
        {
            Caption = 'Date of Sanction';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckStatus();
                ;
            end;
        }
        field(11; "Date of Cancellation"; Date)
        {
            Caption = 'Date of Cancellation';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckStatus();
                ;
            end;
        }
        field(12; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(13; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(14; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(15; "Leaves avail.curr.Month"; Decimal)
        {
            Caption = 'Leaves avail.curr.Month';
            DataClassification = CustomerContent;
        }
        field(16; "No.of Days"; Decimal)
        {
            Caption = 'No.of Days';
            DataClassification = CustomerContent;
        }
        field(17; Processed; Boolean)
        {
            Caption = 'Processed';
            DataClassification = CustomerContent;
        }
        field(20; "Attandance Regularization"; Boolean)
        {
            Caption = 'Attandance Regularization';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Leave Code", "From Date")
        {
        }
        key(Key2; "Employee No.", "Leave Code", Year, Month)
        {
            SumIndexFields = "No.of Days";
        }
    }

    fieldgroups
    {
    }

    var

        Employee: Record "Employee B2B";
        LeaveMaster: Record "Leave Master B2B";
        LeaveMaster2: Record "Leave Master B2B";
        HRSetup: Record "HR Setup B2B";
        DailyAttendance: Record "Daily Attendance B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        StartDate: Date;
        AvailableDate: Date;
        StDate: Date;
        EdDate: Date;
        Exp: Text[30];
        EndDate: Date;
        Text000Lbl: Label 'Leave End Date should be equal to Leave Start Date for Half day Leaves';
        Text002Lbl: Label 'Sanction incharge should not be the same person';
        Text003Lbl: Label 'To Date should be greater than the From Date';
        Text004Lbl: Label '%1 Type Leaves are not available before %2', Comment = '%1 =  Leave Code; %2 = Available';
        Text005Lbl: Label 'Processing is done, You cannot cancel these leaves.';
        Text006Lbl: Label 'This Leave is cancelled, You can not do any modifications.';
        Text007Lbl: Label 'This Employee Is ESI Applicable (i.e. No SL)';
        SLTxt: Label 'SL';
        ELTxt: Label 'EL';
        CLLbl: Label 'CL';
        OneMonthExprLbl: Label '<+1M>';
        OneDayLessExprLbl: Label '<-1D>';
        LEAVEYEARTxt: Label 'LEAVE YEAR';

    procedure UpdateAbsent();
    var
        LeaveApplication: Record "Leave Application B2B";
        Dailyattendance3: Record "Daily Attendance B2B";
    begin
        Dailyattendance3.SETRANGE("Employee No.", "Employee No.");
        Dailyattendance3.SETFILTER(Leave, '<>0');
        if Dailyattendance3.FINDFIRST() then
            repeat
                Dailyattendance3.Absent := 0;
                Dailyattendance3.Leave := 0;
                Dailyattendance3.Present := 1;
                Dailyattendance3."Leave Code" := '';
                Dailyattendance3."Attendance Type" := Dailyattendance3."Attendance Type"::Present;
                Dailyattendance3.MODIFY();
            until Dailyattendance3.NEXT() = 0;

        LeaveApplication.SETRANGE(Sanctioned, true);
        LeaveApplication.SETRANGE(Processed, false);
        LeaveApplication.SETRANGE("Employee No.", "Employee No.");
        if LeaveApplication.FINDFIRST() then
            repeat
                LeaveApplication.TESTFIELD("From Date");
                LeaveApplication.TESTFIELD("To Date");
                Dailyattendance.SETRANGE("Employee No.", LeaveApplication."Employee No.");
                Dailyattendance.SETFILTER(Date, '%1..%2', LeaveApplication."From Date", LeaveApplication."To Date");
                if Dailyattendance.FINDFIRST() then
                    repeat
                        //Dailyattendance."Attendance Type" := Dailyattendance."Attendance Type" :: "4";//Phani
                        Dailyattendance."Leave Code" := LeaveApplication."Leave Code";
                        Dailyattendance.Leave := 1;
                        Dailyattendance.Absent := 0;
                        Dailyattendance.Present := 1;

                        if LeaveApplication."Leave Duration" = LeaveApplication."Leave Duration"::"Half Day" then begin
                            Dailyattendance."Attendance Type" := Dailyattendance."Attendance Type"::Leave;
                            Dailyattendance."Leave Code" := LeaveApplication."Leave Code";
                            Dailyattendance.Leave := 0.5;
                            Dailyattendance.Absent := 0;
                            Dailyattendance.Present := 0.5;
                        end;
                        Dailyattendance.MODIFY();
                    until Dailyattendance.NEXT() = 0;

            until LeaveApplication.NEXT() = 0;

    end;

    procedure LeaveEntitle();
    var
        Payyear: Record "Payroll Year B2B";
    begin
        Payyear.SETRANGE("Year Type", LEAVEYEARTxt);
        Payyear.SETRANGE(Closed, false);
        if Payyear.FINDFIRST() then begin
            StartDate := Payyear."Year Start Date";
            EndDate := Payyear."Year End Date";
        end;

        LeaveMaster.SETRANGE("Leave Code", "Leave Code");
        if LeaveMaster.FINDFIRST() then
            repeat
                if LeaveMaster."Crediting Type" = LeaveMaster."Crediting Type"::"After the Period" then
                    AvailableDate := CALCDATE(LeaveMaster."Crediting Interval", StartDate)
                else
                    if LeaveMaster."Crediting Type" = LeaveMaster."Crediting Type"::"Before the Period" then
                        AvailableDate := StartDate;
            until LeaveMaster.NEXT() = 0;
    end;

    procedure LeaveConvertion();
    var
        LeaveEntitlement: Record "Leave Entitlement B2B";
        CountLeaves: Decimal;
    begin
        LeaveEntitlement.SETRANGE("Employee No.", "Employee No.");
        if LeaveEntitlement.FINDFIRST() then
            repeat
                CountLeaves := 0;
                DailyAttendance.Reset();
                Dailyattendance.SETRANGE("Employee No.", LeaveEntitlement."Employee No.");
                Dailyattendance.SETRANGE("Leave Code", LeaveEntitlement."Leave Code");
                Dailyattendance.SETRANGE(Year, LeaveEntitlement.Year);
                Dailyattendance.SETRANGE(Month, LeaveEntitlement.Month);
                if Dailyattendance.FINDFIRST() then
                    repeat
                        CountLeaves := Dailyattendance.Leave + CountLeaves;
                        if CountLeaves > LeaveEntitlement."Total Leaves" then
                            if (CountLeaves - LeaveEntitlement."Total Leaves") = 0.5 then begin
                                Dailyattendance."Attendance Type" := Dailyattendance."Attendance Type"::Leave;
                                Dailyattendance."Leave Code" := '';
                                Dailyattendance.Leave := 0;
                                Dailyattendance.Absent := 0.5;
                                Dailyattendance.Present := 0.5;
                                Dailyattendance.MODIFY();
                            end else begin
                                Dailyattendance."Attendance Type" := Dailyattendance."Attendance Type"::Absent;
                                Dailyattendance."Leave Code" := '';
                                Dailyattendance.Leave := 0;
                                Dailyattendance.Absent := 1;
                                Dailyattendance.Present := 0;
                                Dailyattendance.MODIFY();
                            end;

                    until Dailyattendance.NEXT() = 0;
            until LeaveEntitlement.NEXT() = 0;
    end;

    procedure CancelLeaves(LeaveApp: Record "Leave Application B2B");
    begin
        if LeaveApp.Processed then
            ERROR(Text005Lbl)
        else begin
            LeaveApp."Date of Cancellation" := WORKDATE();
            LeaveApp.Status := LeaveApp.Status::Cancelled;
            LeaveApp.MODIFY();
            UpdateAbsent();
            LeaveConvertion();
        end;
    end;

    procedure CheckStatus();
    begin
        if Status = Status::Cancelled then
            ERROR(Text006Lbl);
    end;
}

