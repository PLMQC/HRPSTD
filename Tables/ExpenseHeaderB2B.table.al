table 33001398 "Expense Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Expense Header';
    DrillDownPageID = "Expense Statements B2B";
    LookupPageID = "Expense Statements B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.GET();
                    HRSetup.TESTFIELD("Travel Expenses Nos.");
                    NoSeriesMgmt.TestManual(HRSetup."Travel Expenses Nos.");
                    "No.Series" := '';
                end;
            end;
        }
        field(10; "Employee No."; Code[100])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B" WHERE(Blocked = const(False));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                GetEmp();
                "Employee Name" := CopyStr(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name", 1, 50);
                "Category Code" := Employee."Category Code";
            end;
        }
        field(11; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(12; Designation; Text[30])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(60; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(61; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(62; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending For Approval';
            OptionMembers = Open,Released,"Pending For Approval";
            DataClassification = CustomerContent;
        }
        field(72; "Travel Req. No."; Code[20])
        {
            Caption = 'Travel Req. No.';
            TableRelation = "Posted Travel Requisition B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                CopyRequisitionLines("Travel Req. No.", "No.");
            end;
        }
        field(80; "Mode of Travel"; Option)
        {
            Caption = 'Mode of Travel';
            OptionCaption = 'By Road,By Rail,By Sea,By Air';
            OptionMembers = "By Road","By Rail","By Sea","By Air";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(490; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            TableRelation = Category_B2B;
            DataClassification = CustomerContent;
        }
        field(491; "City Type"; Code[20])
        {
            Caption = 'City Type';
            TableRelation = "Cities Type B2B".Code;
            DataClassification = CustomerContent;
        }
        field(492; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(500; "Time Stamp"; DateTime)
        {
            Caption = 'Time Stamp';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(501; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(502; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            Editable = false;
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(801; "Offset Account"; Code[20])
        {
            Caption = 'Offset Account';
            TableRelation = "G/L Account" WHERE(Blocked = CONST(false),
                                                 "Account Type" = CONST(Posting));
            DataClassification = CustomerContent;
        }
        field(802; "Posting Description"; Text[30])
        {
            Caption = 'Posting Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        ExpenseLine: Record "Expense Line B2B";
    begin
        TestStatus();

        ExpenseLine.RESET();
        ExpenseLine.SETRANGE("Document No.", "No.");
        ExpenseLine.DELETEALL();
    end;

    trigger OnInsert();
    begin

        if "No." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD("Travel Expenses Nos.");
            NoSeriesMgmt.InitSeries(HRSetup."Travel Expenses Nos.", xRec."No.Series", 0D, "No.", "No.Series");
        end;

        Evaluate("Created By", USERID());
        "Time Stamp" := CREATEDATETIME(TODAY(), TIME());
    end;

    trigger OnRename();
    begin
        ERROR(Text001Lbl);
    end;

    var
        Employee: Record "Employee B2B";
        HRSetup: Record "HR Setup B2B";
        DimMgt: Codeunit 408;
        NoSeriesMgmt: Codeunit 396;
        Text001Lbl: Label 'You cannot Rename Expense Document.';
        Text002Lbl: Label 'Expense Document %1 Released.', Comment = '%1 = No';
        Text003Lbl: Label 'Expense Document %1 Open.', Comment = '%1 = No';
        Text004Lbl: Label 'Document %1 Posted Successfully.', Comment = '%1 = No';

    procedure AssistEdit(OldExpenseHeader: Record "Expense Header B2B"): Boolean;
    begin
        HRSetup.GET();
        HRSetup.TESTFIELD("Travel Expenses Nos.");
        if NoSeriesMgmt.SelectSeries(HRSetup."Travel Expenses Nos.", OldExpenseHeader."No.Series", "No.Series") then begin
            NoSeriesMgmt.SetSeries("No.");
            exit(true);
        end;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "No." <> '' then
            MODIFY();

        if OldDimSetID <> "Dimension Set ID" then begin
            MODIFY();
            if LinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20]);
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure ShowDimensions();
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1', "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then begin
            MODIFY();
            if LinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure GetEmp();
    begin
        if not Employee.GET("Employee No.") then
            CLEAR(Employee);
    end;

    local procedure ReleaseDoc();
    begin
        OnBeforeReleaseAction(Rec);
        TESTFIELD(Status, Status::Open);
        Status := Status::Released;
        if MODIFY() then
            MESSAGE(Text002Lbl, "No.");
        OnAfterReleaseAction(Rec);
    end;

    local procedure ReOpenDoc();
    begin
        OnBeforeOpenAction(Rec);
        TESTFIELD(Status, Status::Released);
        Status := Status::Open;
        if MODIFY() then
            MESSAGE(Text003Lbl, "No.");
        OnAfterOpenAction(Rec);
    end;

    procedure TestStatus();
    begin
        TESTFIELD(Status, Status::Open);
    end;

    procedure PostDocument(var ExpenseHdr: Record "Expense Header B2B");
    var
        ExpenseLine: Record "Expense Line B2B";
        ExpenseLine2: Record "Expense Line B2B";
        PostedExpHeader: Record "Posted Expense Header B2B";
        PostedExpLine: Record "Posted Expense Line B2B";
        PrevCompType: Text;
        ApprovedAmount: Decimal;

    begin
        OnBeforePostAction(ExpenseHdr);
        TESTFIELD(Status, Status::Released);
        TESTFIELD("Travel Req. No.");
        CLEAR(PrevCompType);
        ExpenseLine.RESET();
        ExpenseLine.SETCURRENTKEY("Component Type");
        ExpenseLine.SETRANGE("Document No.", ExpenseHdr."No.");
        if ExpenseLine.FINDSET() then
            repeat
                if ExpenseLine."Component Type" <> PrevCompType then begin
                    PrevCompType := ExpenseLine."Component Type";
                    ExpenseLine2.RESET();
                    ExpenseLine2.SETRANGE("Document No.", ExpenseHdr."No.");
                    ExpenseLine2.SETRANGE("Component Type", ExpenseLine."Component Type");
                    if ExpenseLine2.FINDSET() then
                        ExpenseLine2.CALCSUMS("Approved Amount (LCY)");
                    ApprovedAmount := ExpenseLine2."Approved Amount (LCY)";
                    ExpenseLine2.RESET();
                    ExpenseLine2.SETRANGE("Document No.", ExpenseHdr."No.");
                    ExpenseLine2.SETRANGE("Component Type", ExpenseLine."Component Type");
                    ExpenseLine2.SETRANGE("Approved Amount (LCY)", 0);
                    if ExpenseLine2.FINDSET() then
                        ExpenseLine2.CALCSUMS("Amount (LCY)");
                    ApprovedAmount += ExpenseLine2."Amount (LCY)";

                    FillGenJournal(ExpenseLine2, ExpenseHdr, ApprovedAmount);
                end;
            until ExpenseLine.NEXT() = 0;

        PostedExpHeader.TRANSFERFIELDS(ExpenseHdr);
        PostedExpHeader.INSERT();

        ExpenseLine.RESET();
        ExpenseLine.SETRANGE("Document No.", ExpenseHdr."No.");
        if ExpenseLine.FINDSET() then
            repeat
                PostedExpLine.TRANSFERFIELDS(ExpenseLine);
                PostedExpLine.INSERT();
            until ExpenseLine.NEXT() = 0;
        MESSAGE(Text004Lbl, ExpenseHdr."No.");
        ExpenseHdr.DELETE();
        ExpenseLine.DELETEALL();
        OnAfterPostAction(ExpenseHdr);
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnBeforeReleaseAction(var ExpenseHdr: Record "Expense Header B2B");
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnBeforeOpenAction(var ExpenseHdr: Record "Expense Header B2B");
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnBeforePostAction(var ExpenseHdr: Record "Expense Header B2B");
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnAfterReleaseAction(var ExpenseHdr: Record "Expense Header B2B");
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnAfterOpenAction(var ExpenseHdr: Record "Expense Header B2B");
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnAfterPostAction(var ExpenseHdr: Record "Expense Header B2B");
    begin
    end;

    local procedure FillGenJournal(var ExpenseLine: Record "Expense Line B2B"; var ExpenseHdr: Record "Expense Header B2B"; var ApprovedAmount: Decimal);
    var
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        with ExpenseHdr do begin
            GenJnlLine.INIT();
            GenJnlLine."Journal Template Name" := "Journal Template Name";
            GenJnlLine."Journal Batch Name" := "Journal Batch Name";
            GenJnlLine."Posting Date" := "Posting Date";
            GenJnlLine."Document Date" := "Posting Date";
            UpdateAccType(ExpenseLine, GenJnlLine, ExpenseHdr);
            GenJnlLine.Amount := ApprovedAmount;
            GenJnlLine."System-Created Entry" := true;
            GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
            GenJnlLine.Description := ExpenseHdr."Posting Description";
            GenJnlLine."Document No." := ExpenseLine."Document No.";
            GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := "Dimension Set ID";
            OnAfterFillGenJournal(ExpenseHdr, ExpenseLine, GenJnlLine);
            GenJnlPostLine.RunWithCheck(GenJnlLine);
        end;
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnAfterFillGenJournal(var ExpenseHdr: Record "Expense Header B2B"; var ExpenseLine: Record "Expense Line B2B"; var GenJnlLine: Record "Gen. Journal Line");
    begin
    end;

    procedure Navigate();
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Posting Date", "No.");
        NavigateForm.RUN();
    end;

    procedure ShowPostedDimensions();
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", copystr(STRSUBSTNO('%1 %2', TABLECAPTION(), "No."), 1, 250));
    end;

    local procedure UpdateAccType(var ExpenseLine: Record "Expense Line B2B"; var GenJnlLine: Record "Gen. Journal Line"; var ExpenseHdr: Record "Expense Header B2B");
    var
        TravelPostingSetup: Record "Travel Posting Setup B2B";
        TravelRequisition: Record "Posted Travel Requisition B2B";
    begin

        TravelPostingSetup.GET(ExpenseLine."Component Type");
        TravelPostingSetup.TESTFIELD("Posting Account");
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := TravelPostingSetup."Posting Account";

        TravelRequisition.GET(ExpenseHdr."Travel Req. No.");
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";

        if ExpenseHdr."Offset Account" <> '' then
            GenJnlLine."Bal. Account No." := ExpenseHdr."Offset Account"
        else
            GenJnlLine."Bal. Account No." := TravelRequisition."Account No.";
    end;

    procedure PerformManualRelease(var ExpenseHeader: Record "Expense Header B2B");
    begin
        /*if ApprovalsMgmt.IsExpenseApprovalsWorkflowEnabled(ExpenseHeader) and (ExpenseHeader.Status = ExpenseHeader.Status::Open) then
          ERROR(Text001);
        ReleaseDoc;*/
    end;

    procedure PerformManualReopen(var ExpenseHeader: Record "Expense Header B2B");
    begin
        if ExpenseHeader.Status = ExpenseHeader.Status::"Pending For Approval" then
            ERROR(Text002Lbl);
        ReOpenDoc();
    end;

    procedure CopyRequisitionLines(ReqNo: Code[20]; ExpNo: Code[20]);
    var
        TravelReq: Record "Posted Travel Requisition B2B";
        TravelReqnLine: Record "Posted Travel Req. Line B2B";
        ExpHeader: Record "Expense Header B2B";
        ExpLine: Record "Expense Line B2B";
        TravelGroups: Record "Travel Groups B2B";
        Components: Record "Components B2B";
        LineNo: Integer;
        DeleteLinesTextLbl: Label 'Line Exist, Do you want to Delete and Copy lines.?';

    begin
        if ExpNo = '' then
            exit;

        ExpHeader.GET(ExpNo);
        if not TravelReq.GET("Travel Req. No.") then
            CLEAR(TravelReq);
        ExpLine.RESET();
        ExpLine.SETRANGE("Document No.", ExpHeader."No.");
        if ExpLine.FINDSET() then
            if not CONFIRM(DeleteLinesTextLbl, false, true) then
                exit;

        ExpLine.DELETEALL();


        "Employee No." := TravelReq."Employee No.";
        "Employee Name" := TravelReq."Employee Name";
        Designation := TravelReq.Designation;
        "Shortcut Dimension 1 Code" := TravelReq."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := TravelReq."Shortcut Dimension 2 Code";
        "Dimension Set ID" := TravelReq."Dimension Set ID";
        "Category Code" := TravelReq."Category Code";
        "City Type" := TravelReq."City Type";
        "Offset Account" := TravelReq."Account No.";
        "Mode of Travel" := TravelReq."Mode of Travel";
        LineNo := 10000;

        ExpLine.RESET();
        ExpLine.SETRANGE("Document No.", ExpHeader."No.");
        if ExpLine.FINDLAST() then
            LineNo += ExpLine."Line No.";

        TravelReqnLine.RESET();
        TravelReqnLine.SETRANGE("Document No.", TravelReq."No.");
        if TravelReqnLine.FINDSET() then
            repeat
                ExpLine.INIT();
                ExpLine.TRANSFERFIELDS(TravelReqnLine);
                ExpLine."Document No." := ExpHeader."No.";
                ExpLine."Line No." := LineNo;
                LineNo += 10000;
                TravelGroups.SETRANGE(Category, "Category Code");
                TravelGroups.SETRANGE("City Type", "City Type");
                TravelGroups.SETRANGE(Component, ExpLine."Component Type");
                if Components.GET(ExpLine."Component Type") and Components.Transport then
                    TravelGroups.SETRANGE("Mode of Transport", "Mode of Travel")
                else
                    TravelGroups.SETRANGE("Mode of Transport");
                if TravelGroups.FINDLAST() then
                    if TravelGroups.Actuals then
                        ExpLine."Amount Limits" := ExpLine.Amount
                    else
                        ExpLine."Amount Limits" := TravelGroups.Limits;

                ExpLine.INSERT();
            until TravelReqnLine.NEXT() = 0;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer);
    var
        ExpenseLine: Record "Expense Line B2B";
        NewDimSetID: Integer;
        Text064Lbl: Label 'You may have changed a dimension.\\Do you want to update the lines?';

    begin
        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not CONFIRM(Text064Lbl) then
            exit;

        ExpenseLine.RESET();
        ExpenseLine.SETRANGE("Document No.", "No.");
        ExpenseLine.LOCKTABLE();
        if ExpenseLine.FINDFIRST() then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(ExpenseLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if ExpenseLine."Dimension Set ID" <> NewDimSetID then begin
                    ExpenseLine."Dimension Set ID" := NewDimSetID;


                    DimMgt.UpdateGlobalDimFromDimSetID(
                      ExpenseLine."Dimension Set ID", ExpenseLine."Shortcut Dimension 1 Code", ExpenseLine."Shortcut Dimension 2 Code");
                    ExpenseLine.MODIFY();
                end;
            until ExpenseLine.NEXT() = 0;
    end;

    procedure LinesExist(): Boolean;
    var
        ExpenseLine: Record "Expense Line B2B";
    begin
        ExpenseLine.RESET();
        ExpenseLine.SETRANGE("Document No.", "No.");
        exit(not ExpenseLine.IsEmpty());
    end;
}

