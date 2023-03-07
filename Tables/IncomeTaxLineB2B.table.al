table 33001289 "Income Tax Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Income Tax Line_B2B';
    //DrillDownPageID = 70230;//Phani
    //LookupPageID = 70230;//Phani
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            DataClassification = CustomerContent;
        }
        field(2; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Effective Date" <> 0D then begin
                    Month := DATE2DMY("Effective Date", 2);
                    Year := DATE2DMY("Effective Date", 3);
                end;
            end;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Income From"; Decimal)
        {
            Caption = 'Income From';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                PT.SETRANGE("Branch Code", "Branch Code");
                PT.SETRANGE("Effective Date", "Effective Date");
                if PT.FINDLAST() then
                    if "Income From" <= PT."Income To" then
                        ERROR(Text000Lbl, "Income From", PT."Income To");

            end;
        }
        field(5; "Income To"; Decimal)
        {
            Caption = 'Income To';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Income To" < "Income From" then
                    ERROR(Text001Lbl);
            end;
        }
        field(7; "Tax Amount"; Decimal)
        {
            Caption = 'Tax Amount';
            DataClassification = CustomerContent;
        }
        field(9; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(10; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(11; "Start Date"; Date)
        {
            Caption = 'Start Date';
            TableRelation = "Payroll Year B2B"."Year Type" WHERE(Closed = CONST(true));
            DataClassification = CustomerContent;
        }
        field(12; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Branch Code", "Effective Date", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PT: Record "Professional Tax Line B2B";
        Text000Lbl: Label '%1 Should be greater than %2', Comment = '%1 = Income From ; %2 = Income To';
        Text001Lbl: Label 'IncomeTo amount should be greater than IncomeFrom amount';

}

