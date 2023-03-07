page 33001308 "Resource Indent Approval B2B"
{
    // version B2BHR1.00.00

    Caption = 'Resource Indent Approval';
    PageType = Worksheet;
    SourceTable = "Recruitment Header B2B";
    SourceTableView = WHERE(Approved = CONST(false),
                            Status = FILTER(<> Rejected),
                            Status = FILTER(<> Open));
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Recruitment Policy No."; "Recruitment Policy No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Recrutiment Policy serial numbeer is displayed here';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'The Recruitment Policy Description is shown here';
                }
                field(Comments; Comments)
                {
                    ApplicationArea = all;
                    ToolTip = 'Comments if any mentioned are shown here';
                }
                field("Indenting Dept."; "Indenting Dept.")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Recruitment Indenting department is displayed here';
                }
                field("No. of Resources"; "No. of Resources")
                {
                    ApplicationArea = all;
                    ToolTip = 'The number of resources required towards the Recruitment are shown here';
                }
                field("Skill Set"; "Skill Set")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Skill set of the Applicant is displayed here';
                }
                field(Qualification; Qualification)
                {
                    ApplicationArea = all;
                    ToolTip = 'The Qualification towards the Applicant is shown here';
                }
                field("Date of Requirement"; "Date of Requirement")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Recruitment Requirement Date is displayed here';
                }
                field("Required Position"; "Required Position")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Recrutiment Postiong towards a JOb is shown here';
                }
                field("Required Dept."; "Required Dept.")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Recruitment needed department is shown here';
                }
                field("Salary Range"; "Salary Range")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Salary Range mentioned is displayed here';
                }
                field("Days Limit"; "Days Limit")
                {
                    ApplicationArea = all;
                    ToolTip = 'The number of days required towards the Recruitment is displayed here';

                }
                field("Required End Date"; "Required End Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Recruitment end date is displayed here';

                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show Document")
            {
                Caption = '&Show Document';
                Image = ShowList;
                action("&Card")
                {
                    Caption = '&Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Resource Indent B2B";
                    RunPageLink = "Recruitment Policy No." = FIELD("Recruitment Policy No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = all;
                    ToolTip = 'Card';
                }
            }
        }
        area(processing)
        {
            action("&Approve")
            {
                Caption = '&Approve';
                Image = Approve;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Approve';

                trigger OnAction();
                begin
                    TESTFIELD(Comments);
                    CLEAR(Dept);
                    Employee.RESET();
                    Employee.SETRANGE("User Id", USERID());
                    if Employee.FINDFIRST() then
                        Dept := Employee."Department Code";
                    HRApproverSetup.RESET();
                    HRApproverSetup.SETRANGE("Document Type", HRApproverSetup."Document Type"::"Resource Indent");
                    HRApproverSetup.SETRANGE(HOD, USERID());
                    if HRApproverSetup.FINDFIRST() then begin
                        HRApproverSetup2.RESET();
                        HRApproverSetup2.SETRANGE("Document Type", HRApproverSetup."Document Type");
                        HRApproverSetup2.SETRANGE(Department, HRApproverSetup.Department);
                        HRApproverSetup2.SETRANGE("Line No.", HRApproverSetup."Line No.");
                        if HRApproverSetup2.FINDFIRST() then begin
                            if (HRApproverSetup2."Addtional  Approver" = '') and (HRApproverSetup2."HR Approval" = '') then begin
                                Status := Status::Release;
                                Approver := '';
                                Approved := true;
                                MODIFY();
                                MESSAGE('%1', Text001Lbl);
                            end;
                            if ((HRApproverSetup2."Addtional  Approver" <> '')) then begin
                                Status := Status::"Pending For Additional Approval";
                                Approver := HRApproverSetup2."Addtional  Approver";
                                MESSAGE('%1', Text000Lbl);
                                MODIFY();
                            end;
                            if (HRApproverSetup2."Addtional  Approver" = '') and (HRApproverSetup2."HR Approval" <> '') then begin
                                Status := Status::"Pending For HR Approval";
                                Approver := HRApproverSetup2."HR Approval";
                                MESSAGE('%1', Text000Lbl);
                            end;
                        end;
                    end;
                    HRApproverSetup.RESET();
                    HRApproverSetup.SETRANGE("Document Type", HRApproverSetup."Document Type"::"Resource Indent");
                    HRApproverSetup.SETRANGE("Addtional  Approver", USERID());
                    if HRApproverSetup.FINDFIRST() then
                        if HRApproverSetup."HR Approval" <> '' then begin
                            Status := Status::"Pending For HR Approval";
                            Approver := HRApproverSetup."HR Approval";
                            MODIFY();
                            MESSAGE('%1', Text000Lbl);
                        end else begin
                            Status := Status::Release;
                            Approver := '';
                            Approved := true;
                            MODIFY();
                            MESSAGE('%1', Text001Lbl);
                        end;

                    HRApproverSetup.RESET();
                    HRApproverSetup.SETRANGE("Document Type", HRApproverSetup."Document Type"::"Resource Indent");
                    HRApproverSetup.SETRANGE("HR Approval", USERID());
                    if HRApproverSetup.FINDFIRST() then begin
                        Status := Status::Release;
                        Approved := true;
                        "Document Type" := "Document Type"::Recruitment;
                        MODIFY();
                        MESSAGE('%1', Text001Lbl);
                    end;
                end;
            }
            action("&Reject")
            {
                Caption = '&Reject';
                Image = Reject;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Reject';

                trigger OnAction();
                begin
                    TESTFIELD("Reason for Rejection");

                    CLEAR(Dept);
                    Employee.RESET();
                    Employee.SETRANGE("User Id", USERID());
                    if Employee.FINDFIRST() then
                        Dept := Employee."Department Code";
                    HRApproverSetup.RESET();
                    HRApproverSetup.SETRANGE("Document Type", HRApproverSetup."Document Type"::"Resource Indent");
                    HRApproverSetup.SETRANGE(Department, Dept);
                    HRApproverSetup.SETRANGE(HOD, USERID());
                    if HRApproverSetup.FINDFIRST() then begin
                        Status := Status::Rejected;
                        MODIFY();
                        MESSAGE('%1', Text002Lbl);
                    end;

                    HRApproverSetup.RESET();
                    HRApproverSetup.SETRANGE("Document Type", HRApproverSetup."Document Type"::"Resource Indent");
                    HRApproverSetup.SETRANGE("Addtional  Approver", USERID());
                    if HRApproverSetup.FINDFIRST() then begin
                        Status := Status::Rejected;
                        MODIFY();
                        MESSAGE('%1', Text002Lbl);
                    end;

                    HRApproverSetup.RESET();
                    HRApproverSetup.SETRANGE("Document Type", HRApproverSetup."Document Type"::"Resource Indent");
                    HRApproverSetup.SETRANGE("HR Approval", USERID());
                    if HRApproverSetup.FINDFIRST() then begin
                        Status := Status::Rejected;
                        MODIFY();
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        SETRANGE(Approver, USERID());
        SETFILTER(Status, '<>%1', Status::Rejected);
    end;

    var
        Employee: Record "Employee B2B";
        HRApproverSetup: Record "HR Approval setup B2B";
        HRApproverSetup2: Record "HR Approval setup B2B";
        Dept: Code[30];
        Text000Lbl: Label 'Document was approved and sent for further aproval';
        Text001Lbl: Label 'Document was Approved.';
        Text002Lbl: Label 'Document was Rejected.';
}

