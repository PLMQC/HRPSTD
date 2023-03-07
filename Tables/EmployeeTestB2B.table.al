table 33001336 "Employee Test B2B"
{
    // version B2BHR1.00.00

    Caption = '"Employee B2B"; Test_B2B';
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
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
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
        field(15; "E-Mail"; Text[30])
        {
            Caption = 'E-Mail';
            DataClassification = CustomerContent;
        }
        field(19; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
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
        field(33; "Cause of Inactivity Code"; Code[10])
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
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(38; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource WHERE(Type = CONST(Person));
            DataClassification = CustomerContent;
        }
        field(39; Comment; Boolean)
        {
            CalcFormula = Exist ("Human Resource Comment Line" WHERE("Table Name" = CONST(Employee),
                                                                     "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            DataClassification = CustomerContent;
            Editable = false;
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
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }
        field(53; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(56; "Department Code"; Code[40])
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
        }
        field(83; Probation; Boolean)
        {
            Caption = 'Probation';
            DataClassification = CustomerContent;
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
            OptionCaption = 'Statutory,Actual Salary,Employee Specific';
            OptionMembers = Statutory,"Actual Salary","Employee Specific";
            DataClassification = CustomerContent;
        }
        field(96; "PF Amount"; Decimal)
        {
            Caption = 'PF Amount';
            MinValue = 0;
            DataClassification = CustomerContent;

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
            CalcFormula = Sum ("Monthly Attendance B2B"."Remaining Amount" WHERE("Employee Code" = FIELD("No."),
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
            DataClassification = CustomerContent;
            Caption = 'Blocked Date';
        }
        field(110; "Resume DB No."; Code[20])
        {
            Caption = 'Resume DB No.';
            DataClassification = CustomerContent;
        }
        field(111; "User Id"; Code[20])
        {
            Caption = 'User Id';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
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
            TableRelation = "Post Code";
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
        field(166; "Work Skill"; Code[20])
        {
            Caption = 'Work Skill';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(22));
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
            Caption = 'Contact Type';
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
            Editable = false;
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(217; "IT Slab Type"; Option)
        {
            Caption = 'IT Slab Type';
            OptionCaption = 'Male,Female,Sr. Citizen';
            OptionMembers = Male,Female,"Sr. Citizen";
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
            TableRelation = "Employee B2B"."No.";
            DataClassification = CustomerContent;
        }
        field(222; "Reporting Name"; Text[30])
        {
            Caption = 'Reporting Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(223; "Experience Prior to MITCON"; Integer)
        {
            Caption = 'Experience Prior to MITCON';
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
        field(262; "Next Appraisal Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Next Appraisal Date';
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
        }
        field(270; "Ext. Probation Period"; Decimal)
        {
            Caption = 'Ext. Probation Period';
            DataClassification = CustomerContent;
        }
        field(271; "Place of Birth"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Place of Birth';
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
        field(300; "Birth Month"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Birth Month';
        }
        field(301; "Employment Month"; Integer)
        {
            Caption = 'Employment Month';
            DataClassification = CustomerContent;
        }
        field(302; "Leaving Month"; Integer)
        {
            Caption = 'Leaving Month';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

