table 33001341 "TDS Salary Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'TDS Salary Details';
    DrillDownPageID = "Salary TDS Details List B2B";
    LookupPageID = "Salary TDS Details List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(3; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(4; "TDS Amount"; Decimal)
        {
            Caption = 'TDS Amount';
            DataClassification = CustomerContent;
        }
        field(5; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(6; "Sal. Posting Date"; Date)
        {
            Caption = 'Sal. Posting Date';
            DataClassification = CustomerContent;
        }
        field(7; "Sal. Posting Document No."; Code[20])
        {
            Caption = 'Sal. Posting Document No.';
            DataClassification = CustomerContent;
        }
        field(8; "TDS Payment Date"; Date)
        {
            Caption = 'TDS Payment Date';
            DataClassification = CustomerContent;
        }
        field(9; "TDS Payment Doc. No."; Code[20])
        {
            Caption = 'TDS Payment Doc. No.';
            DataClassification = CustomerContent;
        }
        field(10; "Challan No."; Code[20])
        {
            Caption = 'Challan No.';
            DataClassification = CustomerContent;
        }
        field(11; "Challan Date"; Date)
        {
            Caption = 'Challan Date';
            DataClassification = CustomerContent;
        }
        field(12; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
        field(13; "BSR Code"; Code[20])
        {
            Caption = 'BSR Code';
            DataClassification = CustomerContent;
        }
        field(14; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
            DataClassification = CustomerContent;
        }
        field(15; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
            DataClassification = CustomerContent;
        }
        field(16; Select; Boolean)
        {
            Caption = 'Select';
            DataClassification = CustomerContent;
        }
        field(17; "TDS Amount Paid"; Decimal)
        {
            Caption = 'TDS Amount Paid';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code", Month, Year)
        {
        }
    }

    fieldgroups
    {
    }

    var
        GenJnlLineGRec: Record "Gen. Journal Line";

    procedure PayTDS(GenJnlLine: Record "Gen. Journal Line");
    begin
        GenJnlLineGRec.COPY(GenJnlLine);
        PAGE.RUNMODAL(33001475);
    end;
}

