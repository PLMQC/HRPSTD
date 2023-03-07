page 33001458 "Questionnaire Card B2B"
{
    // version B2BHR1.00.00

    Caption = 'Questionnaire Card';
    DeleteAllowed = false;
    PageType = Document;
    SourceTable = "Employee B2B";
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
                    ToolTip = 'Choose the Employee number.';
                    ApplicationArea = all;
                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("First Name"; "First Name")
                {
                    ToolTip = 'Specifies the First name of the Employee.';
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    ToolTip = 'Specifies the Last name of the Employee.';
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    ToolTip = 'Specifies the intials or middle name of the employee.';
                    Caption = 'Middle Name/Initials';
                    ApplicationArea = all;
                }
                field(Initials; Initials)
                {
                    ToolTip = 'Specifies the Initials of employee.';
                    ApplicationArea = all;
                }
                field("Permanent Address"; Address)
                {
                    ToolTip = 'Specifies the Permanent address of the employee.';
                    Caption = 'Present Address';
                    ApplicationArea = all;
                }
                field("Permanent Address 2"; "Address 2")
                {
                    ToolTip = 'Specifies the Permanent address of the employee.';
                    Caption = 'Present Address 2';
                    ApplicationArea = all;
                }
                field("Post Code"; "Post Code")
                {
                    ToolTip = 'Specifies the Postal code of the Employee.';
                    Caption = 'Post Code/City';
                    ApplicationArea = all;
                }
                field(City; City)
                {
                    ToolTip = 'Specifies the City of the Employee.';
                    ApplicationArea = all;
                }
                field("Country Code"; "Country Code")
                {
                    ToolTip = 'Specifies the Country code of the Employee.';
                    Caption = 'Country Code';
                    ApplicationArea = all;
                }
                field("Job Title"; "Job Title")
                {
                    ToolTip = 'Specifies the job title of the Employee.';
                    ApplicationArea = all;
                }
                field("Search Name"; "Search Name")
                {
                    ToolTip = 'Shows the search name of the employee.';
                    ApplicationArea = all;
                }
                field(Gender; Gender)
                {
                    ToolTip = 'Specifies the Gender.';
                    ApplicationArea = all;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ToolTip = 'Specifies the last Date modified.';
                    ApplicationArea = all;
                }
                field("Pay Cadre"; "Pay Cadre")
                {
                    ToolTip = 'Specifies the Pay cadre.';
                    ApplicationArea = all;
                }
                field(Designation; Designation)
                {
                    ToolTip = 'Choose the Designation of the Employee.';
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Choose the department code of the Employee.';
                    ApplicationArea = all;
                }
                field("Employment Date"; "Employment Date")
                {
                    ToolTip = 'Specifies the joining date of the Employee.';
                    ApplicationArea = all;
                }
                field(Probation; Probation)
                {
                    ToolTip = 'Specifies the Whether employee is in probation or not';
                    ApplicationArea = all;
                }
                field("Questionnaire Type"; "Questionnaire Type")
                {
                    ToolTip = 'Specifies the Questionnaire type.';
                    ApplicationArea = all;
                }
            }
            part("Credentials For Resume"; "Credentials For Resume B2B")
            {
                Caption = 'Credentials For Resume';
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                action("Co&mments")
                {
                    ToolTip = 'Spcifies the Employee.';
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST("Employee B2B"),
                                  "No." = FIELD("No.");
                    ApplicationArea = all;
                }
                action(Dimensions)
                {
                    ToolTip = 'select the diminesion to be given to employee.';
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(33001193),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                }
                // action("&Attachments")
                // {
                //     ToolTip = 'Shows the attachment.';
                //     Caption = '&Attachments';
                //     Image = Attachments;
                //     Promoted = true;

                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     ApplicationArea = all;

                //     trigger OnAction();
                //     begin
                //         Attachments;
                //     end;
                // }
                action("&Skills")
                {
                    ToolTip = 'Specifies the Skills of the Employee.';
                    Caption = '&Skills';
                    Image = Skills;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Skills B2B";
                    RunPageLink = "Document No." = FIELD("No.");
                    ApplicationArea = all;
                    // Field10=FIELD(Designation);//Phani

                }
                separator("----------------------")
                {
                    Caption = '----------------------';
                }
                action("App&raisal")
                {
                    ToolTip = 'Specifies the Appraisal';
                    Caption = 'App&raisal';
                    Image = MoveUp;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Confirmation B2B";
                    //RunPageLink = "Employee Name"=FIELD("No."),
                    //"Employee ID"=FIELD(Designation),
                    //Field8=FIELD("First Name");//Phani
                    ApplicationArea = all;

                }
                action("Leave &Entitlement")
                {
                    ToolTip = 'Specifies the Employee Leave Entiltlement.';
                    Caption = 'Leave &Entitlement';
                    Image = ImplementRegAbsence;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Leave Entitlement List B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                }
                action("Sanctioning &Incharge")
                {
                    ToolTip = 'Spcifies the Sanction Incharge.';
                    Caption = 'Sanctioning &Incharge';
                    Image = UserSetup;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Leave Sanc. Incharge B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                }
                separator(Separator1102152151)
                {
                }
                action("S&hift")
                {
                    Tooltip = 'specifies the Shift of the Employee.';
                    Caption = 'S&hift';
                    Image = Timeline;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Shift B2B";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = all;
                }
            }
        }
    }

    var
}

