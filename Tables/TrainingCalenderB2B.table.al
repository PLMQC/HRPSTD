table 33001269 "Training Calender B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Calender';
    LookupPageID = "Questi. Profile Setup B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Approved, false);
            end;
        }
        field(3; "Training Interval"; Option)
        {
            Caption = 'Training Interval';
            OptionCaption = ' ,Yearly,Half-Yearly,Quarterly,Monthly,Weekly,Daily';
            OptionMembers = " ",Yearly,"Half-Yearly",Quarterly,Monthly,Weekly,Daily;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Approved, false);
            end;
        }
        field(4; "Training Faculty"; Option)
        {
            Caption = 'Training Faculty';
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Approved, false);
            end;
        }
        field(5; "Training Type"; Text[30])
        {
            Caption = 'Training Type';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('TYPE OF TRAINING'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Approved, false);
            end;
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(15; Month; Option)
        {
            Caption = 'Month';
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Approved, false);

            end;
        }
        field(16; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Approved, false);
            end;
        }
        field(17; Approved; Boolean)
        {
            Caption = 'Approved';
            DataClassification = CustomerContent;
        }
        field(18; "Global Dimension 1"; Code[20])
        {
            Caption = 'Global Dimension 1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Approved, false);
            end;
        }
        field(19; "Training Closed"; Boolean)
        {
            Caption = 'Training Closed';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Approved, false);
            end;
        }
        field(20; "Training Objectives"; Text[250])
        {
            Caption = 'Training Objectives';
            DataClassification = CustomerContent;
        }
        field(21; "Training Cost"; Decimal)
        {
            Caption = 'Training Cost';
            DataClassification = CustomerContent;
        }
        field(22; "Work Group Code"; Code[20])
        {
            Caption = 'Work Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Surcharge Tax Header B2B";
        }
        field(23; Venue; Text[250])
        {
            Caption = 'Venue';
            DataClassification = CustomerContent;
        }
        field(24; "Name of faculty/Consultant"; Text[50])
        {
            Caption = 'Name of faculty/Consultant';
            TableRelation = IF ("Training Faculty" = CONST(Internal)) "Employee B2B"."No.";
            DataClassification = CustomerContent;
        }
        field(25; "Training Objectives 2"; Text[250])
        {
            Caption = 'Training Objectives 2';
            DataClassification = CustomerContent;
        }
        field(26; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;
        }
        field(27; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = CustomerContent;
        }
        field(28; "Work Group Code 2"; Code[20])
        {
            Caption = 'Work Group Code 2';
            TableRelation = "Surcharge Tax Header B2B";
            DataClassification = CustomerContent;
        }
        field(29; "Work Group Code 3"; Code[20])
        {
            Caption = 'Work Group Code 3';
            TableRelation = "Surcharge Tax Header B2B";
            DataClassification = CustomerContent;
        }
        field(30; "Work Group Code 4"; Code[20])
        {
            Caption = 'Work Group Code 4';
            TableRelation = "Surcharge Tax Header B2B";
            DataClassification = CustomerContent;
        }
        field(31; "Work Group Code 5"; Code[20])
        {
            Caption = 'Work Group Code 5';
            TableRelation = "Surcharge Tax Header B2B";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Training Interval")
        {
        }
    }

    fieldgroups
    {
    }

    var
        HRSetup: Record "HR Setup B2B";
        NoSeriesMgt: Codeunit 396;

    procedure AssistEdit(OldTraining: Record "Training Calender B2B"): Boolean;
    var
        Training: Record "Training Calender B2B";
    begin
        with Training do begin
            Training := Rec;
            HRSetup.GET();
            HRSetup.TESTFIELD(HRSetup."Training Nos.");
            if NoSeriesMgt.SelectSeries(HRSetup."Training Nos.", OldTraining."No. Series", "No. Series") then begin
                HRSetup.GET();
                HRSetup.TESTFIELD("Training Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := Training;
                exit(true);
            end;
        end;
    end;
}

