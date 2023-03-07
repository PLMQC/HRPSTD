table 33001410 "Shift Rotation B2B"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;


        }
        field(2; Type; Option)
        {
            OptionMembers = " ",Employee,"Pay Cadre";
            OptionCaption = ' ,Employee,Pay Cadre';
            DataClassification = CustomerContent;
        }
        field(3; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = IF (Type = filter('Pay Cadre')) Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'))
            ELSE
            IF (Type = filter('Employee')) "Employee B2B";
        }
        field(4; "Start Date"; date)
        {
            DataClassification = CustomerContent;

        }
        field(5; "End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Location Code"; Code[20])
        {
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;
        }
        field(7; "Shift Code"; Code[20])
        {
            TableRelation = "Shift Master B2B"."Shift Code" where("Location Code" = field("Location Code"));
            DataClassification = CustomerContent;
        }
        field(8; "Updated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    var


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        TestField(Updated, false);
    end;

    trigger OnRename()
    begin

    end;

}