table 33001204 "Employee PerformanceHeader B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Performance Header';
    LookupPageID = "Employee Performance List B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Apprisal No"; Code[20])
        {
            Caption = 'Apprisal No';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();

                if "Apprisal No" <> xRec."Apprisal No" then begin
                    HRSetup.GET();
                    NoSeriesMgt.TestManual(HRSetup."Appraisal Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = "Employee B2B" WHERE(Blocked = CONST(false), Resigned = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if Employee.GET("Employee No.") then begin
                    "Employee Name" := Employee.FullName();
                    "Physical Location" := Employee."Physical Location";
                    "Department Code" := Employee."Department Code";
                    "Division Code" := FORMAT(Employee.Division);
                    "Date of Joining" := Employee."Employment Date";
                    Designation := Employee.Designation;
                end;
                Evaluate("Apprisar ID", USERID());
            end;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            Editable = false;
            OptionCaption = 'Performance Appraisal,Training Need Identification';
            OptionMembers = "Performance Appraisal","Training Need Identification";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus()
            end;
        }
        field(6; "Period Type"; Option)
        {
            Caption = 'Period Type';
            OptionCaption = 'Quarterly,Half Yearly,Yearly';
            OptionMembers = Quarterly,"Half Yearly",Yearly;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if ("Period Type" = "Period Type"::Quarterly) or ("Period Type" = "Period Type"::"Half Yearly") then begin
                    "From Date" := 0D;
                    "To Date" := 0D;
                    Period := '';
                end
            end;
        }
        field(7; Period; Code[20])
        {
            Caption = 'Period';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                PayrollYear: Record "Payroll Year B2B";
            begin
                TestStatus();
                if "Period Type" = "Period Type"::Yearly then begin
                    PayrollYear.RESET();
                    PayrollYear.SETRANGE("Year Type", FINANCIALYEARTxt);
                    PayrollYear.SETRANGE(Closed, false);
                    if PAGE.RUNMODAL(0, PayrollYear) = ACTION::LookupOK then begin
                        Period := FORMAT(DATE2DMY(PayrollYear."Year Start Date", 3)) + ' - ' + FORMAT(DATE2DMY(PayrollYear."Year End Date", 3));
                        "From Date" := PayrollYear."Year Start Date";
                        "To Date" := PayrollYear."Year End Date";
                    end;
                end;

                Employee.RESET();
                Employee.GET("Employee No.");
                if DATE2DMY("To Date", 3) < DATE2DMY(Employee."Employment Date", 3) then
                    ERROR(Text006Lbl);
            end;

            trigger OnValidate();
            begin
                TestStatus()
            end;
        }
        field(8; "From Date"; Date)
        {
            Caption = 'From Date';
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if ("Period Type" = "Period Type"::Quarterly) or ("Period Type" = "Period Type"::"Half Yearly") then begin
                    if ("From Date" <> 0D) and ("To Date" <> 0D) then
                        Period := FORMAT("From Date") + ' - ' + FORMAT("To Date");
                    Employee.RESET();
                    Employee.GET("Employee No.");
                    if "From Date" < Employee."Employment Date" then
                        ERROR(Text006Lbl);
                end;
            end;
        }
        field(9; "To Date"; Date)
        {
            Caption = 'To Date';
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                if ("Period Type" = "Period Type"::Quarterly) or ("Period Type" = "Period Type"::"Half Yearly") then begin
                    if ("From Date" <> 0D) and ("To Date" <> 0D) then
                        Period := FORMAT("From Date") + ' - ' + FORMAT("To Date");
                    Employee.RESET();
                    Employee.GET("Employee No.");
                    if "To Date" < Employee."Employment Date" then
                        ERROR(Text006Lbl);
                end;
            end;
        }
        field(10; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(11; "Department Code"; Code[30])
        {
            CalcFormula = Lookup("Employee B2B"."Department Code" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Department Code';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(12; "Division Code"; Code[20])
        {
            CalcFormula = Lookup("Employee B2B"."Global Dimension 1 Code" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Division Code';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(13; "Date of Joining"; Date)
        {
            CalcFormula = Lookup("Employee B2B"."Employment Date" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Date of Joining';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(15; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Posted';
            OptionMembers = Open,Released,Posted;
            DataClassification = CustomerContent;
        }
        field(19; "Date of Receipt"; Date)
        {
            Caption = 'Date of Receipt';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(20; "Released By"; Code[50])
        {
            Caption = 'Released By';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(21; "Released Date"; Date)
        {
            Caption = 'Released Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(25; "Total Defined Weightage"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Employee Performance Line B2B".Weightage WHERE("Employee No." = FIELD("Employee No."),
                                                                           Period = FIELD(Period),
                                                                           "KRA Type" = CONST(Question)));
            Caption = 'Total Defined Weightage';
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(26; "Total Achivements"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Employee Performance Line B2B"."Total Target Achived" WHERE("Employee No." = FIELD("Employee No."),
                                                                                        Period = FIELD(Period),
                                                                                        "KRA Type" = CONST(End)));
            Caption = 'Total Achivements';
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(30; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(35; "Physical Location"; Code[20])
        {
            Caption = 'Physical Location';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(40; "Total Self Rating"; Decimal)
        {
            Caption = 'Total Self Rating';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(45; "Total HOD Rating"; Decimal)
        {
            Caption = 'Total HOD Rating';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(50; "Apprisar ID"; Code[50])
        {
            Caption = 'Apprisar ID';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(51; "Question ID"; Code[20])
        {
            Caption = 'Question ID';
            TableRelation = "Questionnaire Header B2B" WHERE("Questionnaire Type" = CONST(Appraisals));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(55; "Form Filter"; Text[50])
        {
            Caption = 'Form Filter';
            FieldClass = FlowFilter;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(56; "Auto Generate Appraisal doc"; Boolean)
        {
            Caption = 'Auto Generate Appraisal doc';
            DataClassification = CustomerContent;

        }

        field(63; "Apprisal Posting Date"; Date)
        {
            Caption = 'Apprisal Posting Date';
            DataClassification = CustomerContent;
        }

        field(64; Designation; Code[50])
        {
            Caption = 'Designation';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DESIGNATIONS'));
            DataClassification = CustomerContent;
        }

        field(65; "New Designtion"; Code[50])
        {
            Caption = 'New Designtion';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DESIGNATIONS'));
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Apprisal No")
        {
        }
        key(Key2; Period, Type, "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        EmpPerfLine.RESET();
        EmpPerfLine.SETRANGE("Appraisal No.", "Apprisal No");
        if EmpPerfLine.FINDFIRST() then
            EmpPerfLine.DELETEALL();
    end;

    trigger OnInsert();
    begin
        if Type = Type::"Training Need Identification" then begin
            if "Apprisal No" = '' then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Training Need Identi.Nos.");
                NoSeriesMgt.InitSeries(HRSetup."Training Need Identi.Nos.", xRec."No. Series", 0D, "Apprisal No", "No. Series");
            end;
        end else
            if "Apprisal No" = '' then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Appraisal Nos.");
                NoSeriesMgt.InitSeries(HRSetup."Appraisal Nos.", xRec."No. Series", 0D, "Apprisal No", "No. Series");
            end;

    end;

    var
        Employee: Record "Employee B2B";

        EmployeePerformanceHeader: Record "Employee PerformanceHeader B2B";
        HRSetup: Record "HR Setup B2B";
        EmpPerfLine: Record "Employee Performance Line B2B";
        NoSeriesMgt: Codeunit 396;

        Text006Lbl: Label 'Period must not be below the employment date';
        Text007Lbl: Label 'Total Weightage is greater than 100. Please change.';
        FINANCIALYEARTxt: Label 'FINANCIAL YEAR';
        Text004Lbl: Label 'Indenting characters @1@@@@@@@@@@@@@@@@@@';
        Text005Lbl: Label 'End %1 is missing a matching Begin.', Comment = '%1 = Serial No';

    procedure AssistEdit(EmployeePerformance: Record "Employee PerformanceHeader B2B"): Boolean;
    begin
        with EmployeePerformanceHeader do begin
            EmployeePerformanceHeader := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD("Appraisal Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Appraisal Nos.", EmployeePerformance."No. Series", "No. Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Appraisal Nos.");
                NoSeriesMgt.SetSeries("Apprisal No");
                Rec := EmployeePerformanceHeader;
                exit(true);
            end;
        end;
    end;

    procedure CalculateTotalRatings();
    var
        PerformanceLine: Record "Employee Performance Line B2B";
        TotalWeightage: Decimal;
    begin
        PerformanceLine.RESET();
        PerformanceLine.SETRANGE("Employee No.", "Apprisal No");
        PerformanceLine.SETRANGE(Period, Period);
        if PerformanceLine.FINDFIRST() then
            repeat
                TotalWeightage += PerformanceLine.Weightage;
            until PerformanceLine.NEXT() = 0;

        if PerformanceLine.FINDFIRST() then
            repeat
                PerformanceLine."Total Target Achived" := PerformanceLine."Joint Review Rating" * PerformanceLine.Weightage;
                PerformanceLine.MODIFY();
            until PerformanceLine.NEXT() = 0;
    end;

    procedure EndTotal();
    var
        PerformanceLine: Record "Employee Performance Line B2B";
        NoOfChars: Integer;
        Progress: Integer;
        Window: Dialog;
        i: Integer;
        Total: array[10] of Decimal;
        TotalAchievement: array[10] of Decimal;
        TotalSelfRatings: array[10] of Decimal;
        TotalHODRatings: array[10] of Decimal;
        NetTotalSelfRating: array[10] of Decimal;
        NetHODRating: array[10] of Decimal;
        TotalAchievementRequired: array[10] of Decimal;
    begin
        CLEAR(i);
        Window.OPEN(Text004Lbl);
        PerformanceLine.RESET();
        PerformanceLine.SETRANGE("Employee No.", "Employee No.");
        PerformanceLine.SETRANGE(Period, Period);
        NoOfChars := PerformanceLine.COUNT();
        if NoOfChars = 0 then
            NoOfChars := 1;
        with PerformanceLine do
            if FINDFIRST() then
                repeat
                    Progress := Progress + 1;
                    Window.UPDATE(1, 10000 * Progress div NoOfChars);
                    if "KRA Type" = "KRA Type"::"End" then begin
                        if i < 1 then
                            ERROR(Text005Lbl, "Serial No.");
                        Weightage := Total[i];
                        "Self Rating" := TotalSelfRatings[i];
                        "HOD Rating" := TotalHODRatings[i];
                        "Total Self Rating" := NetTotalSelfRating[i];
                        "Total HOD Rating" := NetHODRating[i];
                        "Total Target Achived" := TotalAchievement[i];
                        "Total Target" := TotalAchievementRequired[i];
                        if Weightage > 100 then
                            ERROR(Text007Lbl);
                        CLEAR(Total[i]);
                        CLEAR(TotalSelfRatings[i]);
                        CLEAR(TotalHODRatings[i]);
                        CLEAR(NetTotalSelfRating[i]);
                        CLEAR(NetHODRating[i]);
                        MODIFY();
                        i := i - 1;
                    end;
                    if "KRA Type" = "KRA Type"::Answer then begin
                        Total[i] += Weightage;
                        TotalSelfRatings[i] += "Self Rating";
                        TotalHODRatings[i] += "HOD Rating";
                        NetTotalSelfRating[i] += "Total Self Rating";
                        NetHODRating[i] += "Total HOD Rating";
                        TotalAchievement[i] += "Total Target Achived";
                        TotalAchievementRequired[i] += "Total Target";
                    end;
                    if "KRA Type" = "KRA Type"::"Begin" then
                        i := i + 1;
                until NEXT() = 0;
        Window.CLOSE();
    end;

    procedure TestStatus();
    begin
        TESTFIELD(Status, Status::Open);
    end;
}

