page 33001453 "Posted Pay Rev. Document B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Pay Rev. Document';
    PageType = Document;
    SourceTable = "Pay Revision Header B2B";
    UsageCategory = Documents;
    Editable = false;
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
                    ToolTip = 'Dimensions';

                    trigger OnAction();
                    begin
                        ShowDocDim();
                        CurrPage.SAVERECORD();
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
        PayRevisionLine: Record "Pay Revision Line B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Text003Lbl: Label 'No Revision is Done';
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

