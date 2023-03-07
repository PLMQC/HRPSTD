table 33001213 "TourIntimation Setup B2B"
{
    // version B2BHR1.00.00

    Caption = 'TourIntimation Setup';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Tour Intimation';
            OptionMembers = " ","Tour Intimation";
            DataClassification = CustomerContent;
        }
        field(2; Department; Code[20])
        {
            Caption = 'Department';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("Lookup Type" = CONST(4));
            DataClassification = CustomerContent;
        }
        field(3; "Department User"; Code[50])
        {
            Caption = 'Department User';
            TableRelation = User;
            DataClassification = CustomerContent;
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
        field(5; Authoriser; Code[50])
        {
            Caption = 'Authoriser';
            TableRelation = User;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                CLEAR(LoginMgt);
                Authoriser := LoginMgt.OpenUserPageForSelectedUser(UserRec);
                if Authoriser <> '' then begin
                    Employee.RESET();
                    Employee.SETRANGE("User Id", Authoriser);
                    if Employee.FINDFIRST() then
                        if (Employee.Resigned) or (Employee.Blocked) then
                            ERROR(Text001Lbl, Employee."No.");
                end;
            end;
        }
        field(6; Approver; Code[50])
        {
            Caption = 'Approver';
            TableRelation = User;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                CLEAR(LoginMgt);
                Approver := LoginMgt.OpenUserPageForSelectedUser(UserRec);
                if Approver <> '' then begin
                    Employee.RESET();
                    Employee.SETRANGE("User Id", Approver);
                    if Employee.FINDFIRST() then
                        if (Employee.Resigned) or (Employee.Blocked) then
                            ERROR(Text001Lbl, Employee."No.");

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
        key(Key1; "Document Type", Department, "Department User")
        {
        }
        key(Key2; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        TIsetup.RESET();
        TIsetup.SETCURRENTKEY("Line No.");
        if TIsetup.FINDLAST() then
            "Line No." := TIsetup."Line No." + 1
        else
            "Line No." := 1;
    end;

    var
        Employee: Record "Employee B2B";
        TIsetup: Record "TourIntimation Setup B2B";
        UserRec: Record User;

        LoginMgt: Codeunit "Payroll Branch wise Misc B2B";
        Text001Lbl: Label 'You cannot select the employee %1',Comment = '%1 = Employee No.';
}

