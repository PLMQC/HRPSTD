table 33001308 "Posted Leave App Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Leave App Line_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            Editable = false;
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(4; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            Editable = false;
            TableRelation = "Employee Leaves B2B"."Leave Code" WHERE("No." = FIELD("Employee No."));
            DataClassification = CustomerContent;
        }
        field(6; "Leave Duration"; Option)
        {
            Caption = 'Leave Duration';
            Editable = false;
            OptionCaption = ' ,Half Day,Leave';
            OptionMembers = " ","Half Day",Leave;
            DataClassification = CustomerContent;
        }
        field(7; "From Date"; Date)
        {
            Caption = 'From Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "To Date"; Date)
        {
            Caption = 'To Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Reason for Leave"; Text[50])
        {
            Caption = 'Reason for Leave';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13; Year; Integer)
        {
            Caption = 'Year';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(14; Month; Integer)
        {
            Caption = 'Month';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16; "No.of Days"; Decimal)
        {
            Caption = 'No.of Days';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Set For Approval"; Boolean)
        {
            Caption = 'Set For Approval';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; Approve; Boolean)
        {
            Caption = 'Approve';
            DataClassification = CustomerContent;
        }
        field(20; "Employee User ID"; Code[50])
        {
            Caption = 'Employee User ID';
            Editable = true;
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(22; "Carry out Action"; Boolean)
        {
            Caption = 'Carry out Action';
            DataClassification = CustomerContent;
        }
        field(23; "Processed By"; Code[50])
        {
            Caption = 'Processed By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(24; "Processed Date"; Date)
        {
            Caption = 'Processed Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(25; "Processed Status"; Option)
        {
            Caption = 'Processed Status';
            OptionCaption = ' ,Posted,Cancelled';
            OptionMembers = " ",Posted,Cancelled;
            DataClassification = CustomerContent;
        }
        field(26; "Approved Leaves"; Integer)
        {
            CalcFormula = Count ("Leave Plan B2B" WHERE("Leave Application No." = FIELD("Document No."),
                                                    "Employee No" = FIELD("Employee No."),
                                                    "Leave Code" = FIELD("Leave Code"),
                                                    "Approved Status" = FILTER(Approved)));
            Caption = 'Approved Leaves';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Rejected Leaves"; Integer)
        {
            CalcFormula = Count ("Leave Plan B2B" WHERE("Leave Application No." = FIELD("Document No."),
                                                    "Employee No" = FIELD("Employee No."),
                                                    "Leave Code" = FIELD("Leave Code"),
                                                    "Approved Status" = FILTER(Rejected)));
            Caption = 'Rejected Leaves';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Comp Leaves"; Integer)
        {
            CalcFormula = Count ("Leave Plan B2B" WHERE("Leave Application No." = FIELD("Document No."),
                                                    "Employee No" = FIELD("Employee No."),
                                                    "Leave Code" = FIELD("Leave Code"),
                                                    "Approved Status" = FILTER(Approved),
                                                    "Leave Type" = FILTER(LOP),
                                                    "Compensatory Leave" = FILTER(true)));
            Caption = 'Comp Leaves';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(31; "Provisional Leaves Avail"; Decimal)
        {
            Caption = 'Provisional Leaves Avail';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(33; "Session Time"; Option)
        {
            Caption = 'Session Time';
            Editable = false;
            OptionCaption = ' ,First Half,Second Half';
            OptionMembers = " ","First Half","Second Half";
            DataClassification = CustomerContent;
        }
        field(35; Cancel; Boolean)
        {
            Caption = 'Cancel';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Processed Status" = "Processed Status"::Cancelled then
                    ERROR(Text001Lbl);
            end;
        }
        field(36; "Pending For Cancellation"; Boolean)
        {
            Caption = 'Pending For Cancellation';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(37; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Emp Performance Log B2B"."Employee Code";
            DataClassification = CustomerContent;
        }
        field(45; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
        }
        field(46; "HOD Approval"; Boolean)
        {
            Caption = 'HOD Approval';
            DataClassification = CustomerContent;
        }
        field(47; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,Pending for HOD Approval,Pending for Additional Approval,Pending for HR Approval,Leave Application Rejected,Approved';
            OptionMembers = " ","Pending for HOD Approval","Pending for Additional Approval","Pending for HR Approval","Leave Application Rejected",Approved;
            DataClassification = CustomerContent;
        }
        field(48; "Pending for HOD cancelation"; Boolean)
        {
            Caption = 'Pending for HOD cancelation';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(49; "Pending for HR cancelation"; Boolean)
        {
            Caption = 'Pending for HR cancelation';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(50; "Pending for MD cancelation"; Boolean)
        {
            Caption = 'Pending for MD cancelation';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(51; "MD Approval User"; Code[50])
        {
            Caption = 'MD Approval User';
            DataClassification = CustomerContent;
        }
        field(52; "HOD user"; Code[50])
        {
            Caption = 'HOD user';
            DataClassification = CustomerContent;
        }
        field(53; Approver; Code[50])
        {
            Caption = 'Approver';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        LeavePlanRec.RESET();
        LeavePlanRec.SETRANGE("Leave Application No.", "Document No.");
        LeavePlanRec.SETRANGE("Employee No", "Employee No.");
        LeavePlanRec.SETRANGE("Leave Code", "Leave Code");
        if LeavePlanRec.FINDFIRST() then
            LeavePlanRec.DELETEALL();
    end;

    var
        LeavePlanRec: Record "Leave Plan B2B";
        Text001Lbl: Label 'Leave already cancelled.';

    procedure LeavePlanning(LeaveApp: Record "Posted Leave App Line B2B");
    var
        LeavePlan: Record "Leave Plan B2B";
    begin
        LeavePlan.RESET();
        LeavePlan.SETRANGE("Employee No", LeaveApp."Employee No.");
        LeavePlan.SETRANGE("Leave Code", LeaveApp."Leave Code");
        LeavePlan.SETFILTER(LeavePlan."Approved Status", '<>%1', LeavePlan."Approved Status"::" ");
        LeavePlan.SETFILTER("Leave Date", '>=%1 & <= %2', LeaveApp."From Date", LeaveApp."To Date");
        if LeavePlan.FINDFIRST() then
            PAGE.RUN(33001384, LeavePlan);//33001317
    end;

    procedure UpdateProLeaves(LeaveAppRec: Record "Posted Leave App Line B2B");
    var
        ProvLeaves: Record "Provisional Leaves B2B";
        LeavePlan: Record "Leave Plan B2B";
        RejectedLeaves: Decimal;
    begin
        CLEAR(RejectedLeaves);
        LeavePlan.RESET();
        LeavePlan.SETRANGE("Leave Application No.", LeaveAppRec."Document No.");
        LeavePlan.SETRANGE("Employee No", LeaveAppRec."Employee No.");
        LeavePlan.SETRANGE("Leave Code", LeaveAppRec."Leave Code");
        LeavePlan.SETRANGE("Leave Type", LeavePlan."Leave Type"::Leave);
        LeavePlan.SETFILTER("Posted Status", '= %1', LeavePlan."Posted Status"::Cancelled);
        if LeavePlan.FINDFIRST() then
            repeat
                RejectedLeaves := RejectedLeaves + 1;
            until LeavePlan.NEXT() = 0;

        ProvLeaves.RESET();
        ProvLeaves.SETRANGE("Employee No.", LeaveAppRec."Employee No.");
        ProvLeaves.SETRANGE("Leave Code", LeaveAppRec."Leave Code");
        ProvLeaves.SETFILTER(ProvLeaves."Applied Leaves", '<>%1', 0);
        ProvLeaves.SETFILTER("Leave Year Start Date", '<=%1', LeaveAppRec."From Date");
        ProvLeaves.SETFILTER("Leave Year End Date", '>=%1', LeaveAppRec."To Date");
        if ProvLeaves.FINDLAST() then
            repeat
                if RejectedLeaves <> 0 then begin
                    if ProvLeaves."Applied Leaves" <= RejectedLeaves then begin
                        ProvLeaves."Remaining Leaves" := ProvLeaves."Remaining Leaves" + ProvLeaves."Applied Leaves";
                        RejectedLeaves := RejectedLeaves - ProvLeaves."Applied Leaves";
                        ProvLeaves."Applied Leaves" := 0;
                        ProvLeaves.MODIFY();
                    end else begin
                        ProvLeaves."Applied Leaves" := ProvLeaves."Applied Leaves" - RejectedLeaves;
                        ProvLeaves."Remaining Leaves" := ProvLeaves."No.of Leaves" - ProvLeaves."Applied Leaves";
                        RejectedLeaves := 0;
                        ProvLeaves.MODIFY();
                    end;
                end else
                    if RejectedLeaves = 0 then
                        exit;
            until ProvLeaves.NEXT(-1) = 0;
    end;

    procedure CheckLeavePlan(LeaveApp: Record "Posted Leave App Line B2B");
    var
        LeavePlan: Record "Leave Plan B2B";
        Text000Lbl: Label '%1 should not be blank or applied in %2.', Comment = '%1 = Approved Status  ; %2 = Leave Plan ';
    begin
        LeavePlan.RESET();
        LeavePlan.SETRANGE("Leave Application No.", LeaveApp."Document No.");
        LeavePlan.SETRANGE("Employee No", LeaveApp."Employee No.");
        LeavePlan.SETRANGE("Leave Code", LeaveApp."Leave Code");
        LeavePlan.SETFILTER("Approved Status", '%1', LeavePlan."Approved Status"::" ");
        if LeavePlan.FINDFIRST() then
            ERROR(Text000Lbl, LeavePlan.FIELDCAPTION("Approved Status"), LeavePlan.TABLECAPTION());
    end;
}

