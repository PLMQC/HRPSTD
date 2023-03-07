page 33001481 "Employee Training Need B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Training Need';
    PageType = Document;
    SourceTable = "Emp. Tr. Need Identi. Head B2B";
    SourceTableView = WHERE("Document Type" = CONST("Training Need Identification"));
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
                    ToolTip = 'Choose the Unique number for Training needed.';
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Choose the Employee number.';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Shows the Employee name on Selecting the Employee number.';
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Choose the department code.';
                    ApplicationArea = all;
                }
                field("Date of Joining"; "Date of Joining")
                {
                    ToolTip = 'Choose the Date of joining of the Employee.';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Shows the status of the Document wether it is in open or Released.';
                    ApplicationArea = all;
                }
                field("Period Type"; "Period Type")
                {
                    ToolTip = 'Specifies the period type for training.';
                    ApplicationArea = all;
                }
                field(Period; Period)
                {
                    ToolTip = 'Specifies the period of training.';
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = 'Choose the start date of the Training.';
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Choose the end date of the Training.';
                    ApplicationArea = all;
                }
                field("Date of Receipt"; "Date of Receipt")
                {
                    ToolTip = 'Specified the date of recepit for training.';
                    ApplicationArea = all;
                }
            }
            part(Control1102154018; "Emp Training Need Subform B2B")
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
                action("Re&lease")
                {
                    ToolTip = 'Specifies the Document in Release.';
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
                        ReleaseDocument();
                    end;
                }
                action("Re&open")
                {
                    ToolTip = 'Specifies the Document in Re-open.';
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        ReopenDocument();
                    end;
                }
                separator(Separator1102154026)
                {
                }
            }
        }
    }

    procedure ReleaseDocument1();
    begin
        if Status = Status::Open then begin
            TESTFIELD("Date of Receipt");
            Status := Status::Released;
            Evaluate("Released By", USERID());
            "Released Date" := workdate();
            MODIFY();
        end;
    end;

    procedure ReopenDocument1();
    begin
        if Status = Status::Released then begin
            Status := Status::Open;
            MODIFY();
        end;
    end;
}

