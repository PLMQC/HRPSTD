page 33001374 "Leave Journal B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Journal';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Leave Journal B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Entry Type"; "Entry Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave entry type details';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave posting date';
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee no';
                }
                field("Leave Code"; "Leave Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave code';
                }
                field("Leave Description"; "Leave Description")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the leave description';
                }
                field("No.of Leaves"; "No.of Leaves")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the no of leaves details';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specify the post';

                    trigger OnAction();
                    begin
                        Post();
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        "Posting Date" := workdate();
        "Entry Type" := "Entry Type"::Correction;
    end;

    trigger OnOpenPage();
    begin
        SETRANGE("Entry Type", "Entry Type"::Correction);
    end;

    var
        EmpLeaveHistoryNum: Record "Detailed Leave Records B2B";
        EmpLeaveHistory: Record "Detailed Leave Records B2B";
        HRSetup: Record "HR Setup B2B";
        ProvLeaves: Record "Provisional Leaves B2B";
        LeaveJournal: Record "Leave Journal B2B";
        Num: Integer;
        Text000Lbl: Label 'Do you want to post?';

        Text001Lbl: Label 'Leave Corrections Posted Successfully.';

    procedure Post();
    begin
        if not CONFIRM(Text000Lbl, true) then
            exit
        else begin
            LeaveJournal.RESET();
            LeaveJournal.SETRANGE("Entry Type", "Entry Type"::Correction);
            if LeaveJournal.FINDFIRST() then
                repeat
                    LeaveJournal.TESTFIELD("Employee No.");
                    LeaveJournal.TESTFIELD("Leave Code");
                    LeaveJournal.TESTFIELD("No.of Leaves");
                    LeaveJournal.TESTFIELD("Posting Date");
                    HRSetup.GET();
                    EmpLeaveHistoryNum.RESET();
                    if EmpLeaveHistoryNum.FINDLAST() then
                        Num := EmpLeaveHistoryNum."Entry No." + 1
                    else
                        Num := 1;

                    EmpLeaveHistory.INIT();
                    EmpLeaveHistory."Entry No." := Num;
                    EmpLeaveHistory."Employee No." := LeaveJournal."Employee No.";
                    EmpLeaveHistory."Leave Code" := LeaveJournal."Leave Code";
                    EmpLeaveHistory."Leave Description" := LeaveJournal."Leave Description";
                    EmpLeaveHistory."Entry Type" := EmpLeaveHistory."Entry Type"::Correction;
                    EmpLeaveHistory."Entry Date" := workdate();
                    EmpLeaveHistory."Posting Date" := "Posting Date";
                    EmpLeaveHistory.Month := HRSetup."Salary Processing month";
                    EmpLeaveHistory.Year := HRSetup."Salary Processing Year";
                    EmpLeaveHistory.VALIDATE("No. of Leaves", LeaveJournal."No.of Leaves");
                    EmpLeaveHistory."Leave Pay Cadre" := LeaveJournal."Pay Cadre";
                    EmpLeaveHistory.INSERT();

                    ProvLeaves.RESET();
                    ProvLeaves.SETRANGE("Employee No.", LeaveJournal."Employee No.");
                    ProvLeaves.SETRANGE("Leave Code", LeaveJournal."Leave Code");
                    ProvLeaves.SETRANGE(Status, ProvLeaves.Status::Open);
                    ProvLeaves.SETRANGE(Month, HRSetup."Salary Processing month");
                    ProvLeaves.SETRANGE(Year, HRSetup."Salary Processing Year");
                    ProvLeaves.FINDFIRST();
                    ProvLeaves."Remaining Leaves" := ProvLeaves."Remaining Leaves" + LeaveJournal."No.of Leaves";
                    ProvLeaves.MODIFY();

                    LeaveJournal.Delete();
                until LeaveJournal.NEXT() = 0;
            MESSAGE(Text001Lbl);
        end;
    end;
}

