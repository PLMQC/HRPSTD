codeunit 33001205 "TDS Posting B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
    end;

    var
        Text001Txt: Label 'TDS Schedule exists for the Employee';

    procedure InsertPostedTDS(EmpTDSDeduction: Record "Emp TDS Deduction B2B");
    var
        EmpTDSSchedule: Record "Emp TDS Schedule B2B";
        PostedEmpTDSDeduction: Record "Posted Emp TDS Deduction B2B";
        PostedEmpTDSDeduction2: Record "Posted Emp TDS Deduction B2B";
        PostedEmpTDSSchedule: Record "Posted Emp TDS Schedule B2B";
        PostedEmpTDSSchedule2: Record "Posted Emp TDS Schedule B2B";
    begin
        EmpTDSSchedule.RESET();
        EmpTDSSchedule.SETRANGE("Employee No.", EmpTDSDeduction."Employee No.");
        EmpTDSSchedule.SETRANGE("Year Starting Date", EmpTDSDeduction."Year Starting Date");
        EmpTDSSchedule.SETRANGE("Year Ending Date", EmpTDSDeduction."Year Ending Date");
        if EmpTDSSchedule.FINDFIRST() then begin
            PostedEmpTDSDeduction.SETRANGE("Employee No.", EmpTDSDeduction."Employee No.");
            PostedEmpTDSDeduction.SETRANGE("Year Starting Date", EmpTDSDeduction."Year Starting Date");
            PostedEmpTDSDeduction.SETRANGE("Year Ending Date", EmpTDSDeduction."Year Ending Date");
            if PostedEmpTDSDeduction.IsEmpty() then begin
                PostedEmpTDSDeduction2.INIT();
                PostedEmpTDSDeduction2.TRANSFERFIELDS(EmpTDSDeduction);
                PostedEmpTDSDeduction2.INSERT();
                repeat
                    PostedEmpTDSSchedule.SETRANGE("Employee No.", EmpTDSSchedule."Employee No.");
                    PostedEmpTDSSchedule.SETRANGE("Year Starting Date", EmpTDSSchedule."Year Starting Date");
                    PostedEmpTDSSchedule.SETRANGE("Year Ending Date", EmpTDSSchedule."Year Ending Date");
                    PostedEmpTDSSchedule.SETRANGE(Year, EmpTDSSchedule.Year);
                    PostedEmpTDSSchedule.SETRANGE(Month, EmpTDSSchedule.Month);
                    if PostedEmpTDSSchedule.IsEmpty() then begin
                        PostedEmpTDSSchedule2.INIT();
                        PostedEmpTDSSchedule2.TRANSFERFIELDS(EmpTDSSchedule);
                        PostedEmpTDSSchedule2.INSERT();
                    end;
                until EmpTDSSchedule.NEXT() = 0;
            end else
                ERROR(Text001Txt);
        end;

        EmpTDSSchedule.RESET();
        EmpTDSSchedule.SETRANGE("Employee No.", EmpTDSDeduction."Employee No.");
        EmpTDSSchedule.SETRANGE("Year Starting Date", EmpTDSDeduction."Year Starting Date");
        EmpTDSSchedule.SETRANGE("Year Ending Date", EmpTDSDeduction."Year Ending Date");
        EmpTDSSchedule.DELETEALL();

        EmpTDSDeduction.Delete();
    end;
}

