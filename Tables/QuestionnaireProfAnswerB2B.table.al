table 33001275 "Questionnaire Prof. Answer B2B"
{
    // version B2BHR1.00.00

    Caption = 'Questionnaire Profile Answer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var

            begin
            end;
        }
        field(2; "Employee Name"; Text[30])
        {
            CalcFormula = Lookup ("Employee B2B"."First Name" WHERE("First Name" = FIELD("Employee Name")));
            Caption = 'Employee Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Profile Questionnaire Code"; Code[10])
        {
            Caption = 'Profile Questionnaire Code';
            NotBlank = true;
            TableRelation = "Questionnaire Header B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var

            begin
            end;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            TableRelation = "Questionnaire Line B2B"."Line No." WHERE("Profile Questionnaire Code" = FIELD("Profile Questionnaire Code"),
                                                                   Type = CONST(Question));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var

            begin
            end;
        }
        field(7; Answer; Text[50])
        {
            CalcFormula = Lookup ("Questionnaire Line B2B".Description WHERE("Profile Questionnaire Code" = FIELD("Profile Questionnaire Code"),
                                                                         "Line No." = FIELD("Line No.")));
            Caption = 'Answer';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Profile Questionnaire Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure Question(): Text[250];
    var
        ProfileQuestnLine: Record "Questionnaire Line B2B";
    begin
        if ProfileQuestnLine.GET("Profile Questionnaire Code", QuestionLineNo()) then
            exit(ProfileQuestnLine.Description)
    end;

    procedure QuestionLineNo(): Integer;
    var
        ProfileQuestnLine: Record "Questionnaire Line B2B";
    begin
        with ProfileQuestnLine do begin
            RESET();
            SETRANGE("Profile Questionnaire Code", Rec."Profile Questionnaire Code");
            SETFILTER("Line No.", '<%1', Rec."Line No.");
            SETRANGE(Type, Type::Heading);
            if FINDLAST() then
                exit("Line No.");
        end;
    end;
}

