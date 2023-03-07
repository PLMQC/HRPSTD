page 33001536 "Man Power Requis. List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Man Power Requisition  List';
    CardPageID = "Resource Indent B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Recruitment Header B2B";
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
                    ToolTip = 'Choose the Recuritment Policy number.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Enter the Recuritment description.';
                    ApplicationArea = all;
                }
                field("Indenting Dept."; "Indenting Dept.")
                {
                    ToolTip = 'Choose the indenting Department for recuritment.';
                    ApplicationArea = all;
                }
                field("No. of Resources"; "No. of Resources")
                {
                    ToolTip = 'Number of Resources required for department.';
                    ApplicationArea = all;
                }
                field("Date of Requirement"; "Date of Requirement")
                {
                    ToolTip = 'Select the Date of Requirement.';
                    ApplicationArea = all;
                }
                field(Comments; Comments)
                {
                    ToolTip = 'Enter the comments for Requirement.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Detail ")
            {
                ToolTip = 'Specifies the Details of man power.';
                Caption = '"Detail "';
                Image = ViewDetails;
                action(Skills)
                {
                    ToolTip = ' Specifies the skills required for man power.';
                    Caption = 'Skills';
                    Image = Skills;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Credentials B2B";
                    RunPageLink = "Document No." = FIELD("Recruitment Policy No.");
                    ApplicationArea = all;
                }
                action(Comment)
                {
                    ToolTip = 'Choose the comments to written if any.';
                    Caption = 'Comment';
                    Image = ViewComments;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST("Recruitment Header"),
                                  "No." = FIELD("Recruitment Policy No.");
                    ApplicationArea = all;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Re&lease")
                {
                    ToolTip = 'Specifies the Document is Released.';
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
                        RecruitmentHeadGRec.RESET();
                        RecruitmentHeadGRec.GET("Recruitment Policy No.");
                        if (RecruitmentHeadGRec.Status = RecruitmentHeadGRec.Status::Release) then
                            ERROR(Text005Lbl)
                        else begin
                            CLEAR(Dept);
                            EmployeeGrec.RESET();
                            EmployeeGrec.SETRANGE("User Id", USERID());
                            if EmployeeGrec.FINDFIRST() then
                                Dept := EmployeeGrec."Department Code";

                            ResIndSetup.RESET();
                            ResIndSetup.SETRANGE("Document Type", ResIndSetup."Document Type"::"Resource Indent");
                            ResIndSetup.SETRANGE(Department, Dept);
                            ResIndSetup.SETRANGE(User, USERID());
                            if ResIndSetup.FINDFIRST() then begin
                                ResourceIndSetup.RESET();
                                ResourceIndSetup.SETRANGE("Document Type", ResIndSetup."Document Type");
                                ResourceIndSetup.SETRANGE("Line No.", ResIndSetup."Line No.");
                                if ResourceIndSetup.FINDFIRST() then
                                    if ResourceIndSetup.HOD <> '' then begin
                                        Status := Status::"Pending for HOD Approval";
                                        Approver := ResourceIndSetup.HOD;
                                        MODIFY();
                                    end else
                                        if ResourceIndSetup."Addtional  Approver" <> '' then begin
                                            Status := Status::"Pending For Additional Approval";
                                            Approver := ResourceIndSetup."Addtional  Approver";
                                            MODIFY();
                                        end else begin
                                            Status := Status::"Pending For HR Approval";
                                            Approver := ResourceIndSetup."HR Approval";
                                            MODIFY();
                                        end;

                                MODIFY();
                                MESSAGE(Text004Lbl, "Recruitment Policy No.");
                            end else
                                ERROR(Text003Lbl, EmployeeGrec."No.");
                        end;
                        CurrPage.UPDATE(false);
                    end;
                }
                action("&Archive Document")
                {
                    ToolTip = 'you can archive the old document.';
                    Caption = '&Archive Document';
                    Image = Archive;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        //ArchiveManagement.ArchiveResIndDocument(Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("&Print")
                {
                    ToolTip = 'Prints the man power Requisition document.';
                    Caption = '&Print';
                    Image = Print;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        RecruitmentHeadGRec.RESET();
                        RecruitmentHeadGRec.SETRANGE("Recruitment Policy No.", "Recruitment Policy No.");
                        REPORT.RUNMODAL(33001300, true, false, RecruitmentHeadGRec);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);
        SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
    end;

    var

        RecruitmentHeadGRec: Record "Recruitment Header B2B";
        ResIndSetup: Record "HR Approval setup B2B";
        ResourceIndSetup: Record "HR Approval setup B2B";
        EmployeeGrec: Record "Employee B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Dept: Code[30];
        Text003Lbl: Label '"No Resource Indent Approval Setup is defined for %1 "', Comment = '%1 = ';
        Text004Lbl: Label 'Man Power Requisition %1 sent for approval', Comment = '%1 = ';
        Text005Lbl: Label 'Document is already Released';
}

