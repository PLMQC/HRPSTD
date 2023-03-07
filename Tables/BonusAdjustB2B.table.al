table 33001242 "Bonus Adjust B2B"
{
    // version B2BHR1.00.00

    Caption = 'Bonus Adjust';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
        }
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(3; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(5; "Pay Element Code"; Code[30])
        {
            Caption = 'Pay Element Code';
            DataClassification = CustomerContent;
        }
        field(6; "Bonus/Exgratia Amt"; Decimal)
        {
            Caption = 'Bonus/Exgratia Amt';
            DataClassification = CustomerContent;
        }
        field(7; "Additional Bonus"; Decimal)
        {
            Caption = 'Additional Bonus';
            DataClassification = CustomerContent;
        }
        field(8; Adjustments; Decimal)
        {
            Caption = 'Adjustments';
            DataClassification = CustomerContent;
        }
        field(9; Salary; Decimal)
        {
            Caption = 'Salary';
            DataClassification = CustomerContent;
        }
        field(10; "Net Payable"; Decimal)
        {
            Caption = 'Net Payable';
            DataClassification = CustomerContent;
        }
        field(11; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(12; "Exgratia Amt"; Decimal)
        {
            Caption = 'Exgratia Amt';
            DataClassification = CustomerContent;
        }
        field(13; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(14; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(15; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
        field(16; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(17; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
        }
        field(18; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(19; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(20; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(22; "Adv. Bonus"; Decimal)
        {
            Caption = 'Adv. Bonus';
            DataClassification = CustomerContent;
        }
        field(26; "Arrear Bonus"; Decimal)
        {
            Caption = 'Arrear Bonus';
            DataClassification = CustomerContent;
        }
        field(27; "Arrear Exgratia"; Decimal)
        {
            Caption = 'Arrear Exgratia';
            DataClassification = CustomerContent;
        }
        field(28; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(29; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(30; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code", Month, Year, "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit 408;
        Text000Lbl: Label 'Account  in General posting group should be defined for pay element %1 .', Comment = '%1 = Payelemeent';
        Text001Lbl: Label 'Pay Product Posting group/PayElement  is not defined for the pay element %1 in Lookup.', Comment = '%1 = BonusTxt';
        Text003Lbl: Label 'Processed Pay Element %1 is not defined  in the Lookup.', Comment = '%1 = EXGRATIATxt';
        Text004Lbl: Label 'Business  Posting Group not defined to Employee %1.', Comment = '%1 = No';
        AddDedTxt: Label 'ADDITIONS AND DEDUCTIONS';
        BONUSTxt: Label 'BONUS';
        EXGRATIATxt: Label 'EX-GRATIA';
        PAYMENTJNLTxt: Label 'PAYMENTJNL';
        JanTxt: Label 'January';
        FebuaryTxt: Label 'Febuary';
        MarchTxt: Label 'March';
        AprilTxt: Label 'April';
        MayTxt: Label 'May';
        JuneTxt: Label 'June';
        JulyTxt: Label 'July';
        AugustTxt: Label 'August';
        SeptemberTxt: Label 'September';
        OctoberTxt: Label 'October';
        NovemberTxt: Label 'November';
        DecemberTxt: Label 'December';

    procedure PostRecords11(BonusRec: Record "Bonus Adjust B2B");
    var
        Lookup_B2B: Record Lookup_B2B;
        PayrollBusPostingGroup: Record "Payroll Bus. Post Group B2B";
        Employee: Record "Employee B2B";
        PayrollGeneralPostingGroup: Record "Payroll Gen. Posting Group B2B";
        EmpPostingGroup: Record "Employee Posting Group B2B";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PayBusiness: Code[20];
        PayElement: Code[20];
        "AccountNo.": Code[20];
        AccountType: Option "G/L Account";


    begin
        BonusRec.TESTFIELD("Document No.");
        BonusRec.TESTFIELD("Posting Date");
        BonusRec.TESTFIELD("Journal Batch Name");

        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
        Lookup_B2B.SETRANGE("Lookup Name", BONUSTxt);
        if Lookup_B2B.IsEmpty() then
            ERROR(Text001Lbl, BONUSTxt);

        Lookup_B2B.RESET();
        Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
        Lookup_B2B.SETRANGE("Lookup Name", EXGRATIATxt);
        if Lookup_B2B.IsEmpty() then
            ERROR(Text001Lbl, BONUSTxt);

        Employee.RESET();
        Employee.SETRANGE("No.", BonusRec."Employee Code");
        if Employee.FINDFIRST() then;
        if PayrollBusPostingGroup.GET(Employee."Payroll Bus. Posting Group") then begin
            PayrollGeneralPostingGroup.SETRANGE("Payroll Bus. Posting Group", PayrollBusPostingGroup.Code);
            if PayrollGeneralPostingGroup.FINDFIRST() then
                PayBusiness := PayrollGeneralPostingGroup."Payroll Bus. Posting Group";
            Lookup_B2B.RESET();
            Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
            Lookup_B2B.SETRANGE("Lookup Name", EXGRATIATxt);
            if Lookup_B2B.FINDFIRST() then begin
                Lookup_B2B.TESTFIELD("Payroll Prod. Posting Group");
                PayElement := Lookup_B2B."Payroll Prod. Posting Group";
            end else
                ERROR(Text003Lbl, EXGRATIATxt);
            PayrollGeneralPostingGroup.SETRANGE("Payroll Prod. Posting Group", PayElement);
            if PayrollGeneralPostingGroup.IsEmpty() then
                ERROR(Text000Lbl, PayElement);

            Lookup_B2B.RESET();
            Lookup_B2B.SETRANGE("LookupType Name", AddDedTxt);
            Lookup_B2B.SETRANGE("Lookup Name", BONUSTxt);
            if Lookup_B2B.FINDFIRST() then begin
                Lookup_B2B.TESTFIELD("Payroll Prod. Posting Group");
                PayElement := Lookup_B2B."Payroll Prod. Posting Group";
            end else
                ERROR(Text003Lbl, EXGRATIATxt);

            PayrollGeneralPostingGroup.SETRANGE("Payroll Prod. Posting Group", PayElement);
            if PayrollGeneralPostingGroup.FINDFIRST() then
                "AccountNo." := PayrollGeneralPostingGroup."G/L Code"
            else
                ERROR(Text000Lbl, PayElement);
        end else
            ERROR(Text004Lbl, Employee."No.");

        Employee.SETRANGE("No.", BonusRec."Employee Code");
        if Employee.FINDFIRST() then
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        if EmpPostingGroup.FINDFIRST() then;
        AccountType := AccountType::"G/L Account";
        GenJnlLine.INIT();
        GenJnlLine."Journal Template Name" := BonusRec."Journal Template Name";
        GenJnlLine."Journal Batch Name" := BonusRec."Journal Batch Name";
        GenJnlLine."Document No." := BonusRec."Document No.";
        GenJnlLine."Line No." := BonusRec."Line No.";
        GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"G/L Account";
        Employee.SETRANGE("No.", BonusRec."Employee Code");
        if Employee.FINDFIRST() then
            if EmpPostingGroup.GET(Employee."Emp Posting Group") then begin
                EmpPostingGroup.TESTFIELD(EmpPostingGroup."Bonus Payable Acc.");
                GenJnlLine."Bal. Account No." := EmpPostingGroup."Bonus Payable Acc.";
                GenJnlLine.VALIDATE("Bal. Account No.");
            end;

        GenJnlLine.VALIDATE("Account No.");
        GenJnlLine."Posting Date" := BonusRec."Posting Date";
        GenJnlLine.Description := CopyStr(
        BonusRec."Employee Code" + ' ' + GenJnlLine.Description + ' ' +
        ReturnMonth(BonusRec.Month) + '' +
        FORMAT(BonusRec.Year), 1, 100);
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := "AccountNo.";
        GenJnlLine.VALIDATE("Bal. Account No.");
        GenJnlLine.Amount := BonusRec."Net Payable";
        GenJnlLine.VALIDATE(Amount);
        GenJnlLine."Source Code" := PAYMENTJNLTxt;
        GenJnlLine."Dimension Set ID" := BonusRec."Dimension Set ID";
        GenJnlPostLine.RunWithCheck(GenJnlLine);
    end;

    procedure ReturnMonth(Month: Integer): Code[20];
    begin
        case Month of
            1:
                exit(JanTxt);
            2:
                exit(FebuaryTxt);
            3:
                exit(MarchTxt);
            4:
                exit(AprilTxt);
            5:
                exit(MayTxt);
            6:
                exit(JuneTxt);
            7:
                exit(JulyTxt);
            8:
                exit(AugustTxt);
            9:
                exit(SeptemberTxt);
            10:
                exit(OctoberTxt);
            11:
                exit(NovemberTxt);
            12:
                exit(DecemberTxt);
        end;
    end;

    procedure ShowDocDim();
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1 %2', "Employee Code", "Employee Name"),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then
            MODIFY();
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "Employee Code" <> '' then
            MODIFY();

        if OldDimSetID <> "Dimension Set ID" then
            MODIFY();
    end;
}

