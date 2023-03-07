table 33001234 "Professional Tax Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Professional Tax Line';
    //DrillDownPageID = 70230;//Phani
    //LookupPageID = 70230;//Phani
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            TableRelation = "Professional Tax Header B2B"."Branch Code";
            DataClassification = CustomerContent;
        }
        field(2; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            TableRelation = "Professional Tax Header B2B"."Effective Date";
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

            trigger OnValidate();
            begin
                if "Income From" <> 0 then
                    if "Tax Amount" > "Income From" then
                        ERROR(Text002Lbl);

            end;
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
        field(11; "Spl. Case"; Boolean)
        {
            Caption = 'Spl. Case';
            DataClassification = CustomerContent;
        }
        field(12; "Spl. Month"; Option)
        {
            Caption = 'Spl. Month';
            OptionCaption = ' ,1,2,3,4,5,6,7,8,9,10,11,12';
            OptionMembers = " ","1","2","3","4","5","6","7","8","9","10","11","12";
            DataClassification = CustomerContent;
        }
        field(13; "Spl. Value"; Decimal)
        {
            Caption = 'Spl. Value';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Branch Code", "Effective Date", "Line No.")
        {
        }
        key(Key2; "Branch Code", Year, Month, "Income From", "Income To")
        {
            SumIndexFields = "Tax Amount";
        }
    }

    fieldgroups
    {
    }

    var
        Text001Lbl: Label 'IncomeTo amount should be greater than IncomeFrom amount';
        Text002Lbl: Label 'Tax amount should be less than IncomeFrom amount';

}

