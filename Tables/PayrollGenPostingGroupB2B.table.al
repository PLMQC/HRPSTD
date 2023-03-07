table 33001247 "Payroll Gen. Posting Group B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll General Posting Group';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Payroll Bus. Posting Group"; Code[20])
        {
            Caption = 'Payroll Bus. Posting Group';
            TableRelation = "Payroll Bus. Post Group B2B";
            DataClassification = CustomerContent;
        }
        field(2; "Payroll Prod. Posting Group"; Code[20])
        {
            Caption = 'Payroll Prod. Posting Group';
            NotBlank = true;
            TableRelation = "Payroll Prod. Post. Group B2B";
            DataClassification = CustomerContent;
        }
        field(3; "G/L Code"; Code[20])
        {
            Caption = 'G/L Code';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckGLAcc("G/L Code", false);
            end;
        }
    }

    keys
    {
        key(Key1; "Payroll Bus. Posting Group", "Payroll Prod. Posting Group", "G/L Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GLAcc: Record "G/L Account";

    local procedure CheckGLAcc(AccNo: Code[20]; DirectPosting: Boolean);
    begin
        if AccNo = '' then
            exit;
        GLAcc.GET(AccNo);
        GLAcc.CheckGLAcc();
        if DirectPosting then
            GLAcc.TESTFIELD("Direct Posting");
    end;
}

