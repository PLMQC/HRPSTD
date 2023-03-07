table 33001333 "OT Approval B2B"
{
    // version B2BHR1.00.00

    Caption = 'OT Approval_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            Editable = false;
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; Year; Integer)
        {
            Caption = 'Year';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; Month; Integer)
        {
            Caption = 'Month';
            Editable = false;
            ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
            DataClassification = CustomerContent;
        }
        field(5; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "OT Hrs"; Decimal)
        {
            Caption = 'OT Hrs';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "OT Approved Hrs"; Decimal)
        {
            Caption = 'OT Approved Hrs';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("OT Approved Hrs" > "OT Hrs") or ("OT Approved Hrs" <= 0) then
                    ERROR(Text002Lbl);
                if Updated then
                    ERROR(Text006Lbl);
            end;
        }
        field(8; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(9; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(10; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
        }
        field(11; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
            DataClassification = CustomerContent;
        }
        field(12; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(13; "Cancel OT Approved Hrs"; Decimal)
        {
            Caption = 'Cancel OT Approved Hrs';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Cancel OT Approved Hrs" > "OT Approved Hrs") or ("Cancel OT Approved Hrs" <= 0) then
                    ERROR(Text005Lbl);
            end;
        }
        field(14; "OT Hours Canceled"; Boolean)
        {
            Caption = 'OT Hours Canceled';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Date)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text002Lbl: Label 'OT Approved Hrs should be less than or equal to the OT Hrs';
        Text005Lbl: Label 'Cancel OT Approved Hrs should be less than or equal to the OT Approved Hrs';
        Text006Lbl: Label 'OT Details are already approved, OT Approved hours can not be Modified';
}

