page 33001475 "Training Dash Board B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Dash Board';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = "Training Line B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(DepartmentCode1; DepartmentCode)
                {
                    ToolTip = 'Shows the Department Code.';
                    Caption = 'Department Code';
                    TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateFilters();
                    end;
                }
                field(Period1; Period)
                {
                    ToolTip = 'Shows the period of Training.';
                    Caption = 'Period';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PayrollYear.RESET();
                        PayrollYear.SETRANGE("Year Type", Text33001Lbl);
                        PayrollYear.SETRANGE(Closed, false);
                        if PAGE.RUNMODAL(0, PayrollYear) = ACTION::LookupOK then begin
                            Period := FORMAT(DATE2DMY(PayrollYear."Year Start Date", 3)) + ' - ' + FORMAT(DATE2DMY(PayrollYear."Year End Date", 3));
                            StartingDate := PayrollYear."Year Start Date";
                            EndingDate := PayrollYear."Year End Date";
                        end;
                        ShowValues();
                    end;
                }
                field(StartingDate1; StartingDate)
                {
                    ToolTip = 'Shows the Training start date.';
                    Caption = 'Starting Date';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateFilters();
                    end;
                }
                field(EndingDate1; EndingDate)
                {
                    ToolTip = 'Shows the Training End date in Dash board.';
                    Caption = 'Ending Date';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        UpdateFilters();
                    end;
                }
                field(TrainingFacility1; TrainingFacility)
                {
                    ToolTip = 'Specifies the Training Facility.';
                    Caption = 'Training Facility';
                    OptionCaption = ',Internal,External';
                    ApplicationArea = all;
                }
                field(TrainingPremises1; TrainingPremises)
                {
                    ToolTip = 'Specifies the Training Premises.';
                    Caption = 'Training Premises';
                    OptionCaption = ' ,Outside Office,Within Office';
                    ApplicationArea = all;
                }
                field(TrainingType1; TrainingType)
                {
                    ToolTip = 'Specifies the Training Type to be given.';
                    Caption = 'Training Type';
                    TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('TYPE OF TRAINING'));
                    ApplicationArea = all;
                }
                field("Need For Training"; NeedforTraining)
                {
                    ToolTip = 'Shows the Need For Training topic the Dash board.';
                    Caption = 'Training Topic';
                    TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('NEED FOR TRAINING'));
                    ApplicationArea = all;
                }
                field("Classes/Hrs1"; "Classes/Hrs")
                {
                    ToolTip = 'Shows the No. hours.';
                    Caption = 'Classes / Hours';
                    OptionCaption = 'Hrs,Classes';
                    ApplicationArea = all;
                }
            }
            repeater(Control1102154000)
            {
                Editable = false;
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee Employee No.';
                }
                field(Name; Name)
                {
                    ToolTip = 'Shows the name of the Employees.';
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    ToolTip = 'Shows the Middle name of the Employee.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Shows the Department code.';
                    ApplicationArea = all;
                }
                field(Values1; Values)
                {
                    ToolTip = 'Shows the Values of Training.';
                    BlankZero = true;
                    Caption = 'Hrs';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        ShowValues();
    end;

    trigger OnOpenPage();
    begin
        UpdateFilters();
    end;

    var
        PayrollYear: Record "Payroll Year B2B";
        NeedforTraining: Text[30];
        StartingDate: Date;
        EndingDate: Date;
        TrainingFacility: Option " ",Internal,External;
        TrainingPremises: Option " ","Outside Office","Within Office";
        TrainingType: Text[30];
        Period: Code[20];
        Values: Decimal;
        DepartmentCode: Code[20];
        "Classes/Hrs": Option Hrs,Classes;
        Text33001Lbl: Label 'FINANCIAL YEAR';

    procedure ShowValues();
    begin
    end;

    procedure UpdateFilters();
    begin
        RESET();
        if DepartmentCode <> '' then
            SETRANGE("Department Code", DepartmentCode);
        if TrainingFacility <> TrainingFacility::" " then
            SETRANGE("Training Facility", TrainingFacility - 1);
        if TrainingPremises <> TrainingPremises::" " then
            SETRANGE("Training Premises", TrainingPremises - 1);
        if TrainingType <> '' then
            SETRANGE("Training Type", TrainingType);
        if NeedforTraining <> '' then
            SETRANGE("Need  for Training", NeedforTraining);
        if StartingDate <> 0D then
            SETRANGE("From Date", StartingDate);
        CurrPage.UPDATE(false);
    end;
}

