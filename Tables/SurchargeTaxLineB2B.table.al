table 33001380 "Surcharge Tax Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Surcharge Tax Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            TableRelation = "Surcharge Tax Header B2B"."Branch Code";
            DataClassification = CustomerContent;
        }
        field(2; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            TableRelation = "Surcharge Tax Header B2B"."Effective Date";
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
        field(7; "Tax %"; Decimal)
        {
            Caption = 'Tax %';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                SurchargeTaxLine: Record "Surcharge Tax Line B2B";
                Text0001Lbl: Label 'Tax Percentage must greater than %1.', Comment = '%1 = Surcharge Tax';
                Text0002Lbl: Label 'Tax Percentage must less than %1.', Comment = '%1 = Surcharge Tax';
            begin
                SurchargeTaxLine.RESET();
                SurchargeTaxLine.SETRANGE("Branch Code", "Branch Code");
                SurchargeTaxLine.SETRANGE("Effective Date", "Effective Date");
                SurchargeTaxLine.SETFILTER("Line No.", '<%1', "Line No.");
                if SurchargeTaxLine.FINDLAST() then 
                    if SurchargeTaxLine."Tax %" > "Tax %" then
                        ERROR(Text0001Lbl, SurchargeTaxLine."Tax %");
                

                SurchargeTaxLine.RESET();
                SurchargeTaxLine.SETRANGE("Branch Code", "Branch Code");
                SurchargeTaxLine.SETRANGE("Effective Date", "Effective Date");
                SurchargeTaxLine.SETFILTER("Line No.", '>%1', "Line No.");
                if SurchargeTaxLine.FINDFIRST() then 
                    if SurchargeTaxLine."Tax %" <= "Tax %" then
                        ERROR(Text0002Lbl, SurchargeTaxLine."Tax %");
                
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
    }

    fieldgroups
    {
    }

    var
        Text001Lbl: Label 'IncomeTo amount should be greater than IncomeFrom amount';
}

