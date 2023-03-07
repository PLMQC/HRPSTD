page 33001345 "Tour Intima Applicat B2B"
{
    // version B2BHR1.00.00

    Caption = 'Tour Intimation Applications';
    Editable = false;
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Attendance Header B2B";
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
                    ToolTip = 'Specifies Number serices for the Tour Information Applictaion';
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Creation Date"; "Creation Date")
                {
                    ToolTip = 'Specifies the Creation date of the application';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'specifies the Phycsical loaction of the applicant';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ToolTip = 'Specifies the type as "Employee" or "Department"';
                    ApplicationArea = all;
                }
                field("Code"; Code)
                {
                    ToolTip = 'Specifies the code of the type';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Specify the month of the application';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Specify the year of the application';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Specify the start date of the tour';
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
                {
                    ToolTip = 'Specify the end date of the tour';
                    ApplicationArea = all;
                }
                field("Shift Code"; "Shift Code")
                {
                    ToolTip = 'Specify the shift of the applicat like "Day " "Night" etc';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Specifies the statu of the application like "Pending for Approval" , "Approved" "Open" etc';
                    ApplicationArea = all;
                }
            }
            part(OnDutySubForm; "Tour Intimation Subforms B2B")
            {
                Caption = 'OnDutySubForm';
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                ApplicationArea = all;
            }
            group(Others)
            {
                Caption = 'Others';
                field("To Location"; "To Location")
                {
                    ToolTip = 'Specify the location of the Employee or Department';
                    ApplicationArea = all;
                }
                field("Places To Visit"; "Places To Visit")
                {
                    ToolTip = 'specifies the Places of Visit';
                    ApplicationArea = all;
                }
                field("Advance Request"; "Advance Request")
                {
                    ToolTip = 'Specifies if any advanceare taken';
                    ApplicationArea = all;
                }
                field("Assignment No."; "Assignment No.")
                {
                    ToolTip = 'specifies the assignemnt no of the tour';
                    ApplicationArea = all;
                }
                field("Assignment Name"; "Assignment Name")
                {
                    ToolTip = '"specifies the assignemnt Name "';
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ToolTip = '"Specifies the Global Dimention 1 "';
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the Global Dimention 2';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text001Lbl: Label 'Do you want to approve the entries';

    procedure ValidateType();
    begin
    end;

    procedure ReleaseOnDuty();
    var
    begin
    end;

    procedure ApproveOnDuty();
    var
        AttApprovals: Codeunit "Attendance Approvals B2B";
    begin
        if CONFIRM(Text001Lbl) then begin
            CheckValidEntries();
            AttApprovals.ApproveOnDuty(Rec);
        end;
    end;
}

