table 33001243 "Grade Transfer B2B"
{
    // version B2BHR1.00.00

    Caption = 'Grade Transfer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
        }
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(3; Grade; Code[30])
        {
            Caption = 'Grade';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
            DataClassification = CustomerContent;
        }
        field(4; "New Grade"; Code[20])
        {
            Caption = 'New Grade';
            TableRelation = Lookup_B2B."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
            DataClassification = CustomerContent;
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Grade, "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TeststatusOpen();
    end;

    trigger OnInsert();
    begin
        TeststatusOpen();
    end;

    trigger OnModify();
    begin
        TeststatusOpen();
    end;

    var
        PayRevisionHeadGRec: Record "Pay Revision Header B2B";

    procedure InsertGradePayElements(GradeTransfer: Record "Grade Transfer B2B");
    var
        PayRevisionHeader: Record "Pay Revision Header B2B";
    begin
        PayRevisionHeader.SETRANGE("Id.", "Document No.");
        PayRevisionHeader.SETRANGE(Type, PayRevisionHeader.Type::Employee);
        PayRevisionHeader.SETRANGE("No.", "Employee No.");
        if PayRevisionHeader.FINDFIRST() then
            GetPayCadrePayElements(PayRevisionHeader, "New Grade");
    end;

    procedure GetPayCadrePayElements(PayRevisionHeader: Record "Pay Revision Header B2B"; NewGrade: Code[20]);
    var
        PayCadrePayElement: Record "Pay Cadre Pay Element B2B";
        TempPayRevisionline: Record "Pay Revision Line B2B";
        PayRevisionlineLRec: Record "Pay Revision Line B2B";
        HRSetup: Record "HR Setup B2B";
        CheckDate: Date;
        LineNo: Integer;
    begin
        LineNo := 0;
        PayRevisionlineLRec.RESET();
        PayRevisionlineLRec.SETRANGE("Header No.", PayRevisionHeader."Id.");
        if PayRevisionlineLRec.FINDLAST() then
            LineNo := PayRevisionlineLRec."Line No." + 10000
        else
            LineNo := 10000;

        if HRSetup.FINDFIRST() then
            CheckDate := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");

        if PayRevisionHeader.Type = PayRevisionHeader.Type::Employee then begin
            PayCadrePayElement.SETRANGE("Pay Cadre Code", NewGrade);
            PayCadrePayElement.SETRANGE(PayCadrePayElement.Processed, false);
            if PayCadrePayElement.FINDFIRST() then
                repeat
                    TempPayRevisionline.RESET();
                    TempPayRevisionline.SETRANGE("Header No.", PayRevisionHeader."Id.");
                    TempPayRevisionline.SETRANGE(Type, PayRevisionHeader.Type);
                    TempPayRevisionline.SETRANGE("No.", PayRevisionHeader."No.");
                    TempPayRevisionline.SETRANGE("Pay Element", PayCadrePayElement."Pay Element Code");
                    if TempPayRevisionline.FINDFIRST() then begin
                        TempPayRevisionline."Revised Amount / Percent" := PayCadrePayElement."Amount / Percent";
                        TempPayRevisionline."Revised Fixed / Percent" := PayCadrePayElement."Fixed/Percent";
                        TempPayRevisionline."Revised Computation Type" := PayCadrePayElement."Computation Type";
                        TempPayRevisionline."Add/Deduct" := PayCadrePayElement."Add/Deduct";
                        TempPayRevisionline."Modified PayElement" := true;
                        TempPayRevisionline."Effective Date" := PayRevisionHeader."Effective Date";
                        TempPayRevisionline.MODIFY();
                    end else begin
                        TempPayRevisionline.INIT();
                        TempPayRevisionline."Header No." := PayRevisionHeader."Id.";
                        TempPayRevisionline."Line No." := LineNo;
                        TempPayRevisionline."No." := PayRevisionHeader."No.";
                        TempPayRevisionline."Effective Date" := PayRevisionHeader."Effective Date";
                        TempPayRevisionline."Pay Element" := PayCadrePayElement."Pay Element Code";
                        TempPayRevisionline."Starting Date" := PayCadrePayElement."Effective Start Date";
                        TempPayRevisionline."Computation Type" := PayCadrePayElement."Computation Type";
                        TempPayRevisionline."Amount / Percent" := PayCadrePayElement."Amount / Percent";
                        TempPayRevisionline."Revised Amount / Percent" := PayCadrePayElement."Amount / Percent";
                        TempPayRevisionline."Revised Fixed / Percent" := PayCadrePayElement."Fixed/Percent";
                        TempPayRevisionline."Revised Computation Type" := PayCadrePayElement."Computation Type";
                        TempPayRevisionline."Add/Deduct" := PayCadrePayElement."Add/Deduct";
                        TempPayRevisionline."Modified PayElement" := true;
                        TempPayRevisionline.INSERT();
                        LineNo += 10000;
                    end;
                until PayCadrePayElement.NEXT() = 0;

            PayRevisionHeader."New Grade" := NewGrade;
            PayRevisionHeader.MODIFY();
        end;
    end;

    procedure TeststatusOpen();
    begin
        PayRevisionHeadGRec.RESET();
        PayRevisionHeadGRec.SETRANGE("Id.", "Document No.");
        if PayRevisionHeadGRec.FINDFIRST() then
            if PayRevisionHeadGRec.Status = PayRevisionHeadGRec.Status::Released then
                PayRevisionHeadGRec.TESTFIELD(Status, PayRevisionHeadGRec.Status::Open);

    end;
}

