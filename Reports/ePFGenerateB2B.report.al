report 33001222 "e-PF Generate B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\e-PF Generate.rdl';
    Caption = 'e-PF Generate';
    UseRequestPage = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") WHERE(Blocked = FILTER(false), "Stop Payment" = FILTER(false), "PF Applicable" = FILTER(true));
            RequestFilterFields = "No.";
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(P_F__STATEMENT_FOR_THE_MONTH_OF_____FORMAT_MonthName________FORMAT_YearValue_; 'P.F. STATEMENT FOR THE MONTH OF' + '' + FORMAT(MonthNameGVar) + ',  ' + FORMAT(YearValueGVar))
            {
            }
            column(TotalBasicAmt; TotalBasicAmt)
            {
            }
            column(TotalEmpShare; TotalEmpShare)
            {
            }
            column(TotalEPF; TotalEPF)
            {
            }
            column(TotalEPS; TotalEPS)
            {
            }
            column(TotalPFBasic; TotalPFBasic)
            {
            }
            column(SL_No_Caption; SL_No_CaptionLbl)
            {
            }
            column(Basic_Caption; Basic_CaptionLbl)
            {
            }
            column(PF___12_Caption; PF___12_CaptionLbl)
            {
            }
            column(EPFCaption; EPFCaptionLbl)
            {
            }
            column(EPS__Caption; EPS__CaptionLbl)
            {
            }
            column(PF_No_Caption; PF_No_CaptionLbl)
            {
            }
            column(Employer_TotalCaption; Employer_TotalCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Payable_DaysCaption; Payable_DaysCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }
            dataitem("Processed Salary"; "Processed Salary B2B")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Employee Code", "Pay Slip Month", Year, "Line No.");
                column(SlNo; SlNo)
                {
                }
                column(Employee_B2B__PF_No_; "Employee B2B"."PF No")
                {
                }
                column(Employee_B2B__First_Name__Employee_B2B__Middle_Name__Employee_B2B__Last_Name_; "Employee B2B"."First Name" + "Employee B2B"."Middle Name" + "Employee B2B"."Last Name")
                {
                }
                column(PayableDays; PayableDays)
                {
                }
                column(BasicAmt; BasicAmt)
                {
                }
                column(PFAmt; PFAmt)
                {
                }
                column(EPF; EPF)
                {
                }
                column(EPS; EPS)
                {
                }
                column(PFAmt_Control1102152021; PFAmt)
                {
                }
                column(Processed_Salary_Document_Type; "Document Type")
                {
                }
                column(Processed_Salary_Employee_Code; "Employee Code")
                {
                }
                column(Processed_Salary_Pay_Slip_Month; "Pay Slip Month")
                {
                }
                column(Processed_Salary_Year; Year)
                {
                }
                column(Processed_Salary_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    case "Add/Deduct Code" of
                        BASICTxt:
                            BasicAmt := BasicAmt + "Earned Amount";
                        ARREARSBASICTxt:
                            BasicAmt := BasicAmt + "Earned Amount";
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Pay Slip Month", MonthValue);
                    SETRANGE(Year, YearValueGVar);
                    BasicAmt := 0;
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(FileName; FileNameGVar)
                    {
                        ToolTip = 'Choose the File Name.';
                        AssistEdit = true;
                        Caption = 'File Name';
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field(TANLocation; TANLocationGVar)
                    {
                        ToolTip = 'Choose the Company TAN of the location.';
                        Caption = 'T.A.N. Location';
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field(CurrentQuarter; CurrentQuarterGVar)
                    {
                        ToolTip = 'Choose the Quarter for which Report need to generate';
                        Caption = 'Report Frequency';
                        OptionCaption = ' ,Q1,Q2,Q3,Q4';
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field(FinancialYear; FinancialYearGVar)
                    {
                        ToolTip = 'Choose the Financial year';
                        Caption = 'Financial Year';
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field(PersonName; PersonNameGVar)
                    {
                        ToolTip = 'Choose the name of the Employee.';
                        Caption = 'Full Name';
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field(Designation; DesignationGVar)
                    {
                        ToolTip = 'Choose the Designation of the employee.';
                        Caption = '"Designation "';
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field(CreationDate; CreationDateGVar)
                    {
                        Caption = 'Printing Date';
                        Visible = false;
                        ApplicationArea = all;
                        ToolTip = 'Specifies The Printing Date';
                    }
                    field(NameofReturnPrepUtility; NameofReturnPrepUtilityGVar)
                    {
                        Caption = 'Name of Return Preparation Utility';
                        Visible = false;
                        ApplicationArea = all;
                        ToolTip = 'Specifies The preparation utility';
                    }
                    field(MonthName; MonthNameGVar)
                    {
                        ToolTip = 'Choose the Month from the drop down.';
                        Caption = 'MonthName';
                        OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
                        ApplicationArea = all;
                    }
                    field(YearValue; YearValueGVar)
                    {
                        ToolTip = 'Choose the year';
                        Caption = 'YearValue';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    var

    begin
        /*
        if FileOpened then
            OutFile.Close(); //SG
            */
    end;

    trigger OnPreReport();
    var
    begin
        case MonthNameGVar of
            1:
                MonthValue := 1;
            2:
                MonthValue := 2;
            3:
                MonthValue := 3;
            4:
                MonthValue := 4;
            5:
                MonthValue := 5;
            6:
                MonthValue := 6;
            7:
                MonthValue := 7;
            8:
                MonthValue := 8;
            9:
                MonthValue := 9;
            10:
                MonthValue := 10;
            11:
                MonthValue := 11;
            12:
                MonthValue := 12;
        end;

        if MonthValue = 0 then
            ERROR(Text16525Txt);
        if YearValueGVar = 0 then
            ERROR(Text16525Txt);

        CompanyInfo.GET();

        Employee.SETRANGE("No.", "Employee B2B"."No.");
        NoOfBatchs := Employee.COUNT();
        SequenceNo := 1;
    end;

    var
        Employee: Record "Employee B2B";
        CompanyInfo: Record "Company Information";
        OStream: OutStream;
        SequenceNo: Integer;
        NoOfBatchs: Integer;
        PersonNameGVar: Text[75];
        DesignationGVar: Text[30];

        FileNameGVar: Text[250];
        FinancialYearGVar: Code[6];
        TANLocationGVar: Code[10];
        CurrentQuarterGVar: Option " ",Q1,Q2,Q3,Q4;
        CreationDateGVar: Date;
        CalledFromY: Boolean;

        NameofReturnPrepUtilityGVar: Text[75];
        Text16525Txt: Label 'Enter Month';
        MonthNameGVar: Option " ",January,February,March,April,May,June,July,August,September,October,November,December;
        MonthValue: Option;
        YearValueGVar: Integer;
        SlNo: Integer;
        BasicAmt: Decimal;
        EPF: Decimal;
        EPS: Decimal;
        TotalEmpShare: Decimal;
        TotalEPF: Decimal;
        TotalEPS: Decimal;
        TotalBasicAmt: Decimal;
        PFAmt: Decimal;
        TotalPFBasic: Decimal;
        PayableDays: Integer;
        SL_No_CaptionLbl: Label 'SL No.';
        Basic_CaptionLbl: Label '"Basic "';
        PF___12_CaptionLbl: Label 'PF @ 12%';
        EPFCaptionLbl: Label 'EPF';
        EPS__CaptionLbl: Label 'EPS %';
        PF_No_CaptionLbl: Label 'PF No.';
        Employer_TotalCaptionLbl: Label 'Employer Total';
        NameCaptionLbl: Label 'Name';
        Payable_DaysCaptionLbl: Label 'Payable Days';
        TotalCaptionLbl: Label 'Total';
        BASICTxt: Label 'BASIC';
        ARREARSBASICTxt: Label 'ARREARS-BASIC';
        Text330001Txt: Label '194LA';


    local procedure WriteToStream(var FieldText: array[100] of Text[250]; FieldCount: Integer);
    var
        x: Integer;
    begin
        for x := 1 to FieldCount do
            if FieldText[x] <> '' then
                OStream.WRITETEXT(FieldText[x]);
        OStream.WRITETEXT();
    end;

    local procedure GetSection(Section: Option "194C","194G","194J","194A","194I","194","193","194B","194D","194EE","194F","194H","194K","194L","194BB","194E","195","196A","196B","196C","196D"): Text[3];
    begin
        if STRLEN(FORMAT(Section)) = 3 then
            exit(FORMAT(Section));
        if FORMAT(Section) = Text330001Txt then
            exit(FORMAT(Section));
        exit(COPYSTR(FORMAT(Section), STRLEN(FORMAT(Section)) - 2, 3));
    end;

    procedure SetProperties(NewFileName: Text[250]; NewTANLocation: Code[10]; NewCurrentQuarter: Option; NewFinancialYear: Code[6]; NewPersonName: Text[30]; NewDesignation: Text[30]; NewCreationDate: Date; NewCalledFromY: Boolean);
    begin
        TANLocationGVar := NewTANLocation;
        CurrentQuarterGVar := NewCurrentQuarter;
        FinancialYearGVar := NewFinancialYear;
        PersonNameGVar := NewPersonName;
        DesignationGVar := NewDesignation;
        CreationDateGVar := NewCreationDate;
        CalledFromY := NewCalledFromY;
    end;
}

