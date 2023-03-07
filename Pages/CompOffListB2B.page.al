page 33001539 "Comp Off List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Comp Off  List';
    CardPageID = "Comp Off B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Attendance Header B2B";
    SourceTableView = WHERE("Document Type" = CONST("Comp Off"),
                            Status = CONST(Open));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("No."; "No.")
                {
                    Tooltip = 'Enter the Comp off No.sereis. number';
                    ApplicationArea = all;
                }
                field("Creation Date"; "Creation Date")
                {
                    ToolTip = 'Choose the Creation date.';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Shows the Month ';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Show the Year.';
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    Tooltip = 'Choose the Start Date For Comp. off.';
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
                {
                    Tooltip = 'Choose the End Date For Comp. off.';
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ToolTip = 'Select the Dimension Value.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Choose the Physical location of the Employee.';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ToolTip = 'Choose Type from the Drop down list Ex. Employee/Department .';
                    ApplicationArea = all;
                }
                field("Code"; Code)
                {
                    ToolTip = 'Choose Code based on Selection made in Type.';
                    ApplicationArea = all;
                }
                field("Shift Code"; "Shift Code")
                {
                    ToolTip = 'Enter the Shift code of the Employee.';
                    ApplicationArea = all;
                }
                field("Permission Type"; "Permission Type")
                {
                    ToolTip = 'Choose the Permission type of Comp. off.';
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    ToolTip = 'Shows the User Id of the Document Created.';
                    ApplicationArea = all;
                }
                field("Approved By"; "Approved By")
                {
                    ToolTip = 'Shows the person name who has approved Comp. off.';
                    ApplicationArea = all;
                }
                field("Mode Of Travel"; "Mode Of Travel")
                {
                    ToolTip = 'Choose the Mode of Travel.';
                    ApplicationArea = all;
                }
                field("Mode of Booking"; "Mode of Booking")
                {
                    ToolTip = 'Enter the mode of Booking.';
                    ApplicationArea = all;
                }
                field("Assignment No."; "Assignment No.")
                {
                    ToolTip = 'Enter the Assignment No.';
                    ApplicationArea = all;
                }
                field("Assignment Name"; "Assignment Name")
                {
                    ToolTip = 'Enter the Assignment Name.';
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ToolTip = 'Enter the Dimension Value.';
                    ApplicationArea = all;
                }
                field("Places To Visit"; "Places To Visit")
                {
                    ToolTip = 'Enter the Place of Visit.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("P&ost")
                {
                    ToolTip = 'on clicking post the Document.';
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        ApproveCompOff();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        EventHandlingCD: Codeunit "Event Handling B2B";
    begin
        EventHandlingCD.B2BLicenseValidate;
    end;

    var
        Text001Lbl: Label 'Do you want to approve the entries?';

    procedure ApproveCompOff();
    var
        AttApprovals: Codeunit "Attendance Approvals B2B";
    begin
        CheckValidEntries();
        if CONFIRM(Text001Lbl) then
            AttApprovals.ApproveCompOff(Rec);
    end;
}

