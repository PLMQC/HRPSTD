table 33001361 "Emp History B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp History';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;
        }
        field(2; "Emp No."; Code[20])
        {
            Caption = 'Emp No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Employee.GET("Emp No.") then begin
                    "Department Code" := Employee."Department Code";
                    Designation := Employee.Designation;
                end;
            end;
        }
        field(3; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
        }
        field(4; Designation; Code[50])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;

        }
        field(5; "Location code"; Code[20])
        {
            Caption = 'Location code';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Effective Date", "Emp No.", "Department Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee B2B";
}

