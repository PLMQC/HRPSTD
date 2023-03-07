table 33001278 "Job History B2B"
{
    // version B2BHR1.00.00

    Caption = 'Job History';
    //DrillDownPageID = 33001315;//Phani
    //LookupPageID = 33001315;//Phani
    DataClassification = CustomerContent;

    fields
    {
        field(1; "SNo."; Code[20])
        {
            Caption = 'SNo.';
            DataClassification = CustomerContent;
        }
        field(2; "Name of the Company"; Code[50])
        {
            Caption = 'Name of the Company';
            DataClassification = CustomerContent;
        }
        field(3; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                if ("Starting Date" <> 0D) and ("End Date" <> 0D) then begin
                    NoofDays := ABS("End Date" - "Starting Date");
                    NoOfYears := NoofDays DIV 365;
                    NoOfMonth := NoofDays MOD 365;
                    Noofmonth2 := Round(NoOfMonth div 30);
                    Evaluate(Experience, format(NoOfYears) + '.' + Format(Noofmonth2));
                    UpdateExperience();
                end;

            end;
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                if ("Starting Date" <> 0D) and ("End Date" <> 0D) then begin
                    NoofDays := ABS("End Date" - "Starting Date");
                    NoOfYears := NoofDays DIV 365;
                    NoOfMonth := NoofDays MOD 365;
                    Noofmonth2 := Round(NoOfMonth div 30);
                    Evaluate(Experience, format(NoOfYears) + '.' + Format(Noofmonth2));
                    UpdateExperience();
                end;
            end;
        }
        field(5; Designation; Code[20])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE(Lookup_B2B."Lookup Type", 5);
                if PAGE.RUNMODAL(0, Lookup_B2B) = ACTION::LookupOK then
                    Designation := Lookup_B2B."Lookup Name";
            end;
        }
        field(6; "Roles and Responsibility"; Code[30])
        {
            Caption = 'Roles and Responsibility';
            DataClassification = CustomerContent;
        }
        field(7; "Last Salary Drawn"; Decimal)
        {
            Caption = 'Last Salary Drawn';
            DataClassification = CustomerContent;
        }
        field(8; "Awards && Rewards"; Code[50])
        {
            Caption = 'Awards && Rewards';
            DataClassification = CustomerContent;
        }
        field(9; "Extra Curriculam Activities"; Text[50])
        {
            Caption = 'Extra Curriculam Activities';
            DataClassification = CustomerContent;
        }
        field(10; "Type of Industry"; Code[40])
        {
            Caption = 'Type of Industry';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE(Lookup_B2B."Lookup Type", 35);
                if PAGE.RUNMODAL(0, Lookup_B2B) = ACTION::LookupOK then
                    "Type of Industry" := Copystr(Lookup_B2B.Description, 1, 40);
            end;
        }
        field(11; Experience1; Integer)
        {
            Caption = 'Experience1';
            DataClassification = CustomerContent;
        }
        field(12; Experience; Decimal)
        {
            Caption = 'Experience';
            DataClassification = CustomerContent;
        }
        field(13; "Emp No."; Code[20])
        {
            Caption = 'Emp No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(15; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Resume,Employee';
            OptionMembers = Resume,Employee;
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(Key1; "SNo.", "Name of the Company", "Type of Industry")
        {
            SumIndexFields = Experience;
        }
    }

    fieldgroups
    {
    }

    var
        lookup_B2B: Record Lookup_B2b;
        NoOfYears: Decimal;
        NoOfMonth: Integer;
        Noofmonth2: Integer;
        NoofDays: Integer;

    procedure UpdateExperience()
    var

        JobHistory: Record "Job History B2B";
        EmployeeB2B: Record "Employee B2B";
        ResumeDB: Record "Resume Database B2B";
        Totdays: Integer;
        TotNoOfYears: Integer;
        TotNoOfMonth: Integer;
        TotNoofmonth2: Integer;

    begin
        clear(totdays);
        clear(TotNoOfYears);
        clear(TotNoofmonth2);

        Totdays := ABS("End Date" - "Starting Date");
        JobHistory.RESET();
        JobHistory.setrange("SNo.", "SNo.");
        jobhistory.setrange("Name of the Company", '<>%1', "Name of the Company");
        JobHistory.setrange("Type of Industry", '<>%1', "Type of Industry");
        if jobhistory.findset() then
            repeat
                Totdays += ABS("End Date" - "Starting Date");
            until JobHistory.NEXT() = 0;

        if Totdays <> 0 then begin
            TotNoOfYears := totDays DIV 365;
            totNoOfMonth := totDays MOD 365;
            TotNoofmonth2 := ROUND(totNoOfMonth div 30);


        end;

        if EmployeeB2B.Get("Sno.") then begin
            EmployeeB2B."Experience (Years)" := TotNoOfYears;
            EmployeeB2B."Experience (Months)" := TotNoofmonth2;
            EmployeeB2B.MODIFY();
        end else
            if ResumeDB.Get("Sno.") then begin
                ResumeDB."Experience(Years)" := TotNoOfYears;
                ResumeDB.months := TotNoofmonth2;
                if (ResumeDB."Experience(Years)" <> 0) or (ResumeDB.Months <> 0) then
                    ResumeDB."Experience Type" := ResumeDB."Experience Type"::Experienced
                else
                    ResumeDB."Experience Type" := ResumeDB."Experience Type"::Fresher;
                ResumeDB.MODIFY();
            end;

    end;

    trigger OnDelete()
    begin
        UpdateExperience();
    end;
}

