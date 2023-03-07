table 33001281 "LOP Adj. Entries B2B"
{
    // version B2BHR1.00.00

    Caption = 'LOP Adj. Entries';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
        }
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(3; "Pay Cadre"; Code[30])
        {
            Caption = 'Pay Cadre';
            DataClassification = CustomerContent;
        }
        field(4; "Adj. LOP Year"; Integer)
        {
            Caption = 'Adj. LOP Year';
            DataClassification = CustomerContent;
        }
        field(5; "Adj. LOP Month"; Integer)
        {
            Caption = 'Adj. LOP Month';
            DataClassification = CustomerContent;
        }
        field(6; "LOP Year"; Integer)
        {
            Caption = 'LOP Year';
            DataClassification = CustomerContent;
        }
        field(7; "LOP Month"; Integer)
        {
            Caption = 'LOP Month';
            DataClassification = CustomerContent;
        }
        field(8; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(9; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Addition,Deduction';
            OptionMembers = Addition,Deduction;
            DataClassification = CustomerContent;
        }
        field(11; "Day Count"; Decimal)
        {
            Caption = 'Day Count';
            DataClassification = CustomerContent;
        }
        field(12; "LOP Type"; Option)
        {
            Caption = 'LOP Type';
            OptionCaption = ' ,Half Day,Full Day';
            OptionMembers = " ","Half Day","Full Day";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "LOP Type" = "LOP Type"::"Half Day" then
                    "Day Count" := 0.5
                else
                    "Day Count" := 1;
            end;
        }
    }

    keys
    {
        key(Key1; Type, "Employee No.", Date)
        {
        }
    }

    fieldgroups
    {
    }
}

