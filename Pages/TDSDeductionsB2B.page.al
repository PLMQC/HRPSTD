page 33001433 "TDS Deductions B2B"
{
    // version B2BHR1.00.00

    Caption = 'TDS Deductions';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "TDS Deductions B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field(FyStartDate1; FyStartDate)
            {
                Caption = 'Financial Year Start Date';
                Editable = true;
                ApplicationArea = all;
                ToolTip = 'specify the Financial year start date';

                trigger OnLookup(Var Text: Text): Boolean;
                begin
                    PayRollYears.RESET();
                    PayRollYears.SETRANGE("Year Type", Text33001Lbl);
                    PayRollYears.SETRANGE(Closed, false);
                    if PAGE.RUNMODAL(PAGE::"Payroll Years B2B", PayRollYears) = ACTION::LookupOK then begin
                        FyStartDate := PayRollYears."Year Start Date";

                        PayRollYears.RESET();
                        PayRollYears.SETRANGE("Year Type", Text33001Lbl);
                        PayRollYears.SETRANGE("Year Start Date", FyStartDate);
                        if PayRollYears.FINDFIRST() then
                            FyEndDate := PayRollYears."Year End Date";

                        SETRANGE("Financial Year Start Date", FyStartDate);
                        VALIDATE("Financial Year Start Date");
                        if FyStartDate = 0D then
                            CLEAR(FyEndDate);
                        CurrPage.UPDATE();
                    end;
                end;

                trigger OnValidate();
                begin
                    PayRollYears.RESET();
                    PayRollYears.SETRANGE("Year Type", Text33001Lbl);
                    PayRollYears.SETRANGE("Year Start Date", FyStartDate);
                    if PayRollYears.FINDFIRST() then
                        FyEndDate := PayRollYears."Year End Date";

                    SETRANGE("Financial Year Start Date", FyStartDate);
                    VALIDATE("Financial Year Start Date");
                    FyStartDateOnAfterValidate();
                end;
            }
            field(FyEndDate1; FyEndDate)
            {
                Caption = 'Financial Year End Date';
                Editable = true;
                TableRelation = "Payroll Year B2B"."Year End Date" WHERE("Year Type" = CONST('FINANCIAL YEAR'),
                                                                      Closed = CONST(false));
                ApplicationArea = all;
                ToolTip = 'specify the Financial year end date';
            }
            repeater(Control1102154000)
            {
                Editable = true;
                field("Emp ID"; "Emp ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the Employee ID details';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the employee name';
                }
                field("Gross Salary"; "Gross Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the calculate gross salary details';
                    trigger OnDrillDown();
                    begin
                        EmpTDSGrossSal.RESET();
                        EmpTDSGrossSal.SETRANGE("Emp ID", "Emp ID");
                        EmpTDSGrossSal.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
                        PAGE.RUN(33001435, EmpTDSGrossSal);
                    end;
                }
                field("Prev. Comp. Gross Salary"; "Prev. Comp. Gross Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the previous company gross salary details';
                    trigger OnDrillDown();
                    begin
                        "Emp. Previous Company Salary".RESET();
                        "Emp. Previous Company Salary".SETRANGE("Employee Code", "Emp ID");
                        "Emp. Previous Company Salary".SETRANGE("Financial Year Start Date", "Financial Year Start Date");
                        "Emp. Previous Company Salary".SETRANGE("Financial Year End Date", "Financial Year End Date");
                        PAGE.RUNMODAL(33001442, "Emp. Previous Company Salary");
                    end;
                }
                field("Value of prequisites"; "Value of prequisites")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the value of prequisites details';
                }
                field(Bonus; Bonus)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the bonus details';
                }
                field("Entertainment Allowance"; "Entertainment Allowance")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the entertainment allowance details';
                }
                field("PT Amount"; "PT Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the PT amount details';
                }
                field("ST Deduction"; "ST Deduction")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the ST deduction details';
                }
                field("PF Amount"; "PF Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the PF amount details';
                }
                field("Profit Lieu of Salary"; "Profit Lieu of Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the profit lieu of salary details';
                }
                field(Perks; Perks)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the perks details';
                }
                field("Total Gross Salary"; "Total Gross Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the total gross salary details';
                }
                field("Exem Under 10 and 17"; "Exem Under 10 and 17")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the exem under 10 and 17 details';
                }
                field("Gross Total Income"; "Gross Total Income")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the gross total income details';
                }
                field("Income Charged Under Salary"; "Income Charged Under Salary")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the income charged under salry details';
                }
                field("Relief US89"; "Relief US89")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the IT chapter relief us89 details';
                }
                field("Other Income"; "Other Income")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the IT other income details';
                }
                field("Chapter VI"; "Chapter VI")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the IT Chapter VI details';
                }
                field("Chapter VIA"; "Chapter VIA")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the IT Chapter VIA details';
                }
                field("Net Tax Income"; "Net Tax Income")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the Net Tax Income details';
                }
                field("Rebate U/S 87 A"; "Rebate U/S 87 A")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the Rebate U/S 87 A details';
                }
                field("Income Tax"; "Income Tax")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the Income Tax details';
                }
                field(Surcharge; Surcharge)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the Surcharge details';
                }
                field(eCess; eCess)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the ecess details';
                }
                field("Total Tax Liability"; "Total Tax Liability")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the total tax liability details';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action1102154049>")
            {
                Caption = '&Line';
                Image = Line;
                action("<Action1102154050>")
                {
                    Caption = 'Savings';
                    Image = Save;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "TDS Savings B2B";
                    RunPageLink = "Emp ID" = FIELD("Emp ID"),
                                  "Financial Year Start Date" = FIELD("Financial Year Start Date");
                    Enabled = OptionDisable; //TSGOP2
                    ApplicationArea = all;
                    ToolTip = 'specify the IT savings details';
                    trigger OnAction();
                    begin
                        if FyStartDate = 0D then
                            ERROR(Text004Lbl);
                    end;
                }
                action("<Action1102154046>")
                {
                    Caption = 'TDS Monthly Schedule';
                    Image = Calendar;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Page "EMP TDS Monthly Schedule B2B";
                    RunPageLink = "Emp ID" = FIELD("Emp ID"),
                                  "Financial Year Start Date" = FIELD("Financial Year Start Date");
                    ApplicationArea = all;
                    ToolTip = 'specify the TDS monthly schedule details';
                }
            }
        }
        area(processing)
        {
            group("<Action1102154044>")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("<Action1102154045>")
                {
                    Caption = 'Get &Employees';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'specify the get employee details';
                    trigger OnAction();
                    begin
                        if FyStartDate = 0D then
                            ERROR(Text004Lbl);
                        GetEmployees();
                    end;
                }
                group("<Action1102154033>")
                {
                    Caption = 'Calculate Gross Salary';
                    Image = CashFlow;
                    action("<Action1102154034>")
                    {
                        Caption = '&Current Employee';
                        Image = CalculateRemainingUsage;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        ApplicationArea = all;
                        ToolTip = 'specify the current employee gross salary details';
                        trigger OnAction();
                        begin
                            if FyStartDate = 0D then
                                ERROR(Text004Lbl);


                            if (("Net Tax Income" <> 0) and ("Total Tax Liability" <> 0)) then
                                ERROR(Text005Lbl);


                            TDSGrossSal.RESET();
                            TDSGrossSal.SETRANGE("Emp ID", "Emp ID");
                            TDSGrossSal.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
                            if TDSGrossSal.FINDSET() then
                                TDSGrossSal.DELETEALL();


                            ComputeEmpGrossSalary();
                        end;
                    }
                    action("All Employees")
                    {
                        Caption = '&All Employees';
                        Image = CalculateRemainingUsage;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        ApplicationArea = all;
                        ToolTip = 'specify the Calc. Gross Salary All Employee';
                        trigger OnAction();
                        begin
                            if FyStartDate = 0D then
                                ERROR(Text004Lbl);


                            TDSDeduction2.RESET();
                            TDSDeduction2.SETRANGE("Financial Year Start Date", FyStartDate);
                            if TDSDeduction2.FINDFIRST() then
                                repeat
                                    if ((TDSDeduction2."Net Tax Income" <> 0) and (TDSDeduction2."Total Tax Liability" <> 0)) then
                                        ERROR(Text006Lbl, TDSDeduction2."Emp ID");
                                until TDSDeduction2.NEXT() = 0;




                            TDSGrossSal.RESET();
                            TDSGrossSal.SETRANGE("Financial Year Start Date", FyStartDate);
                            if TDSGrossSal.FINDSET() then
                                TDSGrossSal.DELETEALL();

                            ComputeAllEmpGrossSalary();
                        end;
                    }
                }
                group("<Action1102152007>")
                {
                    Caption = 'Caluclate PF Amount';
                    Image = TaxPayment;
                    action("<Action1102152009>")
                    {
                        Caption = '&Current Employee';
                        Image = CalculateRemainingUsage;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        ApplicationArea = all;
                        ToolTip = 'specify the Calc. Gross Salary Current Employee';
                        Enabled = OptionDisable; //TSGOP2
                        trigger OnAction();
                        begin

                            if FyStartDate = 0D then
                                ERROR(Text004Lbl);


                            if (("Net Tax Income" <> 0) and ("Total Tax Liability" <> 0)) then
                                ERROR(Text005Lbl);

                            RepWindow.OPEN(Text011Lbl);

                            PFAmountCal(Rec);
                            RepWindow.CLOSE();
                            MESSAGE(Text001Lbl);
                        end;
                    }
                    action("<Action1102152008>")
                    {
                        Caption = '&All Employees';
                        Image = CalculateRemainingUsage;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = true;
                        ApplicationArea = all;
                        ToolTip = 'specify the Calc. Gross Salary All Employee';
                        trigger OnAction();
                        begin

                            if FyStartDate = 0D then
                                ERROR(Text004Lbl);


                            TDSDeduction2.RESET();
                            TDSDeduction2.SETRANGE("Financial Year Start Date", FyStartDate);
                            if TDSDeduction2.FINDFIRST() then
                                repeat
                                    if ((TDSDeduction2."Net Tax Income" <> 0) and (TDSDeduction2."Total Tax Liability" <> 0)) then
                                        ERROR(Text006Lbl, TDSDeduction2."Emp ID");
                                until TDSDeduction2.NEXT() = 0;

                            RepWindow.OPEN(Text012Lbl);

                            TDSDeduction2.RESET();
                            TDSDeduction2.SETRANGE("Financial Year Start Date", FyStartDate);
                            if TDSDeduction2.FINDFIRST() then
                                repeat
                                    PFAmountCal(TDSDeduction2);
                                until TDSDeduction2.NEXT() = 0;


                            RepWindow.CLOSE();
                            MESSAGE(Text001Lbl);
                        end;
                    }
                }
                group("<Action1102154047>")
                {
                    Caption = 'Update Savings';
                    Image = Reserve;
                    action("<Action1102154052>")
                    {
                        Caption = '&Current Employee';
                        Image = Employee;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedIsBig = false;
                        ApplicationArea = all;
                        ToolTip = 'specify the Calc. Gross Salary current Employee';
                        Enabled = OptionDisable; //TSGOP2
                        trigger OnAction();
                        begin
                            if FyStartDate = 0D then
                                ERROR(Text004Lbl);

                            CalcChapterIDS(Rec);
                        end;
                    }
                    action("<Action1102154053>")
                    {
                        Caption = '&All Employees';
                        Image = Union;
                        ApplicationArea = all;
                        ToolTip = 'specify the Calc. Gross Salary All Employee';
                        trigger OnAction();
                        begin
                            if FyStartDate = 0D then
                                ERROR(Text004Lbl);



                            TDSDeduction2.RESET();
                            TDSDeduction2.SETRANGE("Financial Year Start Date", FyStartDate);
                            if TDSDeduction2.FINDFIRST() then
                                repeat
                                    CalcChapterIDS(TDSDeduction2);
                                until TDSDeduction2.NEXT() = 0;

                        end;
                    }

                }
                group("Calculate Surcharge")
                {
                    Caption = 'Calculate Surcharge';
                    Image = CalculateBalanceAccount;
                    action("<Action1102152019>")
                    {
                        Caption = '&Current Employee';
                        Image = CalculateRemainingUsage;
                        ApplicationArea = all;
                        ToolTip = 'specify Calc. Surcharge Current Employee';
                        trigger OnAction();
                        begin

                            if FyStartDate = 0D then
                                ERROR(Text004Lbl);



                            //RepWindow.OPEN(Text012Lbl);

                            SurchargeAmount(Rec);

                            //RepWindow.CLOSE();
                            MESSAGE(Text001Lbl);
                        end;
                    }
                    action("<Action1102152018>")
                    {
                        Caption = '&All Employees';
                        Image = CalculateRemainingUsage;

                        ApplicationArea = all;
                        ToolTip = 'specify Calc. Surcharge All Employee';
                        trigger OnAction();
                        begin

                            if FyStartDate = 0D then
                                ERROR(Text004Lbl);


                            //RepWindow.OPEN(Text013Lbl);
                            TDSDeduction2.RESET();
                            TDSDeduction2.SETRANGE("Financial Year Start Date", FyStartDate);
                            if TDSDeduction2.FINDSET() then
                                repeat

                                    SurchargeAmount(TDSDeduction2);
                                until TDSDeduction2.NEXT() = 0;

                            //RepWindow.CLOSE();
                            MESSAGE(Text001Lbl);
                        end;
                    }
                }
                group("Calculate Tax Liability")
                {
                    Caption = 'Calculate Tax Liability';
                    Image = TaxPayment;
                    action("Calculate Tax LiabilityCurrent")
                    {
                        Caption = '&Current Employee';
                        Image = Employee;
                        ApplicationArea = all;
                        ToolTip = 'Specify Calc. Gross Salary current Employee';
                        trigger OnAction();
                        begin

                            TESTFIELD("Net Tax Income");

                            TDSSavings1.RESET();
                            TDSSavings1.SETRANGE("Emp ID", "Emp ID");
                            TDSSavings1.SETRANGE("Financial Year Start Date", "Financial Year Start Date");
                            if not TDSSavings1.FINDFIRST() then
                                if not CONFIRM(Text014Lbl, false) then
                                    exit;


                            RepWindow.OPEN(Text013Lbl);


                            CalcTaxLiability(Rec);

                            RepWindow.CLOSE();
                        end;
                    }
                    action("Calculate Tax LiabilityAll")
                    {
                        Caption = '&All Employees';
                        Image = Union;
                        ApplicationArea = all;
                        ToolTip = 'Specify Calc. Gross Salary All Employee';
                        trigger OnAction();
                        begin

                            CLEAR(TDSSavinsNotExists);
                            TDSDeduction2.RESET();
                            TDSDeduction2.SETRANGE("Financial Year Start Date", FyStartDate);
                            if TDSDeduction2.FINDFIRST() then
                                repeat
                                    TDSSavings1.RESET();
                                    TDSSavings1.SETRANGE("Emp ID", TDSDeduction2."Emp ID");
                                    TDSSavings1.SETRANGE("Financial Year Start Date", TDSDeduction2."Financial Year Start Date");
                                    if not TDSSavings1.FINDFIRST() then
                                        TDSSavinsNotExists := true;

                                until TDSDeduction2.NEXT() = 0;


                            if TDSSavinsNotExists then
                                if not CONFIRM(Text015Lbl, false) then
                                    exit;


                            TDSDeduction2.RESET();
                            TDSDeduction2.SETRANGE("Financial Year Start Date", FyStartDate);
                            if TDSDeduction2.FINDFIRST() then
                                repeat
                                    TDSDeduction2."Gross Total Income" := TDSDeduction2."Total Gross Salary" - TDSDeduction2."Exem Under 10 and 17";
                                    TDSDeduction2."Net Tax Income" := ROUND((TDSDeduction2."Gross Total Income" -
                                                   (TDSDeduction2."Other Income" + TDSDeduction2."Chapter VI" + TDSDeduction2."Chapter VIA")), 10.0, '=');
                                    TDSDeduction2.MODIFY();
                                until TDSDeduction2.NEXT() = 0;



                            RepWindow.OPEN(Text013Lbl);


                            TDSDeduction2.RESET();
                            TDSDeduction2.SETRANGE("Financial Year Start Date", FyStartDate);
                            if TDSDeduction2.FINDFIRST() then
                                repeat
                                    TDSDeduction2.TESTFIELD("Net Tax Income");
                                    CalcTaxLiability(TDSDeduction2);
                                until TDSDeduction2.NEXT() = 0;


                            RepWindow.CLOSE();
                        end;
                    }
                }
                group("<Action1102154059>")
                {
                    Caption = 'Calculate TDS Monthly Schedule';
                    Image = CalculateCalendar;
                    action("<Action1102154060>")
                    {
                        Caption = '&Current Employee';
                        Image = Employee;
                        ApplicationArea = all;
                        ToolTip = 'Specify Calc. Gross Salary current Employee';
                        trigger OnAction();
                        begin
                            if "Total Tax Liability" = 0 then
                                ERROR(Text008Lbl);

                            InsertTDSMonthlySchedule(Rec);
                        end;
                    }
                    action("<Action1102154061>")
                    {
                        Caption = '&All Employees';
                        Image = Union;
                        ApplicationArea = all;
                        ToolTip = 'Specify Calc. Gross Salary All Employee';
                        trigger OnAction();
                        begin

                            TDSDeduction2.RESET();
                            TDSDeduction2.SETRANGE("Financial Year Start Date", FyStartDate);
                            TDSDeduction2.SETFILTER("Net Tax Income", '<>%1', 0);
                            TDSDeduction2.SETFILTER("Total Tax Liability", '<>%1', 0);
                            if TDSDeduction2.FINDFIRST() then
                                repeat
                                    InsertTDSMonthlySchedule(TDSDeduction2);
                                until TDSDeduction2.NEXT() = 0;

                        end;
                    }
                }
                group("<Action1102154067>")
                {
                    Caption = 'Calculate TDS Reschedule';
                    Image = Recalculate;
                    action("<Action1102154068>")
                    {
                        Caption = '&Current Employee';
                        Image = Employee;
                        ApplicationArea = all;
                        ToolTip = 'Specify Calc. Gross Salary current Employee';
                        trigger OnAction();
                        begin
                            if not "Update Tax Liability" then
                                ERROR(Text008Lbl);

                            if not CONFIRM(Text016Lbl, false) then
                                exit;

                            CLEAR(CalcDone);
                            CalcTDSMonthlyReSchedule(Rec);

                            if CalcDone then
                                MESSAGE(Text009Lbl);
                        end;
                    }
                    action("<Action1102154069>")
                    {
                        Caption = '&All Employees';
                        Image = Union;
                        ApplicationArea = all;
                        ToolTip = 'Specify Calc. Gross Salary All Employee';
                        trigger OnAction();
                        begin
                            if not CONFIRM(Text016Lbl, false) then
                                exit;

                            CLEAR(CalcDone);

                            TDSDeduction2.RESET();
                            TDSDeduction2.SETRANGE("Financial Year Start Date", FyStartDate);
                            if TDSDeduction2.FINDFIRST() then
                                repeat
                                    if TDSDeduction2."Update Tax Liability" then
                                        ERROR(Text019Lbl, TDSDeduction2."Emp ID");
                                    CalcTDSMonthlyReSchedule(TDSDeduction2);
                                until TDSDeduction2.NEXT() = 0;


                            if CalcDone then
                                MESSAGE(Text009Lbl);
                        end;
                    }
                }
                group("<Action1102154058>")
                {
                    Caption = 'Archi&ve TDS Details';
                    Image = Archive;
                    action("<Action1102152011>")
                    {
                        Caption = '&Current Employee';
                        Image = Employee;
                        ApplicationArea = all;
                        ToolTip = 'Specify the Calc. Gross Salary current Employee';
                        trigger OnAction();
                        begin
                            if not CONFIRM(Text017Lbl, false) then
                                exit
                            else
                                ArchiveTDSDetails(Rec);
                        end;
                    }
                    action("<Action1102152010>")
                    {
                        Caption = '&All Employees';
                        Image = Union;
                        ApplicationArea = all;
                        ToolTip = 'Specify Calc. Gross Salary All Employee';
                        trigger OnAction();
                        begin
                            if not CONFIRM(Text018Lbl, false) then
                                exit
                            else begin
                                TDSDeduction2.RESET();
                                TDSDeduction2.SETRANGE("Financial Year Start Date", FyStartDate);
                                TDSDeduction2.SETFILTER("Gross Salary", '>%1', 0);
                                if TDSDeduction2.FINDSET() then
                                    repeat
                                        ArchiveTDSDetails(TDSDeduction2);
                                    until TDSDeduction2.NEXT() = 0;

                            end;
                            MESSAGE(Text010Lbl);
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        "Financial Year End Date" := FyEndDate;
        "Financial Year Start Date" := FyStartDate;
        "Gross Total Income" := "Total Gross Salary" - "Exem Under 10 and 17";
        if "Other Income" > 0 then
            "Net Tax Income" := "Gross Total Income" + "Other Income" - ("Chapter VI" + "Chapter VIA")
        else
            "Net Tax Income" := "Gross Total Income" - "Other Income" - ("Chapter VI" + "Chapter VIA");
    end;

    //TDSOP2 >>
    trigger OnAfterGetCurrRecord()
    begin
        IF Rec."IT Slab Type" = REc."IT Slab Type"::Option2 THEN
            OptionDisable := FALSE
        ELSE
            OptionDisable := TRUE;
    end;
    //TDSOP2 <<

    trigger OnOpenPage();
    begin
        CLEAR(FyStartDate);
        CLEAR(FyEndDate);
        SETRANGE("Financial Year Start Date", FyStartDate);

        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
    end;

    var
        PayRollYears: Record "Payroll Year B2B";
        Employee: Record "Employee B2B";
        TdsDeductions: Record "TDS Deductions B2B";
        TDSDeduction2: Record "TDS Deductions B2B";
        EmployeeRec: Record "Employee B2B";
        TDSGrossSal: Record "EMP TDS Gross Salary B2B";
        TDSSavings: Record "TDS Savings B2B";
        TDSSavings1: Record "TDS Savings B2B";
        ExcempGroups: Record "Exep/Ded Groups B2B";
        ExcempSections: Record "Excemption Sections B2B";
        ExepDedLimits: Record "Exep/Ded Limits B2B";
        EmpPrevTDSHist: Record "Emp. Previous TDS History B2B";
        EmpTDSGrossSal: Record "EMP TDS Gross Salary B2B";

        "Emp. Previous Company Salary": Record "Emp. Previous Company Sal B2B";
        HRSetup: Record "HR Setup B2B";
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        FyStartDate: Date;
        FyEndDate: Date;
        Text001Lbl: Label 'Processing is completed.';
        RepWindow: Dialog;
        TransDate: Date;
        GrossSalary: Decimal;
        OtherIncome: Decimal;
        ChapterVI: Decimal;
        ChapterVIA: Decimal;
        "ExeUnder10&17": Decimal;
        TDSSavinsNotExists: Boolean;
        CalcDone: Boolean;
        ChapterVICC: Integer;
        ChapterVICCF: Integer;
        ExemGrpID: Code[20];
        MonthlyGross: Decimal;
        NPSEmployee: Decimal;
        NPSEmployer: Decimal;
        Text002Lbl: Label 'Nothing to calculate';
        Text003Lbl: Label 'TDS Details Archived Successfully.';
        Text004Lbl: Label 'Start date must be filled';
        Text005Lbl: Label 'Tax Liability already Calculated for this employee.';
        Text006Lbl: Label 'Tax Liability already Calculated for this employee %1', Comment = '%1 = Emp Id';
        Text008Lbl: Label 'Calculate the Tax Liability';
        Text009Lbl: Label 'TDS Re-Scheduled Successfully';
        Text010Lbl: Label 'TDS Details Archived Successfully';
        Text011Lbl: Label 'Computing Gross Salary .....  \ Employee No   #1########################### \ Employee Name #2###########################', Comment = '%1 = No ; %2 = Namee';
        Text012Lbl: Label 'Computing PF Amount .....\ Employee No   #1###########################\ Employee Name #2#########################', Comment = '%1 =  No; %2 = Name';
        Text013Lbl: Label 'Computing Taxliability ..... \ Employee No   #1########################### \     ''Employee Name #2###########################', Comment = '%1 = No ; %2 = Name';
        Text014Lbl: Label 'This Employee %1 doesnt have any savings, do u want to continue calculate Tax Liabilities?', Comment = '%1 = Boolean';
        Text015Lbl: Label 'Some Employees doesnt have any savings, do u want to continue calculate Tax Liabilities?';
        Text016Lbl: Label 'Do you want to Re-Schedule the TDS Deductions';
        Text017Lbl: Label 'Do you want to archive the TDS Details';
        Text018Lbl: Label 'Do you want to archive the TDS Details for all Employees';
        Text019Lbl: Label 'Calculate the Tax Liability %1', Comment = '%1 = Emp id';
        Text33001Lbl: Label 'FINANCIAL YEAR';
        Text33002Lbl: Label '<1M>';
        Text33003Lbl: Label 'OI';
        Text33004Lbl: Label 'U/S 10 & 17';
        Text33005Lbl: Label 'VI';
        Text33006Lbl: Label 'SEC 80 C';
        Text33007Lbl: Label 'SEC 80 CCF';
        Text33008Lbl: Label 'SEC 80CCD';
        Text33009Lbl: Label 'SEC 80CCD(1)';
        Text33010Lbl: Label 'VI-A';
        Text33011Lbl: Label 'ADDITIONS AND DEDUCTIONS';
        Text33012Lbl: Label 'BASIC';
        Text33013Lbl: Label 'DA';
        Text33014Lbl: Label 'AFTER BASIC';
        Text33015Lbl: Label 'AFTER BASIC AND DA';
        Text33016Lbl: Label 'PF';
        OptionDisable: Boolean;//TDSOP2

    local procedure FyStartDateOnAfterValidate();
    begin
        if FyStartDate = 0D then
            CLEAR(FyEndDate);
        CurrPage.UPDATE();
    end;

    procedure ComputeEmpGrossSalary();
    begin
        RepWindow.OPEN(Text011Lbl);
        CalculateGrossSalary(Rec);
        RepWindow.CLOSE();
        MESSAGE(Text001Lbl);
    end;

    procedure ComputeAllEmpGrossSalary();
    begin
        RepWindow.OPEN(Text011Lbl);
        TDSDeduction2.RESET();
        TDSDeduction2.SETRANGE("Financial Year Start Date", FyStartDate);
        if TDSDeduction2.FINDFIRST() then
            repeat
                CalculateGrossSalary(TDSDeduction2);
            until TDSDeduction2.NEXT() = 0;


        RepWindow.CLOSE();
        MESSAGE(Text001Lbl);
    end;

    procedure PTAmount(TDSDeductions: Record "TDS Deductions B2B");
    var
        PT: Record "Professional Tax Line B2B";
        BranchCode: Code[20];
        EmpPrevCompSal: Record 33001353;
    begin
        CLEAR(BranchCode);
        CLEAR(GrossSalary);
        if Employee.GET(TDSDeductions."Emp ID") then
            BranchCode := Employee."PT Branch Code";
        //TDSDeductions.CALCFIELDS("Gross Salary");
        TDSDeductions.CALCFIELDS("Gross Salary", "Prev. Comp. Gross Salary");
        GrossSalary := (TDSDeductions."Gross Salary" + TDSDeductions."Prev. Comp. Gross Salary");

        EmployeeRec.GET(TDSDeductions."Emp ID");
        if EmployeeRec."Employment Date" > TDSDeductions."Financial Year Start Date" then
            TransDate := EmployeeRec."Employment Date"
        else
            TransDate := TDSDeductions."Financial Year Start Date";

        TDSDeductions.VALIDATE("PT Amount", 0);
        repeat
            if TransDate <= TDSDeductions."Financial Year End Date" then begin
                MonthlyGross := 0;
                EmpTDSGrossSal.RESET();
                EmpTDSGrossSal.SETRANGE("Emp ID", TDSDeductions."Emp ID");
                EmpTDSGrossSal.SETRANGE("Payslip Month", DATE2DMY(TransDate, 2));
                EmpTDSGrossSal.SETRANGE("Payslip Year", DATE2DMY(TransDate, 3));
                if EmpTDSGrossSal.FINDFIRST() then
                    repeat
                        MonthlyGross := MonthlyGross + EmpTDSGrossSal.Amount;
                    until EmpTDSGrossSal.NEXT() = 0;
                PT.RESET();
                PT.SETRANGE(PT."Branch Code", BranchCode);
                if PT.FINDFIRST() then
                    repeat
                        PT.TESTFIELD("Income From");
                        PT.TESTFIELD("Income To");
                        if (PT."Income From" <= MonthlyGross) and (PT."Income To" >= MonthlyGross) then
                            if DATE2DMY(TransDate, 2) = PT."Spl. Month" then
                                TDSDeductions."PT Amount" += PT."Spl. Value"
                            else
                                TDSDeductions."PT Amount" += PT."Tax Amount";
                    until PT.NEXT() = 0;

            end;
            TransDate := CALCDATE(Text33002Lbl, TransDate);
        until ((DATE2DMY(TransDate, 2) > DATE2DMY(TDSDeductions."Financial Year End Date", 2)) and
              (DATE2DMY(TransDate, 3) = DATE2DMY(TDSDeductions."Financial Year End Date", 3))) or
              (DATE2DMY(TransDate, 3) > DATE2DMY(TDSDeductions."Financial Year End Date", 3));

        EmpPrevCompSal.RESET;
        EmpPrevCompSal.SETRANGE("Employee Code", TDSDeductions."Emp ID");
        EmpPrevCompSal.SETRANGE("Financial Year Start Date", TDSDeductions."Financial Year Start Date");
        EmpPrevCompSal.SETRANGE("Pay Element Code", 'PT');
        IF EmpPrevCompSal.FINDFIRST THEN
            TDSDeductions."PT Amount" += EmpPrevCompSal.Amount;

        TDSDeductions.VALIDATE("PT Amount");
        TDSDeductions.MODIFY();
    end;

    procedure GetEmployees();
    begin
        Employee.RESET();
        Employee.SETRANGE(Status, Employee.Status::Active);
        Employee.SETRANGE(Blocked, false);
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            Employee.SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            Employee.SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        if Employee.FINDFIRST() then
            repeat
                TdsDeductions.RESET();
                TdsDeductions.SETRANGE("Emp ID", Employee."No.");
                TdsDeductions.SETRANGE("Financial Year Start Date", FyStartDate);
                if not TdsDeductions.FINDFIRST() then begin
                    TdsDeductions.INIT();
                    TdsDeductions.VALIDATE("Emp ID", Employee."No.");
                    TdsDeductions.VALIDATE("Financial Year Start Date", FyStartDate);
                    TdsDeductions."Financial Year End Date" := FyEndDate;
                    TdsDeductions."Location Code" := Employee."Location Code";
                    TdsDeductions."IT Slab Type" := Employee."IT Slab Type";//TDSOP2
                    TdsDeductions.INSERT();
                end;
            until Employee.NEXT() = 0;
    end;

    procedure InsertTDSMonthlySchedule(TDSDeduction3: Record "TDS Deductions B2B");
    var
        ProcessedSal: Record "Processed Salary B2B";
        EmployeeLRec: Record "Employee B2B";
        EMPTDSMonthlySchedule: Record "EMP TDS Monthly Schedule B2B";
        EMPTDSMon: Record "EMP TDS Monthly Schedule B2B";
        NotProcessed: Boolean;
        ScheduleCount: Decimal;
        RemainingTDS: Decimal;
        TransDate2: Date;
        TDSAmount: Decimal;
    begin
        CLEAR(TransDate2);
        CLEAR(TransDate);
        CLEAR(ScheduleCount);
        CLEAR(TDSAmount);
        EmployeeLRec.GET(TDSDeduction3."Emp ID");
        if EmployeeLRec."Employment Date" > TDSDeduction3."Financial Year Start Date" then
            TransDate := EmployeeLRec."Employment Date"
        else
            TransDate := TDSDeduction3."Financial Year Start Date";

        TransDate2 := TransDate;
        repeat
            ProcessedSal.RESET();
            ProcessedSal.SETRANGE("Employee Code", TDSDeduction3."Emp ID");
            ProcessedSal.SETRANGE("Pay Slip Month", DATE2DMY(TransDate, 2));
            ProcessedSal.SETRANGE(Year, DATE2DMY(TransDate, 3));
            ProcessedSal.SETRANGE("Add/Deduct", ProcessedSal."Add/Deduct"::Addition);
            ProcessedSal.SETFILTER("Earned Amount", '<>%1', 0);
            ProcessedSal.SETRANGE(Posted, true);
            if not ProcessedSal.IsEmpty() then
                TransDate := CALCDATE(Text33002Lbl, TransDate)
            else
                NotProcessed := true;
        until NotProcessed = true;
        TransDate := TransDate2;
        repeat
            EMPTDSMonthlySchedule.INIT();
            EMPTDSMonthlySchedule."Emp ID" := TDSDeduction3."Emp ID";
            EMPTDSMonthlySchedule."Payslip Month" := DATE2DMY(TransDate, 2);
            EMPTDSMonthlySchedule."Payslip Year" := DATE2DMY(TransDate, 3);
            EMPTDSMonthlySchedule."Financial Year Start Date" := "Financial Year Start Date";
            EMPTDSMonthlySchedule."Financial Year End Date" := "Financial Year End Date";
            EMPTDSMonthlySchedule.INSERT();
            TransDate := CALCDATE(Text33002Lbl, TransDate);
        until ((DATE2DMY(TransDate, 2) > DATE2DMY(TDSDeduction3."Financial Year End Date", 2)) and
              (DATE2DMY(TransDate, 3) = DATE2DMY(TDSDeduction3."Financial Year End Date", 3))) or
              (DATE2DMY(TransDate, 3) > DATE2DMY(TDSDeduction3."Financial Year End Date", 3));

        EMPTDSMon.RESET();
        EMPTDSMon.SETRANGE("Emp ID", EMPTDSMonthlySchedule."Emp ID");
        EMPTDSMon.SETRANGE("Financial Year Start Date", EMPTDSMonthlySchedule."Financial Year Start Date");
        ScheduleCount := EMPTDSMon.COUNT();
        if EMPTDSMon.FINDSET() then begin
            TDSAmount := ROUND((TDSDeduction3."Total Tax Liability" / ScheduleCount), 1, '=');
            EMPTDSMon.MODIFYALL("TDS Amount", TDSAmount);
            RemainingTDS := 0;
            RemainingTDS := TDSDeduction3."Total Tax Liability";
        end;

        repeat
            EMPTDSMon.RESET();
            EMPTDSMon.SETRANGE("Emp ID", TDSDeduction3."Emp ID");
            EMPTDSMon.SETRANGE("Payslip Month", DATE2DMY(TransDate2, 2));
            EMPTDSMon.SETRANGE("Payslip Year", DATE2DMY(TransDate2, 3));
            if EMPTDSMon.FINDFIRST() then begin
                if (RemainingTDS > EMPTDSMon."TDS Amount") then begin
                    EMPTDSMon."TDS Remaining Amount" := RemainingTDS - EMPTDSMon."TDS Amount";
                    RemainingTDS := EMPTDSMon."TDS Remaining Amount";
                end else begin
                    EMPTDSMon."TDS Remaining Amount" := 0;
                    RemainingTDS := 0;
                end;
                EMPTDSMon.MODIFY();
                TransDate2 := CALCDATE(Text33002Lbl, TransDate2);
            end;
        until ((DATE2DMY(TransDate2, 2) > DATE2DMY(TDSDeduction3."Financial Year End Date", 2)) and
              (DATE2DMY(TransDate2, 3) = DATE2DMY(TDSDeduction3."Financial Year End Date", 3))) or
              (DATE2DMY(TransDate2, 3) > DATE2DMY(TDSDeduction3."Financial Year End Date", 3));
    end;

    procedure CalcChapterIDS(TDSDeductions: Record "TDS Deductions B2B");
    var
        ITChaptersLRec: Record "IT Chapters B2B";
        EmpPrevITSavingsLRec: Record "Emp. Previous IT Savings B2B";
    begin
        CLEAR(OtherIncome);
        CLEAR(ChapterVI);
        CLEAR(ChapterVIA);
        CLEAR("ExeUnder10&17");
        CLEAR(ChapterVICC);
        CLEAR(ChapterVICCF);
        CLEAR(NPSEmployee);
        CLEAR(NPSEmployer);
        TDSSavings.RESET();
        TDSSavings.SETRANGE("Emp ID", TDSDeductions."Emp ID");
        TDSSavings.SETRANGE("Financial Year Start Date", TDSDeductions."Financial Year Start Date");
        if TDSSavings.FINDFIRST() then begin
            CLEAR(ExemGrpID);
            repeat
                ExcempGroups.GET(TDSSavings."Exemption Group Id");
                ExcempSections.GET(ExcempGroups."Section ID");
                if ExcempSections."Chapter ID" = Text33003Lbl then
                    OtherIncome += TDSSavings.Limit;
                if ExcempSections."Chapter ID" = Text33004Lbl then
                    "ExeUnder10&17" += TDSSavings.Limit;
                if ExcempSections."Chapter ID" = Text33005Lbl then begin
                    if ExcempSections."Section ID" = Text33006Lbl then
                        ChapterVICC += TDSSavings.Limit;
                    if ExcempSections."Section ID" = Text33007Lbl then begin
                        ChapterVICCF += TDSSavings.Limit;
                        ExemGrpID := ExcempGroups."Exemp / Ded Group Id";
                    end;
                    if ExcempSections."Section ID" = Text33008Lbl then
                        NPSEmployee += TDSSavings.Limit;

                    if ExcempSections."Section ID" = Text33009Lbl then
                        NPSEmployer += TDSSavings.Limit;

                end;
                if ExcempSections."Chapter ID" = Text33010Lbl then
                    ChapterVIA += TDSSavings.Limit;
            until TDSSavings.NEXT() = 0;
        end else
            ERROR(Text002Lbl);

        EmpPrevITSavingsLRec.RESET();
        EmpPrevITSavingsLRec.SETRANGE("Employee Code", TDSDeductions."Emp ID");
        EmpPrevITSavingsLRec.SETRANGE("Financial Year Start Date", TDSDeductions."Financial Year Start Date");
        if EmpPrevITSavingsLRec.FINDFIRST() then
            repeat
                ExcempGroups.GET(EmpPrevITSavingsLRec."Exemption/Deduction Group ID");
                ExcempSections.GET(ExcempGroups."Section ID");
                if ExcempSections."Chapter ID" = Text33003Lbl then
                    OtherIncome += EmpPrevITSavingsLRec."Amount Exempted";
                if ExcempSections."Chapter ID" = Text33004Lbl then
                    "ExeUnder10&17" += EmpPrevITSavingsLRec."Amount Exempted";
                if ExcempSections."Chapter ID" = Text33005Lbl then begin
                    if ExcempSections."Section ID" = Text33006Lbl then
                        ChapterVICC += EmpPrevITSavingsLRec."Amount Exempted";
                    if ExcempSections."Section ID" = Text33007Lbl then begin
                        ChapterVICCF += EmpPrevITSavingsLRec."Amount Exempted";
                        ExemGrpID := ExcempGroups."Exemp / Ded Group Id";
                    end;
                    if ExcempSections."Section ID" = Text33008Lbl then
                        NPSEmployee += TDSSavings.Limit;

                    if ExcempSections."Section ID" = Text33009Lbl then
                        NPSEmployer += TDSSavings.Limit;

                end;
                if ExcempSections."Chapter ID" = Text33010Lbl then
                    ChapterVIA += EmpPrevITSavingsLRec."Amount Exempted";
            until EmpPrevITSavingsLRec.NEXT() = 0;



        if ChapterVICC <> 0 then begin
            ITChaptersLRec.GET(Text33005Lbl);
            if ITChaptersLRec."Maximum Limit" <> 0 then
                if ChapterVICC > ITChaptersLRec."Maximum Limit" then
                    ChapterVI += ITChaptersLRec."Maximum Limit"
                else
                    ChapterVI += ChapterVICC
            else
                ChapterVI += ChapterVICC;
        end;
        if ChapterVICCF <> 0 then
            if ExemGrpID <> '' then begin
                ExepDedLimits.GET(ExemGrpID, TDSDeductions."Financial Year Start Date");
                if ExepDedLimits."Exemption Limit" <> 0 then begin
                    if ChapterVICCF > ExepDedLimits."Exemption Limit" then
                        ChapterVI += ExepDedLimits."Exemption Limit"
                    else
                        ChapterVI += ChapterVICCF;
                end else
                    ChapterVI += ChapterVICCF;
            end;

        TDSDeductions."Chapter VI" := ChapterVI + NPSEmployee + NPSEmployer;

        if TDSDeductions."Chapter VI" <> 0 then begin
            ITChaptersLRec.GET(Text33005Lbl);
            if ITChaptersLRec."Maximum Limit" <> 0 then
                if TDSDeductions."Chapter VI" > ITChaptersLRec."Maximum Limit" then
                    TDSDeductions."Chapter VI" := ITChaptersLRec."Maximum Limit";
        end;

        if ChapterVIA <> 0 then begin
            ITChaptersLRec.GET(Text33010Lbl);
            if ITChaptersLRec."Maximum Limit" <> 0 then begin
                if ChapterVIA > ITChaptersLRec."Maximum Limit" then
                    TDSDeductions."Chapter VIA" := ITChaptersLRec."Maximum Limit"
                else
                    TDSDeductions."Chapter VIA" := ChapterVIA;
            end else
                TDSDeductions."Chapter VIA" := ChapterVIA;
        end else
            TDSDeductions."Chapter VIA" := 0;

        if OtherIncome <> 0 then begin
            ITChaptersLRec.GET(Text33003Lbl);
            if ITChaptersLRec."Maximum Limit" <> 0 then begin
                if OtherIncome > ITChaptersLRec."Maximum Limit" then
                    TDSDeductions."Other Income" := ITChaptersLRec."Maximum Limit"
                else
                    TDSDeductions."Other Income" := OtherIncome;
            end else
                TDSDeductions."Other Income" := OtherIncome;
        end else
            TDSDeductions."Other Income" := 0;

        if "ExeUnder10&17" <> 0 then begin
            ITChaptersLRec.GET(Text33004Lbl);
            if ITChaptersLRec."Maximum Limit" <> 0 then begin
                if "ExeUnder10&17" > ITChaptersLRec."Maximum Limit" then
                    TDSDeductions."Exem Under 10 and 17" := ITChaptersLRec."Maximum Limit"
                else
                    TDSDeductions."Exem Under 10 and 17" := "ExeUnder10&17";
            end else
                TDSDeductions."Exem Under 10 and 17" := "ExeUnder10&17";
        end else
            TDSDeductions."Exem Under 10 and 17" := 0;
        TDSDeductions.MODIFY();
    end;

    procedure CalcTaxLiability(TDSDeductions1: Record "TDS Deductions B2B");
    var
        ITSlabLine: Record "IT Slab Line B2B";
        EmployeeLRec: Record "Employee B2B";
        Rebate: Record "Income Tax Rebate Setup B2B";
        SurchargeTaxLine: Record "Surcharge Tax Line B2B";
        TD: Decimal;
        TA: Decimal;
        ExitFlag: Boolean;
        TASurcharge: Decimal;
        TACess: Decimal;
        PrevCompTDSAmt: Decimal;
        RebateAmount: Decimal;
        StopLoop: Boolean;
    begin
        CLEAR(TD);
        CLEAR(TA);
        CLEAR(TASurcharge);
        CLEAR(TACess);
        CLEAR(PrevCompTDSAmt);

        EmployeeLRec.GET(TDSDeductions1."Emp ID");
        TD := TDSDeductions1."Net Tax Income";
        ITSlabLine.RESET();
        ITSlabLine.SETRANGE(SlabType, EmployeeLRec."IT Slab Type");
        ITSlabLine.SETRANGE("Financial Year Start Date", TDSDeductions1."Financial Year Start Date");
        if ITSlabLine.FINDFIRST() then
            repeat
                if TD > ITSlabLine."Total Income" then begin
                    TD := TD - ITSlabLine."Total Income";
                    TA := TA + (ITSlabLine."Total Income" * ITSlabLine."Tax Rate %" / 100);
                end else begin
                    TA := TA + (TD * ITSlabLine."Tax Rate %" / 100);
                    ExitFlag := true;
                end;
            until ((ITSlabLine.NEXT() = 0) or (ExitFlag = true));

        TDSDeductions1."Income Tax" := ROUND(TA, 1.0, '=');

        if TDSDeductions1."Income Tax" <> 0 then begin
            RebateAmount := 0;
            Rebate.RESET();
            Rebate.SETRANGE("Rebate Year Starting Date", FyStartDate);
            Rebate.SETRANGE("Rebate Year Ending Date", FyEndDate);
            if Rebate.FINDFIRST() then begin
                repeat
                    if ((Rebate."Max. Net Taxable Income" >= TDSDeductions1."Net Tax Income") and
                        (Rebate."Min. Net Taxable Income" <= TDSDeductions1."Net Tax Income")) then begin
                        ExcempSections.GET(Rebate."Section ID");
                        if ExcempSections."Chapter ID" = '' then
                            RebateAmount += Rebate."Max. Rebate Amount";
                    end;
                until Rebate.NEXT() = 0;

                if RebateAmount < TDSDeductions1."Income Tax" then
                    TDSDeductions1."Rebate U/S 87 A" := RebateAmount
                else
                    TDSDeductions1."Rebate U/S 87 A" := TDSDeductions1."Income Tax";

                if (TA >= RebateAmount) then
                    TA := TA - RebateAmount
                else
                    TA := 0;
            end;
        end else
            TDSDeductions1."Rebate U/S 87 A" := 0;



        TDSDeductions1."Income Tax" := ROUND(TA, 1.0, '=');

        CLEAR(StopLoop);
        SurchargeTaxLine.RESET();
        SurchargeTaxLine.SETRANGE("Effective Date", TDSDeductions1."Financial Year Start Date");
        if SurchargeTaxLine.FINDSET() then
            repeat
                if TDSDeductions1."Gross Salary" in [SurchargeTaxLine."Income From" .. SurchargeTaxLine."Income To"] then begin
                    TDSDeductions1.Surcharge := ROUND((TDSDeductions1."Income Tax" * SurchargeTaxLine."Tax %") / 100, 1, '=');
                    StopLoop := true;
                end;
            until (SurchargeTaxLine.NEXT() = 0) or StopLoop;

        if not StopLoop then
            TDSDeductions1.Surcharge := 0;

        HRSetup.GET();
        if TA <> 0 then begin
            TASurcharge := (TA * HRSetup.Surcharge) / 100;
            //TDSOP2 >>
            IF EmployeeLRec."IT Slab Type" = EmployeeLRec."IT Slab Type"::Option2 THEN
                TACess := (TA * HRSetup."Opt 2 Educational Cess") / 100
            ELSE
                TACess := (TA * HRSetup."Educational Cess") / 100;//TDSOP2 <<
            TA += (TASurcharge + TACess);
        end;



        TDSDeductions1.eCess := ROUND(TACess, 1.0, '=');

        EmpPrevTDSHist.RESET();
        EmpPrevTDSHist.SETRANGE("Employee Code", TDSDeductions1."Emp ID");
        EmpPrevTDSHist.SETRANGE("Financial Year Start Date", TDSDeductions1."Financial Year Start Date");
        if EmpPrevTDSHist.FINDFIRST() then
            repeat
                PrevCompTDSAmt += EmpPrevTDSHist."TDS Amount Paid";
            until EmpPrevTDSHist.NEXT() = 0;
        TA := (TA - PrevCompTDSAmt);


        TDSDeductions1."Total Tax Liability" := ROUND(TA, 1.0, '=');
        TDSDeductions1."Update Tax Liability" := true;
        TDSDeductions1.MODIFY();
    end;

    procedure ArchiveTDSDetails(TDSDeductions: Record "TDS Deductions B2B");
    var
        TDSDeductionsLRec: Record "TDS Deductions B2B";
        TDSSavingsLRec: Record "TDS Savings B2B";
        ArchTDSDedLRec: Record "Archive TDS Deductions B2B";
        ArchTDSSavLRec: Record "Archive TDS Savings B2B";
        EMPTDSGrossSalGRec: Record "EMP TDS Gross Salary B2B";
    begin
        TDSDeductionsLRec.RESET();
        TDSDeductionsLRec.SETRANGE("Financial Year Start Date", TDSDeductions."Financial Year Start Date");
        TDSDeductionsLRec.SETRANGE("Emp ID", TDSDeductions."Emp ID");
        if TDSDeductionsLRec.FINDFIRST() then begin
            TDSDeductionsLRec.CALCFIELDS(TDSDeductionsLRec."Gross Salary");
            ArchTDSDedLRec.INIT();
            ArchTDSDedLRec.TRANSFERFIELDS(TDSDeductionsLRec);
            ArchTDSDedLRec."Archived Date" := TODAY();
            ArchTDSDedLRec."Gross Salary" := TDSDeductionsLRec."Gross Salary";
            ArchTDSDedLRec.INSERT();

            TDSSavingsLRec.RESET();
            TDSSavingsLRec.SETRANGE("Emp ID", TDSDeductions."Emp ID");
            TDSSavingsLRec.SETRANGE("Financial Year Start Date", TDSDeductions."Financial Year Start Date");
            if TDSSavingsLRec.FINDFIRST() then
                repeat
                    ArchTDSSavLRec.INIT();
                    ArchTDSSavLRec.TRANSFERFIELDS(TDSSavingsLRec);
                    ArchTDSSavLRec."Archived Date" := TODAY();
                    ArchTDSSavLRec.INSERT();

                    TDSSavingsLRec."Actual Paid" := 0;
                    TDSSavingsLRec.Limit := 0;
                    TDSSavingsLRec.MODIFY();
                until TDSSavingsLRec.NEXT() = 0;

            EMPTDSGrossSalGRec.RESET();
            EMPTDSGrossSalGRec.SETRANGE("Emp ID", TDSDeductions."Emp ID");
            EMPTDSGrossSalGRec.SETRANGE("Financial Year Start Date", TDSDeductions."Financial Year Start Date");
            EMPTDSGrossSalGRec.DELETEALL();


            TDSDeductionsLRec."PT Amount" := 0;
            TDSDeductionsLRec."Exem Under 10 and 17" := 0;
            TDSDeductionsLRec."Income Charged Under Salary" := 0;
            TDSDeductionsLRec."Other Income" := 0;
            TDSDeductionsLRec."Gross Total Income" := 0;
            TDSDeductionsLRec."Chapter VI" := 0;
            TDSDeductionsLRec."Chapter VIA" := 0;
            TDSDeductionsLRec."Net Tax Income" := 0;
            TDSDeductionsLRec."Total Tax Liability" := 0;
            TDSDeductionsLRec.Perks := 0;
            TDSDeductionsLRec."Profit Lieu of Salary" := 0;
            TDSDeductionsLRec."Total Gross Salary" := 0;
            TDSDeductionsLRec."Relief US89" := 0;
            TDSDeductionsLRec.Surcharge := 0;
            TDSDeductionsLRec."PF Amount" := 0;
            TDSDeductionsLRec."Income Tax" := 0;
            TDSDeductionsLRec."Value of prequisites" := 0;
            TDSDeductionsLRec."Update Tax Liability" := false;
            TDSDeductionsLRec."Rebate U/S 87 A" := 0;
            TDSDeductionsLRec.eCess := 0;
            TDSDeductionsLRec."ST Deduction" := 0;
            TDSDeductionsLRec.MODIFY();
            MESSAGE(Text003Lbl);
        end;
    end;

    procedure CalcTDSMonthlyReSchedule(TDSDeduction3: Record "TDS Deductions B2B");
    var
        EMPTDSMonthlySchedule: Record "EMP TDS Monthly Schedule B2B";
        EMPTDSMon: Record "EMP TDS Monthly Schedule B2B";
        TDSDeductedAmt: Decimal;
        RemMonths: Integer;
        LastDeductedMonth: Date;
    begin
        CLEAR(RemMonths);
        CLEAR(TDSDeductedAmt);
        CLEAR(LastDeductedMonth);

        EMPTDSMonthlySchedule.RESET();
        EMPTDSMonthlySchedule.SETCURRENTKEY("Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month");
        EMPTDSMonthlySchedule.SETRANGE("Emp ID", TDSDeduction3."Emp ID");
        EMPTDSMonthlySchedule.SETRANGE("Financial Year Start Date", TDSDeduction3."Financial Year Start Date");
        EMPTDSMonthlySchedule.SETFILTER("TDS Amount Deducted", '<>%1', 0);
        if EMPTDSMonthlySchedule.FINDFIRST() then
            repeat
                TDSDeductedAmt += EMPTDSMonthlySchedule."TDS Amount Deducted";
                LastDeductedMonth := DMY2DATE(1, EMPTDSMonthlySchedule."Payslip Month", EMPTDSMonthlySchedule."Payslip Year");
            until EMPTDSMonthlySchedule.NEXT() = 0;

        EMPTDSMonthlySchedule.RESET();
        EMPTDSMonthlySchedule.SETCURRENTKEY("Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month");
        EMPTDSMonthlySchedule.SETRANGE("Emp ID", TDSDeduction3."Emp ID");
        EMPTDSMonthlySchedule.SETRANGE("Financial Year Start Date", TDSDeduction3."Financial Year Start Date");
        if EMPTDSMonthlySchedule.FINDFIRST() then
            repeat
                if DMY2DATE(1, EMPTDSMonthlySchedule."Payslip Month", EMPTDSMonthlySchedule."Payslip Year") > LastDeductedMonth then
                    RemMonths += 1;
            until EMPTDSMonthlySchedule.NEXT() = 0;


        EMPTDSMon.RESET();
        EMPTDSMon.SETCURRENTKEY("Emp ID", "Financial Year Start Date", "Payslip Year", "Payslip Month");
        EMPTDSMon.SETRANGE("Emp ID", TDSDeduction3."Emp ID");
        EMPTDSMon.SETRANGE("Financial Year Start Date", TDSDeduction3."Financial Year Start Date");
        if EMPTDSMon.FINDFIRST() then
            repeat
                if DMY2DATE(1, EMPTDSMon."Payslip Month", EMPTDSMon."Payslip Year") > LastDeductedMonth then begin
                    EMPTDSMon."TDS Amount" := ((TDSDeduction3."Total Tax Liability" - TDSDeductedAmt) / RemMonths);
                    if EMPTDSMon."TDS Amount" < 0 then
                        EMPTDSMon."TDS Amount" := 0;
                    if EMPTDSMon.MODIFY() then
                        CalcDone := true;
                end;
            until EMPTDSMon.NEXT() = 0;
    end;

    procedure CalculateGrossSalary(var TDSDeduction3: Record "TDS Deductions B2B");
    var
        LookupRec: Record Lookup_B2B;
        LookupRec2: Record Lookup_B2B;
        EmpPayElements: Record "Pay Elements B2B";
        EmpPayElements2: Record "Pay Elements B2B";
        EmpPayElements3: Record "Pay Elements B2B";
        ProcessedSal: Record "Processed Salary B2B";
        NotProcessed: Boolean;
        PercentAmt: Decimal;
        BasicAmt: Decimal;
        DAAmt: Decimal;

    begin
        CLEAR(TransDate);
        RepWindow.UPDATE(1, TDSDeduction3."Emp ID");
        RepWindow.UPDATE(2, TDSDeduction3."Employee Name");

        EmployeeRec.GET(TDSDeduction3."Emp ID");
        if EmployeeRec."Employment Date" > TDSDeduction3."Financial Year Start Date" then
            TransDate := EmployeeRec."Employment Date"
        else
            TransDate := TDSDeduction3."Financial Year Start Date";

        repeat
            // if ((DATE2DMY(TransDate, 2) > DATE2DMY(TDSDeduction3."Financial Year End Date", 2)) and
            //       (DATE2DMY(TransDate, 3) = DATE2DMY(TDSDeduction3."Financial Year End Date", 3))) then
            //     NotProcessed := true;
            if TransDate > TDSDeduction3."Financial Year End Date" then
                NotProcessed := true;
            if not NotProcessed then begin
                ProcessedSal.RESET();
                ProcessedSal.SETRANGE("Employee Code", TDSDeduction3."Emp ID");
                ProcessedSal.SETRANGE("Pay Slip Month", DATE2DMY(TransDate, 2));
                ProcessedSal.SETRANGE(Year, DATE2DMY(TransDate, 3));
                ProcessedSal.SETRANGE("Add/Deduct", ProcessedSal."Add/Deduct"::Addition);
                ProcessedSal.SETFILTER("Earned Amount", '<>%1', 0);
                if ProcessedSal.FINDFIRST() then begin
                    repeat
                        TDSGrossSal.Reset();
                        TDSGrossSal.SetRange("Emp ID", ProcessedSal."Employee Code");
                        TDSGrossSal.SetRange("Payslip Month", DATE2DMY(TransDate, 2));
                        TDSGrossSal.SetRange("Payslip Year", DATE2DMY(TransDate, 3));
                        TDSGrossSal.SetRange("Financial Year Start Date", "Financial Year Start Date");
                        TDSGrossSal.SetRange("Pay Element Code", ProcessedSal."Add/Deduct Code");
                        if TDSGrossSal.FindFirst() then begin
                            TDSGrossSal.Amount += (ProcessedSal."Earned Amount" + ProcessedSal."Arrear Amount");
                            TDSGrossSal.Modify();
                        end else begin
                            TDSGrossSal.INIT();
                            TDSGrossSal."Emp ID" := ProcessedSal."Employee Code";
                            TDSGrossSal."Payslip Month" := DATE2DMY(TransDate, 2);
                            TDSGrossSal."Payslip Year" := DATE2DMY(TransDate, 3);
                            TDSGrossSal."Pay Element Code" := ProcessedSal."Add/Deduct Code";
                            TDSGrossSal."Financial Year Start Date" := "Financial Year Start Date";
                            TDSGrossSal."Financial Year End Date" := "Financial Year End Date";
                            TDSGrossSal."Add/Deduct" := ProcessedSal."Add/Deduct";
                            TDSGrossSal.Amount := (ProcessedSal."Earned Amount" + ProcessedSal."Arrear Amount");
                            TDSGrossSal.INSERT();
                        end;
                    until ProcessedSal.NEXT() = 0;
                    TransDate := CALCDATE(Text33002Lbl, TransDate);
                end else begin
                    Employee.RESET();
                    Employee.SETRANGE("No.", TDSDeduction3."Emp ID");
                    if Employee.FINDFIRST() then
                        if Employee.Blocked then
                            NotProcessed := true
                        else begin
                            EmpPayElements2.RESET();
                            EmpPayElements2.SETRANGE("Employee Code", TDSDeduction3."Emp ID");
                            if EmpPayElements2.FINDFIRST() then begin
                                repeat
                                    LookupRec2.RESET();
                                    LookupRec2.SETRANGE("LookupType Name", Text33011Lbl);
                                    LookupRec2.SETRANGE("Lookup Name", EmpPayElements2."Pay Element Code");
                                    LookupRec2.SETRANGE("Add/Deduct", LookupRec2."Add/Deduct"::Addition);
                                    if LookupRec2.FINDFIRST() then begin
                                        LookupRec.GET(LookupRec2."Lookup Id", LookupRec2."Lookup Name", LookupRec2."Lookup Type");
                                        LookupRec.MARK(true);
                                    end;
                                until EmpPayElements2.NEXT() = 0;

                                LookupRec.MARKEDONLY(true);
                                if LookupRec.FINDFIRST() then begin
                                    repeat
                                        EmpPayElements.RESET();
                                        EmpPayElements.SETRANGE("Employee Code", TDSDeduction3."Emp ID");
                                        EmpPayElements.SETRANGE("Pay Element Code", LookupRec."Lookup Name");
                                        EmpPayElements.SETRANGE("Add/Deduct", EmpPayElements."Add/Deduct"::Addition);
                                        EmpPayElements.SETFILTER("Effective Start Date", '<=%1', TransDate);
                                        if EmpPayElements.FINDLAST() then begin
                                            TDSGrossSal.INIT();
                                            TDSGrossSal."Emp ID" := EmpPayElements."Employee Code";
                                            TDSGrossSal."Payslip Month" := DATE2DMY(TransDate, 2);
                                            TDSGrossSal."Payslip Year" := DATE2DMY(TransDate, 3);
                                            TDSGrossSal."Pay Element Code" := EmpPayElements."Pay Element Code";
                                            TDSGrossSal."Financial Year Start Date" := "Financial Year Start Date";
                                            TDSGrossSal."Financial Year End Date" := "Financial Year End Date";
                                            TDSGrossSal."Add/Deduct" := EmpPayElements."Add/Deduct";

                                            if EmpPayElements."Fixed/Percent" = EmpPayElements."Fixed/Percent"::Fixed then
                                                TDSGrossSal.Amount := EmpPayElements."Amount / Percent"
                                            else
                                                if EmpPayElements."Fixed/Percent" = EmpPayElements."Fixed/Percent"::Percent then begin
                                                    CLEAR(PercentAmt);
                                                    CLEAR(BasicAmt);
                                                    CLEAR(DAAmt);

                                                    EmpPayElements3.RESET();
                                                    EmpPayElements3.SETRANGE("Employee Code", TDSDeduction3."Emp ID");
                                                    EmpPayElements3.SETFILTER("Effective Start Date", '<=%1', TransDate);
                                                    EmpPayElements3.SETFILTER("Pay Element Code", Text33012Lbl);
                                                    if EmpPayElements3.FINDFIRST() then
                                                        BasicAmt := EmpPayElements3."Amount / Percent";


                                                    EmpPayElements3.RESET();
                                                    EmpPayElements3.SETRANGE("Employee Code", TDSDeduction3."Emp ID");
                                                    EmpPayElements3.SETFILTER("Effective Start Date", '<=%1', TransDate);
                                                    EmpPayElements3.SETFILTER("Pay Element Code", Text33013Lbl);
                                                    if EmpPayElements3.FINDFIRST() then
                                                        if EmpPayElements3."Fixed/Percent" = EmpPayElements3."Fixed/Percent"::Fixed then
                                                            DAAmt := EmpPayElements3."Amount / Percent"
                                                        else
                                                            if EmpPayElements3."Fixed/Percent" = EmpPayElements3."Fixed/Percent"::Percent then
                                                                if EmpPayElements3."Computation Type" = Text33014Lbl then
                                                                    DAAmt += (BasicAmt * EmpPayElements3."Amount / Percent") / 100
                                                                else
                                                                    if EmpPayElements3."Computation Type" = Text33015Lbl then
                                                                        DAAmt += ((DAAmt + BasicAmt) * EmpPayElements3."Amount / Percent") / 100;


                                                    if EmpPayElements."Computation Type" = Text33014Lbl then
                                                        PercentAmt += (BasicAmt * EmpPayElements."Amount / Percent") / 100;
                                                    if EmpPayElements."Computation Type" = Text33015Lbl then
                                                        PercentAmt += ((BasicAmt + DAAmt) * EmpPayElements."Amount / Percent") / 100;

                                                    TDSGrossSal.Amount := PercentAmt;
                                                end;

                                            TDSGrossSal.INSERT();

                                        end;
                                    until LookupRec.NEXT() = 0;
                                    TransDate := CALCDATE(Text33002Lbl, TransDate);
                                end;
                            end;
                        end;
                end;
            end;
        until NotProcessed = true;
        TDSDeductions := TDSDeduction3;
        PerkAmount(TDSDeductions);
        LeaveEncashAmount(TDSDeductions);
        IF TDSDeductions."IT Slab Type" <> TDSDeductions."IT Slab Type"::Option2 THEN BEGIN //TDSOP2
            STAmountCalc(TDSDeductions);
            PTAmount(TDSDeductions);
        END ELSE BEGIN
            TDSDeductions.VALIDATE("PT Amount");
            TDSDeductions.MODIFY;
        END;
    end;

    procedure PerkAmount(var TDSDeduction: Record "TDS Deductions B2B");
    var
        EmpSalAdjLimitsLRec: Record "Employee Sal Adj. Limits B2B";
        PerkAmt: Decimal;
    begin

        CLEAR(PerkAmt);
        EmpSalAdjLimitsLRec.RESET();
        EmpSalAdjLimitsLRec.SETRANGE("Employee Code", TDSDeduction."Emp ID");
        EmpSalAdjLimitsLRec.SETRANGE("Financial Year Start Date", TDSDeduction."Financial Year Start Date");
        EmpSalAdjLimitsLRec.SETRANGE(Perk, true);
        if EmpSalAdjLimitsLRec.FINDFIRST() then
            repeat
                PerkAmt += EmpSalAdjLimitsLRec."Annual Limit";
            until EmpSalAdjLimitsLRec.NEXT() = 0;

        TDSDeduction.Perks := PerkAmt;
        TDSDeduction.MODIFY();
    end;


    procedure LeaveEncashAmount(var TDSDeduction: Record "TDS Deductions B2B");
    var
        PostedLeaveEncashLine: Record "Leave Encashed B2B";
        LeaveAmount: Decimal;
        Checkdate: Date;
    begin
        CLEAR(LeaveAmount);
        PostedLeaveEncashLine.RESET();
        PostedLeaveEncashLine.SETRANGE("Employee Code", TDSDeduction."Emp ID");
        if PostedLeaveEncashLine.FINDFIRST() then
            repeat
                CLEAR(Checkdate);
                Checkdate := DMY2DATE(1, PostedLeaveEncashLine.Month, PostedLeaveEncashLine.Year);
                if (Checkdate >= TDSDeduction."Financial Year Start Date") and (Checkdate <= TDSDeduction."Financial Year End Date") then
                    LeaveAmount := LeaveAmount + PostedLeaveEncashLine."Encash Amount";
            until PostedLeaveEncashLine.NEXT() = 0;
        TDSDeduction."Profit Lieu of Salary" := LeaveAmount;
        TDSDeduction.MODIFY();
    end;

    procedure SurchargeAmount(TDSDeductionLocal: Record "TDS Deductions B2B");
    var
        SurchargeTaxLine: Record "Surcharge Tax Line B2B";
        StopLoop: Boolean;
        Text50001Lbl: Label 'Surcharge Setup %1 not found.', Comment = '%1 =Start date ';
    begin
        CLEAR(StopLoop);
        TDSDeductionLocal.CALCFIELDS("Gross Salary", "Prev. Comp. Gross Salary");
        RepWindow.UPDATE(1, TDSDeductionLocal."Emp ID");
        RepWindow.UPDATE(2, TDSDeductionLocal."Employee Name");


        SurchargeTaxLine.RESET();
        SurchargeTaxLine.SETRANGE("Effective Date", TDSDeductionLocal."Financial Year Start Date");
        if SurchargeTaxLine.FINDSET() then
            repeat
                if (TDSDeductionLocal."Gross Salary" + TDSDeductionLocal."Prev. Comp. Gross Salary") in [SurchargeTaxLine."Income From" .. SurchargeTaxLine."Income To"] then begin
                    TDSDeductionLocal.Surcharge := ROUND((TDSDeductionLocal."Income Tax" * SurchargeTaxLine."Tax %") / 100, 1, '=');
                    TDSDeductionLocal.MODIFY();
                    StopLoop := true;
                end;
            until (SurchargeTaxLine.NEXT() = 0) or StopLoop
        else
            ERROR(Text50001Lbl, TDSDeductionLocal."Financial Year Start Date");

        if not StopLoop then begin
            TDSDeductionLocal.Surcharge := 0;
            TDSDeductionLocal.MODIFY();
        end;
    end;

    procedure STAmountCalc(var TDSDeduction: Record "TDS Deductions B2B");
    var
        ITChapters: Record "IT Chapters B2B";
        IncomeTaxRebateSetup: Record "Income Tax Rebate Setup B2B";
    begin
        ITChapters.RESET();
        ITChapters.SETRANGE("Standard Deduction", true);
        if ITChapters.FINDFIRST() then begin
            IncomeTaxRebateSetup.RESET();
            IncomeTaxRebateSetup.SETRANGE("Section ID", ITChapters."Chapter ID");
            IncomeTaxRebateSetup.SETRANGE("Rebate Year Starting Date", TDSDeduction."Financial Year Start Date");
            if IncomeTaxRebateSetup.FINDFIRST() then begin
                TDSDeduction."ST Deduction" := IncomeTaxRebateSetup."Standard Deduction Amount";
                TDSDeduction.MODIFY();
            end;
        end;
    end;

    procedure PFAmountCal(TDSDeductionLocal: Record "TDS Deductions B2B");
    var
        ProcessedSal1: Record "Processed Salary B2B";
        TDSSavingRec: Record "TDS Savings B2B";
        ExeDedGrp: Record "Exep/Ded Groups B2B";
        EMPTDSGrossSalary: Record "EMP TDS Gross Salary B2B";
        Lookup_B2B: Record Lookup_B2B;
        GrossAmount: Decimal;
        GrossAmount1: Decimal;
        GrossAmount2: Decimal;
        ExpID: Code[20];
        PFGrossSalary: Decimal;
        ProcessDate: Date;
    begin
        //TDSOP2 >>
        IF TDSDeductionLocal."IT Slab Type" = TDSDeductionLocal."IT Slab Type"::Option2 THEN
            EXIT;  //TDSOP2 <<
        RepWindow.UPDATE(1, TDSDeductionLocal."Emp ID");
        RepWindow.UPDATE(2, TDSDeductionLocal."Employee Name");

        GrossSalary := 0;
        Employee.RESET();
        Employee.SETRANGE("No.", TDSDeductionLocal."Emp ID");
        if Employee.FINDFIRST() then
            if (Employee."PF Applicable" = true) then
                TDSDeductionLocal.CALCFIELDS("Gross Salary", "Prev. Comp. Gross Salary")
            else
                exit;

        GrossSalary := (TDSDeductionLocal."Gross Salary" + TDSDeductionLocal."Prev. Comp. Gross Salary");

        EmployeeRec.GET(TDSDeductionLocal."Emp ID");
        if EmployeeRec."Employment Date" > TDSDeductionLocal."Financial Year Start Date" then
            TransDate := EmployeeRec."Employment Date"
        else
            TransDate := TDSDeductionLocal."Financial Year Start Date";

        GrossAmount := 0;
        GrossAmount1 := 0;
        GrossAmount2 := 0;

        ProcessDate := TransDate;
        repeat
            ProcessedSal1.RESET();
            ProcessedSal1.SETRANGE("Employee Code", TDSDeductionLocal."Emp ID");
            ProcessedSal1.SETRANGE("Pay Slip Month", DATE2DMY(ProcessDate, 2));
            ProcessedSal1.SETRANGE(Year, DATE2DMY(ProcessDate, 3));
            ProcessedSal1.SETRANGE("Add/Deduct", ProcessedSal1."Add/Deduct"::Deduction);
            ProcessedSal1.SETRANGE("Add/Deduct Code", Text33016Lbl);
            ProcessedSal1.SETFILTER("Earned Amount", '<>%1', 0);
            if ProcessedSal1.FINDFIRST() then
                GrossAmount1 += (ProcessedSal1."Earned Amount" + ProcessedSal1."Arrear Amount")
            else begin
                CLEAR(PFGrossSalary);
                Lookup_B2B.RESET();
                Lookup_B2B.SETRANGE("Lookup Id", 16);
                Lookup_B2B.SETRANGE(PF, true);
                if Lookup_B2B.FINDSET() then
                    repeat
                        EMPTDSGrossSalary.RESET();
                        EMPTDSGrossSalary.SETRANGE("Emp ID", EmployeeRec."No.");
                        EMPTDSGrossSalary.SETRANGE("Payslip Year", DATE2DMY(ProcessDate, 3));
                        EMPTDSGrossSalary.SETRANGE("Payslip Month", DATE2DMY(ProcessDate, 2));
                        EMPTDSGrossSalary.SETFILTER(Amount, '<>%1', 0);
                        EMPTDSGrossSalary.SETRANGE("Pay Element Code", Lookup_B2B."Lookup Name");
                        if EMPTDSGrossSalary.FINDFIRST() then
                            PFGrossSalary += EMPTDSGrossSalary.Amount;

                    until Lookup_B2B.NEXT() = 0;
                GrossAmount2 += EmpPFAmount(EmployeeRec."No.", PFGrossSalary, TransDate);
            end;
            ProcessDate := CALCDATE(Text33002Lbl, ProcessDate);
        until ProcessDate > TDSDeductionLocal."Financial Year End Date";
        GrossAmount := GrossAmount1 + GrossAmount2;

        CLEAR(ExpID);
        ExeDedGrp.RESET();
        ExeDedGrp.SETRANGE("Pay Element Code", Text33016Lbl);
        if ExeDedGrp.FINDFIRST() then
            ExpID := ExeDedGrp."Exemp / Ded Group Id";

        TDSDeductionLocal."PF Amount" := ROUND(GrossAmount, 1, '=');
        TDSDeductionLocal.VALIDATE("PF Amount");
        TDSDeductionLocal.MODIFY();

        TDSSavingRec.SETRANGE("Emp ID", TDSDeductionLocal."Emp ID");
        TDSSavingRec.SETRANGE("Financial Year Start Date", TDSDeductionLocal."Financial Year Start Date");
        TDSSavingRec.SETRANGE("Exemption Group Id", ExpID);
        if TDSSavingRec.FINDFIRST() then begin
            TDSSavingRec.VALIDATE("Actual Paid", TDSDeductionLocal."PF Amount");
            TDSSavingRec.MODIFY();
        end else begin
            TDSSavingRec.RESET();
            TDSSavingRec.SETRANGE("Emp ID", TDSDeductionLocal."Emp ID");
            TDSSavingRec.SETRANGE("Financial Year Start Date", TDSDeductionLocal."Financial Year Start Date");
            TDSSavingRec.SETRANGE("Financial Year End Date", TDSDeductionLocal."Financial Year End Date");
            TDSSavingRec.INIT();
            TDSSavingRec."Emp ID" := TDSDeductionLocal."Emp ID";
            TDSSavingRec."Financial Year Start Date" := TDSDeductionLocal."Financial Year Start Date";
            TDSSavingRec."Financial Year End Date" := TDSDeductionLocal."Financial Year End Date";
            TDSSavingRec."Exemption Group Id" := ExpID;
            TDSSavingRec."Actual Paid" := TDSDeductionLocal."PF Amount";
            TDSSavingRec.VALIDATE("Actual Paid");
            TDSSavingRec.INSERT();
        end;
    end;

    procedure EmpPFAmount(EmployeeCode: Code[20]; GrossAmount: Decimal; PeriodDate: Date): Decimal;
    var
        EmployeeLocal: Record "Employee B2B";
        HRSetupGRec: Record "HR Setup B2B";
        PF: Record PF_B2B;
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        EPSAmount: Decimal;
        NewGrossAmount: Decimal;
    begin
        HRSetupGRec.GET();
        if HRSetupGRec.Database = HRSetupGRec.Database::IND then
            if PF.FINDFIRST() then
                repeat

                    if GrossAmount < PF."PF Amount" then
                        NewGrossAmount := GrossAmount
                    else
                        NewGrossAmount := PF."PF Amount";

                    if EmployeeLocal.GET(EmployeeCode) then
                        if EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::"Actual Salary" then
                            NewGrossAmount := GrossAmount;


                    if PF."Effective Date" <= PeriodDate then
                        if PF."Rounding Method" = PF."Rounding Method"::Nearest then begin
                            EPSAmount := ROUND((NewGrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '=');
                            EmployerContribution := ROUND((NewGrossAmount * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '=')
                                                      - EPSAmount;
                            EmployeeContribution := ROUND((NewGrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '=');

                        end;
                    if PF."Rounding Method" = PF."Rounding Method"::Up then begin
                        EPSAmount := ROUND((NewGrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '>');
                        EmployerContribution := ROUND((NewGrossAmount * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '>')
                                                  - EPSAmount;
                        EmployeeContribution := ROUND((NewGrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '>');
                    end;
                    if PF."Rounding Method" = PF."Rounding Method"::Down then begin
                        EPSAmount := ROUND((NewGrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '<');
                        EmployerContribution := ROUND((NewGrossAmount * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '<')
                                                  - EPSAmount;
                        EmployeeContribution := ROUND((NewGrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '<');
                    end;
                    if EmployeeLocal."PF Applicability" = EmployeeLocal."PF Applicability"::"Employee Specific" then
                        EmployeeContribution := EmployeeLocal."PF Amount";
                until PF.NEXT() = 0;
        exit(EmployeeContribution);
    end;
}

