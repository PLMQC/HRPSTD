page 33001334 "Training Calender B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Calender';
    PageType = Card;
    SourceTable = "Training Calender B2B";
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
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Document Number as per Setup';

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Description details';
                }
                field("Training Type"; "Training Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Type as per lookup values defined in Setup';
                }
                field("Global Dimension 1"; "Global Dimension 1")
                {
                    Caption = 'Division';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Dimension';
                }
                field("Training Faculty"; "Training Faculty")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Faculty Name';
                }
                field(Month; Month)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training MOnth';
                }
                field(Approved; Approved)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Document Status as Approved / Pending for Approval.';
                }
                field("Training Objectives"; "Training Objectives")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training objective applicable';
                }
                field("Training Objectives 2"; "Training Objectives 2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training objective 2';
                }
                field("Training Cost"; "Training Cost")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Cost if any';
                }
                field(Venue; Venue)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Venue';
                }
                field("Name of faculty/Consultant"; "Name of faculty/Consultant")
                {
                    Caption = 'Name of Faculty/Consultant';
                    MultiLine = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Faculty / Consultants Name.';
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Starting date';
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training End Date based on NUmber of Days';
                }
                field("Work Group Code"; "Work Group Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Work Group Code';
                }
                field("Work Group Code 2"; "Work Group Code 2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Work Group Code';
                }
                field("Work Group Code 3"; "Work Group Code 3")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Work Group Code';
                }
                field("Work Group Code 4"; "Work Group Code 4")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Work Group Code';
                }
                field("Work Group Code 5"; "Work Group Code 5")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Training Work Group Code';
                }
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
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specify the Process of training the Employee';
                    trigger OnAction();
                    begin
                        if Approved = false then begin
                            if CONFIRM(Text003Lbl, false) then begin
                                Approved := true;
                                MODIFY();
                                MESSAGE(Text004Lbl, "No.");
                            end;
                        end else
                            ERROR(Text005Lbl, "No.");
                    end;
                }
                action("&Calendar Schedules")
                {
                    Caption = '&Calendar Schedules';
                    Image = Calendar;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Resource Indent Approval B2B";
                    RunPageLink = "Recruitment Policy No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'specify the Calender Schedule of the Employee';
                }
            }
        }
    }

    var
        Text003Lbl: Label 'Do You want to Approve?';
        Text004Lbl: Label 'Training Calender No. %1 is Approved', Comment = '%1 = No';
        Text005Lbl: Label 'Training Calender No. %1 is already Approved', Comment = '%1 = No';
}

