codeunit 33001213 "Payroll Branch wise Misc B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
    end;

    var
        Text001Txt: Label '%1 is not payroll user', Comment = '%1 =User';

    procedure OpenUserPageForSelectedUser(var User: Record User): Code[50]
    var
        UserLookup: Page "User Lookup";
    begin
        UserLookup.Editable := false;
        //UserLookup.SetTableView(User);
        UserLookup.LookupMode(true);
        UserLookup.RunModal();
        UserLookup.SetSelectionFilter(User);
        if User.FindFirst() then
            Exit(User."User Name");
    end;

    procedure ReturnTrimmedUserID(UserIDLVarPar: Text[132]): Code[132];
    var
        UserIDTrimmedLVar: Code[132];
        StrPosLVar: Integer;
    begin
        CLEAR(StrPosLVar);
        StrPosLVar := STRPOS(UserIDLVarPar, '\');
        evaluate(UserIDTrimmedLVar, COPYSTR(UserIDLVarPar, (StrPosLVar + 1),
                                              (STRLEN(UserIDLVarPar) - StrPosLVar)));
        exit(UserIDTrimmedLVar);
    end;

    procedure ReturnUserLocationCode(): Code[20];
    var
        PayrollLocUserLRec: Record "Payroll Location Users B2B";
        LocCodeLVar: Code[20];
    begin
        CLEAR(LocCodeLVar);
        PayrollLocUserLRec.RESET();
        if PayrollLocUserLRec.FINDFIRST() then
            repeat
                if LOWERCASE(USERID()) = LOWERCASE(PayrollLocUserLRec."User ID") then
                    LocCodeLVar := PayrollLocUserLRec."Location Code";
            until PayrollLocUserLRec.NEXT() = 0;
        exit(LocCodeLVar);
    end;

    procedure ReturnPayrollUserID(): Code[50];
    var
        PayrollLocUserLRec: Record "Payroll Location Users B2B";
        UserIDExsists: Boolean;
        UserCode: Code[50];
    begin
        CLEAR(UserIDExsists);
        PayrollLocUserLRec.RESET();
        if PayrollLocUserLRec.FINDFIRST() then
            repeat
                if USERID() = PayrollLocUserLRec."User ID" then
                    UserIDExsists := true;
            until PayrollLocUserLRec.NEXT() = 0;

        if UserIDExsists then begin
            Evaluate(UserCode, USERID());
            exit(UserCode);
        end else begin
            MESSAGE(Text001Txt, USERID());
            exit('');
        end;
    end;
}

