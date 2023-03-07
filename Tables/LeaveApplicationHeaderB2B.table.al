table 33001305 "Leave Application Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Application Header_B2B';
    DrillDownPageID = "Leave Application List B2B";
    LookupPageID = "Leave Application List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();

            begin
                if Employee.GET("Employee No.") then begin
                    "Employee Name" := FORMAT(Employee."First Name" + Employee."Last Name");
                    "Employee UserID" := Employee."User Id";
                    "Location Code" := Employee."Location Code";
                    "Department Code" := Employee."Department Code";
                end;
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(5; "Employee UserID"; Code[50])
        {
            Caption = 'Employee UserID';
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(7; "Application Date"; Date)
        {
            Caption = 'Application Date';
            DataClassification = CustomerContent;
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(15; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16; "Last Modified Date"; Date)
        {
            Caption = 'Last Modified Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(17; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(25; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
        }
        field(30; "Work Assigned To"; Code[20])
        {
            Caption = 'Work Assigned To';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(40; "Work Assigned To Name"; Text[120])
        {
            Caption = 'Work Assigned To Name';
            DataClassification = CustomerContent;
        }
        field(50; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending For Approval';
            OptionMembers = Open,Released,"Pending For Approval";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Status = Status::Released then
                    OnAfterReleaseLeaveApp(Rec);
            end;
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        LeaveApplicationLine.RESET();
        LeaveApplicationLine.SETRANGE("Document No.", "Document No.");
        LeaveApplicationLine.DELETEALL(true);
    end;

    trigger OnInsert();
    begin
        if "Document No." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD("Leave Application Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", xRec."No. Series", 0D, "Document No.", "No. Series");
            Evaluate("Employee UserID", USERID());
        end;
        evaluate("Created By", USERID());
    end;

    trigger OnModify();
    begin
        "Last Modified Date" := workdate();
        evaluate("Last Modified By", USERID());
    end;

    var
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        LeaveApplicationLine: Record "Leave Application Line B2B";
        NoSeriesMgt: Codeunit 396;
        UserNames: Text[1024];

    procedure AssistEdit(OldLeaveApp: Record "Leave Application Header B2B"): Boolean;
    var
        LeaveApp: Record "Leave Application Header B2B";
    begin
        with LeaveApp do begin
            LeaveApp := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD("Leave Application Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Leave Application Nos.", OldLeaveApp."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Document No.");
                Rec := LeaveApp;
                Evaluate("Employee UserID", USERID());
                exit(true);
            end;
        end;
    end;

    procedure GetResources1(FromUserID: Code[50]);
    var
        ResourceNames: Record "Resource Hierarchy B2B";
        TempUser: Record User temporary;
    begin
        ResourceNames.RESET();
        ResourceNames.SETRANGE("From User ID", FromUserID);
        ResourceNames.SETRANGE("To User ID", FromUserID);
        ResourceNames.SETFILTER("To User ID", '<>%1', FromUserID);
        if ResourceNames.FINDFIRST() then
            repeat
                if not TempUser.GET(ResourceNames."To User ID") then begin
                    TempUser.INIT();
                    TempUser."User Security ID" := ResourceNames."To User ID";
                    TempUser.INSERT();
                    UserNames := copystr(UserNames + ResourceNames."To User ID" + '|', 1, 1024);
                end;
                GetResources1(ResourceNames."To User ID");
            until ResourceNames.NEXT() = 0;
        UserNames += USERID() + '|';
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterReleaseLeaveApp(var LeaveApplicationHeader: Record "Leave Application Header B2B");
    begin
    end;
}

