page 33001219 "Create Year B2B"
{
    // version B2BHR1.00.00

    Caption = 'Create Year';
    PageType = Card;
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(StartDate1; StartDate)
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the various pay roll years to used run the HR and Payroll "Leave Year, Financial Year, ESI Year and PF Year" Every year associated has a "Start Date and End Date"';
                    ApplicationArea = all;
                }
                field(EndDate1; EndDate)
                {
                    Caption = 'End Date';
                    ToolTip = 'Specifies the various pay roll years to used run the HR and Payroll "Leave Year, Financial Year, ESI Year and PF Year" Every year associated has a "Start Date and End Date"';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Create)
            {
                Caption = 'Create';
                Image = Start;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the Create year details.';

                trigger OnAction();
                begin
                    CheckValidations();
                    CurrPage.CLOSE();
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        DateINIT();
        StartDate := StartDate2;
    end;

    var
        YearType2: Code[50];
        StartDate: Date;
        EndDate: Date;
        Text000Lbl: Label 'Start Date can''t be blank';
        Text001Lbl: Label 'End Date can''t be blank';
        Text002Lbl: Label 'Start date can''t be greater than the End date';
        StartDate2: Date;

    procedure YearTypeInsert(YearType: Code[50]);
    begin
        YearType2 := YearType;
    end;

    procedure PayYearInsert();
    var
        PayYear: Record "Payroll Year B2B";
    begin
        PayYear.RESET();
        PayYear.INIT();
        PayYear."Year Type" := YearType2;
        PayYear."Year Start Date" := StartDate;
        PayYear."Year End Date" := EndDate;
        PayYear.INSERT();
    end;

    procedure CheckValidations();
    begin
        if StartDate = 0D then
            ERROR(Text000Lbl);

        if EndDate = 0D then
            ERROR(Text001Lbl);

        if StartDate > EndDate then
            ERROR(Text002Lbl);

        PayYearINSERT();
    end;

    procedure Dateinit();
    var
        PayYear: Record "Payroll Year B2B";
        MaxDate: Date;
    begin
        PayYear.SETRANGE("Year Type", YearType2);
        if PayYear.FINDFIRST() then begin
            repeat
                if PayYear."Year End Date" > MaxDate then
                    MaxDate := PayYear."Year End Date";
            until PayYear.NEXT() = 0;
            StartDate2 := MaxDate + 1;
        end else
            StartDate2 := 0D;
    end;

    procedure HRSetupInsert();
    var
        HRsetup: Record "HR Setup B2B";
        PayYear: Record "Payroll Year B2B";
    begin
        PayYear.SETRANGE("Year Type", 'FINANCIAL YEAR');
        if PayYear.FINDFIRST() then
            if PayYear.COUNT() = 1 then
                if HRsetup.FINDFIRST() then begin
                    HRsetup."Salary Processing month" := DATE2DMY(StartDate, 2);
                    HRsetup."Salary Processing Year" := DATE2DMY(StartDate, 3);
                    HRsetup.MODIFY();
                end else begin
                    HRsetup.INIT();
                    HRsetup."Salary Processing month" := DATE2DMY(StartDate, 2);
                    HRsetup."Salary Processing Year" := DATE2DMY(StartDate, 3);
                    HRsetup.INSERT();
                end;


    end;
}

