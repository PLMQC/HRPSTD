page 33001192 "LookUps B2B"
{
    // version B2BHR1.00.00

    Caption = 'LookUps-B2B';
    DelayedInsert = true;
    MultipleNewLines = false;
    PageType = Worksheet;
    SourceTable = Lookup_B2B;
    UsageCategory = Tasks;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field(TemplateNameGlobal1; TemplateNameGlobal)
            {
                Caption = 'LookUp Type';
                Importance = Promoted;
                ApplicationArea = all;
                ToolTip = 'Specifies the Lookup type.';
                trigger OnValidate()
                begin
                    if TemplateNameGlobal <> '' then begin
                        LookUpType.RESET();
                        LookUpType.SETRANGE(Name, TemplateNameGlobal);
                        LookUpType.FINDFIRST();
                        TemplateNumber := LookUpType."No.";
                    end else
                        TemplateNumber := 0;

                    SetControlsAppearance();
                    SETRANGE("Lookup Type", TemplateNumber);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnLookup(var Text: Text): Boolean;
                var
                    LookupTypesPage: Page 33001191;
                begin
                    LookUpType.RESET();
                    CLEAR(LookupTypesPage);
                    LookupTypesPage.LOOKUPMODE(TRUE);
                    LookupTypesPage.SETTABLEVIEW(LookUpType);
                    IF LookupTypesPage.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                        LookupTypesPage.GETRECORD(LookUpType);
                        TemplateNumber := LookUpType."No.";
                        TemplateNameGlobal := LookUpType.Name;
                    END;
                    SetControlsAppearance();
                    SETRANGE("Lookup Type", TemplateNumber);
                    CurrPage.UPDATE(FALSE);
                end;
            }
            repeater(SkillSetColums)
            {
                Caption = 'SkillSetColums';
                Editable = true;
                Enabled = true;
                Visible = SkillsetColumnsVisible;
                field("Lookup Name"; "Lookup Name")
                {
                    Caption = 'Lookup Name';
                    ToolTip = 'Specifies the applicable Look Name';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        "Lookup Type" := TemplateNumber;
                        "LookupType Name" := TemplateNameGlobal;
                        Lookup_B2B.SETRANGE("LookupType Name", TemplateNameGlobal);
                        if Lookup_B2B.FINDFIRST() then
                            repeat
                                if "Lookup Name" = Lookup_B2B."Lookup Name" then
                                    ERROR(Text001Lbl, "Lookup Name");

                            until Lookup_B2B.NEXT() = 0;

                    end;
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the applicable Look Description associated with Lookup Name.';
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ToolTip = 'Specifies the Working Note / Remark for the said Lookup name and Description.';
                    ApplicationArea = all;
                }
            }
            repeater(ADDandDEDUColumns)
            {
                Caption = 'ADDandDEDUColumns';
                Visible = ADDandDEDUColumnsVisible;
                field("Lookup NameAddDeduc"; "Lookup Name")
                {
                    Caption = 'Lookup Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Lookup Addition/Deduction.';
                    trigger OnValidate();
                    begin
                        "Lookup Type" := TemplateNumber;
                        "LookupType Name" := TemplateNameGlobal;
                        Lookup_B2B.SETRANGE("LookupType Name", TemplateNameGlobal);
                        if Lookup_B2B.FINDFIRST() then
                            repeat
                                if "Lookup Name" = Lookup_B2B."Lookup Name" then
                                    ERROR(Text001Lbl, "Lookup Name");

                            until Lookup_B2B.NEXT() = 0;
                    end;
                }
                field(DescriptionAddDedu; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Lookup description.';
                }
                field("Add/Deduct"; "Add/Deduct")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Add/Deduct';
                }
                field("Applicable for OT"; "Applicable for OT")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Applicable for OT in Employee master.';
                }
                field(ESI; ESI)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ESI Details.';
                }
                field(PF; PF)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the PF Details.';
                }
                field("Leave Encashment"; "Leave Encashment")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Leave Encashment details.';
                }
                field(Priority; Priority)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Priority details.';
                }
                field("Payroll Prod. Posting Group"; "Payroll Prod. Posting Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Product posting groups for posting purpose.';
                }
                field("Bonus/Exgratia"; "Bonus/Exgratia")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Bonus/Exgratia details.';
                }
                field(Gratuity; Gratuity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Gratuity details.';
                }
                field(PT; PT)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee PT details.';
                }
                field("Applicable for C Off"; "Applicable for C Off")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee applicable for C Off details.';
                }
                field("Print in Payslip"; "Print in Payslip")
                {
                    ApplicationArea = all;
                }
                field("Show Priority"; "Show Priority")
                {
                    ApplicationArea = all;
                }
                field("Print in Payregister"; "Print in Payregister")
                {
                    ApplicationArea = all;
                }

                field(RemarksAdd; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Ramark details for Employee from HR department.';
                }
            }
            repeater(LoanTypesColumns)
            {
                Caption = 'LoanTypesColumns';
                Visible = LoanTypesColumnsVisible;
                field("Lookup NameLoanTypes"; "Lookup Name")
                {
                    Caption = 'Lookup Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Loan type Colums.';

                    trigger OnValidate();
                    begin
                        "Lookup Type" := TemplateNumber;
                        "LookupType Name" := TemplateNameGlobal;
                        Lookup_B2B.SETRANGE("LookupType Name", TemplateNameGlobal);
                        if Lookup_B2B.FINDFIRST() then
                            repeat
                                if "Lookup Name" = Lookup_B2B."Lookup Name" then
                                    ERROR(Text001Lbl, "Lookup Name");

                            until Lookup_B2B.NEXT() = 0;

                    end;
                }
                field(DescriptionLoan; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Description details.';
                }
                field(Grade; Grade)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee grade details.';
                }
                field("All Grades"; "All Grades")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee all grade details.';
                }
                field("Max.Amt.Type"; "Max.Amt.Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Grade wise amount limit details.';
                }
                field("Max.Amt"; "Max.Amt")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Maximum amount details.';
                }
                field("Max.No. of instalments"; "Max.No. of instalments")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Loan Max.No. Of instalments detail.';
                }
                field("Loan Priority No."; "Loan Priority No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Loan priority No.';
                }
                field(RemarksLoanTypes; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Remarks in Lookup type.';
                }
            }
            repeater(PayrollYearsColumns)
            {
                Caption = 'PayrollYearsColumns';
                Visible = PayrollYearsColumnsVisible;
                field("Lookup Namepayroll"; "Lookup Name")
                {
                    Caption = 'Lookup Name';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Payroll year details.';

                    trigger OnValidate();
                    begin
                        "Lookup Type" := TemplateNumber;
                        "LookupType Name" := TemplateNameGlobal;
                        Lookup_B2B.SETRANGE("LookupType Name", TemplateNameGlobal);
                        if Lookup_B2B.FINDFIRST() then
                            repeat
                                if "Lookup Name" = Lookup_B2B."Lookup Name" then
                                    ERROR(Text001Lbl, "Lookup Name");

                            until Lookup_B2B.NEXT() = 0;

                    end;
                }
                field(DescriptionPayyears; Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Description details.';
                }
                field(RemarksPayrollyears; Remarks)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Remarks detail.';
                }
            }
            repeater(ComputationTypeColumns)
            {
                Caption = 'ComputationTypeColumns';
                Visible = ComputationTypeColumnsVisible;

                field("Lookup Namecomputu"; "Lookup Name")
                {
                    Caption = 'Lookup Name';
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Payelement computation details.';

                    trigger OnValidate();
                    begin
                        "Lookup Type" := TemplateNumber;
                        "LookupType Name" := TemplateNameGlobal;
                        Lookup_B2B.SETRANGE("LookupType Name", TemplateNameGlobal);
                        if Lookup_B2B.FINDFIRST() then
                            repeat
                                if "Lookup Name" = Lookup_B2B."Lookup Name" then
                                    ERROR(Text001Lbl, "Lookup Name");

                            until Lookup_B2B.NEXT() = 0;

                    end;
                }
                field(DescriptionCompution; Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Description of Compution.';
                }
                field(RemarksCompu; Remarks)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Remarks in  Lookupups.';
                }
            }
            repeater(PayCadreColumns)
            {
                Caption = 'PayCadreColumns';
                Visible = PayCadreColumnsVisible;
                field("Lookup NamePaycadre"; "Lookup Name")
                {
                    Caption = 'Lookup Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Paycadre details.';

                    trigger OnValidate();
                    begin
                        "Lookup Type" := TemplateNumber;
                        "LookupType Name" := TemplateNameGlobal;
                        Lookup_B2B.SETRANGE("LookupType Name", TemplateNameGlobal);
                        if Lookup_B2B.FINDFIRST() then
                            repeat
                                if "Lookup Name" = Lookup_B2B."Lookup Name" then
                                    ERROR(Text001Lbl, "Lookup Name");

                            until Lookup_B2B.NEXT() = 0;

                    end;
                }
                field(DescriptionPaycadre; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Description details.';
                }
                field("Period Start Date"; "Period Start Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Period start date details.';
                }
                field("Period End Date"; "Period End Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Period end date details.';
                }
                field("Incentive Applicable"; "Incentive Applicable")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Incentive applicable details.';
                }
                field(Probation; Probation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Probation details.';
                }
                field("Probation Period"; "Probation Period")
                {
                    ApplicationArea = all;
                }
                field(RemarksPaycadre; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Paycadre remark details.';
                }
            }
            repeater(OutStationColumns)
            {
                Caption = 'OutStationColumns';
                Visible = OutStationColumnsVisible;
                field("Lookup NameOUTStation"; "Lookup Name")
                {
                    Caption = 'Lookup Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Lookup name .';

                    trigger OnValidate();
                    begin
                        "Lookup Type" := TemplateNumber;
                        "LookupType Name" := TemplateNameGlobal;
                        Lookup_B2B.SETRANGE("LookupType Name", TemplateNameGlobal);
                        if Lookup_B2B.FINDFIRST() then
                            repeat
                                if "Lookup Name" = Lookup_B2B."Lookup Name" then
                                    ERROR(Text001Lbl, "Lookup Name");

                            until Lookup_B2B.NEXT() = 0;

                    end;
                }
                field(Descriptionoutsta; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Lookup Description.';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Amount details.';
                }
                field(RemarksOutstation; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Remark detail.';
                }
            }
            repeater(OTGroupsColumns)
            {
                Caption = 'OTGroupsColumns';
                Visible = OTGroupsColumnsVisible;
                field("Lookup NameOTGrou"; "Lookup Name")
                {
                    Caption = 'Lookup Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the OT details.';

                    trigger OnValidate();
                    begin
                        "Lookup Type" := TemplateNumber;
                        "LookupType Name" := TemplateNameGlobal;
                        Lookup_B2B.SETRANGE("LookupType Name", TemplateNameGlobal);
                        if Lookup_B2B.FINDFIRST() then
                            repeat
                                if "Lookup Name" = Lookup_B2B."Lookup Name" then
                                    ERROR(Text001Lbl, "Lookup Name");

                            until Lookup_B2B.NEXT() = 0;

                    end;
                }
                field(DescriptionOTgroups; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Description details.';
                }
                field("Computed Gross OT %"; "Computed Gross OT %")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Gross OT details.';
                }
                field(RemarksOTGroup; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Remarks Detail.';
                }
            }
            repeater(GenaralColumns)
            {
                Caption = 'GenaralColumns';
                Visible = GenaralColumnsVisible;
                field("Lookup NameGenaral"; "Lookup Name")
                {
                    Caption = 'Lookup Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Lookup Name.';

                    trigger OnValidate();
                    begin
                        "Lookup Type" := TemplateNumber;
                        "LookupType Name" := TemplateNameGlobal;
                        Lookup_B2B.SETRANGE("LookupType Name", TemplateNameGlobal);
                        if Lookup_B2B.FINDFIRST() then
                            repeat
                                if "Lookup Name" = Lookup_B2B."Lookup Name" then
                                    ERROR(Text001Lbl, "Lookup Name");

                            until Lookup_B2B.NEXT() = 0;

                    end;
                }
                field(DescriptionGeneral; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Lookup Description.';
                }
                field("Designation Pay Cader"; Rec."Designation Pay Cader")
                {
                    ApplicationArea = all;
                }
                field(RemarksGenaral; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Remarks detail.';
                }
                field(Priority2; Priority)
                {
                    Caption = 'Priority';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Priorty Detail.';
                }
            }
            repeater(PerformanceRatingScale)
            {
                Caption = 'PerformanceRatingScale';
                Visible = PerformanceRatingScaleVisible;
                field("Lookup NamePerformance"; "Lookup Name")
                {
                    Caption = 'Lookup Name';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Performance rating scale details.';

                    trigger OnValidate();
                    begin
                        "Lookup Type" := TemplateNumber;
                        "LookupType Name" := TemplateNameGlobal;
                        Lookup_B2B.SETRANGE("LookupType Name", TemplateNameGlobal);
                        if Lookup_B2B.FINDFIRST() then
                            repeat
                                if "Lookup Name" = Lookup_B2B."Lookup Name" then
                                    ERROR(Text001Lbl, "Lookup Name");

                            until Lookup_B2B.NEXT() = 0;

                    end;
                }
                field(DescriptionPerformance; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Description of Performance .';
                }
                field("Performance Scale Value"; "Performance Scale Value")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Performance scale value.';
                }
                field(RemarksPerformance; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Remarks Detail.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                action("Define &Pay Elements")
                {
                    Caption = 'Define &Pay Elements';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Pay Cadre Pay Elements B2B";
                    RunPageLink = "Pay Cadre Code" = FIELD("Lookup Name");
                    Visible = DefinePayEleVisisble;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Define pay elements detail.';
                }
            }
            group(Payyear)
            {
                Caption = 'Payroll &Years';
                action("Payroll &Year List")
                {
                    Caption = 'Payroll &Year List';
                    Image = Calendar;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Payroll Years B2B";
                    RunPageLink = "Year Type" = FIELD("Lookup Name");
                    Visible = PayYearVisible2;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Payroll Year list details.';
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        "Lookup Type" := TemplateNumber;
    end;

    trigger OnOpenPage();
    begin
        TemplateNumber := 1;
        TemplateNameGlobal := Text002Lbl;
        SETRANGE("Lookup Type", 1);
        SkillsetColumnsVisible := true;
        ADDandDEDUColumnsVisible := false;
        LoanTypesColumnsVisible := false;
        PayrollYearsColumnsVisible := false;
        ComputationTypeColumnsVisible := false;
        PayCadreColumnsVisible := false;
        OutStationColumnsVisible := false;
        OTGroupsColumnsVisible := false;
        GenaralColumnsVisible := false;
        PayYearVisible2 := false;
        DefinePayEleVisisble2 := false;
        PerformanceRatingScaleVisible := false;
        PayyearVisible := false;
        DefinePayEleVisisble := false;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        Lookup_B2B.SETRANGE("LookupType Name", Text003Lbl);
        if Lookup_B2B.FINDFIRST() then
            repeat
                Lookup_B2B.TESTFIELD("Period Start Date");
                Lookup_B2B.TESTFIELD(Lookup_B2B."Period End Date");
            until Lookup_B2B.NEXT() = 0;
    end;

    procedure SetControlsAppearance()
    begin
        if TemplateNameGlobal = Text002Lbl then begin
            SkillsetColumnsVisible := true;
            ADDandDEDUColumnsVisible := false;
            LoanTypesColumnsVisible := false;
            PayrollYearsColumnsVisible := false;
            ComputationTypeColumnsVisible := false;
            PayCadreColumnsVisible := false;
            OutStationColumnsVisible := false;
            OTGroupsColumnsVisible := false;
            GenaralColumnsVisible := false;
            PerformanceRatingScaleVisible := false;
        end else
            SkillsetColumnsVisible := false;
        if TemplateNameGlobal = Text004Lbl then begin
            SkillsetColumnsVisible := false;
            ADDandDEDUColumnsVisible := true;
            LoanTypesColumnsVisible := false;
            PayrollYearsColumnsVisible := false;
            ComputationTypeColumnsVisible := false;
            PayCadreColumnsVisible := false;
            OutStationColumnsVisible := false;
            OTGroupsColumnsVisible := false;
            GenaralColumnsVisible := false;
            PerformanceRatingScaleVisible := false;
        end else
            ADDandDEDUColumnsVisible := false;
        if TemplateNameGlobal = Text005Lbl then begin
            SkillsetColumnsVisible := false;
            ADDandDEDUColumnsVisible := false;
            LoanTypesColumnsVisible := true;
            PayrollYearsColumnsVisible := false;
            ComputationTypeColumnsVisible := false;
            PayCadreColumnsVisible := false;
            OutStationColumnsVisible := false;
            OTGroupsColumnsVisible := false;
            GenaralColumnsVisible := false;
            PerformanceRatingScaleVisible := false;
        end else
            LoanTypesColumnsVisible := false;

        if TemplateNameGlobal = Text006Lbl then begin
            SkillsetColumnsVisible := false;
            ADDandDEDUColumnsVisible := false;
            LoanTypesColumnsVisible := false;
            PayrollYearsColumnsVisible := true;
            ComputationTypeColumnsVisible := false;
            PayCadreColumnsVisible := false;
            OutStationColumnsVisible := false;
            OTGroupsColumnsVisible := false;
            GenaralColumnsVisible := false;
            PerformanceRatingScaleVisible := false;
        end else
            PayrollYearsColumnsVisible := false;

        if TemplateNameGlobal = Text006Lbl then
            PayYearVisible2 := true
        else
            PayYearVisible2 := false;

        if TemplateNameGlobal = Text007Lbl then begin
            SkillsetColumnsVisible := false;
            ADDandDEDUColumnsVisible := false;
            LoanTypesColumnsVisible := false;
            PayrollYearsColumnsVisible := false;
            ComputationTypeColumnsVisible := true;
            PayCadreColumnsVisible := false;
            OutStationColumnsVisible := false;
            OTGroupsColumnsVisible := false;
            GenaralColumnsVisible := false;
            PerformanceRatingScaleVisible := false;
        end else
            ComputationTypeColumnsVisible := false;

        if TemplateNameGlobal = Text003Lbl then begin
            SkillsetColumnsVisible := false;
            ADDandDEDUColumnsVisible := false;
            LoanTypesColumnsVisible := false;
            PayrollYearsColumnsVisible := false;
            ComputationTypeColumnsVisible := false;
            PayCadreColumnsVisible := true;
            OutStationColumnsVisible := false;
            OTGroupsColumnsVisible := false;
            GenaralColumnsVisible := false;
            PerformanceRatingScaleVisible := false;
        end else
            PayCadreColumnsVisible := false;

        if TemplateNameGlobal = Text003Lbl then
            DefinePayEleVisisble := true
        else
            DefinePayEleVisisble := false;

        if TemplateNameGlobal = Text008Lbl then begin
            SkillsetColumnsVisible := false;
            ADDandDEDUColumnsVisible := false;
            LoanTypesColumnsVisible := false;
            PayrollYearsColumnsVisible := false;
            ComputationTypeColumnsVisible := false;
            PayCadreColumnsVisible := false;
            OutStationColumnsVisible := true;
            OTGroupsColumnsVisible := false;
            GenaralColumnsVisible := false;
            PerformanceRatingScaleVisible := false;
        end else
            OutStationColumnsVisible := false;

        if TemplateNameGlobal = Text009Lbl then begin
            SkillsetColumnsVisible := false;
            ADDandDEDUColumnsVisible := false;
            LoanTypesColumnsVisible := false;
            PayrollYearsColumnsVisible := false;
            ComputationTypeColumnsVisible := false;
            PayCadreColumnsVisible := false;
            OutStationColumnsVisible := false;
            OTGroupsColumnsVisible := true;
            GenaralColumnsVisible := false;
            PerformanceRatingScaleVisible := false;
        end else
            OTGroupsColumnsVisible := false;

        if TemplateNameGlobal = Text0010Lbl then begin
            SkillsetColumnsVisible := false;
            ADDandDEDUColumnsVisible := false;
            LoanTypesColumnsVisible := false;
            PayrollYearsColumnsVisible := false;
            ComputationTypeColumnsVisible := false;
            PayCadreColumnsVisible := false;
            OutStationColumnsVisible := false;
            OTGroupsColumnsVisible := false;
            GenaralColumnsVisible := false;
            PerformanceRatingScaleVisible := true;
        end else
            PerformanceRatingScaleVisible := false;

        if not (TemplateNameGlobal in [Text009Lbl, Text008Lbl, Text003Lbl, Text007Lbl, Text006Lbl, Text005Lbl,
                            Text004Lbl, Text002Lbl, Text0010Lbl]) then begin
            SkillsetColumnsVisible := false;
            ADDandDEDUColumnsVisible := false;
            LoanTypesColumnsVisible := false;
            PayrollYearsColumnsVisible := false;
            ComputationTypeColumnsVisible := false;
            PayCadreColumnsVisible := false;
            OutStationColumnsVisible := false;
            OTGroupsColumnsVisible := false;
            GenaralColumnsVisible := true;
            PerformanceRatingScaleVisible := false;
        end else
            GenaralColumnsVisible := false;

    end;

    var
        LookUpType: Record "Lookup Type B2B";
        Lookup_B2B: Record Lookup_B2B;

        TemplateNameGlobal: Code[50];
        TemplateNumber: Integer;
        [InDataSet]
        // "Add/DeductVisible": Boolean;
        // [InDataSet]
        // "Applicable for OTVisible": Boolean;
        // [InDataSet]
        // ESIVisible: Boolean;
        // [InDataSet]
        // PFVisible: Boolean;
        // [InDataSet]
        // PriorityVisible: Boolean;
        // [InDataSet]
        // "Leave EncashmentVisible": Boolean;
        // [InDataSet]
        // PayrollProdPostingGroupVisible: Boolean;
        // [InDataSet]
        // "Bonus/ExgratiaVisible": Boolean;
        // [InDataSet]
        // GratuityVisible: Boolean;
        // [InDataSet]
        // PTVisible: Boolean;
        // [InDataSet]
        // "Applicable for C OffVisible": Boolean;
        // [InDataSet]
        // "Loan Priority No.Visible": Boolean;
        // [InDataSet]
        // GradeVisible: Boolean;
        // [InDataSet]
        // "Max.AmtVisible": Boolean;
        // [InDataSet]
        // "Max.No. of instalmentsVisible": Boolean;
        // [InDataSet]
        // "All GradesVisible": Boolean;
        // [InDataSet]
        // "Max.Amt.TypeVisible": Boolean;
        [InDataSet]
        PayyearVisible: Boolean;
        // [InDataSet]
        // "Period Start DateVisible": Boolean;
        // [InDataSet]
        // "Period End DateVisible": Boolean;
        // [InDataSet]
        // FunctionsVisible: Boolean;
        // [InDataSet]
        // "Min SalaryVisible": Boolean;
        // [InDataSet]
        // "Incentive ApplicableVisible": Boolean;
        // [InDataSet]
        // "Lookup NameVisible": Boolean;
        // [InDataSet]
        // DescriptionVisible: Boolean;
        // [InDataSet]
        // AmountVisible: Boolean;
        // [InDataSet]
        // "Computed Gross OT %Visible": Boolean;
        // [InDataSet]
        // "Lookup NameEditable": Boolean;
        // [InDataSet]
        // DescriptionEditable: Boolean;
        // [InDataSet]
        // RemarksEditable: Boolean;
        // [InDataSet]
        // "Bonus AdjustVisible": Boolean;
        // [InDataSet]
        // loanpri: Boolean;
        // [InDataSet]
        // TrainingTypeVisible: Boolean;
        [InDataSet]
        SkillsetColumnsVisible: Boolean;
        [InDataSet]
        ADDandDEDUColumnsVisible: Boolean;
        [InDataSet]
        LoanTypesColumnsVisible: Boolean;
        [InDataSet]
        PayrollYearsColumnsVisible: Boolean;
        [InDataSet]
        ComputationTypeColumnsVisible: Boolean;
        [InDataSet]
        PayCadreColumnsVisible: Boolean;
        [InDataSet]
        OutStationColumnsVisible: Boolean;
        [InDataSet]
        OTGroupsColumnsVisible: Boolean;
        [InDataSet]
        GenaralColumnsVisible: Boolean;
        [InDataSet]
        PayYearVisible2: Boolean;
        [InDataSet]
        DefinePayEleVisisble2: Boolean;
        //Text000Lbl: Label 'Lookup types are not defined';
        [InDataSet]
        PerformanceRatingScaleVisible: Boolean;
        [InDataSet]
        DefinePayEleVisisble: Boolean;
        Text001Lbl: Label '%1 is already exists', Comment = '%1 = Lookup name';
        Text002Lbl: Label 'SKILL SET';
        Text003Lbl: Label 'PAY CADRE';
        Text004Lbl: Label 'ADDITIONS AND DEDUCTIONS';
        Text005Lbl: Label 'LOAN TYPES';
        Text006Lbl: Label 'PAYROLL YEARS';
        Text007Lbl: Label 'COMPUTATION TYPE';
        Text008Lbl: Label 'OUT STATION ALLOWANCE';
        Text009Lbl: Label 'OT GROUPS';
        Text0010Lbl: Label 'PERFORMANCE RATING SCALE';
}

