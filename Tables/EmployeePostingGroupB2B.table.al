table 33001248 "Employee Posting Group B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Posting Group_B2B';
    LookupPageID = "Employee Posting  Group B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Salary Payable Acc."; Code[20])
        {
            Caption = 'Salary Payable Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(4; "PF Payable Acc."; Code[20])
        {
            Caption = 'PF Payable Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(5; "TDS Payable Acc."; Code[20])
        {
            Caption = 'TDS Payable Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(6; "ESI Payable Acc."; Code[20])
        {
            Caption = 'ESI Payable Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(7; "EPS Payable Acc."; Code[20])
        {
            Caption = 'EPS Payable Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(8; "EDLI Charges Acc."; Code[20])
        {
            Caption = 'EDLI Charges Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(9; "PF Admin Charge Payable Acc."; Code[20])
        {
            Caption = 'PF Admin Charge Payable Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(11; "PT Payable Account"; Code[20])
        {
            Caption = 'PT Payable Account';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(12; "RIFA Charges Acc."; Code[20])
        {
            Caption = 'RIFA Charges Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(13; "Arrear Salary Payable Acc."; Code[20])
        {
            Caption = 'Arrear Salary Payable Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(14; "Bonus Payable Acc."; Code[20])
        {
            Caption = 'Bonus Payable Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(15; "Employee Imprest Account"; Code[20])
        {
            Caption = 'Employee Imprest Account';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(20; "LTA Posting Group"; Code[20])
        {
            Caption = 'LTA Posting Group';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(21; "LeaveEncash Payable Acc."; Code[20])
        {
            Caption = 'LeaveEncash Payable Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(22; "LWF Payable Acc."; Code[20])
        {
            Caption = 'LWF Payable Acc.';
            Description = 'B2BSR1.0';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(23; "VPF Payable Acc."; Code[20])
        {
            Caption = 'VPF Payable Acc.';
            Description = 'B2BSR1.0';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        EmployeeGRec.RESET();
        EmployeeGRec.SETRANGE("Emp Posting Group", Code);
        if EmployeeGRec.FINDFIRST() then
            ERROR(Text0000Lbl, EmployeeGRec."No.");
    end;

    var
        EmployeeGRec: Record "Employee B2B";
        Text0000Lbl: Label 'You cannot delete the posting group because it already assigned to the employee %1.', Comment = '%1 = No';
}

