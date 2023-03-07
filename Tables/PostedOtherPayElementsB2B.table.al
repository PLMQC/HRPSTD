table 33001225 "Posted Other PayElements B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Other PayElements';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Employee.GET("Employee No.") then
                    "Employee Name" := Employee."First Name";
            end;
        }
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(3; Month; Integer)
        {
            Caption = 'Month';
            ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
            DataClassification = CustomerContent;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(5; "Pay Element Code"; Code[30])
        {
            Caption = 'Pay Element Code';
            TableRelation = "Pay Deductions B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if PayDeduct.GET("Pay Element Code") then begin
                    Description := PayDeduct.Description;
                    "Add/Deduct" := PayDeduct."Add/Deduct";
                end;
            end;
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(8; "Add/Deduct"; Option)
        {
            Caption = 'Add/Deduct';
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
            DataClassification = CustomerContent;
        }
        field(9; Priority; Integer)
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
        }
        field(10; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(11; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Canteen,Holiday Compensation,OT,LED,Others,OSA,NSA';
            OptionMembers = " ",Canteen,"Holiday Compensation",OT,LED,Others,OSA,NSA;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Month, Year, "Pay Element Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee B2B";
        PayDeduct: Record "Pay Deductions B2B";

    procedure UpdateProcSalary(OtherDeduct: Record "Other PayElements B2B");
    var
        TempProcSalary: Record "Temp Processed Salary B2B";
    begin
        TempProcSalary.INIT();
        TempProcSalary."Document Type" := TempProcSalary."Document Type"::Payroll;
        TempProcSalary."Employee Code" := OtherDeduct."Employee No.";
        TempProcSalary."Pay Slip Month" := OtherDeduct.Month;
        TempProcSalary.Year := OtherDeduct.Year;
        TempProcSalary."Line No." := TempProcSalary."Line No." + 10000;
        TempProcSalary."Fixed/Percent" := TempProcSalary."Fixed/Percent"::Fixed;
        TempProcSalary."Add/Deduct Code" := OtherDeduct."Pay Element Code";
        TempProcSalary."Earned Amount" := OtherDeduct.Amount;
        TempProcSalary."Add/Deduct" := OtherDeduct."Add/Deduct";
        TempProcSalary."Employee Name" := OtherDeduct."Employee Name";
        TempProcSalary.Priority := OtherDeduct.Priority;
        TempProcSalary.INSERT();
    end;
}

