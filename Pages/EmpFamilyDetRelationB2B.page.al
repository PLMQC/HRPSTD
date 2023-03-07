page 33001590 "Emp Family Det. & Relation B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Family Details & Relation';
    PageType = Worksheet;
    SourceTable = "Employee Relative B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Relative Code"; "Relative Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the relative code';
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the first name';
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the middle name';
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the last name';
                }
                field("Birth Date"; "Birth Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the birth date';
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the phone no.';
                }
                field("Relatives Employee No."; "Relatives Employee No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the relatives employee no.';
                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the comment';
                }
                field(Relative; Relative)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the relative';
                }
                field("Reference Name"; "Reference Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the reference name';
                }
                field(Address1; Address1)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the address 1';
                }
                field(Address2; Address2)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the address 2';
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the occupation';
                }
                field("Relative Type"; "Relative Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the relative type';
                }
            }
        }

    }

    actions
    {
        area(navigation)
        {
            group("<Action25>")
            {
                Caption = 'Relative';
                action("<Action26>")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST("Employee Relative B2B"),
                                  "No." = FIELD("Employee No."),
                                  "Table Line No." = FIELD("Line No.");

                    ApplicationArea = all;
                    ToolTip = 'Specifies the comment';
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec.type := Rec.type::Employee;
    end;

    trigger OnInit()
    begin
        Rec.type := Rec.type::Employee;
    end;

}

