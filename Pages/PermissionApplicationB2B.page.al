page 33001517 "Permission Application B2B"
{
    // version B2BHR1.00.00

    Caption = 'Permission Application';
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Attendance Header B2B";
    SourceTableView = WHERE("Document Type" = CONST(Permission),
                            Status = CONST(Open));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ToolTip = 'Choose the No. sereis defined from drop down.';
                    ApplicationArea = all;
                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Creation Date"; "Creation Date")
                {
                    ToolTip = 'Choose the Date of Creation.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Select the Physical location of the Employee.';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ToolTip = 'Choose the Type from drop down ex. Employee or Department.';
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        TypeOnAfterValidate();
                    end;
                }
                field("Code"; Code)
                {
                    ToolTip = 'Choose the Employee No.';
                    Editable = "Employee CodeEditable";
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Select the Month for Permission.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Select the year for Permission.';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Choose the Permission start Date.';
                    ApplicationArea = all;
                }
                field("Permission Type"; "Permission Type")
                {
                    ToolTip = 'Choose the Permission Type like early leaving or late coming.';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Shows the Status of Document.';
                    ApplicationArea = all;
                }
            }
            part(Control1102154011; "Permission Subform B2B")
            {
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Get &Employees")
                {
                    ToolTip = 'on clicking get the list of the employees.';
                    Caption = 'Get &Employees';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        InsertPermissionEmployees();
                    end;
                }
                action("Re&lease")
                {
                    ToolTip = 'shows the document is released.';
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        ReleasePermission();
                    end;
                }
            }
        }
    }

    trigger OnInit();
    begin
        "Employee CodeEditable" := true;
    end;

    var
        [InDataSet]
        "Employee CodeEditable": Boolean;
        Text001Lbl: Label 'Do you want to release the document';

    procedure ReleaseOvertime();
    var
        AttApprovals: Codeunit "Attendance Approvals B2B";
    begin
        CheckValidEntries();
        if CONFIRM(Text001Lbl) then
            AttApprovals.ReleaseOvertime(Rec);
    end;

    procedure ReleasePermission();
    var
        AttApprovals: Codeunit "Attendance Approvals B2B";
    begin
        CheckValidEntries();

        if CONFIRM(Text001Lbl) then
            AttApprovals.ReleaseOvertime(Rec);
    end;

    local procedure TypeOnAfterValidate();
    begin
    end;
}

