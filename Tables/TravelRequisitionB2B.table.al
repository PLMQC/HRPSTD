table 33001396 "Travel Requisition B2B"
{
    // version B2BHR1.00.00

    Caption = 'Travel Requisition';
    DrillDownPageID = "Travel Requisitions B2B";
    LookupPageID = "Travel Requisitions B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.GET();
                    HRSetup.TESTFIELD("Travel Requisition Nos.");
                    NoSeriesMgmt.TestManual(HRSetup."Travel Requisition Nos.");
                    "No.Series" := '';
                end;
            end;
        }
        field(10; "Employee No."; Code[100])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B"
            where(Blocked = const(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                GetEmp();
                "Employee Name" := CopyStr(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name", 1, 50);
                Gender := Employee.Gender;
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
        field(13; Age; Integer)
        {
            Caption = 'Age';
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(14; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = 'NA, Female,Male';
            OptionMembers = NA," Female",Male;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(15; "Boarding at"; Text[30])
        {
            Caption = 'Boarding at';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(16; Destination; Text[30])
        {
            Caption = 'Destination';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(17; "Customer / Client No."; Text[250])
        {
            Caption = 'Customer / Client No';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                CustomerList: Page "Customer List";
            begin
                TestStatus();
                Cust.RESET();
                CustomerList.LOOKUPMODE(true);
                CustomerList.SETTABLEVIEW(Cust);
                if CustomerList.RUNMODAL() = ACTION::LookupOK then begin
                    CustomerList.SetSelection(Cust);
                    CLEAR("Customer / Client No.");
                    CLEAR("Customer Name");
                    CLEAR("Customer Name 2");
                    repeat
                        if STRLEN("Customer / Client No." + Cust."No.") <= 250 then
                            if "Customer / Client No." <> '' then
                                "Customer / Client No." += '|' + Cust."No."
                            else
                                "Customer / Client No." := Cust."No.";

                        if STRLEN("Customer Name" + Cust.Name) <= 250 then
                            if "Customer Name" <> '' then
                                "Customer Name" += '|' + Cust.Name
                            else
                                "Customer Name" := Cust.Name
                        else
                            if STRLEN("Customer Name 2" + Cust.Name) <= 250 then
                                if "Customer Name 2" <> '' then
                                    "Customer Name 2" += '|' + Cust.Name
                                else
                                    "Customer Name 2" := Cust.Name;

                    until Cust.NEXT() = 0;
                end;
            end;

            trigger OnValidate();
            begin
                TestStatus();
                Cust.RESET();
                Cust.SETFILTER("No.", "Customer / Client No.");
                if Cust.FINDSET() then begin
                    CLEAR("Customer / Client No.");
                    CLEAR("Customer Name");
                    CLEAR("Customer Name 2");
                    repeat
                        if STRLEN("Customer / Client No." + Cust."No.") <= 250 then
                            if "Customer / Client No." <> '' then
                                "Customer / Client No." += '|' + Cust."No."
                            else
                                "Customer / Client No." := Cust."No.";

                        if STRLEN("Customer Name" + Cust.Name) <= 250 then begin
                            if "Customer Name" <> '' then
                                "Customer Name" += '|' + Cust.Name
                            else
                                "Customer Name" := Cust.Name;
                        end else
                            if STRLEN("Customer Name 2" + Cust.Name) <= 250 then
                                if "Customer Name 2" <> '' then
                                    "Customer Name 2" += '|' + Cust.Name
                                else
                                    "Customer Name 2" := Cust.Name;

                    until Cust.NEXT() = 0;
                end;
            end;
        }
        field(18; "Customer Name"; Text[250])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(19; "Customer Name 2"; Text[250])
        {
            Caption = 'Customer Name 2';
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
        field(30; "Travel Requisition Date"; Date)
        {
            Caption = 'Travel Requisition Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(31; "Travel From"; Text[30])
        {
            Caption = 'Travel From';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(32; "Travel To"; Text[30])
        {
            Caption = 'Travel To';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(33; "Travel From Date"; Date)
        {
            Caption = 'Travel From Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(34; "Travel To Date"; Date)
        {
            Caption = 'Travel To Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(51; "Account No."; Code[20])
        {
            Caption = 'Account  No.';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                 Blocked = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(53; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
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
        field(81; "Coach Type"; Option)
        {
            Caption = 'Coach Type';
            OptionCaption = ' ,A/C Sleeper,1st Class A/c,Business Class,Economy Class';
            OptionMembers = " ","A/C Sleeper","1st Class A/c","Business Class","Economy Class";
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
        field(801; "Posting Description"; Text[30])
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
        TravelRequisitionLine: Record "Travel Requisition Line B2B";
    begin
        TestStatus();

        TravelRequisitionLine.RESET();
        TravelRequisitionLine.SETRANGE("Document No.", "No.");
        TravelRequisitionLine.DELETEALL();
    end;

    trigger OnInsert();
    begin

        if "No." = '' then begin
            HRSetup.GET();
            HRSetup.TESTFIELD("Travel Requisition Nos.");
            NoSeriesMgmt.InitSeries(HRSetup."Travel Requisition Nos.", xRec."No.Series", 0D, "No.", "No.Series");
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
        Cust: Record Customer;
        HRSetup: Record "HR Setup B2B";
        DimMgt: Codeunit 408;
        NoSeriesMgmt: Codeunit 396;
        Text001Lbl: Label 'You cannot Rename Requisition Document.';
        Text002Lbl: Label 'Requisition Document %1 Released.', Comment = '%1 = No.';
        Text003Lbl: Label 'Requisition Document %1 Open.', Comment = '%1 = No.';
        Text004Lbl: Label 'Document %1 Posted Successfully.', Comment = '%1 = Travel Requisition No.';

    procedure AssistEdit(OldTravelRequisition: Record "Travel Requisition B2B"): Boolean;
    begin
        HRSetup.GET();
        HRSetup.TESTFIELD("Travel Requisition Nos.");
        if NoSeriesMgmt.SelectSeries(HRSetup."Travel Requisition Nos.", OldTravelRequisition."No.Series", "No.Series") then begin
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

    procedure PostDocument(var TravelReq: Record "Travel Requisition B2B");
    var
        TravelReqLine: Record "Travel Requisition Line B2B";
        PostedTravelReq: Record "Posted Travel Requisition B2B";
        PostedTravelReqLine: Record "Posted Travel Req. Line B2B";
    begin
        OnBeforePostAction(TravelReq);
        TESTFIELD(Status, Status::Released);
        TravelReqLine.RESET();
        TravelReqLine.SETRANGE("Document No.", TravelReq."No.");
        if TravelReqLine.FINDSET() then begin
            TravelReqLine.CALCSUMS("Amount (LCY)");
            FillGenJournal(TravelReqLine, TravelReq);


            PostedTravelReq.TRANSFERFIELDS(TravelReq);
            PostedTravelReq.INSERT();

            TravelReqLine.RESET();
            TravelReqLine.SETRANGE("Document No.", TravelReq."No.");
            if TravelReqLine.FINDSET() then
                repeat
                    PostedTravelReqLine.TRANSFERFIELDS(TravelReqLine);
                    PostedTravelReqLine.INSERT();
                until TravelReqLine.NEXT() = 0;
            TravelReq.DELETE();
            TravelReqLine.DELETEALL();

            MESSAGE(Text004Lbl, TravelReq."No.");
            OnAfterPostAction(TravelReq);
        end;
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnBeforeReleaseAction(var TravelReq: Record "Travel Requisition B2B");
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnBeforeOpenAction(var TravelReq: Record "Travel Requisition B2B");
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnBeforePostAction(var TravelReq: Record "Travel Requisition B2B");
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnAfterReleaseAction(var TravelReq: Record "Travel Requisition B2B");
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnAfterOpenAction(var TravelReq: Record "Travel Requisition B2B");
    begin
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnAfterPostAction(var TravelReq: Record "Travel Requisition B2B");
    begin
    end;

    local procedure FillGenJournal(var TravelReqLine: Record "Travel Requisition Line B2B"; var TravelReq: Record "Travel Requisition B2B");
    var
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        with TravelReq do begin
            GenJnlLine.INIT();
            GenJnlLine."Journal Template Name" := "Journal Template Name";
            GenJnlLine."Journal Batch Name" := "Journal Batch Name";
            GenJnlLine."Posting Date" := "Posting Date";
            GenJnlLine."Document Date" := "Posting Date";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := "Account No.";
            GenJnlLine.Amount := TravelReqLine."Amount (LCY)";
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
            GenJnlLine."Bal. Account No." := "Bank Account No.";
            GenJnlLine."System-Created Entry" := true;
            GenJnlLine.Description := "Posting Description";
            GenJnlLine."Document No." := "No.";
            GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := "Dimension Set ID";
            OnAfterFillGenJournal(TravelReqLine, GenJnlLine);
            GenJnlPostLine.RunWithCheck(GenJnlLine);
        end;
    end;

    [IntegrationEvent(TRUE, false)]
    procedure OnAfterFillGenJournal(var TravelReqLine: Record "Travel Requisition Line B2B"; var GenJnlLine: Record "Gen. Journal Line");
    begin
    end;

    procedure Navigate(var TravelRequisition: Record "Travel Requisition B2B");
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Posting Date", "No.");
        NavigateForm.RUN();
    end;

    procedure PerformManualRelease(var TravelRequisition: Record "Travel Requisition B2B");
    var

    begin
        /*if ApprovalsMgmt.IsTravelRequisitionApprovalsWorkflowEnabled(TravelRequisition) and (TravelRequisition.Status = TravelRequisition.Status::Open) then
          ERROR(Text001);
        ReleaseDoc;*/
        ReleaseDoc();
    end;

    procedure PerformManualReopen(var TravelRequisition: Record "Travel Requisition B2B");
    begin
        if TravelRequisition.Status = TravelRequisition.Status::"Pending For Approval" then
            ERROR(Text002Lbl);
        ReOpenDoc();
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer);
    var
        TravelReqLine: Record "Travel Requisition Line B2B";
        NewDimSetID: Integer;
        Text064Lbl: Label 'You may have changed a dimension.\\Do you want to update the lines?';

    begin
        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not CONFIRM(Text064Lbl) then
            exit;

        TravelReqLine.RESET();
        TravelReqLine.SETRANGE("Document No.", "No.");
        TravelReqLine.LOCKTABLE();
        if TravelReqLine.FINDFIRST() then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(TravelReqLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if TravelReqLine."Dimension Set ID" <> NewDimSetID then begin
                    TravelReqLine."Dimension Set ID" := NewDimSetID;


                    DimMgt.UpdateGlobalDimFromDimSetID(
                      TravelReqLine."Dimension Set ID", TravelReqLine."Shortcut Dimension 1 Code", TravelReqLine."Shortcut Dimension 2 Code");
                    TravelReqLine.MODIFY();
                end;
            until TravelReqLine.NEXT() = 0;
    end;

    procedure LinesExist(): Boolean;
    var
        TravelReqLine: Record "Travel Requisition Line B2B";
    begin
        TravelReqLine.RESET();
        TravelReqLine.SETRANGE("Document No.", "No.");
        exit(not TravelReqLine.IsEmpty());
    end;
}

