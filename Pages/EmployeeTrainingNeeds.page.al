page 33001482 "Employee Training Needs B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Training Need List';
    CardPageID = "Employee Training Need B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Emp. Tr. Need Identi. Head B2B";
    SourceTableView = SORTING("Document Type", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = CONST("Training Need Identification"));
    UsageCategory = Lists;

    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Choose the Employee No.';
                    ApplicationArea = all;
                }
                field(Period; Period)
                {
                    ToolTip = 'Selet the period of Training.';
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = 'Traning period Start Date.';
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Choose the Employee Department code.';
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Taning period End date.';
                    ApplicationArea = all;
                }
                field("Date of Receipt"; "Date of Receipt")
                {
                    ToolTip = 'Specifies the Date of Recepit of training.';
                    ApplicationArea = all;
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
            }
        }
    }
}

