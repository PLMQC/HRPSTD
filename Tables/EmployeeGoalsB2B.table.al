table 33001377 "Employee Goals B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Goals';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Quarter; Option)
        {
            Caption = 'Quarter';
            OptionCaption = ' ,Q1,Q2,Q3,Q4';
            OptionMembers = " ",Q1,Q2,Q3,Q4;
            DataClassification = CustomerContent;
        }
        field(4; "Budget Weightage"; Decimal)
        {
            Caption = 'Budget Weightage';
            DataClassification = CustomerContent;
        }
        field(5; "Actual Weightage"; Decimal)
        {
            Caption = 'Actual Weightage';
            DataClassification = CustomerContent;
        }
        field(6; "Approvar ID"; Code[50])
        {
            Caption = 'Approvar ID';
            Editable = false;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(7; "Weightage Status"; Option)
        {
            Caption = 'Weightage Status';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
            DataClassification = CustomerContent;
        }
        field(8; "Goals Description"; Text[50])
        {
            Caption = 'Goals Description';
            DataClassification = CustomerContent;
        }
        field(9; "Serial No."; Integer)
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
        }
        field(10; "Actual Weightage Status"; Option)
        {
            Caption = 'Actual Weightage Status';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
            DataClassification = CustomerContent;
        }
        field(11; "Q1 Goals"; Text[50])
        {
            Caption = 'Q1 Goals';
            DataClassification = CustomerContent;
        }
        field(12; "Target Date"; Date)
        {
            Caption = 'Target Date';
            DataClassification = CustomerContent;
        }
        field(13; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(14; Select; Boolean)
        {
            Caption = 'Select';
            DataClassification = CustomerContent;
        }
        field(15; KPA; Text[30])
        {
            Caption = 'KPA';
            DataClassification = CustomerContent;
        }
        field(16; Period; Code[20])
        {
            Caption = 'Period';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                PayrollYear: Record "Payroll Year B2B";
            begin
                PayrollYear.RESET();
                PayrollYear.SETRANGE("Year Type", FinanceYearTextLbl);
                PayrollYear.SETRANGE(Closed, false);
                if PAGE.RUNMODAL(0, PayrollYear) = ACTION::LookupOK then begin
                    Period := FORMAT(DATE2DMY(PayrollYear."Year Start Date", 3)) + ' - ' + FORMAT(DATE2DMY(PayrollYear."Year End Date", 3));
                    "From Date" := PayrollYear."Year Start Date";
                    "To Date" := PayrollYear."Year End Date";
                end;
            end;
        }
        field(17; "From Date"; Date)
        {
            Caption = 'From Date';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(18; "To Date"; Date)
        {
            Caption = 'To Date';
            Editable = true;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FinanceYearTextLbl: Label 'FINANCIAL YEAR';

}

