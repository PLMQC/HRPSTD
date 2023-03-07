table 33001273 "Questionnaire Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Questionnaire Header';
    DrillDownPageID = "Questionnaires B2B";
    LookupPageID = "Questionnaires B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Questionnaire Type"; Option)
        {
            Caption = 'Questionnaire Type';
            OptionCaption = ' ,Joining Formalities,Appraisals,Induction,Training,Exit Interview,KRA';
            OptionMembers = " ","Joining Formalities",Appraisals,Induction,Training,"Exit Interview",KRA;
            DataClassification = CustomerContent;
        }
        field(10; "Employee Status"; Code[30])
        {
            Caption = 'Employee Status';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(12));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

