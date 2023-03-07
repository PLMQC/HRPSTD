table 33001219 "Leave Master B2B"
{
    // version B2BHR1.00.00

    Caption = 'Leave Master';
    DrillDownPageID = "Leave List B2B";
    LookupPageID = "Leave List B2B";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(3; "No. of Leaves in Year"; Decimal)
        {
            Caption = 'No. of Leaves in Year';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
                if "No. of Leaves in Year" <= 0 then
                    ERROR(Text000Lbl);
            end;
        }
        field(4; "Crediting Interval"; DateFormula)
        {
            Caption = 'Crediting Interval';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
                CreditInterval := COPYSTR(FORMAT("Crediting Interval"), 1, 1);
                if CreditInterval = '-' then
                    ERROR(Text002Lbl);
                UpdateTotalLeaves();
            end;
        }
        field(5; "Crediting Type"; Option)
        {
            Caption = 'Crediting Type';
            OptionCaption = 'Before the Period,After the Period';
            OptionMembers = "Before the Period","After the Period";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(6; "Minimum Allowed"; Decimal)
        {
            Caption = 'Minimum Allowed';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(7; "Maximum Allowed"; Decimal)
        {
            Caption = 'Maximum Allowed';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(8; "Carry Forward"; Boolean)
        {
            Caption = 'Carry Forward';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
                TESTFIELD("Max.Leaves to Carry Forward", 0);
            end;
        }
        field(9; "Applicable Date"; Date)
        {
            Caption = 'Applicable Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(10; "Max.Leaves to Carry Forward"; Decimal)
        {
            Caption = 'Max.Leaves to Carry Forward';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Carry Forward", true);
            end;
        }
        field(11; "Applicable During Probation"; Boolean)
        {
            Caption = 'Applicable During Probation';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(12; "No.of Leaves During Probation"; Decimal)
        {
            Caption = 'No.of Leaves During Probation';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(13; Encashable; Boolean)
        {
            Caption = 'Encashable';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(14; "Max. Encashable"; Decimal)
        {
            Caption = 'Max. Encashable';
            DataClassification = CustomerContent;
            MinValue = 0;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(15; "Min. Encashable"; Decimal)
        {
            Caption = 'Min. Encashable';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(16; "Encashment in excess of."; Decimal)
        {
            Caption = 'Encashment in excess of.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(17; "Min. Retaining Leaves"; Decimal)
        {
            Caption = 'Min. Retaining Leaves';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD(Encashable);

                if "Carry Forward" then
                    if "Min. Retaining Leaves" >= "Max.Leaves to Carry Forward" then
                        ERROR(Text003Lbl, FIELDCAPTION("Min. Retaining Leaves"), FIELDCAPTION("Max.Leaves to Carry Forward"));

            end;
        }
        field(20; "Pay Cadre"; Code[250])
        {
            Caption = 'Pay Cadre';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(20));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(21; "All Cadres"; Boolean)
        {
            Caption = 'All Cadres';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(22; "Leaves in Crediting Interval"; Decimal)
        {
            Caption = 'Leaves in Crediting Interval';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                CreditingInterval: Text[30];
                CheckString: Text;
                Position: Integer;

            begin
                CheckForGradeWiseLeaves();
                CreditingInterval := FORMAT("Leaves in Crediting Interval");
                Position := STRPOS(CreditingInterval, '.');
                if Position <> 0 then begin
                    CheckString := COPYSTR(CreditingInterval, Position);
                    if CheckString <> '.5' then
                        ERROR(Text005Lbl);
                end;
                UpdateTotalLeaves();
            end;
        }
        field(25; "Type of Leave"; Option)
        {
            Caption = 'Type of Leave';
            OptionCaption = ' ,Casual,Sick,Earned,Maternity,Special';
            OptionMembers = " ",Casual,Sick,Earned,Maternity,Special;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
                // if "Type of Leave" <> "Type of Leave"::" " then begin
                //     LeaveMaster.RESET();
                //     LeaveMaster.SETRANGE("Location Code", "Location Code");
                //     LeaveMaster.SETRANGE("Type of Leave", "Type of Leave");
                //     if LeaveMaster.FINDFIRST() then
                //         ERROR(Text004Lbl, "Location Code");
                // end;
            end;
        }
        field(30; "Off Days b/w Leaves"; Boolean)
        {
            Caption = 'Off Days b/w Leaves';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(31; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            Editable = true;
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(35; "Minimum Working Days"; Decimal)
        {
            Caption = 'Minimum Working Days';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(40; "Update Leaves On Salary Post"; Boolean)
        {
            Caption = 'Update Leaves On Salary Post';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(41; "Advance Leaves"; Boolean)
        {
            Caption = 'Advance Leaves';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckForGradeWiseLeaves();
            end;
        }
        field(45; "Lapse Period"; DateFormula)
        {

            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Leave Code", "Location Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        GradeLeaves.RESET();
        GradeLeaves.SETRANGE("Leave Code", "Leave Code");
        GradeLeaves.SETRANGE("Location Code", "Location Code");
        if GradeLeaves.FINDFIRST() then
            ERROR(Text001Lbl, "Leave Code");
    end;

    trigger OnInsert();
    begin
        if "Location Code" = '' then
            ERROR('');
    end;

    trigger OnModify();
    begin
        GradeLeaves.RESET();
        GradeLeaves.SETRANGE("Leave Code", "Leave Code");
        GradeLeaves.SETRANGE("Location Code", "Location Code");
        if GradeLeaves.FINDFIRST() then
            if "Lapse Period" = xRec."Lapse Period" then
                ERROR(Text001Lbl, "Leave Code");
    end;

    var
        GradeLeaves: Record "Grade Wise Leaves B2B";
        CreditInterval: Text[30];
        Text000Lbl: Label 'Number of leaves should be greaterthan zero';
        Text001Lbl: Label 'Grade wise leaves exists,you cannot delete / modify the leave master of %1.', Comment = '%1 = ';
        Text002Lbl: Label 'Negative values should not be allowed.';
        Text003Lbl: Label '%1 should be less than %2.', Comment = '%1 =  ; %2 = ';
        Text005Lbl: Label 'Must be half day';
        OneMonthTxt: Label '<+1M>';

    procedure UpdateTotalLeaves();
    var
        TempDate: Date;
        TempDate1: Date;
        NoofMonths: Integer;
    begin
        if FORMAT("Crediting Interval") <> '' then begin
            NoofMonths := 0;
            TempDate := WORKDATE();
            TempDate1 := WORKDATE();
            TempDate := CALCDATE("Crediting Interval", TempDate);
            repeat
                TempDate1 := CALCDATE(OneMonthTxt, TempDate1);
                NoofMonths += 1;
            until (Date2DMY(TempDate1, 2) = date2dmy(TempDate, 2)) and (Date2DMY(TempDate1, 3) = date2dmy(TempDate, 3));
            "No. of Leaves in Year" := "Leaves in Crediting Interval" * 12 / NoofMonths;
        end;
    end;

    procedure CheckForGradeWiseLeaves();
    begin
        GradeLeaves.RESET();
        GradeLeaves.SETRANGE("Leave Code", "Leave Code");
        GradeLeaves.SETRANGE("Location Code", "Location Code");
        if GradeLeaves.FINDFIRST() then
            ERROR(Text001Lbl, "Leave Code");
    end;
}

