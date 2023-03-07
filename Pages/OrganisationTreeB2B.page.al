page 33001582 "Organisation Tree B2B"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Organisation Tree B2B";
    Editable = false;




    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                IndentationColumn = Indenantion;
                IndentationControls = Name;
                ShowAsTree = true;
                field(code; Code)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies The code';
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = NoEmphasize;
                    ToolTip = 'Specifies The Name';

                }
                Field(EMPCount; EMPCount)
                {
                    ApplicationArea = All;
                    Caption = 'Count';
                    ToolTip = 'Specifies The Emp count';
                }
            }
        }

    }

    trigger OnAfterGetRecord()

    begin
        NoEmphasize := Indenantion <> 3;
    end;

    trigger OnOpenPage()
    begin
        InsertEntries();
    end;

    var
        NoEmphasize: Boolean;




    local procedure InsertEntries()
    var
        OrganisationTree: record "Organisation Tree B2B";
        LookupRec: Record Lookup_B2B;
        lookuprecDivision: Record Lookup_B2B;
        EmployeeB2B: Record "Employee B2B";
        EmployeeB2BCheck: Record "Employee B2B";
        PayrollLocations: Record "Payroll Locations B2B";
        EntryNum: Integer;
        DeptCode: code[50];
        DivsionCode: Code[50];
    begin
        OrganisationTree.DELETEALL();

        EntryNum := 1;
        DeptCode := 'DEPARTMENTS';
        DivsionCode := 'DESIGNATIONS';
        PayrollLocations.RESET();
        if PayrollLocations.FINDSET() then
            repeat
                OrganisationTree.INIT();
                OrganisationTree."Entry No." := Entrynum;
                OrganisationTree.Name := PayrollLocations."Location Code";
                OrganisationTree.Indenantion := 0;
                EmployeeB2BCheck.RESET();
                EmployeeB2BCheck.setrange("Location Code", PayrollLocations."Location Code");
                if EmployeeB2BCheck.FINDSET() then
                    OrganisationTree.Empcount := EmployeeB2BCheck.count();
                OrganisationTree.INSERT();
                EntryNum += 1;

                LookupRec.RESET();
                lookuprec.SetCurrentKey(Priority);
                LookupRec.setrange("LookupType Name", DeptCode);
                if lookuprec.FINDSET() then
                    repeat
                        OrganisationTree.INIT();
                        OrganisationTree."Entry No." := Entrynum;
                        OrganisationTree.Name := Lookuprec."Lookup Name";
                        OrganisationTree.Indenantion := 1;
                        EmployeeB2BCheck.RESET();
                        EmployeeB2BCheck.setrange("Location Code", PayrollLocations."Location Code");
                        EmployeeB2BCheck.setrange("Department Code", lookuprec."Lookup Name");
                        if EmployeeB2BCheck.FINDSET() then begin
                            OrganisationTree.Empcount := EmployeeB2BCheck.count();
                            OrganisationTree.INSERT();

                        end;
                        EntryNum += 1;

                        lookuprecDivision.RESET();
                        lookuprecDivision.SetCurrentKey(Priority);
                        lookuprecDivision.setrange("LookupType Name", DivsionCode);
                        if lookuprecDivision.FINDSET() then
                            repeat

                                OrganisationTree.INIT();
                                OrganisationTree."Entry No." := Entrynum;
                                OrganisationTree.Name := lookuprecDivision."Lookup Name";
                                OrganisationTree.Indenantion := 2;
                                EmployeeB2BCheck.RESET();
                                EmployeeB2BCheck.setrange("Location Code", PayrollLocations."Location Code");
                                EmployeeB2BCheck.setrange("Department Code", lookuprec."Lookup Name");
                                EmployeeB2Bcheck.setrange(Designation, lookuprecDivision."Lookup Name");
                                if EmployeeB2BCheck.FINDSET() then begin
                                    OrganisationTree.Empcount := EmployeeB2BCheck.count();
                                    OrganisationTree.INSERT();
                                end;
                                EntryNum += 1;
                                EmployeeB2B.RESET();
                                EmployeeB2B.setrange("Location Code", PayrollLocations."Location Code");
                                EmployeeB2B.setrange(Designation, lookuprecDivision."Lookup Name");
                                EmployeeB2B.setrange("Department Code", lookuprec."Lookup Name");
                                if EmployeeB2B.FINDSET() then
                                    repeat
                                        OrganisationTree.INIT();
                                        OrganisationTree."Entry No." := Entrynum;
                                        OrganisationTree.Name := EmployeeB2B."No." + ' ' + EmployeeB2B.FullName();
                                        OrganisationTree.Indenantion := 3;
                                        OrganisationTree.Empcount := 0;
                                        OrganisationTree.INSERT();
                                        EntryNum += 1;
                                    until EmployeeB2B.NEXT() = 0;


                            until lookuprecDivision.NEXT() = 0;


                    until lookuprec.NEXT() = 0;


            until PayrollLocations.NEXT() = 0;

    end;

    local procedure InsertEntries2()
    var
        OrganisationTree: record "Organisation Tree B2B";
        LookupRec: Record Lookup_B2B;
        EmployeeB2B: Record "Employee B2B";
        PayrollLocations: Record "Payroll Locations B2B";
        EntryNum: Integer;
        DeptCode: code[50];
    begin
        OrganisationTree.DELETEALL();
        EntryNum := 1;
        DeptCode := 'DEPARTMENTS';
        LookupRec.RESET();
        lookuprec.SetCurrentKey(Priority);
        LookupRec.setrange("LookupType Name", DeptCode);
        if lookuprec.FINDSET() then
            repeat
                OrganisationTree.INIT();
                OrganisationTree."Entry No." := Entrynum;
                OrganisationTree.Name := Lookuprec."Lookup Name";
                OrganisationTree.Indenantion := 1;
                OrganisationTree.INSERT();
                EntryNum += 1;
                PayrollLocations.RESET();
                if PayrollLocations.FINDSET() then
                    repeat
                        OrganisationTree.INIT();
                        OrganisationTree."Entry No." := Entrynum;
                        OrganisationTree.Name := PayrollLocations."Location Code";
                        OrganisationTree.Indenantion := 2;
                        OrganisationTree.INSERT();
                        EntryNum += 1;
                        EmployeeB2B.RESET();
                        EmployeeB2B.setrange("Department Code", lookuprec."Lookup Name");
                        EmployeeB2B.setrange("Location Code", PayrollLocations."Location Code");
                        if EmployeeB2B.FINDSET() then
                            repeat
                                OrganisationTree.INIT();
                                OrganisationTree."Entry No." := Entrynum;
                                OrganisationTree.Name := EmployeeB2B."No.";
                                OrganisationTree.Indenantion := 3;
                                OrganisationTree.INSERT();
                                EntryNum += 1;
                            until EmployeeB2B.NEXT() = 0;


                    until PayrollLocations.NEXT() = 0;


            until lookuprec.NEXT() = 0;

    end;




}