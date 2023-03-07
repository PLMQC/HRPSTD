page 33001290 "Employee Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Details';
    PageType = Card;
    SourceTable = "Employee B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee no details in employee master';
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee first name in employee master';
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee last name in employee master';
                }
                field("Middle Name"; "Middle Name")
                {
                    Caption = 'Middle Name/Initials';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee middle name in employee master';
                }
                field(Initials; Initials)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee initials in employee master';
                }
                field(Gender; Gender)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee gender details in employee master';
                }
                field("PT Branch Code"; "PT Branch Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee PT branch code in employee master';
                }
                field(Address; Address)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee address in employee master';
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee address2 in employee master';
                }
                field("Post Code"; "Post Code")
                {
                    Caption = 'Post Code/City';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee post code details in employee master';
                }
                field(City; City)
                {
                    Caption = 'City';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee city details in employee master';
                }
                field("Country Code"; "Country Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee country code in employee master';
                }
            }
            group("Processed Salary")
            {
                Caption = 'Processed Salary';
                grid("Processed Period")
                {
                    Caption = 'Processed Period';
                    GridLayout = Rows;
                    group(Control1102152005)
                    {
                        field(Month1; Month)
                        {
                            Caption = 'Month';
                            ApplicationArea = all;
                            ToolTip = 'Specifies the employee salary month in employee details';

                            trigger OnValidate();
                            begin
                                CurrPage.ProcSal.PAGE.GetEmp(Month, Year, "No.");
                            end;
                        }
                    }
                    group(Control1102152000)
                    {
                        field(Year1; Year)
                        {
                            Caption = 'Year';
                            ApplicationArea = all;
                            ToolTip = 'Specifies the employee salary process year in employee details';

                            trigger OnValidate();
                            begin
                                CurrPage.ProcSal.PAGE.GetEmp(Month, Year, "No.");
                            end;
                        }
                    }
                }
                part(ProcSal; "EmpDetails ProcSal B2B")
                {
                    SubPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = all;

                }
            }
            group("Monthly Attendace")
            {
                Caption = 'Monthly Attendace';
                grid("Attendance Period")
                {
                    Caption = 'Attendance Period';
                    GridLayout = Rows;
                    group(Control1102152010)
                    {
                        field(MonAtt1; Month)
                        {
                            Caption = 'Month';
                            ApplicationArea = all;
                            ToolTip = 'Specifies the employee salary process month  in employee details';

                            trigger OnValidate();
                            begin
                                CurrPage.MonAttSubForm.PAGE.GetEmp(Month, Year, "No.");
                            end;
                        }
                    }
                    group(Control1102152008)
                    {
                        field(YearAtt1; Year)
                        {
                            Caption = 'Year';
                            ApplicationArea = all;
                            ToolTip = 'Specifies the employee salary process year in employee details';

                            trigger OnValidate();
                            begin
                                CurrPage.MonAttSubForm.PAGE.GetEmp(Month, Year, "No.");
                            end;
                        }
                    }
                }
                part(MonAttSubForm; "EmpDet MonAtt B2B")
                {
                    Caption = 'MonAttSubForm';
                    SubPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = all;

                }
            }
            group("Leave Application")
            {
                Caption = 'Leave Application';
                grid("Leave Period")
                {
                    Caption = 'Leave Period';
                    GridLayout = Rows;
                    group(Control1102152017)
                    {
                        field(MonLeavAPP; Month)
                        {
                            Caption = 'Month';
                            ApplicationArea = all;
                            ToolTip = 'Specifies the Employee Leave Period Details';

                            trigger OnValidate();
                            begin
                                CurrPage.LeaveApplication.PAGE.GetEmp(Month, Year, "No.");
                            end;
                        }
                    }
                    group(Control1102152015)
                    {
                        field(YearLeavApp; Year)
                        {
                            Caption = 'Year';
                            ApplicationArea = all;
                            ToolTip = 'Specifies the employee year in employee details';

                            trigger OnValidate();
                            begin
                                CurrPage.LeaveApplication.PAGE.GetEmp(Month, Year, "No.");
                            end;
                        }
                    }
                }
                part(LeaveApplication; "EmpDet LeaveApp B2B")
                {
                    Caption = 'LeaveApplication';
                    SubPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;

                }
            }
            group("Leave Entitlement")
            {
                Caption = 'Leave Entitlement';
                grid("Leave Enti.Period")
                {
                    Caption = 'Leave Enti.Period';
                    GridLayout = Rows;
                    group(Control1102152022)
                    {
                        field(MonthLevEn2; Month)
                        {
                            Caption = 'Month';
                            ApplicationArea = all;
                            ToolTip = 'Specifies the employee month details in employee details';

                            trigger OnValidate();
                            begin
                                CurrPage.LeaveEntSubform.PAGE.GetEmp(Month, Year, "No.");
                            end;
                        }
                    }
                    group(Control1102152020)
                    {
                        field(YearLeEn1; Year)
                        {
                            Caption = 'Year';
                            ApplicationArea = all;
                            ToolTip = 'Specifies the employee year in employee details';

                            trigger OnValidate();
                            begin
                                CurrPage.LeaveEntSubform.PAGE.GetEmp(Month, Year, "No.");
                            end;
                        }
                    }
                }
                part(LeaveEntSubform; "EmpDet_Emp leaves B2B")
                {
                    SubPageLink = "No." = FIELD("No.");
                    ApplicationArea = all;

                }
            }
            group("Loan Details")
            {
                Caption = 'Loan Details';
                grid("Loan Period")
                {
                    Caption = 'Loan Period';
                    GridLayout = Rows;
                    group(Control1102152028)
                    {
                        field(LoanId2; LoanId)
                        {
                            Caption = 'Loan Id';
                            ApplicationArea = all;
                            ToolTip = 'Specifies the employee loan id  in employee details';

                            trigger OnLookup(Var Text: Text): Boolean;
                            begin
                                loan.SETRANGE("Employee Code", "No.");
                                if PAGE.RUNMODAL(0, loan) = ACTION::LookupOK then
                                    LoanId := loan.Id;

                                CurrPage.LoanDetSunForm.PAGE.GetEmp(LoanId);
                            end;

                            trigger OnValidate();
                            begin
                                CurrPage.LoanDetSunForm.PAGE.GetEmp(LoanId);
                            end;
                        }
                    }
                }
                part(LoanDetSunForm; "EmpDet LoanDet B2B")
                {
                    Caption = 'LoanDetSunForm';
                    SubPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;

                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                Editable = false;
                field(Extension; Extension)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee communication details in employee details';
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee mobile no  in employee details';
                }
                field(Pager; Pager)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee all details in employee details';
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee phone no in employee details';
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee email in employee details';
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee email in employee details';
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                Editable = false;
                field("Employment Date"; "Employment Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee joining date in employee details';
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee job title in employee details';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee designation in employee details';
                }
                field("User Id"; "User Id")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee user id in employee details';
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee department code in employee details';
                }
                field("Pay Cadre"; "Pay Cadre")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee pay cadre in employee details';
                }
                field(Probation; Probation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee probation details in employee details';
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                Editable = false;
                field("Birth Date"; "Birth Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee birthdate in employee details';
                }
                field("Social Security No."; "Social Security No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee social seurity no in employee details';
                }
                field("Blood Group"; "Blood Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee blood group in employee master';
                }
            }
            group("Pay Method")
            {
                Caption = 'Pay Method';
                Editable = false;
                field("Payment Method"; "Payment Method")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee pay method in employee master';

                    trigger OnValidate();
                    begin
                        if ("Payment Method" = "Payment Method"::Cash) or ("Payment Method" = "Payment Method"::Cheque) then begin
                            "Bank Code" := '';
                            "Bank Name" := '';
                            "Bank Branch" := '';
                            "Bank CodeEditable" := false;
                            "Bank NameEditable" := false;
                            "Bank BranchEditable" := false;
                            "Account TypeEditable" := false;
                            "Account NoEditable" := false;
                        end else begin
                            "Bank CodeEditable" := true;
                            "Bank NameEditable" := true;
                            "Bank BranchEditable" := true;
                            "Account TypeEditable" := true;
                            "Account NoEditable" := true;
                        end;
                    end;
                }
                field("Bank Code"; "Bank Code")
                {
                    Editable = "Bank CodeEditable";
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee bankcode in employee details';
                }
                field("Bank Name"; "Bank Name")
                {
                    Editable = "Bank NameEditable";
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee bank name';
                }
                field("Bank Branch"; "Bank Branch")
                {
                    Editable = "Bank BranchEditable";
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee bank branch details  in employee details';
                }
                field("Account Type"; "Account Type")
                {
                    Editable = "Account TypeEditable";
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee account type in employee details';
                }
                field("Account No"; "Account No")
                {
                    Editable = "Account NoEditable";
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee account no  in employee details';
                }
            }
            group(Taxation)
            {
                Caption = 'Taxation';
                Editable = false;
                field("ESI No"; "ESI No")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee ESI NO in employee details';
                }
                field("PF No"; "PF No")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee PF NO in employee details';
                }
                field("PAN No"; "PAN No")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee pan no in employee details';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Pay Slip")
            {
                Caption = 'Generate Pay Slip';
                Image = UserCertificate;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                ToolTip = 'Specifies the employee payslip in employee details';

                trigger OnAction();
                var
                    MonthlyAttendance: Record "Monthly Attendance B2B";
                begin
                    MonthlyAttendance.SETRANGE("Employee Code", "No.");
                    MonthlyAttendance.SETRANGE("Pay Slip Month", Month);
                    REPORT.RUN(33001248, true, false, MonthlyAttendance);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        CurrPage.ProcSal.PAGE.GetEmp(Month, Year, "No.");
        CurrPage.MonAttSubForm.PAGE.GetEmp(Month, Year, "No.");
        CurrPage.LeaveApplication.PAGE.GetEmp(Month, Year, "No.");
        CurrPage.LeaveEntSubform.PAGE.GetEmp(Month, Year, "No.");
        CurrPage.LoanDetSunForm.PAGE.GetEmp(LoanId);
    end;

    trigger OnInit();
    begin
        "Account NoEditable" := true;
        "Account TypeEditable" := true;
        "Bank BranchEditable" := true;
        "Bank NameEditable" := true;
        "Bank CodeEditable" := true;
    end;

    trigger OnOpenPage();
    var
        HRSetup: Record "HR Setup B2B";
    begin
        FILTERGROUP(0);
        FILTERGROUP(2);
        if HRSetup.FINDFIRST() then begin
            Month := HRSetup."Salary Processing month";
            Year := HRSetup."Salary Processing Year";
        end;
    end;

    var
        loan: Record Loan_B2B;
        Month: Integer;
        Year: Integer;
        LoanId: Code[20];

        [InDataSet]
        "Bank CodeEditable": Boolean;
        [InDataSet]
        "Bank NameEditable": Boolean;
        [InDataSet]
        "Bank BranchEditable": Boolean;
        [InDataSet]
        "Account TypeEditable": Boolean;
        [InDataSet]
        "Account NoEditable": Boolean;

    local procedure YearC1102152009OnActivate();
    begin
        CurrPage.ProcSal.PAGE.GetEmp(Month, Year, "No.");
    end;

    local procedure YearC1102152014OnActivate();
    begin
        CurrPage.MonAttSubForm.PAGE.GetEmp(Month, Year, "No.");
    end;

    local procedure MonthC1102152016OnActivate();
    begin
        CurrPage.MonAttSubForm.PAGE.GetEmp(Month, Year, "No.");
    end;

    local procedure YearC1102152036OnActivate();
    begin
        CurrPage.LeaveApplication.PAGE.GetEmp(Month, Year, "No.");
    end;

    local procedure MonthC1102152038OnActivate();
    begin
        CurrPage.LeaveApplication.PAGE.GetEmp(Month, Year, "No.");
    end;

    local procedure YearC1102152041OnActivate();
    begin
        CurrPage.LeaveEntSubform.PAGE.GetEmp(Month, Year, "No.");
    end;

    local procedure MonthC1102152043OnActivate();
    begin
        CurrPage.LeaveEntSubform.PAGE.GetEmp(Month, Year, "No.");
    end;

    local procedure LoanIdOnActivate();
    begin
        CurrPage.LoanDetSunForm.PAGE.GetEmp(LoanId);
    end;
}

