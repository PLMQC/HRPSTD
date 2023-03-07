table 33001190 "HR Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'HR Setup';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Employee Nos."; Code[20])
        {
            Caption = 'Employee Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(5; "Resume DB Nos."; Code[20])
        {
            Caption = 'Resume DB Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(6; "Recruitment Nos."; Code[20])
        {
            Caption = 'Recruitment Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(7; "Pay Revision Nos."; Code[20])
        {
            Caption = 'Pay Revision Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(8; "Loan Nos."; Code[20])
        {
            Caption = 'Loan Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(9; "Training Nos."; Code[20])
        {
            Caption = 'Training Nos';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(10; "Salary Processing month"; Integer)
        {
            Caption = 'Salary Processing month';
            InitValue = 1;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Salary Processing month" = 1 then
                    "Processing Month" := "Processing Month"::January;
                if "Salary Processing month" = 2 then
                    "Processing Month" := "Processing Month"::February;
                if "Salary Processing month" = 3 then
                    "Processing Month" := "Processing Month"::March;
                if "Salary Processing month" = 4 then
                    "Processing Month" := "Processing Month"::April;
                if "Salary Processing month" = 5 then
                    "Processing Month" := "Processing Month"::May;
                if "Salary Processing month" = 6 then
                    "Processing Month" := "Processing Month"::June;
                if "Salary Processing month" = 7 then
                    "Processing Month" := "Processing Month"::July;
                if "Salary Processing month" = 8 then
                    "Processing Month" := "Processing Month"::August;
                if "Salary Processing month" = 9 then
                    "Processing Month" := "Processing Month"::September;
                if "Salary Processing month" = 10 then
                    "Processing Month" := "Processing Month"::October;
                if "Salary Processing month" = 11 then
                    "Processing Month" := "Processing Month"::November;
                if "Salary Processing month" = 12 then
                    "Processing Month" := "Processing Month"::December;
                CompOffLapse();//B2BBP
            end;
        }
        field(11; "Salary Processing Year"; Integer)
        {
            Caption = 'Salary Processing Year';
            DataClassification = CustomerContent;
        }
        field(14; "Default Attendance Type"; Option)
        {
            Caption = 'Default Attendance Type';
            OptionCaption = 'Present,Absent';
            OptionMembers = Present,Absent;
            DataClassification = CustomerContent;
        }
        field(17; "Employer PF"; Code[20])
        {
            Caption = 'Employer PF';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(18; "Employer EPS"; Code[20])
        {
            Caption = 'Employer EPS';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(19; "PF Admin. Charges"; Code[20])
        {
            Caption = 'PF Admin. Charges';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(20; "EDLI Charges"; Code[20])
        {
            Caption = 'EDLI Charges';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(21; "Employer ESI"; Code[20])
        {
            Caption = 'Employer ESI';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(22; "Posted Payroll No."; Code[20])
        {
            Caption = 'Posted Payroll No.';
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(23; "Processing Month"; Option)
        {
            Caption = 'Processing Month';
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = January,February,March,April,May,June,July,August,September,October,November,December;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Processing Month" = "Processing Month"::January then
                    "Salary Processing month" := 1;
                if "Processing Month" = "Processing Month"::February then
                    "Salary Processing month" := 2;
                if "Processing Month" = "Processing Month"::March then
                    "Salary Processing month" := 3;
                if "Processing Month" = "Processing Month"::April then
                    "Salary Processing month" := 4;
                if "Processing Month" = "Processing Month"::May then
                    "Salary Processing month" := 5;
                if "Processing Month" = "Processing Month"::June then
                    "Salary Processing month" := 6;
                if "Processing Month" = "Processing Month"::July then
                    "Salary Processing month" := 7;
                if "Processing Month" = "Processing Month"::August then
                    "Salary Processing month" := 8;
                if "Processing Month" = "Processing Month"::September then
                    "Salary Processing month" := 9;
                if "Processing Month" = "Processing Month"::October then
                    "Salary Processing month" := 10;
                if "Processing Month" = "Processing Month"::November then
                    "Salary Processing month" := 11;
                if "Processing Month" = "Processing Month"::December then
                    "Salary Processing month" := 12;
            end;
        }
        field(24; Locked; Boolean)
        {
            Caption = 'Locked';
            DataClassification = CustomerContent;
        }
        field(30; "Rounding Precision"; Decimal)
        {
            Caption = 'Rounding Precision';
            InitValue = 1;
            MaxValue = 100;
            MinValue = 0.0001;
            DataClassification = CustomerContent;
        }
        field(31; "Rounding Type"; Option)
        {
            Caption = 'Rounding Type';
            OptionCaption = 'To the nearest value,Up,Down';
            OptionMembers = "To the nearest value",Up,Down;
            DataClassification = CustomerContent;
        }
        field(32; "RIFA Charges"; Code[20])
        {
            Caption = 'RIFA Charges';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(37; "Min. No.of Years"; Decimal)
        {
            Caption = 'Min. No.of Years';
            DataClassification = CustomerContent;
        }
        field(38; "No.of Days Salary"; Integer)
        {
            Caption = 'No.of Days Salary';
            DataClassification = CustomerContent;
        }
        field(39; "No.of Days in Month"; Integer)
        {
            Caption = 'No.of Days in Month';
            DataClassification = CustomerContent;

        }
        field(41; "Attachment Storage Type"; Option)
        {
            Caption = 'Attachment Storage Type';
            OptionCaption = 'Embedded,Disk File';
            OptionMembers = Embedded,"Disk File";
            DataClassification = CustomerContent;
        }
        field(42; "Cash Account"; Code[20])
        {
            Caption = 'Cash Account';
            TableRelation = "G/L Account"."No.";
            DataClassification = CustomerContent;
        }
        field(43; "Bank Account"; Code[20])
        {
            Caption = 'Bank Account';
            TableRelation = "Bank Account"."No.";
            DataClassification = CustomerContent;
        }
        field(44; "Attmt. Storage Location"; Text[250])
        {
            Caption = 'Attmt. Storage Location';
            DataClassification = CustomerContent;
        }
        field(45; "Training Calender Nos."; Code[20])
        {
            Caption = 'Training Calender Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(46; "TrainingPlan Nos."; Code[20])
        {
            Caption = 'TrainingPlan Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(48; "Appraisal Nos."; Code[20])
        {
            Caption = 'Appraisal Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(51; "Linking Factor1"; Decimal)
        {
            Caption = 'Linking Factor1';
            DataClassification = CustomerContent;
        }
        field(52; "Linking Factor2"; Decimal)
        {
            Caption = 'Linking Factor2';
            DataClassification = CustomerContent;
        }
        field(53; "Neutralisation Points"; Decimal)
        {
            Caption = 'Neutralisation Points';
            DataClassification = CustomerContent;
        }
        field(54; "VDA Rate"; Decimal)
        {
            Caption = 'VDA Rate';
            DataClassification = CustomerContent;
        }
        field(55; "FDA Amount"; Decimal)
        {
            Caption = 'FDA Amount';
            DataClassification = CustomerContent;
        }
        field(58; "Leave Application Nos."; Code[20])
        {
            Caption = 'Leave Application Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60; "Compensatory Leave Code"; Code[20])
        {
            Caption = 'Compensatory Leave Code';
            TableRelation = "Leave Master B2B"."Leave Code";
            DataClassification = CustomerContent;
        }
        field(65; "Paid Days Per Month"; Decimal)
        {
            Caption = 'Paid Days Per Month';
            DataClassification = CustomerContent;
        }
        field(68; "Minimum Absent Days (HRA)"; Decimal)
        {
            Caption = 'Minimum Absent Days (HRA)';
            DataClassification = CustomerContent;
        }
        field(70; "Att Bonus Min Days"; Decimal)
        {
            Caption = 'Att Bonus Min Days';
            DataClassification = CustomerContent;
        }
        field(72; "Att Bonus Min Leaves"; Decimal)
        {
            Caption = 'Att Bonus Min Leaves';
            DataClassification = CustomerContent;
        }
        field(100; "Leave b/w Off Days"; Boolean)
        {
            Caption = 'Leave b/w Off Days';
            DataClassification = CustomerContent;
        }
        field(101; "Leave Entitlement Period"; Integer)
        {
            Caption = 'Leave Entitlement Period';
            DataClassification = CustomerContent;
        }
        field(105; "PF Nos."; Code[20])
        {
            Caption = 'PF Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(107; "Att Reg Period"; DateFormula)
        {
            Caption = 'Att Reg Period';
            DataClassification = CustomerContent;
        }
        field(120; "Over Time Nos."; Code[20])
        {
            Caption = 'Over Time Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(121; "On Duty Nos."; Code[20])
        {
            Caption = 'On Duty Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(122; "Tour intimation Nos."; Code[20])
        {
            Caption = 'Tour intimation Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(123; "Shift Nos."; Code[20])
        {
            Caption = 'Shift Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(125; "Permission Nos."; Code[20])
        {
            Caption = 'Permission Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(130; "LOP Adj. Nos."; Code[20])
        {
            Caption = 'LOP Adj. Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(132; "Comp Off Nos."; Code[20])
        {
            Caption = 'Comp Off Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(200; "HR E-Mail"; Text[30])
        {
            Caption = 'HR E-Mail';
            DataClassification = CustomerContent;
        }
        field(201; No; Code[30])
        {
            Caption = 'No';
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(202; "Job Desciption Nos."; Code[50])
        {
            Caption = 'Job Desciption Nos.';
            //Enabled = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(203; "Insurance Nos."; Code[20])
        {
            Caption = 'Insurance Nos.';
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(204; "Conveyance Acc."; Code[20])
        {
            Caption = 'Conveyance Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(205; "Food Acc."; Code[20])
        {
            Caption = 'Food Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(206; "Subscription Acc."; Code[20])
        {
            Caption = 'Subscription Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(207; "Medical Acc."; Code[20])
        {
            Caption = 'Medical Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(208; "Entertainment Acc."; Code[20])
        {
            Caption = 'Entertainment Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(209; "Night Shift All. Acc."; Code[20])
        {
            Caption = 'Night Shift All. Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(210; "Others Acc."; Code[20])
        {
            Caption = 'Others Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(211; "Travelling Expences Acc."; Code[20])
        {
            Caption = 'Travelling Expences Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(212; "Books and Periodical"; Code[20])
        {
            Caption = 'Books and Periodical';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(213; "LTA Nos."; Code[20])
        {
            Caption = 'LTA Nos.';
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(214; "Ind. Training Nos."; Code[20])
        {
            Caption = 'Ind. Training Nos.';
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(215; "Training Need Identi.Nos."; Code[20])
        {
            Caption = 'Training Need Identi.Nos.';
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(220; "Tax Account Number(TAN)"; Code[20])
        {
            Caption = 'Tax Account Number(TAN)';
            //TableRelation = Table13725;//Phani
            DataClassification = CustomerContent;
        }
        field(221; "Permanent Account Number"; Code[20])
        {
            Caption = 'Permanent Account Number';
            DataClassification = CustomerContent;
        }
        field(222; Surcharge; Decimal)
        {
            Caption = 'Surcharge';
            DataClassification = CustomerContent;
        }
        field(223; "Educational Cess"; Decimal)
        {
            Caption = 'Educational Cess';
            DataClassification = CustomerContent;
        }
        field(233; "Training Schedule Nos."; Code[20])
        {
            Caption = 'Training Schedule Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(234; "Activate Leave Approvals"; Boolean)
        {
            Caption = 'Activate Leave Approvals';
            DataClassification = CustomerContent;
        }
        field(235; "Leave Encashment Nos."; Code[20])
        {
            Caption = 'Leave Encashment Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(236; "Activate Res. Indent Approvals"; Boolean)
        {
            Caption = 'Activate Res. Indent Approvals';
            DataClassification = CustomerContent;
        }
        field(250; "Exit Interview Nos."; Code[20])
        {
            Caption = 'Exit Interview Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(261; "Exit Interview Que. Nos."; Code[10])
        {
            Caption = 'Exit Interview Que. Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(263; "Job Description Nos."; Code[20])
        {
            Caption = 'Job Description Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(264; "Attendance Storage Location"; Text[250])
        {
            Caption = 'Attendance Storage Location';
            DataClassification = CustomerContent;
        }
        field(265; "Appraisal Identification"; Code[20])
        {
            Caption = 'Appraisal Identification';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(266; Intern; Code[20])
        {
            Caption = 'Intern';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(267; "Intern Evaluation"; Code[20])
        {
            Caption = 'Intern Evaluation';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(295; "Resume Block Period(Months)"; Integer)
        {
            Caption = 'Resume Block Period(Months)';
            DataClassification = CustomerContent;
        }
        field(308; "Restricted OT Hrs."; Decimal)
        {
            Caption = 'Restricted OT Hrs.';
            DataClassification = CustomerContent;
        }
        field(309; "Excess OT Hrs. Payelement"; Code[20])
        {
            Caption = 'Excess OT Hrs. Payelement';
            TableRelation = Lookup_B2B."Lookup Id" WHERE("Lookup Type" = CONST(16),
                                                      "Add/Deduct" = CONST(Addition),
                                                      "System Defined" = CONST(false));
            DataClassification = CustomerContent;
        }
        field(310; "HR UserID"; Code[20])
        {
            Caption = 'HR UserID';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(311; "Confirmation Nos."; Code[20])
        {
            Caption = 'Confirmation Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(312; "Seperation Nos."; Code[20])
        {
            Caption = 'Seperation Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(313; "Next No."; Code[20])
        {
            Caption = 'Next No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(314; "Archive Att. Storage Location"; Text[250])
        {
            Caption = 'Archive Att. Storage Location';
            DataClassification = CustomerContent;
        }
        field(315; "Attendance Automation UserID"; Code[10])
        {
            Caption = 'Attendance Automation UserID';
            TableRelation = user."User Name";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(316; "Prob Id"; Code[20])
        {
            Caption = 'Prob Id';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(317; "Confirmation ID"; Code[20])
        {
            Caption = 'Confirmation ID';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(318; "Employer National Pension %"; Decimal)
        {
            Caption = 'Employer National Pension %';
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(319; Database; Option)
        {
            Caption = 'Database';
            OptionCaption = 'W1,IND';
            OptionMembers = W1,IND;
            DataClassification = CustomerContent;
        }
        field(320; "Travel Requisition Nos."; Code[20])
        {
            Caption = 'Travel Requisition Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(321; "Travel Expenses Nos."; Code[20])
        {
            Caption = 'Travel Expenses Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(355; "Resource Nos."; code[20])
        {
            Caption = 'Resource Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(365; "Notice Period"; DateFormula)
        {
            Caption = '"Notice Period"';
            DataClassification = CustomerContent;

        }
        //TDSOP2 >>
        field(366; "Opt 2 Educational Cess"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        //TDSOP2 <<
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ITChapterCheck: Record "IT Chapters B2B";
        Text001Lbl: Label 'U/S 10 & 17';
        Text002Lbl: Label 'OI';
        Text003Lbl: Label 'VI';
        Text004Lbl: Label 'VI-A';
        Text005Lbl: Label 'U/S 16';
        Text006Lbl: Label '10 (13A)';
        Text007Lbl: Label 'HRA Exemption';
        Text008Lbl: Label 'AOD';
        Text009Lbl: Label 'Any Other Deductions';
        Text010Lbl: Label 'H/P - P&L';
        Text011Lbl: Label 'House Property income or Loss';
        Text012Lbl: Label 'INT ON HBL';
        Text013Lbl: Label 'Interest on House Building Loan';
        //Text014Lbl: Label 'Other Income (Interest etc.,)';
        Text015Lbl: Label 'SEC 10 (10)';
        Text016Lbl: Label 'Gratuity and Other Expemtion';
        Text017Lbl: Label 'SEC 10 (14)';
        Text018Lbl: Label 'Transport/CEA/Uniform Allowance';
        Text019Lbl: Label 'SEC 17 (2)';
        Text020Lbl: Label 'Medical Bills Exepmtion';
        Text021Lbl: Label 'SEC 17 (5)';
        Text022Lbl: Label 'LTA Exemption';
        Text023Lbl: Label 'SEC 80 C';
        Text024Lbl: Label 'Pension/NSC/PPF/EPF&VPF/CEA/HLPR/IP&others';
        Text025Lbl: Label 'SEC 80 CCF';
        Text026Lbl: Label 'Long-Term Infrastructure Bonds';
        Text027Lbl: Label 'SEC 80CCD';
        Text028Lbl: Label 'National Pension Scheem';
        Text029Lbl: Label 'SEC 80CCD(1)';
        Text030Lbl: Label 'Employer National Pension Scheme';
        Text031Lbl: Label 'SD U/S 16';
        Text032Lbl: Label 'Standard deduction U/S 16';
        Text033Lbl: Label 'SEC 80D';
        Text034Lbl: Label 'Medical Insureance - Individual / Parents';
        Text035Lbl: Label 'SEC 80DD';
        Text036Lbl: Label 'Medical for Handicapped Dependents';
        Text037Lbl: Label 'SEC 80DDB';
        Text038Lbl: Label 'Medical for Special diseases';
        Text039Lbl: Label 'SEC 80E';
        Text040Lbl: Label 'Higher Education Loan Interest Repayment';
        Text041Lbl: Label 'SEC 80G';
        Text042Lbl: Label 'Donation to approved fund and Charities';
        Text043Lbl: Label 'SEC 80GG';
        Text044Lbl: Label 'Rent Deduction only if HRA not received';
        Text045Lbl: Label 'SEC 80U';
        Text046Lbl: Label 'Deduction for Parmanent Disability';
        Text047Lbl: Label 'SEC 80 CCG';
        Text048Lbl: Label 'Rajiv Gandhi Equity Savings Scheme';
        Text049Lbl: Label '87 (A)';
        Text050Lbl: Label 'Rebate';
        Text053Lbl: Label 'CEA EXEMPTION';
        Text055Lbl: Label 'CEA FEES';
        Text057Lbl: Label 'DFAF&C';
        Text059Lbl: Label 'DFPD';
        Text061Lbl: Label 'EPF & VPF';
        Text062Lbl: Label 'PF';

        Text063Lbl: Label 'H/P - P&L';
        Text064Lbl: Label 'HELIR';
        Text066Lbl: Label 'HLPR';
        Text069Lbl: Label '10 (13A)';
        //Text070Lbl: Label 'INT ON HBL';
        Text071Lbl: Label 'IP & OTHERS';
        Text074Lbl: Label 'LTIB';
        Text076Lbl: Label 'M FOR SD';
        Text078Lbl: Label 'MEDICAL BILL EXEMP';
        Text079Lbl: Label 'MEDICAL FOR HC D';
        Text081Lbl: Label 'MIP - PARENTS';
        Text083Lbl: Label 'MIP - SELF';
        Text084Lbl: Label 'NSC';
        Text087Lbl: Label 'OTHER EXPEMTION';
        Text089Lbl: Label 'PENSION SCHEME';
        Text091Lbl: Label 'PPF';
        Text092Lbl: Label 'RD-HRA NOT RECEIVED';
        Text093Lbl: Label 'SEC 80GG';
        Text094Lbl: Label 'TRANSPORT EXEMP';
        Text096Lbl: Label 'CA';
        Text097Lbl: Label 'UNIFORM EXPENSES';
        Text098Lbl: Label 'NPS';
        Text100Lbl: Label 'National Pension Scheem';
        Text101Lbl: Label 'ENPS';
        Text102Lbl: Label 'SEC 80CCD(1)';
        Text103Lbl: Label 'Employer National Pension Scheme';
        Text104Lbl: Label 'EQUITY';
        Text106Lbl: Label 'Equity Shares';
        //Text111Lbl: Label 'Any Other Deductions';
        Text113Lbl: Label 'House Property income or Loss';
        Text116Lbl: Label 'Interest on House Building Loan';
        Text118Lbl: Label 'Other Income (Interest etc.,)';
        Text123Lbl: Label 'Transport/CEA/Uniform Allowance';
        //Text125Lbl: Label 'SEC 17 (2)';
        Text126Lbl: Label 'Medical Bills Exepmtion';
        Text134Lbl: Label 'Long-Term Infrastructure Bonds';
        Text137Lbl: Label 'Medical Insureance - Individual / Parents';
        Text139Lbl: Label 'Medical for Handicapped Dependents';
        //Text141Lbl: Label 'Medical for Special diseases';
        Text147Lbl: Label 'Donation to approved fund and Charities';
        //Text163Lbl: Label 'CEA FEES';
        //Text188Lbl: Label 'MEDICAL BILL EXEMP';
        Text198Lbl: Label 'RD-HRA NOT RECEIVED';
    //Text201Lbl: Label 'SEC 10 (14)';

    procedure TDSSetups();
    var
        ITChapters: Record "IT Chapters B2B";
        ExcemptionSections: Record "Excemption Sections B2B";
        ExepDedGroups: Record "Exep/Ded Groups B2B";
        Window: Dialog;
        Text014Lbl: Label 'Creating TDS Setups          @1@@@@@@@@@@@@@@@@@';
        ERRText001Lbl: Label 'Records Already Exists';
    begin
        ITChapterCheck.RESET();
        ITChapterCheck.SETRANGE("Chapter ID", Text001lbl);
        if ITChapterCheck.FINDFIRST() then
            ERROR(ERRText001Lbl);
        Window.OPEN(Text014Lbl);
        Window.UPDATE(1, 100);
        SLEEP(10);

        ITChapters.RESET();
        if not ITChapters.FINDFIRST() then begin
            ITChapters.INIT();
            ITChapters."Chapter ID" := Text002Lbl;
            ITChapters."Maximum Limit" := 0;
            ITChapters.INSERT();

            ITChapters.INIT();
            ITChapters."Chapter ID" := Text001lbl;
            ITChapters."Maximum Limit" := 0;
            ITChapters.INSERT();

            ITChapters.INIT();
            ITChapters."Chapter ID" := Text003Lbl;
            ITChapters."Maximum Limit" := 150000;
            ITChapters.INSERT();

            ITChapters.INIT();
            ITChapters."Chapter ID" := Text004Lbl;
            ITChapters."Maximum Limit" := 0;
            ITChapters.INSERT();

            ITChapters.INIT();
            ITChapters."Chapter ID" := Text005Lbl;
            ITChapters."Maximum Limit" := 40000;
            ITChapters."Standard Deduction" := true;
            ITChapters.INSERT();
        end;

        Window.UPDATE(1, 1000);
        SLEEP(10);

        ExcemptionSections.RESET();
        if not ExcemptionSections.FINDFIRST() then begin
            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text006Lbl;
            ExcemptionSections.Description := Text007Lbl;
            ExcemptionSections."Chapter ID" := Text001lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text008Lbl;
            ExcemptionSections.Description := Text009Lbl;
            ExcemptionSections."Chapter ID" := Text002Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text010Lbl;
            ExcemptionSections.Description := Text011Lbl;
            ExcemptionSections."Chapter ID" := Text002Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text012Lbl;
            ExcemptionSections.Description := Text013Lbl;
            ExcemptionSections."Chapter ID" := Text002Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text002Lbl;
            ExcemptionSections.Description := Text014Lbl;
            ExcemptionSections."Chapter ID" := Text002Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text015Lbl;
            ExcemptionSections.Description := Text016Lbl;
            ExcemptionSections."Chapter ID" := Text001lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text017Lbl;
            ExcemptionSections.Description := Text018Lbl;
            ExcemptionSections."Chapter ID" := Text001lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text019Lbl;
            ExcemptionSections.Description := Text020Lbl;
            ExcemptionSections."Chapter ID" := Text001lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text021Lbl;
            ExcemptionSections.Description := Text022Lbl;
            ExcemptionSections."Chapter ID" := Text001lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text023Lbl;
            ExcemptionSections.Description := Text024Lbl;
            ExcemptionSections."Chapter ID" := Text003Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text025Lbl;
            ExcemptionSections.Description := Text026Lbl;
            ExcemptionSections."Chapter ID" := Text003Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text027Lbl;
            ExcemptionSections.Description := Text028Lbl;
            ExcemptionSections."Chapter ID" := Text003Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text029Lbl;
            ExcemptionSections.Description := Text030Lbl;
            ExcemptionSections."Chapter ID" := Text003Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text031Lbl;
            ExcemptionSections.Description := Text032Lbl;
            ExcemptionSections."Chapter ID" := Text005Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text033Lbl;
            ExcemptionSections.Description := Text034Lbl;
            ExcemptionSections."Chapter ID" := Text004Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text035Lbl;
            ExcemptionSections.Description := Text036Lbl;
            ExcemptionSections."Chapter ID" := Text004Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text037Lbl;
            ExcemptionSections.Description := Text038Lbl;
            ExcemptionSections."Chapter ID" := Text004Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text039Lbl;
            ExcemptionSections.Description := Text040Lbl;
            ExcemptionSections."Chapter ID" := Text004Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text041Lbl;
            ExcemptionSections.Description := Text042Lbl;
            ExcemptionSections."Chapter ID" := Text004Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text043Lbl;
            ExcemptionSections.Description := Text044Lbl;
            ExcemptionSections."Chapter ID" := Text004Lbl;
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text045Lbl;
            ExcemptionSections.Description := Text046Lbl;
            ExcemptionSections."Chapter ID" := Text004Lbl;
            ExcemptionSections.INSERT();
            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text047Lbl;
            ExcemptionSections.Description := Text048Lbl;
            ExcemptionSections."Chapter ID" := '';
            ExcemptionSections.INSERT();

            ExcemptionSections.INIT();
            ExcemptionSections."Section ID" := Text049Lbl;
            ExcemptionSections.Description := Text050Lbl;
            ExcemptionSections."Chapter ID" := '';
            ExcemptionSections.INSERT();
        end;

        Window.UPDATE(1, 2000);
        SLEEP(10);

        ExepDedGroups.RESET();
        if not ExepDedGroups.FINDFIRST() then begin
            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text008Lbl;
            ExepDedGroups."Section ID" := Text008Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text053Lbl;
            ExepDedGroups."Section ID" := Text017Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text055Lbl;
            ExepDedGroups."Section ID" := Text023Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text057Lbl;
            ExepDedGroups."Section ID" := Text041Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text059Lbl;
            ExepDedGroups."Section ID" := Text045Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text061Lbl;
            ExepDedGroups."Section ID" := Text023Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := Text062Lbl;
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text063Lbl;
            ExepDedGroups."Section ID" := Text063Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text064Lbl;
            ExepDedGroups."Section ID" := Text039Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text066Lbl;
            ExepDedGroups."Section ID" := Text023Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text007Lbl;
            ExepDedGroups."Section ID" := Text069Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text012Lbl;
            ExepDedGroups."Section ID" := Text012Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text071Lbl;
            ExepDedGroups."Section ID" := Text023Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text022Lbl;
            ExepDedGroups."Section ID" := Text021Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text074Lbl;
            ExepDedGroups."Section ID" := Text025Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text076Lbl;
            ExepDedGroups."Section ID" := Text037Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text078Lbl;
            ExepDedGroups."Section ID" := Text019Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text079Lbl;
            ExepDedGroups."Section ID" := Text035Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text081Lbl;
            ExepDedGroups."Section ID" := Text033Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text083Lbl;
            ExepDedGroups."Section ID" := Text033Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text084Lbl;
            ExepDedGroups."Section ID" := Text023Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text002Lbl;
            ExepDedGroups."Section ID" := Text002Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text087Lbl;
            ExepDedGroups."Section ID" := Text015Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text089Lbl;
            ExepDedGroups."Section ID" := Text023Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text091Lbl;
            ExepDedGroups."Section ID" := Text023Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text092Lbl;
            ExepDedGroups."Section ID" := Text093Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text094Lbl;
            ExepDedGroups."Section ID" := Text017Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := Text096Lbl;
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text097Lbl;
            ExepDedGroups."Section ID" := Text017Lbl;
            ExepDedGroups.Description := '';
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text098Lbl;
            ExepDedGroups."Section ID" := Text027Lbl;
            ExepDedGroups.Description := Text100Lbl;
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text101Lbl;
            ExepDedGroups."Section ID" := Text102Lbl;
            ExepDedGroups.Description := Text103Lbl;
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();

            ExepDedGroups.INIT();
            ExepDedGroups."Exemp / Ded Group Id" := Text104Lbl;
            ExepDedGroups."Section ID" := Text047Lbl;
            ExepDedGroups.Description := Text106Lbl;
            ExepDedGroups."Pay Element Code" := '';
            ExepDedGroups.INSERT();
        end;

        RecheckTDSSetups();
        Window.UPDATE(1, 5000);
        SLEEP(10);
    end;

    procedure RecheckTDSSetups();
    var
        ITChapters: Record "IT Chapters B2B";
        ExcemptionSections: Record "Excemption Sections B2B";
        ExepDedGroups: Record "Exep/Ded Groups B2B";
    begin
        ITChapters.INIT();
        ITChapters."Chapter ID" := Text002Lbl;
        ITChapters."Maximum Limit" := 0;
        if not ITChapterExists(Text002Lbl) then
            ITChapters.INSERT();

        ITChapters.INIT();
        ITChapters."Chapter ID" := Text001lbl;
        ITChapters."Maximum Limit" := 0;
        if not ITChapterExists(Text001lbl) then
            ITChapters.INSERT();

        ITChapters.INIT();
        ITChapters."Chapter ID" := Text003Lbl;
        ITChapters."Maximum Limit" := 150000;
        if not ITChapterExists(Text003Lbl) then
            ITChapters.INSERT();

        ITChapters.INIT();
        ITChapters."Chapter ID" := Text004Lbl;
        ITChapters."Maximum Limit" := 0;
        if not ITChapterExists(Text004Lbl) then
            ITChapters.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text006Lbl;
        ExcemptionSections.Description := Text007Lbl;
        ExcemptionSections."Chapter ID" := Text001lbl;
        if not ExcemptionSectionsExists(Text006Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text008Lbl;
        ExcemptionSections.Description := Text009Lbl;
        ExcemptionSections."Chapter ID" := Text002Lbl;
        if not ExcemptionSectionsExists(Text008Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text010Lbl;
        ExcemptionSections.Description := Text113Lbl;
        ExcemptionSections."Chapter ID" := Text002Lbl;
        if not ExcemptionSectionsExists(Text010Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text012Lbl;
        ExcemptionSections.Description := Text116Lbl;
        ExcemptionSections."Chapter ID" := Text002Lbl;
        if not ExcemptionSectionsExists(Text012Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text002Lbl;
        ExcemptionSections.Description := Text118Lbl;
        ExcemptionSections."Chapter ID" := Text002Lbl;
        if not ExcemptionSectionsExists(Text002Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text015Lbl;
        ExcemptionSections.Description := Text016Lbl;
        ExcemptionSections."Chapter ID" := Text001lbl;
        if not ExcemptionSectionsExists(Text015Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text017Lbl;
        ExcemptionSections.Description := Text123Lbl;
        ExcemptionSections."Chapter ID" := Text001lbl;
        if not ExcemptionSectionsExists(Text017Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text019Lbl;
        ExcemptionSections.Description := Text126Lbl;
        ExcemptionSections."Chapter ID" := Text001lbl;
        if not ExcemptionSectionsExists(Text019Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text021Lbl;
        ExcemptionSections.Description := Text022Lbl;
        ExcemptionSections."Chapter ID" := Text001lbl;
        if not ExcemptionSectionsExists(Text021Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text023Lbl;
        ExcemptionSections.Description := Text024Lbl;
        ExcemptionSections."Chapter ID" := Text003Lbl;
        if not ExcemptionSectionsExists(Text023Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text025Lbl;
        ExcemptionSections.Description := Text134Lbl;
        ExcemptionSections."Chapter ID" := Text003Lbl;
        if not ExcemptionSectionsExists(Text025Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text033Lbl;
        ExcemptionSections.Description := Text137Lbl;
        ExcemptionSections."Chapter ID" := Text004Lbl;
        if not ExcemptionSectionsExists(Text033Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text035Lbl;
        ExcemptionSections.Description := Text139Lbl;
        ExcemptionSections."Chapter ID" := Text004Lbl;
        if not ExcemptionSectionsExists(Text035Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text037Lbl;
        ExcemptionSections.Description := Text038Lbl;
        ExcemptionSections."Chapter ID" := Text004Lbl;
        if not ExcemptionSectionsExists(Text037Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text039Lbl;
        ExcemptionSections.Description := Text040Lbl;
        ExcemptionSections."Chapter ID" := Text004Lbl;
        if not ExcemptionSectionsExists(Text039Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text041Lbl;
        ExcemptionSections.Description := Text147Lbl;
        ExcemptionSections."Chapter ID" := Text004Lbl;
        if not ExcemptionSectionsExists(Text041Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text043Lbl;
        ExcemptionSections.Description := Text044Lbl;
        ExcemptionSections."Chapter ID" := Text004Lbl;
        if not ExcemptionSectionsExists(Text043Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text045Lbl;
        ExcemptionSections.Description := Text046Lbl;
        ExcemptionSections."Chapter ID" := Text004Lbl;
        if not ExcemptionSectionsExists(Text045Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text047Lbl;
        ExcemptionSections.Description := Text048Lbl;
        ExcemptionSections."Chapter ID" := '';
        if not ExcemptionSectionsExists(Text047Lbl) then
            ExcemptionSections.INSERT();

        ExcemptionSections.INIT();
        ExcemptionSections."Section ID" := Text049Lbl;
        ExcemptionSections.Description := Text050Lbl;
        ExcemptionSections."Chapter ID" := '';
        if not ExcemptionSectionsExists(Text049Lbl) then
            ExcemptionSections.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text008Lbl;
        ExepDedGroups."Section ID" := Text008Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text008Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text053Lbl;
        ExepDedGroups."Section ID" := Text017Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text053Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text055Lbl;
        ExepDedGroups."Section ID" := Text023Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text055Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text057Lbl;
        ExepDedGroups."Section ID" := Text041Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text057Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text059Lbl;
        ExepDedGroups."Section ID" := Text045Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text059Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text061Lbl;
        ExepDedGroups."Section ID" := Text023Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := Text062Lbl;
        if not ExepDedGroupsExists(Text061Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text010Lbl;
        ExepDedGroups."Section ID" := Text010Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text010Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text064Lbl;
        ExepDedGroups."Section ID" := Text039Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text064Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text066Lbl;
        ExepDedGroups."Section ID" := Text023Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text066Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text007Lbl;
        ExepDedGroups."Section ID" := Text069Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text007Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text012Lbl;
        ExepDedGroups."Section ID" := Text012Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text012Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text071Lbl;
        ExepDedGroups."Section ID" := Text023Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text071Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text022Lbl;
        ExepDedGroups."Section ID" := Text021Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text022Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text074Lbl;
        ExepDedGroups."Section ID" := Text025Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text074Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text076Lbl;
        ExepDedGroups."Section ID" := Text037Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text076Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text078Lbl;
        ExepDedGroups."Section ID" := Text019Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text078Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text079Lbl;
        ExepDedGroups."Section ID" := Text035Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text079Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text081Lbl;
        ExepDedGroups."Section ID" := Text033Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text081Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text083Lbl;
        ExepDedGroups."Section ID" := Text033Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text083Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text084Lbl;
        ExepDedGroups."Section ID" := Text023Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text084Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text002Lbl;
        ExepDedGroups."Section ID" := Text002Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text002Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text087Lbl;
        ExepDedGroups."Section ID" := Text015Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text087Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text089Lbl;
        ExepDedGroups."Section ID" := Text023Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text089Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text091Lbl;
        ExepDedGroups."Section ID" := Text023Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text091Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text198Lbl;
        ExepDedGroups."Section ID" := Text043Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text198Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text094Lbl;
        ExepDedGroups."Section ID" := Text017Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := Text096Lbl;
        if not ExepDedGroupsExists(Text094Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text097Lbl;
        ExepDedGroups."Section ID" := Text017Lbl;
        ExepDedGroups.Description := '';
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text097Lbl) then
            ExepDedGroups.INSERT();

        ExepDedGroups.INIT();
        ExepDedGroups."Exemp / Ded Group Id" := Text104Lbl;
        ExepDedGroups."Section ID" := Text047Lbl;
        ExepDedGroups.Description := Text106Lbl;
        ExepDedGroups."Pay Element Code" := '';
        if not ExepDedGroupsExists(Text104Lbl) then
            ExepDedGroups.INSERT();
    end;

    procedure ITChapterExists(ChaptID: Code[20]): Boolean;
    var
        ITChapters: Record "IT Chapters B2B";
    begin
        if ITChapters.GET(ChaptID) then
            exit(true)
        else
            exit(false);
    end;

    procedure ExcemptionSectionsExists(SecID: Code[20]): Boolean;
    var
        ExcemptionSections: Record "Excemption Sections B2B";
    begin
        if ExcemptionSections.GET(SecID) then
            exit(true)
        else
            exit(false);
    end;

    procedure ExepDedGroupsExists(ExDedGrpID: Code[20]): Boolean;
    var
        ExepDedGroups: Record "Exep/Ded Groups B2B";
    begin
        if ExepDedGroups.GET(ExDedGrpID) then
            exit(true)
        else
            exit(false);
    end;

    procedure CompOffLapse()
    var
        LeaveMaster: Record "Leave Master B2B";
        DetailedLeaveRecord: Record "Detailed Leave Records B2B";
        HrSetup: Record "HR Setup B2B";
        EmpoyeeB2B: Record "Employee B2B";
        LastDetailedLeaveRecord: Record "Detailed Leave Records B2B";
        InitDetailedLeaveRecord: Record "Detailed Leave Records B2B";
        EmployeeLeaves: Record "Employee Leaves B2B";
        EmptyDF: DateFormula;
        LapsePeriod: Text;
    begin
        HrSetup.Get();
        LeaveMaster.Reset();
        LeaveMaster.SetRange("Leave Code", HrSetup."Compensatory Leave Code");
        if LeaveMaster.FindFirst() then
            if LeaveMaster."Lapse Period" <> EmptyDF then
                LapsePeriod := '-' + Format(LeaveMaster."Lapse Period");

        if LapsePeriod <> '' then begin
            EmpoyeeB2B.Reset();
            EmpoyeeB2B.SetRange(Blocked, false);
            if EmpoyeeB2B.FindSet() then
                repeat
                    DetailedLeaveRecord.Reset();
                    DetailedLeaveRecord.SetRange("Employee No.", EmpoyeeB2B."No.");
                    DetailedLeaveRecord.SetRange("Leave Code", LeaveMaster."Leave Code");
                    DetailedLeaveRecord.SetFilter("Entry Date", '<=%1', CalcDate(LapsePeriod, DMY2Date(1, "Salary Processing month", "Salary Processing Year")));
                    DetailedLeaveRecord.SetRange(Lapse, false);
                    if DetailedLeaveRecord.FindSet() then begin
                        EmployeeLeaves.Reset();
                        EmployeeLeaves.SetRange("No.", EmpoyeeB2B."No.");
                        EmployeeLeaves.SetRange("Leave Code", HrSetup."Compensatory Leave Code");
                        if EmployeeLeaves.FindLast() then;
                        DetailedLeaveRecord.CalcSums("No. of Leaves");
                        if DetailedLeaveRecord."No. of Leaves" > 0 then begin
                            LastDetailedLeaveRecord.Reset();
                            if LastDetailedLeaveRecord.FindLast() then;
                            InitDetailedLeaveRecord.Init();
                            InitDetailedLeaveRecord."Entry No." := LastDetailedLeaveRecord."Entry No." + 1;
                            InitDetailedLeaveRecord."Employee No." := EmpoyeeB2B."No.";
                            InitDetailedLeaveRecord."Entry Date" := DMY2Date(1, "Salary Processing month", "Salary Processing Year");
                            InitDetailedLeaveRecord.VALIDATE("Leave Code", HrSetup."Compensatory Leave Code");
                            LeaveMaster.Get(HrSetup."Compensatory Leave Code", EmpoyeeB2B."Location Code");
                            InitDetailedLeaveRecord."Leave Description" := LeaveMaster.Description;
                            EmpoyeeB2B.Get(InitDetailedLeaveRecord."Employee No.");
                            InitDetailedLeaveRecord."Leave Pay Cadre" := EmployeeLeaves."Leave Pay Cadre";
                            InitDetailedLeaveRecord."Entry Type" := InitDetailedLeaveRecord."Entry Type"::Lapse;
                            InitDetailedLeaveRecord."Posting Date" := WORKDATE();

                            InitDetailedLeaveRecord."No. of Leaves" += -DetailedLeaveRecord."No. of Leaves";
                            InitDetailedLeaveRecord.Month := DATE2DMY(InitDetailedLeaveRecord."Entry Date", 2);
                            InitDetailedLeaveRecord.Year := DATE2DMY(InitDetailedLeaveRecord."Entry Date", 3);
                            InitDetailedLeaveRecord.Insert(true);
                            DetailedLeaveRecord.ModifyAll(Lapse, true, true);

                        end;
                    end;
                until EmpoyeeB2B.Next() = 0;

        end;
    end;
}

