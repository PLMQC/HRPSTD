page 33001195 "Employee List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee List';
    CardPageID = "Employee Card B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Employee B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("No."; "No.")
                {
                    ToolTip = 'Specifies the Emloyee number series of the involved entry or record, according to the specified number series.';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        if Emp.GET("No.") then;
                    end;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Specifies the Emloyee''s Department code';
                    ApplicationArea = all;
                }
                field("PF Applicability"; "PF Applicability")
                {
                    ToolTip = 'Specifies the Employee''s PF applicability';
                    ApplicationArea = all;
                }
                field("User Id"; "User Id")
                {
                    ToolTip = 'Specifies the Emloyee''s user ID';
                    ApplicationArea = all;
                }
                field("Birth Date"; "Birth Date")
                {
                    ToolTip = 'Specifies the Emloyee''s date of birth';
                    ApplicationArea = all;
                }
                field(FullName; FullName())
                {
                    Caption = 'Full Name';
                    ToolTip = 'Specifies the Emloyee''s Full Name';
                    ApplicationArea = all;
                }
                field("Account No"; "Account No")
                {
                    ToolTip = 'Specifies the Emloyee''s bank Account No.';
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the Global Dimension value applicable as per the General LEdger setup.';
                    ApplicationArea = all;
                }
                field("Location Code"; "Location Code")
                {
                    ToolTip = 'Specifies the Emloyee''s Location Code.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Specifies the Emloyee''s Physical Loction Code.';
                    ApplicationArea = all;
                }
                field("Pay Cadre"; "Pay Cadre")
                {
                    ToolTip = 'Specifies the Emloyee''s Pay Grade / Pay Cader';
                    ApplicationArea = all;
                }
                field("Payroll Bus. Posting Group"; "Payroll Bus. Posting Group")
                {
                    ToolTip = 'Specifies the Business porting group based on which the General Ledger is effected.';
                    ApplicationArea = all;
                }
                field("Emp Posting Group"; "Emp Posting Group")
                {
                    ToolTip = 'Specifies the Employee  Business porting group based on which the General Ledger is effected.';
                    ApplicationArea = all;
                }
                field(Designation; Designation)
                {
                    ToolTip = 'Specifies the designation applicable to employee''s.';
                    ApplicationArea = all;
                }
                field("PT Branch Code"; "PT Branch Code")
                {
                    ToolTip = 'Specifies the PT Branch Code applicable to employee''s.';
                    ApplicationArea = all;
                }
                field("PF No"; "PF No")
                {
                    ToolTip = 'Specifies the PF NO. applicable to employee''s.';
                    ApplicationArea = all;
                }
                field("PF Applicable"; "PF Applicable")
                {
                    ToolTip = 'Specifies whether the PF is applicable to employee''s.';
                    ApplicationArea = all;
                }
                field("ESI Applicable"; "ESI Applicable")
                {
                    ToolTip = 'Specifies whether the ESI is applicable to employee''s.';
                    ApplicationArea = all;
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    ToolTip = 'Specifies the employee''s Phone Number.';
                    ApplicationArea = all;
                }
                field("ESI No"; "ESI No")
                {
                    ToolTip = 'Specifies the employee''s ESI Number applicable.';
                    ApplicationArea = all;
                }
                field("VDA Applicable"; "VDA Applicable")
                {
                    ToolTip = 'Specifies whether the VDA is applicable to employee''s.';
                    ApplicationArea = all;
                }
                field("E-Mail"; "E-Mail")
                {
                    ToolTip = 'Specifies the employee''s Email Address';
                    ApplicationArea = all;
                }
                field(Blocked; Blocked)
                {
                    ToolTip = 'Specifies whether the employee is blocked';
                    ApplicationArea = all;
                }
                field(Qualification; Qualification)
                {
                    ToolTip = 'Specifies employee''s Education Qualifications.';
                    ApplicationArea = all;
                }
                field("Employment Date"; "Employment Date")
                {
                    ToolTip = 'Specifies employee''s joining / confirmed date in the company..';
                    ApplicationArea = all;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    ToolTip = 'Specifies the employee''s company Email ID.';
                    ApplicationArea = all;
                }
                field("Work Group Code"; "Work Group Code")
                {
                    ToolTip = 'Specifies the employee''s Work group Code.';
                    ApplicationArea = all;
                }
                field("Out Station All. Group"; "Out Station All. Group")
                {
                    ToolTip = 'Specifies whether the Out Station  is applicable to All employee''s group.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST("Employee B2B"),
                                  "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee comments details.';
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(33001193),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Dimensions detail while posting document.';
                }
                action("Alternative A&ddresses")
                {
                    Caption = 'Alternative A&ddresses';
                    Image = AlternativeAddress;
                    RunObject = Page "Emp Alternative Add List B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee alternative addresses details.';
                }
                separator(Separator1102152032)
                {
                }
                action("App&raisal")
                {
                    Caption = 'App&raisal';
                    Image = MoveUp;
                    RunObject = Page "Employee Performance List B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee appraisal details.';
                }
                separator(Separator1102154042)
                {
                }
                separator(Separator1102152042)
                {
                }
                action("S&hift")
                {
                    Caption = 'S&hift';
                    Image = ImplementRegAbsence;
                    RunObject = Page "Employee Shift B2B";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee shift details.';
                }
                separator(Separator1102152073)
                {
                }
                action("Lea&ves")
                {
                    Caption = 'Lea&ves';
                    Image = AbsenceCategories;
                    RunObject = Page "Emp Leave List B2B";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee leave details.';
                }
                separator(Separator1102152066)
                {
                }
                action("&Family Details")
                {
                    Caption = '&Family Details';
                    Image = Relatives;
                    RunObject = Page "Family Details & Relation B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee family details.';
                }
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    RunObject = Page "Employee Qualifications B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee qualification details.';
                }
                action("Article Info. Overview")
                {
                    Caption = 'Article Info. Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview-B2B";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee overview details.';
                }
                action("Article Information")
                {
                    Caption = 'Article Information';
                    Image = Filed;
                    RunObject = Page "Misc. Article Information B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee article information details.';
                }
                action("&Confidential Information")
                {
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = Page "Confidential Information B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee confidentiial information details.';
                }
                action("Co&nfidential Info. Overview")
                {
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Over B2B";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee overview details.';
                }
                separator(Separator1102154321)
                {
                }
                group("T&DS")
                {
                    Caption = 'T&DS';
                    Image = CalculateSalesTax;
                    action("Previous Company Details")
                    {
                        Caption = 'Previous Company Details';
                        Image = CompanyInformation;
                        RunObject = Page "Emp. Prev. Comp. TDS B2B";
                        RunPageLink = "No." = FIELD("No.");
                        ApplicationArea = all;
                        ToolTip = 'Specifies the Employee previous company details.';
                    }
                    action("Previous IT Savings")
                    {
                        Caption = 'Previous IT Savings';
                        Image = History;
                        RunObject = Page "Empployee Prev. IT Savings B2B";
                        RunPageLink = "Employee Code" = FIELD("No.");
                        ApplicationArea = all;
                        ToolTip = 'Specifies the Employee previous IT savings details.';
                    }
                    separator(Separator1102154327)
                    {
                    }
                    action("Salary Adjustment Limits")
                    {
                        Caption = 'Salary Adjustment Limits';
                        Image = LimitedCredit;
                        RunObject = Page "Emp. Salary Adj. Limits B2B";
                        RunPageLink = "Employee Code" = FIELD("No.");
                        ApplicationArea = all;
                        ToolTip = 'Specifies the salary adjustment limits.';
                    }
                }
            }
            group("&Payroll")
            {
                Caption = '&Payroll';
                action("Pay &Elements")
                {
                    Caption = 'Pay &Elements';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Pay Elements B2B";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Pay elements.';
                }
                action("&Loans")
                {
                    Caption = '&Loans';
                    Image = Loaner;
                    RunObject = Page "Loan List B2B";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Loans details.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("New E&mployee Leaves")
                {
                    Caption = 'New E&mployee Leaves';
                    Image = NewTimesheet;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the New Employee Leave details.';

                    trigger OnAction();
                    begin
                        GenerateNewEmpLeaves();
                    end;
                }
            }
        }
        area(creation)
        {
            group(ActionGroup1102152005)
            {
                Caption = 'Dimensions';
                Image = Dimensions;
                action("Dimensions-Single")
                {
                    Caption = 'Dimensions-Single';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(33001193),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Dimension single details while posting document.';
                }
                action("Dimensions-&Multiple")
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions-&Multiple';
                    Image = DimensionSets;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Dimension multiple details while posting documents.';

                    trigger OnAction();
                    var
                        EmployeeB2BL: Record "Employee B2B";
                        DefaultDimMultiple: Page "Default Dimensions-Multiple";
                    begin
                        CurrPage.SETSELECTIONFILTER(EmployeeB2BL);
                        DefaultDimMultiple.SetMultiEmployeeB2B(EmployeeB2BL);
                        DefaultDimMultiple.RUNMODAL();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if Emp.GET("No.") then;
    end;

    trigger OnOpenPage();
    var
        EventHandlingCD: Codeunit "Event Handling B2B";
        ErrorLabel: Label 'Invalid License, Please Contact B2B Software Technologies.';
    begin
        EventHandlingCD.B2BLicenseValidate();

        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
    end;

    var
        Emp: Record "Employee B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        TempEmpLeaves: Record "Employee Leaves B2B" temporary;
        GradeWiseLeaves: Record "Grade Wise Leaves B2B";
        GradeWiseLeaves2: Record "Grade Wise Leaves B2B";
        PayrollYearRec: Record "Payroll Year B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        // PictureExists: Boolean;
        // Text005Lbl: Label 'Do you want to replace the existing picture?';
        // Text006Lbl: Label 'Do you want to delete the picture?';
        Text007Lbl: Label 'Leaves already inserted for this employee';
        Text008Lbl: Label 'LEAVE YEAR';

    procedure OpenEmpCard();
    begin
        if Emp.GET("No.") then
            PAGE.RUN(PAGE::"Employee Card B2B", Emp);
    end;

    procedure GenerateNewEmpLeaves();
    var
        StartDate: Date;
    begin
        TempEmpLeaves.DELETEALL();
        if not "Leaves Not Generated" then begin
            MESSAGE(Text007Lbl);
            exit;
        end else begin
            TESTFIELD("Leave Pay Cadre");
            TESTFIELD("Employment Date");
            GradeWiseLeaves2.RESET();
            GradeWiseLeaves2.SETRANGE(GradeWiseLeaves2."Leave Pay Cadre", "Leave Pay Cadre");
            GradeWiseLeaves2.SETRANGE(GradeWiseLeaves2."Crediting Type", GradeWiseLeaves2."Crediting Type"::"Before the Period");
            GradeWiseLeaves2.SETRANGE("Location Code", "Location Code");
            if GradeWiseLeaves2.FINDFIRST() then
                repeat
                    TempEmpLeaves.INIT();
                    TempEmpLeaves."No." := "No.";
                    TempEmpLeaves."Leave Pay Cadre" := "Leave Pay Cadre";
                    TempEmpLeaves."Leave Code" := GradeWiseLeaves2."Leave Code";
                    TempEmpLeaves."Leave Description" := GradeWiseLeaves2."Leave Description";
                    TempEmpLeaves."Leaves for the Current Period" := GradeWiseLeaves2."Leaves in Crediting Interval";
                    GetPayrollYearRec();
                    GradeWiseLeaves.RESET();
                    GradeWiseLeaves.SETRANGE("Leave Code", TempEmpLeaves."Leave Code");
                    GradeWiseLeaves.SETRANGE("Leave Pay Cadre", "Leave Pay Cadre");
                    GradeWiseLeaves.FINDFIRST();
                    if "Employment Date" >= PayrollYearRec."Year Start Date" then begin
                        StartDate := "Employment Date";
                        repeat
                            StartDate := CALCDATE(GradeWiseLeaves."Crediting Interval", StartDate);
                        until ("Employment Date" < StartDate) or (StartDate > PayrollYearRec."Year End Date");
                    end;
                    TempEmpLeaves."Next Leave Period" := StartDate;
                    TempEmpLeaves.INSERT();
                until GradeWiseLeaves2.NEXT() = 0;
            PAGE.RUNMODAL(33001373, TempEmpLeaves);
        end;
    end;

    procedure GetPayrollYearRec();
    begin
        PayrollYearRec.RESET();
        PayrollYearRec.SETRANGE("Year Type", Text008Lbl);
        PayrollYearRec.SETRANGE(Closed, false);
        PayrollYearRec.FINDFIRST();
    end;
}

