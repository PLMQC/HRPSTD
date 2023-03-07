table 33001193 "Employee B2B"
{
    // version B2BHR1.00.00

    Caption = '"Employee B2B";';
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name";
    DrillDownPageID = "Employee List B2B";
    LookupPageID = "Employee List B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "First Name"; Text[30])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if ("Search Name" = UPPERCASE(xRec."First Name")) or ("Search Name" = '') then
                    "Search Name" := "First Name";
            end;
        }
        field(3; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }
        field(5; Initials; Text[30])
        {
            Caption = 'Initials';
            DataClassification = CustomerContent;
        }
        field(6; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
            DataClassification = CustomerContent;
        }
        field(7; "Search Name"; Code[30])
        {
            Caption = 'Search Name';
            DataClassification = CustomerContent;
        }
        field(8; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(9; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Postcode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GUIALLOWED());
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            DataClassification = CustomerContent;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Postcode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GUIALLOWED());
            end;
        }
        field(12; Country; Text[30])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            DataClassification = CustomerContent;
        }
        field(15; "E-Mail"; Text[50])
        {
            Caption = 'E-Mail';
            DataClassification = CustomerContent;
        }
        field(16; County; Text[30])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
        }
        field(18; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(19; Picture; MediaSet)
        {
            Caption = 'Picture';
            DataClassification = CustomerContent;
        }
        field(20; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
            DataClassification = CustomerContent;
        }
        field(21; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
            DataClassification = CustomerContent;
        }
        field(24; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
            DataClassification = CustomerContent;
        }
        field(25; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(26; "Manager No."; Code[20])
        {
            Caption = 'Manager No.';
            TableRelation = Employee;
            DataClassification = CustomerContent;
        }
        field(29; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
            DataClassification = CustomerContent;
        }
        field(31; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
            DataClassification = CustomerContent;
        }
        field(32; "Inactive Date"; Date)
        {
            Caption = 'Inactive Date';
            DataClassification = CustomerContent;
        }
        field(33; "Cause of Inactivity Code"; Code[30])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('CAUSES OF INACTIVITY'));
            DataClassification = CustomerContent;
        }
        field(34; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
            DataClassification = CustomerContent;
        }
        field(35; "Grounds for Term. Code"; Code[30])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('GROUNDS OF TERMINATION'));
            DataClassification = CustomerContent;
        }
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(38; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource WHERE(Type = CONST(Person));
            DataClassification = CustomerContent;
        }
        field(39; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST(Employee),
                                                                     "No." = FIELD("No.")));

            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(41; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;

        }
        field(42; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(43; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(44; "Cause of Absence Filter"; Code[10])
        {
            Caption = 'Cause of Absence Filter';
            FieldClass = FlowFilter;
            TableRelation = "Cause of Absence";
        }
        field(46; Extension; Text[30])
        {
            Caption = 'Extension';
            DataClassification = CustomerContent;
        }
        field(47; "Employee No. Filter"; Code[20])
        {
            Caption = 'Employee No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;

        }
        field(48; Pager; Text[30])
        {
            Caption = 'Pager';
            DataClassification = CustomerContent;
        }
        field(49; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = CustomerContent;
        }
        field(50; "Company E-Mail"; Text[80])
        {
            Caption = 'Company E-Mail';
            DataClassification = CustomerContent;
        }
        field(51; Title; Text[30])
        {
            Caption = 'Title';
            DataClassification = CustomerContent;
        }
        field(52; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = CustomerContent;
        }
        field(53; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(56; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
            DataClassification = CustomerContent;
        }
        field(57; Designation; Code[50])
        {
            Caption = 'Designation';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DESIGNATIONS'));
            DataClassification = CustomerContent;
        }
        field(58; "Martial status"; Option)
        {
            Caption = 'Martial status';
            OptionCaption = 'Married,Single';
            OptionMembers = Married,Single;
            DataClassification = CustomerContent;
        }
        field(59; "Spouse Name"; Code[50])
        {
            Caption = 'Spouse Name';
            DataClassification = CustomerContent;
        }
        field(60; "Marraige Date"; Date)
        {
            Caption = 'Marraige Date';
            DataClassification = CustomerContent;
        }
        field(61; "No. Of Children"; Integer)
        {
            Caption = 'No. Of Children';
            DataClassification = CustomerContent;
        }
        field(62; "Driving License No."; Code[20])
        {
            Caption = 'Driving License No.';
            DataClassification = CustomerContent;
        }
        field(63; "PAN No"; Code[20])
        {
            Caption = 'PAN No';
            DataClassification = CustomerContent;
        }
        field(64; "ESI No"; Text[20])
        {
            Caption = 'ESI No';
            DataClassification = CustomerContent;
        }
        field(65; "ESI Dispensary"; Text[50])
        {
            Caption = 'ESI Dispensary';
            DataClassification = CustomerContent;
        }
        field(66; "Father/Husband"; Text[50])
        {
            Caption = 'Father/Husband';
            DataClassification = CustomerContent;
        }
        field(67; "PF No"; Text[20])
        {
            Caption = 'PF No';
            DataClassification = CustomerContent;
        }
        field(68; "Blood Group"; Option)
        {
            Caption = 'Blood Group';
            OptionCaption = ' ,A+,A-,B+,B-,AB+,AB-,O+,O-';
            OptionMembers = " ","A+","A-","B+","B-","AB+","AB-","O+","O-";
            DataClassification = CustomerContent;
        }
        field(69; "Payment Method"; Option)
        {
            Caption = 'Payment Method';
            OptionCaption = 'Cash,Cheque,Bank Transfer';
            OptionMembers = Cash,Cheque,"Bank Transfer";
            DataClassification = CustomerContent;
        }
        field(70; "Bank Code"; Code[10])
        {
            Caption = 'Bank Code';
            DataClassification = CustomerContent;
        }
        field(72; "Bank Name"; Text[20])
        {
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
        field(73; "Bank Branch"; Text[20])
        {
            Caption = 'Bank Branch';
            DataClassification = CustomerContent;
        }
        field(74; "Account Type"; Text[30])
        {
            Caption = 'Account Type';
            DataClassification = CustomerContent;
        }
        field(75; "Account No"; Code[20])
        {
            Caption = 'Account No';
            DataClassification = CustomerContent;
        }
        field(76; "Resignation Date"; Date)
        {
            Caption = 'Resignation Date';
            DataClassification = CustomerContent;
        }
        field(77; "Confirmation Date"; Date)
        {
            Caption = 'Confirmation Date';
            DataClassification = CustomerContent;
        }
        field(79; Passport; Code[20])
        {
            Caption = 'Passport';
            DataClassification = CustomerContent;
        }
        field(80; Experience; Integer)
        {
            Caption = 'Experience';
            DataClassification = CustomerContent;
        }
        field(81; "Release Status"; Option)
        {
            Caption = 'Release Status';
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
        }
        field(82; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Blocked Date" := WORKDATE();
                MonthlyAttendance.RESET();
                MonthlyAttendance.SETRANGE("Employee Code", "No.");
                if MonthlyAttendance.FINDFIRST() then
                    repeat
                        if (MonthlyAttendance.Year > DATE2DMY("Blocked Date", 3)) or
                           ((MonthlyAttendance.Year = DATE2DMY("Blocked Date", 3)) and
                           (MonthlyAttendance."Pay Slip Month" >= DATE2DMY("Blocked Date", 2)))
                        then begin
                            MonthlyAttendance.Blocked := Blocked;
                            MonthlyAttendance.MODIFY();
                        end;
                    until MonthlyAttendance.NEXT() = 0;

                CLoseProvisionalLeaves.RESET();
                CLoseProvisionalLeaves.SETRANGE(CLoseProvisionalLeaves."Employee No.", "No.");
                if CLoseProvisionalLeaves.FINDFIRST() then
                    repeat
                        CLoseProvisionalLeaves.Status := CLoseProvisionalLeaves.Status::Closed;
                        CLoseProvisionalLeaves.MODIFY();
                    until CLoseProvisionalLeaves.NEXT() = 0;
            end;
        }
        field(83; Probation; Boolean)
        {
            Caption = 'Probation';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Probation = false then
                    ERROR(Text002Lbl);
                if "Probation End Date" <> 0D then
                    ERROR(Text003Lbl);
            end;
        }
        field(84; "Attendance Not Generated"; Boolean)
        {
            Caption = 'Attendance Not Generated';
            DataClassification = CustomerContent;
        }
        field(85; "OT Applicable"; Boolean)
        {
            Caption = 'OT Applicable';
            DataClassification = CustomerContent;
        }
        field(86; "OT Calculation Rate"; Decimal)
        {
            Caption = 'OT Calculation Rate';
            DecimalPlaces = 0 : 2;
            InitValue = 1;
            MinValue = 1;
            DataClassification = CustomerContent;
        }
        field(87; "Leaves Not Generated"; Boolean)
        {
            Caption = 'Leaves Not Generated';
            DataClassification = CustomerContent;
        }
        field(88; "ESI Applicable"; Boolean)
        {
            Caption = 'ESI Applicable';
            DataClassification = CustomerContent;
        }
        field(89; "PF Applicable"; Boolean)
        {
            Caption = 'PF Applicable';
            DataClassification = CustomerContent;
        }
        field(90; "PT Branch Code"; Code[20])
        {
            Caption = 'PT Branch Code';
            TableRelation = "Professional Tax Header B2B";
            DataClassification = CustomerContent;
        }
        field(91; Division; Option)
        {
            Caption = 'Division';
            OptionCaption = 'EOU,DTA';
            OptionMembers = EOU,DTA;
            DataClassification = CustomerContent;
        }
        field(92; "Trainee Number"; Code[20])
        {
            Caption = 'Trainee Number';
            DataClassification = CustomerContent;
        }
        field(95; "PF Applicability"; Option)
        {
            Caption = 'PF Applicability';
            OptionCaption = 'Statutory,Actual Salary';
            OptionMembers = Statutory,"Actual Salary","Employee Specific";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "PF Amount" := 0;
            end;
        }
        field(96; "PF Amount"; Decimal)
        {
            Caption = 'PF Amount';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                PF: Record PF_B2B;
            begin
                TESTFIELD("PF Applicability", "PF Applicability"::"Employee Specific");
                PF.FINDFIRST();
                if ("PF Amount" < (PF."PF Amount" * PF."Employee Contribution" / 100)) then
                    ERROR(Text004Lbl, ROUND(PF."PF Amount" * PF."Employee Contribution" / 100, 0.01));
            end;
        }
        field(100; Qualification; Code[20])
        {
            Caption = 'Qualification';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('QUALIFICATION'));
            DataClassification = CustomerContent;
        }
        field(101; "Emp Posting Group"; Code[20])
        {
            Caption = 'Emp Posting Group';
            TableRelation = "Employee Posting Group B2B".Code;
            DataClassification = CustomerContent;
        }
        field(102; "Payroll Bus. Posting Group"; Code[20])
        {
            Caption = 'Payroll Bus. Posting Group';
            TableRelation = "Payroll Bus. Post Group B2B".Code;
            DataClassification = CustomerContent;
        }
        field(103; "Pay Cadre"; Code[20])
        {
            Caption = 'Pay Cadre';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                PayCadrePayElement: Record "Pay Cadre Pay Element B2B";
                PayElement: Record "Pay Elements B2B";
                Text000Lbl: Label 'You cannot MODIFY() the pay cadre.';
            begin
                MonthlyAttendance.RESET();
                MonthlyAttendance.SETRANGE("Employee Code", "No.");
                MonthlyAttendance.SETRANGE(Posted, true);
                if MonthlyAttendance.FINDFIRST() then
                    ERROR(Text000Lbl);

                PayElement.SETRANGE("Employee Code", "No.");
                if PayElement.FINDFIRST() then
                    if CONFIRM(Text008Lbl) then
                        PayElement.DELETEALL();

                PayElement.SETRANGE("Employee Code", "No.");
                PayElement.SETRANGE("Pay Cadre", xRec."Pay Cadre");
                if PayElement.FINDFIRST() then
                    if CONFIRM(Text008Lbl) then
                        PayElement.DELETEALL();

                Lookup_B2B.SETRANGE("LookupType Name", PAYCADRELbl);
                Lookup_B2B.SETRANGE("Lookup Name", "Pay Cadre");
                if Lookup_B2B.FINDFIRST() then begin
                    Lookup_B2B.TESTFIELD("Period Start Date");
                    Lookup_B2B.TESTFIELD("Period Start Date");
                    "Period Start Date" := Lookup_B2B."Period Start Date";
                    "Period End Date" := Lookup_B2B."Period End Date";
                    Probation := Lookup_B2B.Probation;
                    Validate("Probation Period", Lookup_B2B."Probation Period");//B2BMMOn05Aug2022
                    MODIFY();
                end;

                GetPayCadrePayElements(Rec);
                PayCadrePayElement.RESET();
                if PayCadrePayElement.FINDFIRST() then
                    repeat
                        PayCadrePayElement.Processed := false;
                        PayCadrePayElement.MODIFY();
                    until PayCadrePayElement.NEXT() = 0;
            end;

        }
        field(104; "Period Start Date"; Date)
        {
            Caption = 'Period Start Date';
            DataClassification = CustomerContent;
        }
        field(105; "Period End Date"; Date)
        {
            Caption = 'Period End Date';
            DataClassification = CustomerContent;
        }
        field(106; "Balance Amt(LCY)"; Decimal)
        {
            CalcFormula = Sum("Monthly Attendance B2B"."Remaining Amount" WHERE("Employee Code" = FIELD("No."),
                                                                             Posted = CONST(true)));
            Caption = 'Balance Amt(LCY)';
            DecimalPlaces = 2 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(108; "PT Applicable"; Boolean)
        {
            Caption = 'PT Applicable';
            DataClassification = CustomerContent;
        }
        field(109; "Blocked Date"; Date)
        {
            Caption = 'Blocked Date';
            DataClassification = CustomerContent;
        }
        field(110; "Resume DB No."; Code[20])
        {
            Caption = 'Resume DB No.';
            DataClassification = CustomerContent;
        }
        field(111; "User Id"; Code[50])
        {
            Caption = 'User Id';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(116; "VDA Applicable"; Boolean)
        {
            Caption = 'VDA Applicable';
            DataClassification = CustomerContent;
        }
        field(117; "FDA Applicable"; Boolean)
        {
            Caption = 'FDA Applicable';
            DataClassification = CustomerContent;
        }
        field(118; "Stop Payment"; Boolean)
        {
            Caption = 'Stop Payment';
            DataClassification = CustomerContent;
        }
        field(119; "ESI Branch"; Text[30])
        {
            Caption = 'ESI Branch';
            DataClassification = CustomerContent;
        }
        field(121; "Required Shift"; Boolean)
        {
            Caption = 'Required Shift';
            DataClassification = CustomerContent;
        }
        field(128; "Bank/Cash Account"; Code[10])
        {
            Caption = 'Bank/Cash Account';
            TableRelation = IF ("Payment Method" = CONST(Cash)) "G/L Account"
            ELSE
            IF ("Payment Method" = CONST("Bank Transfer")) "Bank Account";
            DataClassification = CustomerContent;
        }
        field(131; "Present  Address"; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(132; "Present Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(133; "Present City"; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(134; "Present Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(135; "Present Country"; Text[30])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
        }
        field(136; "Present Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
        }
        field(137; "Present County"; Text[30])
        {
            Caption = 'Present County';
            DataClassification = CustomerContent;
        }
        field(138; "Mother Name"; Text[30])
        {
            Caption = 'Mother Name';
            DataClassification = CustomerContent;
        }
        field(142; "TDS Applicable"; Boolean)
        {
            Caption = 'TDS Applicable';
            DataClassification = CustomerContent;
        }
        field(150; "LTA Applicable"; Boolean)
        {
            Caption = 'LTA Applicable';
            DataClassification = CustomerContent;
        }
        field(151; "LTA  Rate"; Decimal)
        {
            Caption = 'LTA  Rate';
            DecimalPlaces = 0 : 2;
            InitValue = 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(160; "Work Group Code"; Code[20])
        {
            Caption = 'Work Group Code';
            TableRelation = "Training Calendar Schedule B2B";
            DataClassification = CustomerContent;
        }
        field(161; "Level Code"; Code[20])
        {
            Caption = 'Level Code';
            DataClassification = CustomerContent;
        }
        field(164; Section; Code[20])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
        }
        field(165; "Physical Location"; Code[20])
        {
            Caption = 'Physical Location';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(23));
            DataClassification = CustomerContent;
        }
        field(168; "Employee Status"; Code[20])
        {
            Caption = 'Employee Status';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(24));
            DataClassification = CustomerContent;
        }
        field(170; "Experience (Years)"; Integer)
        {
            Caption = 'Experience (Years)';
            DataClassification = CustomerContent;
        }
        field(171; "Experience (Months)"; Integer)
        {
            Caption = 'Experience (Months)';
            DataClassification = CustomerContent;
        }
        field(172; "OT Group"; Code[20])
        {
            Caption = 'OT Group';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(25));
            DataClassification = CustomerContent;
        }
        field(174; "Out Station All. Group"; Code[20])
        {
            Caption = 'Out Station All. Group';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(26));
            DataClassification = CustomerContent;
        }
        field(181; "Current Age (Years)"; Integer)
        {
            Caption = 'Current Age (Years)';
            DataClassification = CustomerContent;
        }
        field(182; "Current Age (Months)"; Integer)
        {
            Caption = 'Current Age (Months)';
            DataClassification = CustomerContent;
        }
        field(200; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(201; "Present FAX no."; Code[30])
        {
            Caption = 'Present FAX no.';
            DataClassification = CustomerContent;
        }
        field(202; "Present E-Mail"; Code[10])
        {
            Caption = 'Present E-Mail';
            DataClassification = CustomerContent;
        }
        field(203; "Present Mobile No."; Text[30])
        {
            Caption = 'Present Mobile No.';
            DataClassification = CustomerContent;
        }
        field(204; "Present Pager"; Text[30])
        {
            Caption = 'Present Pager';
            DataClassification = CustomerContent;
        }
        field(210; "Questionnaire Type"; Option)
        {
            Caption = 'Questionnaire Type';
            OptionCaption = ' ,Joining Formalities,Appraisals,Induction';
            OptionMembers = " ","Joining Formalities",Appraisals,Induction;
            DataClassification = CustomerContent;
        }
        field(215; "Exgratia %"; Decimal)
        {
            Caption = 'Exgratia %';
            DataClassification = CustomerContent;
        }
        field(216; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            Editable = true;
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(217; "IT Slab Type"; Option)
        {
            Caption = 'IT Slab Type';
            OptionCaption = 'Male,Female,Sr. Citizen,Option2';//TDSOP2
            OptionMembers = Male,Female,"Sr. Citizen",Option2;//TDSOP2
            DataClassification = CustomerContent;
        }
        field(220; IRP; Boolean)
        {
            Caption = 'IRP';
            DataClassification = CustomerContent;
        }
        field(221; "Reporting To"; Code[20])
        {
            Caption = 'Reporting To';
            TableRelation = "Employee B2B"
            WHERE(Blocked = CONST(false),
                                                Resigned = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." = "Reporting To" then
                    ERROR(Text005Lbl);

                B2BEmpGRec.RESET();
                if B2BEmpGRec.GET("Reporting To") then begin
                    if (B2BEmpGRec.Blocked = true or B2BEmpGRec.Resigned = true) then
                        ERROR(Text006Lbl);
                    "Reporting Name" := B2BEmpGRec."First Name"
                end else
                    "Reporting Name" := '';
            end;
        }
        field(222; "Reporting Name"; Text[30])
        {
            Caption = 'Reporting Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(223; "Experience Prior to Cur.Comp"; Integer)
        {
            Caption = 'Experience Prior to Cur.Comp';
            DataClassification = CustomerContent;
        }
        field(230; Resigned; Boolean)
        {
            Caption = 'Resigned';
            DataClassification = CustomerContent;
        }
        field(240; "Leave Pay Cadre"; Code[50])
        {
            Caption = 'Leave Pay Cadre';
            NotBlank = true;
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(22));
            DataClassification = CustomerContent;
        }
        field(251; "Sr. Citizen PF Applicability"; Boolean)
        {
            Caption = 'Sr. Citizen PF Applicability';
            DataClassification = CustomerContent;
        }
        field(260; "Last Appraisal Date"; Date)
        {
            Caption = 'Last Appraisal Date';
            DataClassification = CustomerContent;
        }
        field(262; "NEXT() Appraisal Date"; Date)
        {
            Caption = 'NEXT() Appraisal Date';
            DataClassification = CustomerContent;
        }
        field(264; Hieght; Decimal)
        {
            Caption = 'Hieght';
            DataClassification = CustomerContent;
        }
        field(266; Weight; Decimal)
        {
            Caption = 'Weight';
            DataClassification = CustomerContent;
        }
        field(268; "Probation Period"; DateFormula)
        {
            Caption = 'Probation Period';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //TESTFIELD(Probation);
                // if "Probation End Date" <> 0D then
                //      ERROR(Text007Lbl);
                if Probation then //B2BMMOnAug2022
                    "Probation End Date" := CALCDATE("Probation Period", "Employment Date");
            end;

        }
        field(270; "Ext. Probation Period"; DateFormula)
        {
            Caption = 'Ext. Probation Period';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(271; "Place of Birth"; Text[30])
        {
            Caption = 'Place of Birth';
            DataClassification = CustomerContent;
        }
        field(272; Nationality; Text[30])
        {
            Caption = 'Nationality';
            DataClassification = CustomerContent;
        }
        field(273; "Special Acheivements"; Text[250])
        {
            Caption = 'Special Acheivements';
            DataClassification = CustomerContent;
        }
        field(274; "Last Working Day"; Date)
        {
            Caption = 'Last Working Day';
            DataClassification = CustomerContent;
        }
        field(275; "Bank IFCS Code"; Code[11])
        {
            Caption = 'Bank IFCS Code';
            DataClassification = CustomerContent;
        }
        field(280; "Appointment Date"; Date)
        {
            Caption = 'Appointment Date';
            DataClassification = CustomerContent;
        }
        field(281; "Appointment Letter No."; Code[20])
        {
            Caption = 'Appointment Letter No.';
            DataClassification = CustomerContent;
        }
        field(282; "On Duty Description"; Text[30])
        {
            Caption = 'On Duty Description';
            DataClassification = CustomerContent;
        }
        field(290; "MSR Card Number"; Code[20])
        {
            Caption = 'MSR Card Number';
            DataClassification = CustomerContent;
        }
        field(291; "Hieght UOM"; Code[10])
        {
            Caption = 'Hieght UOM';
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(292; "Wieght UOM"; Code[10])
        {
            Caption = 'Wieght UOM';
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(293; "Probation End Date"; Date)
        {
            Caption = 'Probation End Date';
            DataClassification = CustomerContent;
        }
        field(294; Scale; Code[100])
        {
            Caption = 'Scale';
            DataClassification = CustomerContent;
        }
        field(295; "Passport Expire Date"; Date)
        {
            Caption = 'Passport Expire Date';
            DataClassification = CustomerContent;
        }
        field(296; "Retirement Date"; Date)
        {
            Caption = 'Retirement Date';
            DataClassification = CustomerContent;
        }
        field(297; "Job Description"; Code[10])
        {
            Caption = 'Job Description';
            DataClassification = CustomerContent;
            //TableRelation = "Emp. Previous IT Savings" WHERE ("Financial Year End Date" = FIELD ("Department Code"));//Phani
        }
        field(298; "Role Criticality"; Code[10])
        {
            Caption = 'Role Criticality';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PRIORITY'));
            DataClassification = CustomerContent;
        }
        field(299; "Releaved Date"; Date)
        {
            Caption = 'Releaved Date';
            DataClassification = CustomerContent;
        }
        field(300; Approver; Boolean)
        {
            Caption = 'Approver';
            DataClassification = CustomerContent;
        }
        field(301; "Apprisal Date"; Date)
        {
            Caption = 'Apprisal Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Apprisal Week No." := DATE2DWY("Apprisal Date", 2);
            end;
        }
        field(302; "Apprisal Week No."; Integer)
        {
            Caption = 'Apprisal Week No.';
            DataClassification = CustomerContent;
        }
        field(303; "Replacement For"; Code[20])
        {
            Caption = 'Replacement For';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(304; "NEXT() Appraisal Due Date"; Date)
        {
            Caption = 'NEXT() Appraisal Due Date';
            DataClassification = CustomerContent;
        }
        field(305; "Employee StatutoryPostingGroup"; Code[20])
        {
            Caption = 'Employee StatutoryPostingGroup';
            TableRelation = "Employer Stat. Post. Group B2B";
            DataClassification = CustomerContent;
        }
        field(306; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(307; "UAN No."; Code[20])
        {
            Caption = 'UAN No.';
            DataClassification = CustomerContent;
        }
        field(308; "Aadhar No."; Code[20])
        {
            Caption = 'Aadhar No.';
            DataClassification = CustomerContent;
        }
        field(309; "LWF Applicable"; Boolean)
        {
            Caption = 'LWF Applicable';
            DataClassification = CustomerContent;
        }
        field(310; "VPF Applicable"; Boolean)
        {
            Caption = 'VPF Applicable';
            DataClassification = CustomerContent;
        }
        field(311; "VPF %"; Decimal)
        {
            Caption = 'VPF %';
            DataClassification = CustomerContent;
        }
        field(312; "VPF Amount"; Decimal)
        {
            Caption = 'VPF Amount';
            DataClassification = CustomerContent;
        }
        field(313; "VPF Per/Amount"; Option)
        {
            Caption = 'VPF Per/Amount';
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
            DataClassification = CustomerContent;
        }
        field(314; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            TableRelation = Category_B2B;
            DataClassification = CustomerContent;
        }
        field(315; "Resume Reference No."; code[20])
        {
            caption = 'Resume Reference No.';
            DataClassification = CustomerContent;
        }
        field(319; "Auto Generate Appraisal doc"; Boolean)
        {
            Caption = 'Auto Generate Appraisal doc';
            DataClassification = CustomerContent;

        }
        field(320; "Period Type"; Option)
        {
            Caption = 'Apprisal Period Type';
            OptionCaption = 'Quarterly,Half Yearly,Yearly';
            OptionMembers = Quarterly,"Half Yearly",Yearly;
            DataClassification = CustomerContent;
        }
        field(375; "Notice Period Last Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(380; "No G/L Posting"; Boolean)
        {
            Caption = 'Outsourced Employee';
            DataClassification = CustomerContent;
        }
        field(381; "Next Appraisal Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        // CHB2B15SEP2022<<
        field(50001; "Exit ReasonCode For Pf"; code[30])
        {
            Editable = false;
            Caption = 'Exit ReasonCode For Pf';
            DataClassification = CustomerContent;
        }
        // CHB2B15SEP2022>>
        //CHB2BJAN52023<<
        field(50002; "Exit ReasonCode For ESI"; code[30])
        {
            Editable = false;
            caption = 'Exit ReasonCode For ESI';
            DataClassification = CustomerContent;
        }
        //CHB2BJAN52023>>

    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; Status)
        {
        }
        key(Key4; "Last Name", "First Name", "Middle Name")
        {
        }
        key(Key5; "Bank Name", "Payment Method")
        {
        }
        key(Key6; "Blood Group")
        {
        }
        key(Key7; "Location Code")
        {
        }
        key(Key8; Designation)
        {
        }
        key(Key9; "Department Code")
        {
        }
        key(Key10; "Birth Date")
        {
        }
        key(Key11; "Pay Cadre")
        {
        }
        key(Key12; "Physical Location")
        {
        }
        key(Key13; "First Name", "Middle Name", "Last Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "First Name", "Middle Name", "Last Name")
        {
        }
    }

    trigger OnDelete()
    var
        DailyAttendance: Record "Daily Attendance B2B";
        EmployeeShift: Record "Employee Shift B2B";
        PayElements: Record "Pay Elements B2B";
    begin
        MonthlyAttendance.RESET();
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Posted, true);
        if MonthlyAttendance.FINDFIRST() then
            ERROR(Text000Lbl, "No.");

        DailyAttendance.SETRANGE("Employee No.", "No.");
        if DailyAttendance.FINDFIRST() then
            DailyAttendance.DELETEALL();

        MonthlyAttendance.RESET();
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        if MonthlyAttendance.FINDFIRST() then
            MonthlyAttendance.DELETEALL();

        EmployeeShift.SETRANGE("Employee Code", "No.");
        if EmployeeShift.FINDFIRST() then
            EmployeeShift.DELETEALL();

        PayElements.SETRANGE("Employee Code", "No.");
        if PayElements.FINDFIRST() then
            PayElements.DELETEALL();

        EmpLeaves.SETRANGE("No.", "No.");
        if EmpLeaves.FINDFIRST() then
            EmpLeaves.DELETEALL();

        DetailedLeaves.SETRANGE("Employee No.", "No.");
        if DetailedLeaves.FINDFIRST() then
            DetailedLeaves.DELETEALL();

        ProvLeaves.SETRANGE("Employee No.", "No.");
        if ProvLeaves.FINDFIRST() then
            ProvLeaves.DELETEALL();

        LeaveApp.SETRANGE("Employee No.", "No.");
        if LeaveApp.FINDFIRST() then
            LeaveApp.DELETEALL(true);

        PostedLeaveApp.SETRANGE("Employee No.", "No.");
        if PostedLeaveApp.FINDFIRST() then
            PostedLeaveApp.DELETEALL(true);

        LeavePlan.SETRANGE("Employee No", "No.");
        if LeavePlan.FINDFIRST() then
            LeavePlan.DELETEALL();
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Employee Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Attendance Not Generated" := true;
        "Leaves Not Generated" := true;
        "ESI Applicable" := true;
        "PF Applicable" := true;
        "PT Applicable" := true;
        "Last Date Modified" := TODAY();
        "Location Code" := LocWiseMiscGCU.ReturnUserLocationCode();

        if "Location Code" = '' then
            ERROR(Text001Lbl, USERID());
    end;

    trigger OnMODIFY()
    begin
        "Last Date Modified" := TODAY();
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := TODAY();
    end;

    var
        Postcode: Record "Post Code";
        HRSetup: Record "HR Setup B2B";
        Employee: Record "Employee B2B";
        Lookup_B2B: Record Lookup_B2B;
        EmpLeaves: Record "Employee Leaves B2B";
        DetailedLeaves: Record "Detailed Leave Records B2B";
        ProvLeaves: Record "Provisional Leaves B2B";
        LeavePlan: Record "Leave Plan B2B";
        LeaveApp: Record "Leave Application Header B2B";
        MonthlyAttendance: Record "Monthly Attendance B2B";
        PostedLeaveApp: Record "Posted Leave App Header B2B";
        B2BEmpGRec: Record "Employee B2B";
        CLoseProvisionalLeaves: Record "Provisional Leaves B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit 396;
        Text000Lbl: Label 'You cannot delete Employee %1 because one or more General  ledger entries exist for this employee.', Comment = '%1 = No';
        Text001Lbl: Label 'No location code found for %1', Comment = '%1 = User Id';
        Text002Lbl: Label 'Confirmation need to be done from employee confirmation';
        Text003Lbl: Label 'Probation period already exists';
        Text004Lbl: Label 'PF Amount must not be less than Statutory limit %1', Comment = '%1 =P ';
        Text005Lbl: Label 'Report to cannot be of the same employee';
        Text006Lbl: Label 'Employe was blocked or resigned';
        Text007Lbl: Label 'Probation period already exists';
        Text008Lbl: Label 'Pay Elements are exist, Do you want to delete';
        PAYCADRELbl: Label 'PAY CADRE';

    procedure AssistEdit(OldEmployee: Record "Employee B2B"): Boolean
    begin
        with Employee do begin
            Employee := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD("Employee Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Employee Nos.", OldEmployee."No. Series", "No. Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Employee Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := Employee;
                exit(true);
            end;
        end;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Employee B2B", "No.", FieldNumber, ShortcutDimCode);
        MODIFY();
    end;

    procedure FullName(): Text[150]
    begin
        if "Middle Name" = '' then
            exit("First Name" + ' ' + "Last Name")
        else
            exit("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;
    /*
    procedure Attachments()
    var
        Attachment: Record "HR Attachment-B2B";
    begin
        Attachment.RESET();
        Attachment.SETRANGE("Table ID", DATABASE::"Employee B2B");
        Attachment.SETRANGE("Document No.", "No.");
        PAGE.RUNMODAL(PAGE::HRAttachments_B2B, Attachment);
    end;*/

    procedure GetPayCadrePayElements(Employee: Record "Employee B2B")
    var
        PayCadrePayElement: Record "Pay Cadre Pay Element B2B";
        PayCadrePayElement2: Record "Pay Cadre Pay Element B2B";
        PayElements: Record "Pay Elements B2B";
        CheckDate: Date;
    begin
        if HRSetup.FINDFIRST() then
            CheckDate := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");
        PayCadrePayElement.Reset();
        PayCadrePayElement.SETRANGE("Pay Cadre Code", Employee."Pay Cadre");
        PayCadrePayElement.SETRANGE(PayCadrePayElement.Processed, false);
        if PayCadrePayElement.FINDFIRST() then
            repeat
                PayCadrePayElement2.Reset();
                PayCadrePayElement2.SETRANGE(PayCadrePayElement2.Processed, false);
                PayCadrePayElement2.SETRANGE("Pay Cadre Code", PayCadrePayElement."Pay Cadre Code");
                PayCadrePayElement2.SETRANGE("Pay Element Code", PayCadrePayElement."Pay Element Code");
                if PayCadrePayElement2.FINDFIRST() then begin
                    repeat
                        PayCadrePayElement2.Processed := true;
                        PayCadrePayElement2.MODIFY();
                        if PayCadrePayElement2."Effective Start Date" <= CheckDate then begin
                            PayElements.Init();
                            PayElements."Employee Code" := Employee."No.";
                            PayElements."Effective Start Date" := PayCadrePayElement2."Effective Start Date";
                            PayElements."Pay Element Code" := PayCadrePayElement2."Pay Element Code";
                            PayElements."Fixed/Percent" := PayCadrePayElement2."Fixed/Percent";
                            PayElements."Computation Type" := PayCadrePayElement2."Computation Type";
                            PayElements."Loan Priority No" := PayCadrePayElement2."Loan Priority No";
                            PayElements."Amount / Percent" := PayCadrePayElement2."Amount / Percent";
                            PayElements."Add/Deduct" := PayCadrePayElement2."Add/Deduct";
                            PayElements."Applicable for OT" := PayCadrePayElement2."Applicable for OT";
                            PayElements.Processed := false;
                            PayElements.ESI := PayCadrePayElement2.ESI;
                            PayElements.PF := PayCadrePayElement2.PF;
                            PayElements."Bonus/Exgratia" := PayCadrePayElement2."Bonus/Exgratia";
                            PayElements.Gratuity := PayCadrePayElement2.Gratuity;
                            PayElements.PT := PayCadrePayElement2.PT;
                            PayElements."Leave Encashment" := PayCadrePayElement2."Leave Encashment";
                            PayElements."Pay Cadre" := Employee."Pay Cadre";
                        end;
                    until PayCadrePayElement2.NEXT() = 0;
                    PayElements.INSERT();
                end;
            until PayCadrePayElement.NEXT() = 0;

    end;

    procedure AttendanceUpdation()
    var
        DailyAttendance: Record "Daily Attendance B2B";
    begin
        DailyAttendance.SETRANGE("Employee No.", "No.");
        if DailyAttendance.FINDFIRST() then
            repeat
                if DailyAttendance.Date < "Employment Date" then
                    if not DailyAttendance."Non-Working" then begin
                        DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Absent;
                        DailyAttendance.Present := 0;
                        DailyAttendance.Absent := 1;
                        DailyAttendance.Leave := 0;
                    end;

                DailyAttendance.MODIFY();
            until DailyAttendance.NEXT() = 0;
    end;
}

