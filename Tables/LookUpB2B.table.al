table 33001192 Lookup_B2B
{
    // version B2BHR1.00.00

    Caption = 'Lookup';
    DrillDownPageID = "LookUp List B2B";
    LookupPageID = "LookUp List B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Lookup Id"; Integer)
        {
            Caption = 'Lookup ID';
            DataClassification = CustomerContent;
        }
        field(2; "Lookup Name"; Code[20])
        {
            Caption = 'Lookup Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "System Defined" then
                    ERROR(Text000Lbl);
            end;
        }
        field(3; "Lookup Type"; Integer)
        {
            Caption = 'Lookup Type';
            TableRelation = "Lookup Type B2B";
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(6; "LookupType Name"; Code[50])
        {
            CalcFormula = Lookup("Lookup Type B2B".Name WHERE("No." = FIELD("Lookup Type")));
            Caption = 'LookupTypeName';
            Editable = false;
            FieldClass = FlowField;

        }
        field(10; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;

        }
        field(12; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(13; "Add/Deduct"; Option)
        {
            Caption = 'Add/Deduct';
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "System Defined" then
                    ERROR(Text000Lbl);
            end;
        }
        field(14; "Computed Gross OT %"; Decimal)
        {
            Caption = 'Computed Gross OT %';
            DataClassification = CustomerContent;
        }
        field(15; "Applicable for OT"; Boolean)
        {
            Caption = 'Applicable for OT';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Lookup Type" = 16) and ("Lookup Name" = OTTxtLbl) and "Applicable for OT" then
                    ERROR(Text004Lbl);

                PayElement.RESET();
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayElement.FINDFIRST() then
                    repeat
                        PayElement."Applicable for OT" := "Applicable for OT";
                        PayElement.MODIFY();
                    until PayElement.NEXT() = 0;

                PayCadrePayElement.RESET();
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayCadrePayElement.FINDFIRST() then
                    repeat
                        PayCadrePayElement."Applicable for OT" := "Applicable for OT";
                        PayCadrePayElement.MODIFY();
                    until PayCadrePayElement.NEXT() = 0;
            end;
        }
        field(16; ESI; Option)
        {
            Caption = 'ESI';
            OptionCaption = ' ,Regular Element,Irregular Element';
            OptionMembers = " ","Regular Element","Irregular Element";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Lookup Type" = 16) and ("Lookup Name" = ESITxtLbl) then
                    ERROR(Text004Lbl);

                PayElement.RESET();
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayElement.FINDFIRST() then
                    repeat
                        PayElement.ESI := ESI;
                        PayElement.MODIFY();
                    until PayElement.NEXT() = 0;

                PayCadrePayElement.RESET();
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayCadrePayElement.FINDFIRST() then
                    repeat
                        PayCadrePayElement.ESI := ESI;
                        PayCadrePayElement.MODIFY();
                    until PayCadrePayElement.NEXT() = 0;
            end;
        }
        field(17; PF; Boolean)
        {
            Caption = 'PF';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Lookup Type" = 16) and ("Lookup Name" = PFTxtLbl) and PF then
                    ERROR(Text004Lbl);

                PayElement.RESET();
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayElement.FINDFIRST() then
                    repeat
                        PayElement.PF := PF;
                        PayElement.MODIFY();
                    until PayElement.NEXT() = 0;

                PayCadrePayElement.RESET();
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayCadrePayElement.FINDFIRST() then
                    repeat
                        PayCadrePayElement.PF := PF;
                        PayCadrePayElement.MODIFY();
                    until PayCadrePayElement.NEXT() = 0;
            end;
        }
        field(18; "Leave Encashment"; Boolean)
        {
            Caption = 'Leave Encashment';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                PayElement.RESET();
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayElement.FINDFIRST() then
                    repeat
                        PayElement."Leave Encashment" := "Leave Encashment";
                        PayElement.MODIFY();
                    until PayElement.NEXT() = 0;

                PayCadrePayElement.RESET();
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayCadrePayElement.FINDFIRST() then
                    repeat
                        PayCadrePayElement."Leave Encashment" := "Leave Encashment";
                        PayCadrePayElement.MODIFY();
                    until PayCadrePayElement.NEXT() = 0;
            end;
        }
        field(19; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Loan';
            OptionMembers = " ",Loan;
            DataClassification = CustomerContent;
        }
        field(20; "Loan Interest Type"; Option)
        {
            Caption = 'Loan Interest Type';
            OptionCaption = 'Interest Free,Yearly Reducing';
            OptionMembers = "Interest Free","Yearly Reducing";
            DataClassification = CustomerContent;
        }
        field(21; "Interest Percent"; Decimal)
        {
            Caption = 'Interest Percent';
            DataClassification = CustomerContent;
        }
        field(22; Priority; Integer)
        {
            Caption = 'Priority';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Loan.FINDFIRST() then
                    repeat
                        Loan.Priority := Priority;
                        Loan.MODIFY();
                    until Loan.NEXT() = 0;


                if "Lookup Id" = 16 then
                    if Priority <> 0 then
                        TESTFIELD("Add/Deduct", "Add/Deduct"::Deduction);

            end;
        }
        field(30; "Payroll Prod. Posting Group"; Code[20])
        {
            Caption = 'Payroll Prod. Posting Group';
            TableRelation = "Payroll Prod. Post. Group B2B".Code;
            DataClassification = CustomerContent;
        }
        field(31; "System Defined"; Boolean)
        {
            Caption = 'System Defined';
            DataClassification = CustomerContent;
        }
        field(32; "Period Start Date"; Date)
        {
            Caption = 'Period Start Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                HRSetup: Record "HR Setup B2B";
                CheckDate: Date;
            begin
                if HRSetup.FINDFIRST() then
                    if "Period Start Date" <> 0D then begin
                        CheckDate := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");
                        "Period End Date" := (CALCDATE(OneMonthExprLbl, "Period Start Date") - 1);
                        if (DATE2DMY("Period End Date", 2) <> HRSetup."Salary Processing month") or
                           (DATE2DMY("Period End Date", 3) <> HRSetup."Salary Processing Year")
                        then
                            ERROR(Text001Lbl, "Period End Date", HRSetup."Salary Processing month", HRSetup."Salary Processing Year")
                    end else
                        "Period End Date" := 0D;

            end;
        }
        field(33; "Period End Date"; Date)
        {
            Caption = 'Period End Date';
            DataClassification = CustomerContent;
        }
        field(34; "Min Salary"; Decimal)
        {
            Caption = 'Min Salary';
            DataClassification = CustomerContent;
        }
        field(35; "Loan Priority No."; Integer)
        {
            Caption = 'Loan Priority No.';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Loan.RESET();
                Loan.SETRANGE("Loan Type", "Lookup Name");
                if Loan.FINDSET() then
                    repeat
                        Loan."Loan Priority No" := "Loan Priority No.";
                        Loan.MODIFY();
                    until Loan.NEXT() = 0;

            end;
        }
        field(36; Probation; Boolean)
        {
            Caption = 'Probation';
            DataClassification = CustomerContent;
        }
        field(37; "Bonus/Exgratia"; Option)
        {
            Caption = 'Bonus/Exgratia';
            OptionCaption = ' ,Bonus,Ex-gratia,Both';
            OptionMembers = " ",Bonus,"Ex-gratia",Both;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                PayElement.RESET();
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayElement.FINDSET() then
                    repeat
                        PayElement."Bonus/Exgratia" := "Bonus/Exgratia";
                        PayElement.MODIFY();
                    until PayElement.NEXT() = 0;

                PayCadrePayElement.RESET();
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayCadrePayElement.FINDSET() then
                    repeat
                        PayCadrePayElement."Bonus/Exgratia" := "Bonus/Exgratia";
                        PayCadrePayElement.MODIFY();
                    until PayCadrePayElement.NEXT() = 0;
            end;
        }
        field(38; "Incentive Applicable"; Option)
        {
            Caption = 'Incentive Applicable';
            OptionCaption = ' ,Bonus,Ex-gratia';
            OptionMembers = " ",Bonus,"Ex-gratia";
            DataClassification = CustomerContent;
        }
        field(39; "Per Meal Rate"; Decimal)
        {
            Caption = 'Per Meal Rate';
            DataClassification = CustomerContent;
        }
        field(40; Grade; Code[20])
        {
            Caption = 'Grade';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
            DataClassification = CustomerContent;
        }
        field(41; "Max.Amt"; Decimal)
        {
            Caption = 'Max.Amt';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Max.Amt.Type" = "Max.Amt.Type"::" " then
                    ERROR(Text002Lbl);
            end;
        }
        field(42; "Max.No. of instalments"; Integer)
        {
            Caption = 'Max.No. of instalments';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(44; Gratuity; Boolean)
        {
            Caption = 'Gratuity';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                PayElement.RESET();
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayElement.FINDSET() then
                    repeat
                        PayElement.Gratuity := Gratuity;
                        PayElement.MODIFY();
                    until PayElement.NEXT() = 0;

                PayCadrePayElement.RESET();
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayCadrePayElement.FINDSET() then
                    repeat
                        PayCadrePayElement.Gratuity := Gratuity;
                        PayCadrePayElement.MODIFY();
                    until PayCadrePayElement.NEXT() = 0;
            end;
        }
        field(46; PT; Boolean)
        {
            Caption = 'PT';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Lookup Type" = 16) and ("Lookup Name" = PTTxtLbl) and PT then
                    ERROR(Text004Lbl);

                PayElement.RESET();
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayElement.FINDSET() then
                    repeat
                        PayElement.PT := PT;
                        PayElement.MODIFY();
                    until PayElement.NEXT() = 0;

                PayCadrePayElement.RESET();
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayCadrePayElement.FINDSET() then
                    repeat
                        PayCadrePayElement.PT := PT;
                        PayCadrePayElement.MODIFY();
                    until PayCadrePayElement.NEXT() = 0;
            end;
        }
        field(47; Recruitment; Boolean)
        {
            Caption = 'Recruitment';
            DataClassification = CustomerContent;
        }
        field(49; "Bonus Adjust"; Boolean)
        {
            Caption = 'Bonus Adjust';
            DataClassification = CustomerContent;
        }
        field(50; "All Grades"; Boolean)
        {
            Caption = 'All Grades';
            DataClassification = CustomerContent;
        }
        field(51; "Max.Amt.Type"; Option)
        {
            Caption = 'Max.Amt.Type';
            OptionCaption = ' ,Amount,Gross Salary';
            OptionMembers = " ",Amount,"Gross Salary";
            DataClassification = CustomerContent;
        }
        field(55; LTA; Boolean)
        {
            Caption = 'LTA';
            DataClassification = CustomerContent;
        }
        field(60; "Applicable for C Off"; Boolean)
        {
            Caption = 'Applicable for C Off';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Lookup Type" = 16) and ("Lookup Name" = COFFTxtLbl) and "Applicable for C Off" then
                    ERROR(Text004Lbl);

                PayElement.RESET();
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayElement.FINDFIRST() then
                    repeat
                        PayElement."Applicable for C Off" := "Applicable for C Off";
                        PayElement.MODIFY();
                    until PayElement.NEXT() = 0;

                PayCadrePayElement.RESET();
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                if PayCadrePayElement.FINDFIRST() then
                    repeat
                        PayCadrePayElement."Applicable for C Off" := "Applicable for C Off";
                        PayCadrePayElement.MODIFY();
                    until PayCadrePayElement.NEXT() = 0;
            end;
        }
        field(75; "Attendance Start Date"; Date)
        {
            Caption = 'Attendance Start Date';
            DataClassification = CustomerContent;
        }
        field(76; "Attendance End Date"; Date)
        {
            Caption = 'Attendance End Date';
            DataClassification = CustomerContent;
        }
        field(100; "Print in Payregister"; Boolean)
        {
            Caption = 'Print in Payregister';
            DataClassification = CustomerContent;
        }
        field(101; "Continuous Deduction for Loan"; Boolean)
        {
            Caption = 'Continuous Deduction for Loan';
            DataClassification = CustomerContent;
        }
        field(102; "Pay Cadre"; Code[30])
        {
            Caption = 'Pay Cadre';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Id" = CONST(20));
            DataClassification = CustomerContent;
        }
        field(103; "Print in Payregister(Actualy)"; Boolean)
        {
            Caption = 'Print in Payregister(Actualy)';
            DataClassification = CustomerContent;
        }
        field(110; Sequence; Integer)
        {
            Caption = 'Sequence';
            InitValue = 10000;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE(Sequence, Sequence);
                if Lookup_B2B.FINDFIRST() and (Sequence <> 0) then
                    ERROR(SequenceExistErrLbl, Sequence);
            end;
        }
        field(112; "Training Type"; Text[30])
        {
            Caption = 'Training Type';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('TYPE OF TRAINING'));
            DataClassification = CustomerContent;
        }
        field(113; "Performance Scale Value"; Decimal)
        {
            Caption = 'Performance Scale Value';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE("Performance Scale Value", "Performance Scale Value");
                if Lookup_B2B.FINDFIRST() then
                    repeat
                        ERROR(Text005Lbl);
                    until Lookup_B2B.NEXT() = 0;
            end;
        }
        field(114; "Print in Payslip"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(115; "Show Priority"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(116; "Probation Period"; DateFormula)
        {
            Caption = 'Probation Period';
            DataClassification = CustomerContent;
        }
        field(117; "Designation Pay Cader"; code[20])
        {
            caption = 'Designation Pay Cader';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup type" = filter(20));

            DataClassification = CustomerContent;
        }
        //<<CHB2B18OCT2022
        /*field(50001; "Exit Reason Code For Pf"; Option)
        {
            OptionMembers = " ",C,S,R,D,P;
        }*/
        //CHB2B18OCT2022>>

    }

    keys
    {
        key(Key1; "Lookup Id", "Lookup Name", "Lookup Type")
        {
        }
        key(Key2; "Lookup Name")
        {
        }
        key(Key3; "Lookup Type")
        {
        }
        key(Key4; "Lookup Name", "Lookup Type")
        {
        }
        key(Key5; "Add/Deduct")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Lookup Name", Description)
        {
        }
    }

    trigger OnDelete();
    begin
        if "System Defined" then
            ERROR(Text000Lbl);

        if "Lookup Type" = 20 then begin
            Employee.RESET();
            Employee.SETRANGE(Employee."Pay Cadre", "Lookup Name");
            if Employee.FINDFIRST() then
                ERROR(Text003Lbl, "Lookup Name")
            else begin
                PayCadrePayElement.RESET();
                PayCadrePayElement.SETRANGE("Pay Cadre Code", "Lookup Name");
                if PayCadrePayElement.FINDFIRST() then
                    repeat
                        PayCadrePayElement.DELETE();
                    until PayCadrePayElement.NEXT() = 0;
            end;
        end;
    end;

    trigger OnInsert();
    begin
        if Lookup_B2B.FINDLAST() then
            "Lookup Id" := Lookup_B2B."Lookup Id" + 1
        else
            "Lookup Id" := 1;
    end;

    trigger OnRename();
    begin
        if "System Defined" then
            ERROR(Text000Lbl);
    end;

    var
        Employee: Record "Employee B2B";
        PayElement: Record "Pay Elements B2B";
        PayCadrePayElement: Record "Pay Cadre Pay Element B2B";
        Loan: Record Loan_B2B;
        Lookup_B2B: Record Lookup_B2B;
        Text000Lbl: Label 'You cannot modify/delete the system defined record';
        Text001Lbl: Label '"Month and Year in the ending date %1, should be equal to salary processing month %2 and year %3 "', Comment = '%1 =  ; %2 = ;%3 = ';
        Text002Lbl: Label 'Select Maximum Amount Type.';
        Text003Lbl: Label 'You cannnot delete the paycadre %1, it was already assigned to employees.', Comment = '%1 = Lookup Name';
        Text004Lbl: Label 'Invalid selection.';
        Text005Lbl: Label '"You cannot assign same rating value "';
        OTTxtLbl: Label 'OT';
        ESITxtLbl: Label 'ESI';
        PFTxtLbl: Label 'PF';
        OneMonthExprLbl: Label '<1M>';
        PTTxtLbl: Label 'PT';
        COFFTxtLbl: Label 'C OFF';
        SequenceExistErrLbl: Label 'Sequence %1 is already exists.', Comment = '%1 = Sequence No';
}

