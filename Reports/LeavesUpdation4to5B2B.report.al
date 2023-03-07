report 33001255 "Leaves Updation 4 to 5 B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Leaves Updation 4 to 5.rdlc';
    Caption = 'Leaves Updation 4 to 5';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {

            trigger OnAfterGetRecord();
            begin
                LeaveMaster.RESET();
                LeaveMaster.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                if LeaveMaster.FINDFIRST() then
                    repeat
                        LeaveEntitle.RESET();
                        LeaveEntitle.SETRANGE("Employee No.", "Employee B2B"."No.");
                        LeaveEntitle.SETRANGE("Leave Code", LeaveMaster."Leave Code");
                        if LeaveEntitle.FINDLAST() then begin
                            Window.UPDATE(1, "Employee B2B"."No.");
                            LeaveJournal.INIT();
                            LeaveJournal."Entry Type" := LeaveJournal."Entry Type"::"Opening Balance";
                            LeaveJournal."Line No." := Num;
                            LeaveJournal."Leave Code" := LeaveMaster."Leave Code";
                            LeaveJournal."Leave Description" := LeaveMaster.Description;
                            LeaveJournal."Employee No." := "Employee B2B"."No.";
                            LeaveJournal."Employee Name" := "Employee B2B"."First Name";
                            LeaveJournal."Posting Date" := WORKDATE();
                            LeaveJournal."No.of Leaves" := LeaveEntitle."Total Leaves";
                            LeaveJournal."Pay Cadre" := "Employee B2B"."Pay Cadre";
                            LeaveJournal.INSERT();
                            Num := Num + 10000;
                        end;
                    until LeaveMaster.NEXT() = 0;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                Num := 10000;
            end;
        }
    }

    requestpage
    {
        Caption = 'Leaves Updation 4 to 5';

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        Window.CLOSE();
    end;

    trigger OnPreReport();
    begin
        LeaveMaster.RESET();
        LeaveMaster.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        if LeaveMaster.FINDFIRST() then
            repeat
                GradeLeaves.RESET();
                GradeLeaves.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                GradeLeaves.SETRANGE("Leave Code", LeaveMaster."Leave Code");
                if not GradeLeaves.FINDFIRST() then
                    ERROR(Text001Txt, LeaveMaster."Leave Code");
            until LeaveMaster.NEXT() = 0;

        LeaveJournal.RESET();
        if LeaveJournal.FINDFIRST() then
            LeaveJournal.DELETEALL();
        Window.OPEN(Text002Txt);
    end;

    var
        LeaveEntitle: Record "Leave Entitlement B2B";
        LeaveMaster: Record "Leave Master B2B";
        LeaveJournal: Record "Leave Journal B2B";
        GradeLeaves: Record "Grade Wise Leaves B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Window: Dialog;
        Num: Decimal;
        Text001Txt: Label 'Gradewise leaves are not updated for leave code %1.', Comment = '%1 = Leave Code';
        Text002Txt: Label 'Employee No. #1#########################\', Comment = '%1 = No';

}

