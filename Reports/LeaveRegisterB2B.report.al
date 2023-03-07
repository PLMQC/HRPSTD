report 33001262 "Leave Register B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Leave Register.rdl';
    Caption = 'Leave Register';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            RequestFilterFields = "No.";


            column(Employee_B2B__First_Name______Employee_B2B__Middle_Name______Employee_B2B__Last_Name_; "Employee B2B"."First Name" + ' ' + "Employee B2B"."Middle Name" + ' ' + "Employee B2B"."Last Name")
            {
            }
            column(Employee_B2B__Department_Code_; "Department Code")
            {
            }
            column(Employee_B2B_Employee_B2B__No__; "Employee B2B"."No.")
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(USERID; USERID())
            {
            }
            column(FORMAT_TODAY_; FORMAT(TODAY()))
            {
            }
            column(CALCDATE___1D__LeaveYearStartDate_; CALCDATE('<-1D>', LeaveYearStartDate))
            {
            }
            column(LeaveYearStartDate; LeaveYearStartDate)
            {
            }
            column(PrevYearLeaves; PrevYearLeaves)
            {
            }
            column(AddedLeaves; AddedLeaves)
            {
            }
            column(Employee_B2B__Department_Code_Caption; FIELDCAPTION("Department Code"))
            {
            }
            column(LEAVE_REGISTER_FROM___Caption; LEAVE_REGISTER_FROM___CaptionLbl)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(FORM_NO_Caption; FORM_NO_CaptionLbl)
            {
            }
            column(STR_DTCaption; STR_DTCaptionLbl)
            {
            }
            column(END_DTCaption; END_DTCaptionLbl)
            {
            }
            column(L_DAYSCaption; L_DAYSCaptionLbl)
            {
            }
            column(CUR_BALCaption; CUR_BALCaptionLbl)
            {
            }
            column(HALF_DAYCaption; HALF_DAYCaptionLbl)
            {
            }
            column(C_FCaption; C_FCaptionLbl)
            {
            }
            column(ALLOTCaption; ALLOTCaptionLbl)
            {
            }
            column(NARATIONCaption; NARATIONCaptionLbl)
            {
            }
            dataitem("Posted Leave App Line"; "Posted Leave App Line B2B")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                column(Posted_Leave_App_Line__Document_No__; "Document No.")
                {
                }
                column(Posted_Leave_App_Line__From_Date_; "From Date")
                {
                }
                column(Posted_Leave_App_Line__To_Date_; "To Date")
                {
                }
                column(Posted_Leave_App_Line__No_of_Days_; "No.of Days")
                {
                }
                column(Posted_Leave_App_Line__Provisional_Leaves_Avail_; "Provisional Leaves Avail")
                {
                }
                column(Posted_Leave_App_Line__Session_Time_; "Session Time")
                {
                }
                column(Narration; Narration)
                {
                }
                column(Posted_Leave_App_Line__No_of_Days__Control1102152031; "No.of Days")
                {
                }
                column(Posted_Leave_App_Line__Provisional_Leaves_Avail__Control1102152032; "Provisional Leaves Avail")
                {
                }
                column(TOTALCaption; TOTALCaptionLbl)
                {
                }
                column(Posted_Leave_App_Line_Line_No_; "Line No.")
                {
                }
                column(Posted_Leave_App_Line_Employee_No_; "Employee No.")
                {
                }
                column(Provisional_Leaves_Avail; "Provisional Leaves Avail")
                { }

                trigger OnAfterGetRecord();
                begin
                    if "Processed Status" = "Posted Leave App Line"."Processed Status"::Cancelled then
                        Narration := "Posted Leave App Line"."Reason for Leave" + ' -- ' + Text001Txt
                    else
                        Narration := "Posted Leave App Line"."Reason for Leave";
                    "Posted Leave App Line"."Provisional Leaves Avail" := "Posted Leave App Line"."Provisional Leaves Avail" -
                                                                           "Posted Leave App Line"."No.of Days";
                end;

                trigger OnPreDataItem();
                begin
                    if LeaveRegisterFromGVar <> 0D then
                        "Posted Leave App Line".SETFILTER("From Date", '>=%1', LeaveRegisterFromGVar);


                end;
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(OpeningBalForCurrYear);
                CLEAR(AddedLeaves);
                CLEAR(PrevYearLeaves);
                EmpLeaves.RESET();
                EmpLeaves.SETRANGE("No.", "No.");
                if EmpLeaves.FINDFIRST() then
                    repeat
                        ProviLeavesGRec.RESET();
                        ProviLeavesGRec.SETRANGE("Employee No.", EmpLeaves."No.");
                        ProviLeavesGRec.SETRANGE("Leave Code", EmpLeaves."Leave Code");
                        ProviLeavesGRec.SETRANGE(Status, ProviLeavesGRec.Status::Open);
                        if ProviLeavesGRec.FINDFIRST() then
                            OpeningBalForCurrYear += ProviLeavesGRec."No.of Leaves";
                        LeaveMasterGRec.RESET();
                        LeaveMasterGRec.SETRANGE("Leave Code", EmpLeaves."Leave Code");
                        if LeaveMasterGRec.FINDFIRST() then
                            AddedLeaves += LeaveMasterGRec."Leaves in Crediting Interval";
                    until EmpLeaves.NEXT() = 0;
                PrevYearLeaves := OpeningBalForCurrYear - AddedLeaves;

                PayrollYears.RESET();
                PayrollYears.SETRANGE("Year Type", Text000Txt);
                PayrollYears.SETFILTER(Closed, '<>%1', true);
                if PayrollYears.FINDFIRST() then
                    LeaveYearStartDate := PayrollYears."Year Start Date";
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(LeaveRegisterFrom; LeaveRegisterFromGVar)
                    {
                        ToolTip = 'Enter the date from which leave register to be generated.';
                        Caption = 'Leave Register From';
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

    trigger OnInitReport();
    begin
        CompInfo.get();
        CompInfo.CALCFIELDS(Picture);
    end;

    var

        CompInfo: Record "Company Information";
        ProviLeavesGRec: Record "Provisional Leaves B2B";
        EmpLeaves: Record "Employee Leaves B2B";
        LeaveMasterGRec: Record "Leave Master B2B";
        PayrollYears: Record "Payroll Year B2B";
        AddedLeaves: Decimal;
        OpeningBalForCurrYear: Decimal;
        PrevYearLeaves: Decimal;
        LeaveYearStartDate: Date;
        Narration: Text[120];
        LeaveRegisterFromGVar: Date;



        LEAVE_REGISTER_FROM___CaptionLbl: Label 'LEAVE REGISTER FROM :-';
        Employee_No_CaptionLbl: Label 'Employee No.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        FORM_NO_CaptionLbl: Label 'FORM NO.';
        STR_DTCaptionLbl: Label 'STR DT';
        END_DTCaptionLbl: Label 'END DT';
        L_DAYSCaptionLbl: Label 'L.DAYS';
        CUR_BALCaptionLbl: Label 'CUR BAL';
        HALF_DAYCaptionLbl: Label 'HALF DAY';
        C_FCaptionLbl: Label 'C.F';
        ALLOTCaptionLbl: Label 'ALLOT';
        NARATIONCaptionLbl: Label 'NARATION';
        TOTALCaptionLbl: Label 'TOTAL';
        Text000Txt: Label 'LEAVE YEAR';
        Text001Txt: Label 'Leave Canceled';
}

