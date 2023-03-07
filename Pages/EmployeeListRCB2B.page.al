page 33001535 "Employee List RC B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee List';
    CardPageID = "Employee Card B2B";
    Editable = false;
    PageType = ListPart;
    SourceTable = "Employee B2B";


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; "No.")
                {
                    ToolTip = 'Choose the Employee No.';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        if Employee.GET("No.") then;
                    end;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Choose the Department code of Employee.';
                    ApplicationArea = all;
                }
                field("PF Applicability"; "PF Applicability")
                {
                    ToolTip = 'Choose the PF Applicability as Satutory or Actual.';
                    ApplicationArea = all;
                }
                field("PF Amount"; "PF Amount")
                {
                    ToolTip = 'Shows the PF Amount.';
                    Visible = false;
                    ApplicationArea = all;
                }
                field("User Id"; "User Id")
                {
                    ToolTip = 'Choose the user id of the Employee.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action2>")
            {
                ToolTip = 'Specifies the document is open.';
                Caption = 'Open';
                Image = Open;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Return';
                ApplicationArea = all;

                trigger OnAction();
                begin
                    OpenEmpCard();
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if Employee.GET("No.") then;
    end;

    var
        Employee: Record "Employee B2B";

    procedure OpenEmpCard();
    begin
        if Employee.GET("No.") then
            PAGE.RUN(PAGE::"Employee Card B2B", Employee);
    end;
}

