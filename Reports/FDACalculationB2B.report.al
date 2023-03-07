report 33001235 "FDA Calculation B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\FDA Calculation.rdlc';
    Caption = 'FDA Calculation';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {

            trigger OnAfterGetRecord();
            begin
                HRSetup.GET();
                PayElements.INIT();
                PayElements."Employee Code" := "No.";
                PayElements."Effective Start Date" := EffDateGVar;
                PayElements."Pay Element Code" := FDATxt;
                PayElements.VALIDATE("Pay Element Code");
                PayElements."Amount / Percent" := AmountGVar;
                PayElements."Computation Type" := NONAttendanceTxt;
                PayElements.INSERT(true);
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Amount; AmountGVar)
                {
                    ToolTip = 'Enter the amount to Fixed Dearness Allowance (FDA).';
                    Caption = 'FDA Amount';
                    ApplicationArea = all;
                }
                field(EffDate; EffDateGVar)
                {
                    ToolTip = 'Choose the Effective date from which FDA is calculated.';
                    Caption = 'Effective Date';
                    ApplicationArea = all;
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

    var
        HRSetup: Record "HR Setup B2B";
        PayElements: Record "Pay Elements B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        AmountGVar: Decimal;
        EffDateGVar: Date;

        FDATxt: Label 'FDA';
        NONAttendanceTxt: Label 'NON Attendance';
}

