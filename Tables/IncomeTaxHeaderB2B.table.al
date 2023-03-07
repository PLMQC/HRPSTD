table 33001288 "Income Tax Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Income Tax Header_B2B';
    DataCaptionFields = "Branch Code";
    DrillDownPageID = "IncomeTax List B2B";
    LookupPageID = "IncomeTax List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;

            trigger OnValidate();

            begin
            end;
        }
        field(4; "Finalcial Year"; Code[50])
        {
            Caption = 'Finalcial Year';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                PayrollYear.SETRANGE("Year Type", FYTxt);
                if PAGE.RUNMODAL(0, PayrollYear) = ACTION::LookupOK then begin
                    "Finalcial Year" := PayrollYear."Year Type";
                    "Start Date" := PayrollYear."Year Start Date";
                    "End Date" := PayrollYear."Year End Date";
                end;
            end;
        }
        field(5; Surcharge; Integer)
        {
            Caption = 'Surcharge';
            DataClassification = CustomerContent;
        }
        field(6; Ecess; Integer)
        {
            Caption = 'Ecess';
            DataClassification = CustomerContent;
        }
        field(7; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(8; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Branch Code", "Start Date", "End Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        ProfLine: Record "Professional Tax Line B2B";
    begin
        ProfLine.RESET();
        ProfLine.SETRANGE("Branch Code", "Branch Code");
        ProfLine.SETRANGE("Effective Date", "Effective Date");
        if ProfLine.FINDFIRST() then
            ProfLine.DELETEALL();
    end;

    var
        PayrollYear: Record "Payroll Year B2B";
        FYTxt: Label 'FINANCIAL YEAR';
}

