table 33001250 "Payroll Journal Template B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Journal Template';
    LookupPageID = "Payroll Jou Template List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Test Report ID"; Integer)
        {
            Caption = 'Test Report ID';
            DataClassification = CustomerContent;
        }
        field(6; "Form ID"; Integer)
        {
            Caption = 'Form ID';
            DataClassification = CustomerContent;
        }
        field(7; "Posting Report ID"; Integer)
        {
            Caption = 'Posting Report ID';
            DataClassification = CustomerContent;
        }
        field(8; "Force Posting Report"; Boolean)
        {
            Caption = 'Force Posting Report';
            DataClassification = CustomerContent;
        }
        field(9; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Salary Post,Salary Payment,Salary Adjustment,Pay Revision,Bonus,Final Settlement,Leave Encashment,LV Enc Payment,FS Payment,,,Pay Revision Payment,Loan Repayment';
            OptionMembers = "Salary Post","Salary Payment","Salary Adjustment","Pay Revision",Bonus,"Final Settlement","Leave Encashment","LV Enc Payment","FS Payment",,,"Pay Revision Payment","Loan Repayment";

            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                case Type of
                    Type::"Salary Post":
                        "Form ID" := 33001231;
                    Type::"Salary Payment":
                        "Form ID" := 33001277;
                    Type::"Salary Adjustment":
                        "Form ID" := 33001537;
                    Type::"Pay Revision":
                        "Form ID" := 33001258;
                    Type::Bonus:
                        "Form ID" := 33001265;
                    Type::"Leave Encashment":
                        "Form ID" := 33001239;
                    Type::"Final Settlement":
                        "Form ID" := 33001261;
                    Type::"LV Enc Payment":
                        "Form ID" := 33001525;
                    Type::"FS Payment":
                        "Form ID" := 33001501;
                    Type::"Pay Revision Payment":
                        "Form ID" := 33001407;
                    Type::"Loan Repayment":
                        "Form ID" := 33001248;

                end;
                PayrollJnlTemplate.RESET();
                if PayrollJnlTemplate.FINDFIRST() then
                    repeat
                        if PayrollJnlTemplate.Type <> PayrollJnlTemplate.Type::"Salary Post" then
                            if PayrollJnlTemplate.Type = Type then
                                ERROR(Text003Lbl, Type);

                    until PayrollJnlTemplate.NEXT() = 0;
            end;
        }
        field(10; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
            DataClassification = CustomerContent;
        }
        field(11; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(12; Recurring; Boolean)
        {
            Caption = 'Recurring';
            DataClassification = CustomerContent;
        }
        field(15; "Test Report Name"; Text[80])
        {
            CalcFormula = Lookup (AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Test Report ID")));
            Caption = 'Test Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Form Name"; Text[80])
        {
            CalcFormula = Lookup (AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Page),
                                                                           "Object ID" = FIELD("Form ID")));
            Caption = 'Form Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Posting Report Name"; Text[80])
        {
            CalcFormula = Lookup (AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Posting Report ID")));
            Caption = 'Posting Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Force Doc. Balance"; Boolean)
        {
            Caption = 'Force Doc. Balance';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(19; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
            DataClassification = CustomerContent;
        }
        field(20; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset";
            DataClassification = CustomerContent;
        }
        field(21; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "No. Series" <> '' then begin
                    if Recurring then
                        ERROR(
                          Text000Lbl,
                          FIELDCAPTION("Posting No. Series"));
                    if "No. Series" = "Posting No. Series" then
                        "Posting No. Series" := '';
                end;
            end;
        }
        field(22; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Posting No. Series" = "No. Series") and ("Posting No. Series" <> '') then
                    FIELDERROR("Posting No. Series", STRSUBSTNO(Text001Lbl, "Posting No. Series"));
            end;
        }
        field(23; "Copy VAT Setup to Jnl. Lines"; Boolean)
        {
            Caption = 'Copy VAT Setup to Jnl. Lines';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(24; "Allow VAT Difference"; Boolean)
        {
            Caption = 'Allow VAT Difference';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
            begin
            end;
        }
        field(25; "Cust. Receipt Report ID"; Integer)
        {
            Caption = 'Cust. Receipt Report ID';
            DataClassification = CustomerContent;
        }
        field(26; "Cust. Receipt Report Name"; Text[80])
        {
            CalcFormula = Lookup (AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Cust. Receipt Report ID")));
            Caption = 'Cust. Receipt Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Vendor Receipt Report ID"; Integer)
        {
            Caption = 'Vendor Receipt Report ID';
            DataClassification = CustomerContent;
        }
        field(28; "Vendor Receipt Report Name"; Text[80])
        {
            CalcFormula = Lookup (AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Vendor Receipt Report ID")));
            Caption = 'Vendor Receipt Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Name)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        VALIDATE(Type);
    end;

    var
        PayrollJnlTemplate: Record "Payroll Journal Template B2B";
        Text000Lbl: Label 'Only the %1 field can be filled in on recurring journals.', Comment = '%1 = No Series';
        Text001Lbl: Label 'must not be %1', Comment = '%1 = No Series';
        Text003Lbl: Label 'Template  is already exist with the type %1', Comment = '%1 = Type ';
}

