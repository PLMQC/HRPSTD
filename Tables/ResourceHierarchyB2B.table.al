table 33001304 "Resource Hierarchy B2B"
{
    // version B2BHR1.00.00

    Caption = 'Resource Hierarchy_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(2; "From User ID"; Code[50])
        {
            Caption = 'From User ID';
            Editable = false;
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(4; "To User ID"; Code[50])
        {
            Caption = 'To User ID';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(5; "To Employee ID"; Code[20])
        {
            CalcFormula = Lookup ("Employee B2B"."No." WHERE("User Id" = FIELD("To User ID")));
            Caption = 'To Employee ID';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "To Employee Name"; Text[50])
        {
            CalcFormula = Lookup ("Employee B2B"."First Name" WHERE("User Id" = FIELD("To User ID")));
            Caption = 'To Employee Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "From User ID", "To User ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if ResourceHierarchy.GET("To User ID", "From User ID") then
            ERROR(Text001Lbl, "To User ID", "From User ID");
    end;

    var
        ResourceHierarchy: Record "Resource Hierarchy B2B";
        Text001Lbl: Label '%1 is under %2.', Comment = '%1 = To User ID ; %2 = From User ID';
}

