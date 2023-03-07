table 33001331 "HR Approval setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'HR Approval setup_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Resource Indent';
            OptionMembers = " ","Resource Indent";
            DataClassification = CustomerContent;
        }
        field(2; Department; Code[20])
        {
            Caption = 'Department';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(4));
            DataClassification = CustomerContent;
        }
        field(3; User; Code[50])
        {
            Caption = 'User';
            TableRelation = User;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                CLEAR(LoginMgt);
                User := LoginMgt.OpenUserPageForSelectedUser(UserRec);
                Employee.RESET();
                Employee.SETRANGE("User Id", User);
                if Employee.FINDFIRST() and ((Employee.Resigned) or (Employee.Blocked)) then begin
                    CLEAR(User);
                    ERROR(Text001lbl, Employee."No.");
                end;
            end;
        }
        field(4; HOD; Code[50])
        {
            Caption = 'HOD';
            TableRelation = User;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                CLEAR(LoginMgt);
                HOD := LoginMgt.OpenUserPageForSelectedUser(UserRec);
                if HOD <> '' then begin
                    Employee.RESET();
                    Employee.SETRANGE("User Id", HOD);
                    if Employee.FINDFIRST() then
                        if (Employee.Resigned) or (Employee.Blocked) then
                            ERROR(Text001Lbl, Employee."No.");

                end;
            end;
        }
        field(5; "Addtional  Approver"; Code[50])
        {
            Caption = 'Addtional  Approver';
            TableRelation = User;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                CLEAR(LoginMgt);
                "Addtional  Approver" := LoginMgt.OpenUserPageForSelectedUser(UserRec);
                if "Addtional  Approver" <> '' then begin
                    Employee.RESET();
                    Employee.SETRANGE("User Id", "Addtional  Approver");
                    if Employee.FINDFIRST() then
                        if (Employee.Resigned) or (Employee.Blocked) then
                            ERROR(Text001Lbl, Employee."No.");

                end;
            end;
        }
        field(6; "HR Approval"; Code[50])
        {
            Caption = 'HR Approval';
            TableRelation = User;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                CLEAR(LoginMgt);
                "HR Approval" := LoginMgt.OpenUserPageForSelectedUser(UserRec);
                if "HR Approval" <> '' then begin
                    Employee.RESET();
                    Employee.SETRANGE("User Id", "HR Approval");
                    if Employee.FINDFIRST() then
                        if (Employee.Resigned) or (Employee.Blocked) then
                            ERROR(Text001lbl, Employee."No.");

                end;
            end;
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", Department, User)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee B2B";
        UserRec: Record User;
        LoginMgt: Codeunit "Payroll Branch wise Misc B2B";
        Text001Lbl: Label 'You cannot select the employee %1', Comment = '%1 = No';
}

