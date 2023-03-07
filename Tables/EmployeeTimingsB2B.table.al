table 33001254 "Employee Timings B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Timings';
    DrillDownPageID = "Employee Timings B2B";
    LookupPageID = "Employee Timings B2B";

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
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(4; "Time In"; Time)
        {
            Caption = 'Time In';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Difference: Decimal;
                MilliSec: Decimal;
                "Min": Decimal;
                Hrs: Decimal;
            begin
                if "Time Out" <> 000000T then begin
                    Difference := "Time Out" - "Time In";
                    Hrs := Difference div 3600000;
                    MilliSec := Difference mod 3600000;
                    if MilliSec <> 0 then begin
                        Min := (MilliSec) / (60000);
                        "No.of Hours" := ((Hrs * 100) + (Min)) / 100;
                    end else
                        "No.of Hours" := ("Time Out" - "Time In") / (3600000);
                end;
            end;
        }
        field(5; "Time Out"; Time)
        {
            Caption = 'Time Out';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Difference: Decimal;
                MilliSec: Decimal;
                "Min": Decimal;
                Hrs: Decimal;
            begin
                if "Time In" <> 000000T then begin
                    Difference := "Time Out" - "Time In";
                    Hrs := Difference div 3600000;
                    MilliSec := Difference mod 3600000;
                    if MilliSec <> 0 then begin
                        Min := (MilliSec) / (60000);
                        "No.of Hours" := ((Hrs * 100) + (Min)) / 100;
                    end else
                        "No.of Hours" := ("Time Out" - "Time In") / (3600000);
                end;
            end;
        }
        field(6; "No.of Hours"; Decimal)
        {
            Caption = 'No.of Hours';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Date, "Time In")
        {
            SumIndexFields = "No.of Hours";
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee B2B";
}

