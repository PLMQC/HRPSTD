page 33001258 "Pay Revision Document B2B"
{
    // version B2BHR1.00.00

    Caption = 'Pay Revision Document';
    PageType = Document;
    SourceTable = "Pay Revision Header B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Id."; "Id.")
                {
                    ToolTip = 'Specifies the Id number in pay revision document';
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field(Type; Type)
                {
                    ToolTip = '"specifies the type from drill down like a""EMployee"" , "" Grade"" etc "';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        TypeOnAfterValidate();
                    end;
                }
                field("No."; "No.")
                {
                    ToolTip = 'Specifies the emplyee number from the drill down list';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        NoOnAfterValidate();
                    end;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = '"Specifies the employee name against the employee number "';
                    ApplicationArea = all;
                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = '"Specifies the pay reveision effictive date "';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE();
                    end;
                }
                field(Posted; Posted)
                {
                    ToolTip = 'Specifies mark if posted in to payrevison document';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Editable = true;
                    ToolTip = 'specify the staus like "Opne" , "Released"';
                    ApplicationArea = all;
                }
                field("Caluclate For Entire Month"; "Caluclate For Entire Month")
                {
                    ToolTip = 'Specifies the pay revevion caluclations for entire month';
                    ApplicationArea = all;
                }
                field("Caluclate From Effective Date"; "Caluclate From Effective Date")
                {
                    ToolTip = 'Specifies the calculations from the effective date in pay reveison document';
                    ApplicationArea = all;
                }
            }
            part(RevisionLine; "Pay Revision Subform B2B")
            {
                Caption = 'RevisionLine';
                SubPageLink = "Header No." = FIELD("Id."),
                              Type = FIELD(Type),
                              "No." = FIELD("No.");
                ApplicationArea = all;
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ToolTip = 'Specifies the journal batch name';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    var
                        PayRevisionLine: Record "Pay Revision Line B2B";
                    begin
                        JournalTemplate.SETRANGE("Form ID", 33001258);
                        if JournalTemplate.FINDFIRST() then begin
                            JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                            if PAGE.RUNMODAL(33001274, JournalBatch) = ACTION::LookupOK then begin
                                "Journal Batch Name" := JournalBatch.Name;
                                "Journal Template Name" := JournalBatch."Journal Template Name";
                                "Posting Date" := workdate();
                                NoSeries.RESET();
                                NoSeries.SETRANGE(Code, JournalBatch."No. Series");
                                if NoSeries.FINDFIRST() then
                                    "Document No." := NoSeriesMgt.TryGetNextNo(NoSeries.Code, WORKDATE());
                                PayRevisionLine.SETRANGE("Header No.", "Id.");
                                PayRevisionLine.SETRANGE(Type, Type);
                                PayRevisionLine.SETRANGE("No.", "No.");
                                if PayRevisionLine.FINDSET() then
                                    repeat
                                        PayRevisionLine."Journal Template Name" := "Journal Template Name";
                                        PayRevisionLine."Journal Batch Name" := "Journal Batch Name";
                                        PayRevisionLine."Posting Date" := "Posting Date";
                                        PayRevisionLine."Document No." := "Document No.";
                                        PayRevisionLine.MODIFY();
                                    until PayRevisionLine.NEXT() = 0;
                            end;
                        end;
                    end;
                }
                field("Posting Date"; "Posting Date")
                {
                    ToolTip = 'Specifies the posting date of the journal';
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
                {
                    ToolTip = 'Specifies the document no of the journal';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Document)
            {
                Caption = 'Document';
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Dimension';

                    trigger OnAction();
                    begin
                        ShowDocDim();
                        CurrPage.SAVERECORD();
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Arrears")
                {
                    Caption = 'Calculate &Arrears';
                    Image = Balance;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Arrears';

                    trigger OnAction();
                    begin
                        TESTFIELD(Status, Status::Released);
                        CheckForValidEntries();
                        CalculateArrearAmount(Rec);
                        CalculateNewlyAddedArrears(Rec);
                        UpdateArrearAmount(Rec);
                        UpdateESIArrearAmount(Rec);
                        UpdatePFArrearAmount(Rec);
                        UpdatePTArrearAmount(Rec);
                        Status := Status::Open;
                        MODIFY();
                    end;
                }
                action("Grade &Transfer")
                {
                    Caption = 'Grade &Transfer';
                    Image = MoveUp;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Grade transfer';

                    trigger OnAction();
                    begin
                        TESTFIELD(Type, Type::Employee);
                        TESTFIELD("No.");
                        GradeTransfer.INIT();
                        GradeTransfer."Document No." := "Id.";
                        GradeTransfer."Employee No." := "No.";
                        GradeTransfer."Employee Name" := "Employee Name";
                        GradeTransfer.Grade := Grade;
                        GradeTransfer.SETRANGE("Document No.", "Id.");
                        GradeTransfer.SETRANGE("Employee No.", "No.");
                        GradeTransfer.SETRANGE(Grade, Grade);
                        if not GradeTransfer.FINDFIRST() then
                            GradeTransfer.INSERT();
                        GradeTransfer.SETRANGE("Document No.", "Id.");
                        GradeTransfer.SETRANGE("Employee No.", "No.");
                        GradeTransfer.SETRANGE(Grade, Grade);
                        if GradeTransfer.FINDFIRST() then
                            PAGE.RUN(33001266, GradeTransfer);
                    end;
                }
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Release';

                    trigger OnAction();
                    begin
                        Release();
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The reopen';
                    trigger OnAction();
                    begin
                        Reopen();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Post';

                    trigger OnAction();
                    begin
                        if Posted then
                            ERROR(Text002Lbl, "Id.");
                        if CONFIRM(Text001Lbl) then
                            if Type = Type::All then begin
                                CLEAR(PayHeadTemp);
                                PayHeadTemp.DELETEALL();
                                PayHeadTemp.INIT();
                                PayHeadTemp.TRANSFERFIELDS(Rec);
                                PayHeadTemp.INSERT();
                                PayHeadTemp.RESET();
                                PayHeadTemp.SETRANGE("Id.", "Id.");
                                if PayHeadTemp.FINDFIRST() then begin
                                    PayRevisionLine.RESET();
                                    PayRevisionLine.SETRANGE("Header No.", PayHeadTemp."Id.");
                                    PayRevisionLine.SETRANGE("Pay Element", Text005Lbl);
                                    if PayRevisionLine.FINDFIRST() then
                                        repeat
                                            PayHeadTemp."No." := PayRevisionLine."No.";
                                            PayHeadTemp.MODIFY();
                                            ArrearPosting.ProcessPosting(PayHeadTemp);
                                            PostPayRevision(PayHeadTemp);
                                        until PayRevisionLine.NEXT() = 0;
                                    PayHeadTemp."No." := '';
                                    PayHeadTemp.MODIFY();
                                    PayRevHead.RESET();
                                    PayRevHead.SETRANGE("Id.", PayHeadTemp."Id.");
                                    if PayRevHead.FINDFIRST() then begin
                                        PayRevHead.Posted := true;
                                        PayRevHead.MODIFY();
                                    end;
                                    MESSAGE(Text004Lbl);
                                end;
                            end else begin
                                ArrearPosting.ProcessPosting(Rec);
                                PostPayRevision(Rec);
                                Posted := true;
                                UpdateProcessedsalary();
                                MESSAGE(Text004Lbl);
                            end;

                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    var
        PayrollUsers: Record "Payroll Location Users B2B";
    begin
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
    end;

    var
        GradeTransfer: Record "Grade Transfer B2B";
        PayRevisionLine: Record "Pay Revision Line B2B";

        PayHeadTemp: Record "Pay Revision Header B2B";
        PayRevHead: Record "Pay Revision Header B2B";
        NoSeries: Record "No. Series";
        JournalTemplate: Record "Payroll Journal Template B2B";
        JournalBatch: Record "Payroll Journal Batch B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        NoSeriesMgt: Codeunit 396;
        ArrearPosting: Codeunit "Arrear Posting B2B";
        Text001Lbl: Label 'Do you want to post Pay Revision ?';
        Text002Lbl: Label 'Pay Revision %1 is already posted.', Comment = '%1 = Id';

        Text003Lbl: Label 'No Revision is Done';
        Text004Lbl: Label 'Posted succesfully';
        Text005Lbl: Label 'BASIC';

    local procedure TypeOnAfterValidate();
    begin
        CurrPage.UPDATE();
    end;

    local procedure NoOnAfterValidate();
    begin
        CurrPage.UPDATE();
    end;

    procedure UpdateProcessedsalary();
    var
        ProcessedSalary: Record "Processed Salary B2B";
        StartMonth: Integer;
        StartYear: Integer;
        EndMonth: Integer;
        EndYear: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
    begin
        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", "Id.");
        PayRevisionLine.SETRANGE("Pay Element", Text005Lbl);
        if PayRevisionLine.FINDFIRST() then;
        CLEAR(StartMonth);
        CLEAR(StartYear);
        CLEAR(EndMonth);
        CLEAR(EndYear);
        StartMonth := DATE2DMY("Effective Date", 2);
        StartYear := DATE2DMY("Effective Date", 3);
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
        ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', StartMonth);
        ProcessedSalary.SETFILTER(Year, '>=%1', StartYear);
        ProcessedSalary.SETRANGE(Posted, true);
        ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
        if ProcessedSalary.FINDLAST() then begin
            EndMonth := ProcessedSalary."Pay Slip Month";
            EndYear := ProcessedSalary.Year;
        end;
        CheckMonth := StartMonth;
        CheckYear := StartYear;
        repeat
            ProcessedSalary.RESET();
            ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
            ProcessedSalary.SETRANGE("Pay Slip Month", CheckMonth);
            ProcessedSalary.SETRANGE(Year, CheckYear);
            ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
            if ProcessedSalary.FINDFIRST() then
                repeat
                    ProcessedSalary."Arrears Not Posted" := false;
                    ProcessedSalary.MODIFY();
                until ProcessedSalary.NEXT() = 0;

            CheckMonth := CheckMonth + 1;
            if CheckMonth = 13 then begin
                CheckMonth := 1;
                CheckYear := CheckYear + 1;
            end;
        until ((CheckMonth > EndMonth) and (CheckYear = EndYear)) or (CheckYear > EndYear);
    end;

    procedure CheckForValidEntries();
    var
        DiffFound: Boolean;
    begin
        DiffFound := false;
        PayRevisionLine.RESET();
        PayRevisionLine.SETRANGE("Header No.", "Id.");
        if PayRevisionLine.FINDFIRST() then
            repeat
                if (PayRevisionLine."Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent") and (PayRevisionLine."Amount / Percent" = PayRevisionLine."Revised Amount / Percent") then
                    DiffFound := false
                else
                    if (PayRevisionLine."Fixed / Percent" <> PayRevisionLine."Revised Fixed / Percent") or (PayRevisionLine."Amount / Percent" <> PayRevisionLine."Revised Amount / Percent") then
                        DiffFound := true;
            until (PayRevisionLine.NEXT() = 0) or (DiffFound);
        if not DiffFound then
            ERROR(Text003Lbl);
    end;
}

