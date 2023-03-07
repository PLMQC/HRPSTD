page 33001382 "Leave Correction B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Correction';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Leave Journal B2B";
    UsageCategory = Tasks;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentEmpNo1; CurrentEmpNo)
                {
                    ToolTip = 'Choose the Current Employee no.';
                    ApplicationArea = all;
                    Caption = 'Employee No.';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                            CurrentEmpNo := Employee."No.";
                            EmployeeName := Employee."First Name";
                        end;

                        SelectEmployee();
                    end;

                    trigger OnValidate();
                    begin
                        if Employee.GET(CurrentEmpNo) then
                            EmployeeName := Employee."First Name"
                        else
                            EmployeeName := '';

                        if CurrentEmpNo = '' then
                            EmployeeName := '';

                        SelectEmployee();
                    end;
                }
                field(EmployeeName1; EmployeeName)
                {
                    ToolTip = 'Show the Employee name.';
                    Caption = 'Employee Name';
                    ApplicationArea = all;
                }
                field(PostDate1; PostDate)
                {
                    ToolTip = 'Choose the posting date.';
                    Caption = 'Date';
                    ApplicationArea = all;
                }
                field(ShowAll1; ShowAll)
                {
                    ToolTip = 'Shows the Check mark it displays all employees.';
                    Caption = 'Show All';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        if ShowAll then begin
                            RESET();
                            ShowAllLeaves();
                        end else
                            LeaveJournal.DELETEALL();
                    end;
                }
            }
            repeater(Control1102154000)
            {
                field("Entry Type"; "Entry Type")
                {
                    ToolTip = 'Specifies the Entry type.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Leave Code"; "Leave Code")
                {
                    ToolTip = 'Choose the Leave code correct leave code.';
                    ApplicationArea = all;
                }
                field("Leave Description"; "Leave Description")
                {
                    ToolTip = 'Specifies the leave description.';
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = ' Specifies the start date of leave.';
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Specifes the end of the leave.';
                    ApplicationArea = all;
                }
                field("Reason for Leave"; "Reason for Leave")
                {
                    ToolTip = 'Specifies the Reason for leave.';
                    ApplicationArea = all;
                }
                field("No.of Leaves"; "No.of Leaves")
                {
                    ToolTip = 'Specifies the No. of leaves.';
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
                action("Get &Leaves")
                {
                    ToolTip = 'Get the leaves of the employee.';
                    Caption = 'Get &Leaves';
                    Image = GetLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        GetLeaves();
                        CurrPage.UPDATE(false);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        SelectEmployee();
    end;

    var
        Employee: Record "Employee B2B";
        LeaveJournal: Record "Leave Journal B2B";
        TempLeaveJournal: Record "Leave Journal B2B";
        DetailLeaveRec: Record "Detailed Leave Records B2B";
        CurrentEmpNo: Code[20];
        EmployeeName: Text[50];
        Num: Integer;
        ShowAll: Boolean;
        PostDate: Date;

    procedure GetLeaves();
    begin
        LeaveJournal.DELETEALL();

        if LeaveJournal.FINDLAST() then
            Num := LeaveJournal."Line No." + 10000
        else
            Num := 10000;

        if CurrentEmpNo <> '' then begin
            DetailLeaveRec.SETRANGE("Employee No.", CurrentEmpNo);
            DetailLeaveRec.SETRANGE("Entry Type", DetailLeaveRec."Entry Type"::Utilization);
            if DetailLeaveRec.FINDFIRST() then
                repeat
                    TempLeaveJournal.INIT();
                    TempLeaveJournal."Entry Type" := TempLeaveJournal."Entry Type"::Utilization;
                    TempLeaveJournal."Line No." := Num;
                    TempLeaveJournal."Leave Code" := DetailLeaveRec."Leave Code";
                    TempLeaveJournal."Leave Description" := DetailLeaveRec."Leave Description";
                    TempLeaveJournal."Employee No." := DetailLeaveRec."Employee No.";
                    TempLeaveJournal."Employee Name" := EmployeeName;
                    TempLeaveJournal."Reason for Leave" := DetailLeaveRec."Reason For Leave";
                    TempLeaveJournal."No.of Leaves" := DetailLeaveRec."No. of Leaves";
                    TempLeaveJournal.INSERT();
                    Num := Num + 10000;
                until DetailLeaveRec.NEXT() = 0;
        end;
    end;

    procedure ShowAllLeaves();
    begin
        if LeaveJournal.FINDLAST() then
            Num := LeaveJournal."Line No." + 10000
        else
            Num := 10000;

        if ShowAll then begin
            DetailLeaveRec.SETRANGE("Entry Type", DetailLeaveRec."Entry Type"::Utilization);
            if CurrentEmpNo <> '' then
                DetailLeaveRec.SETRANGE("Employee No.", CurrentEmpNo);
            if DetailLeaveRec.FINDFIRST() then
                repeat
                    TempLeaveJournal.INIT();
                    TempLeaveJournal."Entry Type" := TempLeaveJournal."Entry Type"::Utilization;
                    TempLeaveJournal."Line No." := Num;
                    TempLeaveJournal."Leave Code" := DetailLeaveRec."Leave Code";
                    TempLeaveJournal."Leave Description" := DetailLeaveRec."Leave Description";
                    TempLeaveJournal."Employee No." := DetailLeaveRec."Employee No.";
                    TempLeaveJournal."Employee Name" := EmployeeName;
                    TempLeaveJournal."Reason for Leave" := DetailLeaveRec."Reason For Leave";
                    TempLeaveJournal."No.of Leaves" := DetailLeaveRec."No. of Leaves";
                    TempLeaveJournal.INSERT();
                    Num := Num + 10000;
                until DetailLeaveRec.NEXT() = 0;
        end;
    end;

    procedure SelectEmployee();
    begin
        SETRANGE("Employee No.", CurrentEmpNo);
        CurrPage.UPDATE(false);
    end;
}

