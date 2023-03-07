table 33001274 "Questionnaire Line B2B"
{
    // version B2BHR1.00.00

    Caption = 'Questionnaire Line';
    //LookupPageID = 50264;//Phani
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Profile Questionnaire Code"; Code[10])
        {
            Caption = 'Profile Questionnaire Code';
            TableRelation = "Questionnaire Header B2B".Code;
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Heading,Question,Answer';
            OptionMembers = Heading,Question,Answer;
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(5; "Multiple Answers"; Boolean)
        {
            Caption = 'Multiple Answers';
            DataClassification = CustomerContent;
        }
        field(6; Set; Boolean)
        {
            Caption = 'Set';
            DataClassification = CustomerContent;
        }
        field(7; Answer; Option)
        {
            Caption = 'Answer';
            OptionCaption = 'Boolean,Text';
            OptionMembers = Boolean,Text;
            DataClassification = CustomerContent;
        }
        field(10; "Heirarchy No."; Integer)
        {
            Caption = 'Heirarchy No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Profile Questionnaire Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ProfileQuestnLine: Record "Questionnaire Line B2B";

    procedure Question(): Text[250];
    begin
        ProfileQuestnLine.RESET();
        ProfileQuestnLine.SETRANGE("Profile Questionnaire Code", Rec."Profile Questionnaire Code");
        ProfileQuestnLine.SETFILTER("Line No.", '<%1', Rec."Line No.");
        ProfileQuestnLine.SETRANGE(Type, Type::Heading);
        if ProfileQuestnLine.FINDLAST() then
            exit(ProfileQuestnLine.Description);
    end;

    procedure FindQuestionLine() QuestnLineNo: Integer;
    var
    begin
        ProfileQuestnLine.RESET();
        ProfileQuestnLine.SETRANGE("Profile Questionnaire Code", "Profile Questionnaire Code");
        ProfileQuestnLine.SETFILTER("Line No.", '<%1', "Line No.");
        ProfileQuestnLine.SETRANGE(Type, Type::Heading);
        exit(ProfileQuestnLine."Line No.");
    end;
}

