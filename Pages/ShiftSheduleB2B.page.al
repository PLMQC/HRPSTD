page 33001543 "Shift Shedule B2B"
{
    // version B2BHR1.00.00

    Caption = 'Shift Shedule';
    PageType = Document;
    SourceTable = "Shift Schedule Header B2B";
    SourceTableView = WHERE(Posted = CONST(false));
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
                    ToolTip = 'Choose the ID.';
                    ApplicationArea = all;
                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Global Dimesion 1 Code"; "Global Dimesion 1 Code")
                {
                    ToolTip = 'Select the Dimension for the shift.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Choose the Physical Location';
                    ApplicationArea = all;
                }
                field(Department; Department)
                {
                    ToolTip = 'Choose the Department.';
                    ApplicationArea = all;
                }
                field("Current Shift"; "Current Shift")
                {
                    ToolTip = 'Choose the Current shift of employees.';
                    ApplicationArea = all;
                }
                field("Revised Shift"; "Revised Shift")
                {
                    ToolTip = 'Choose the Revised shift of employees.';
                    ApplicationArea = all;
                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Choose the Efficative date of the Revised shift.';
                    ApplicationArea = all;
                }
            }
            part(Control1102154011; "Shift Schedule Subform B2B")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = all;
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
                action("Get &Employees")
                {
                    ToolTip = 'On Clicking Gets the list of Employees.';
                    Caption = 'Get &Employees';
                    Image = Employee;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        InsertEmployees();
                    end;
                }
                action("Update &Shift")
                {
                    ToolTip = 'Updates the Shift of the Employee.';
                    Caption = 'Update &Shift';
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        UpdateEmployeeShift();
                    end;
                }
            }
        }
    }
}

