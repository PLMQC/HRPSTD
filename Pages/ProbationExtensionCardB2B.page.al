page 33001226 "Probation Extension Card B2B"
{
    // version B2BHR1.00.00

    Caption = 'Probation Extension Card';
    PageType = Card;
    SourceTable = "Probation Extended B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Id."; "Id.")
                {
                    AssistEdit = true;
                    ToolTip = 'Specifies the Probation number series of the involved entry or record, according to the specified number series';
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Employee  Id"; "Employee  Id")
                {
                    ToolTip = 'Specifies the employee code picked from the drop list.';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Specifies the employee name based on employee code picked from the drop list.';
                    ApplicationArea = all;
                }
                field("Joining Date"; "Joining Date")
                {
                    ToolTip = 'Specifies the date of joining of an employee or employee''s in the company';
                    ApplicationArea = all;
                }
                field("Appointment Date"; "Appointment Date")
                {
                    ToolTip = 'Specifies the date of appointment as per appointment letter of an employee or employee''s in the company';
                    ApplicationArea = all;
                }
                field(Department; Department)
                {
                    ToolTip = 'Specifies the department code picked from the drop list.';
                    ApplicationArea = all;
                }
                field(Designation; Designation)
                {
                    ToolTip = 'Specifies the employee''s designation code picked from the drop list.';
                    ApplicationArea = all;
                }
                field("Probation Period"; "Probation Period")
                {
                    ToolTip = 'Specifies the probation period of an employee or employee''s.';
                    ApplicationArea = all;
                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Specifies the employee''s probation extension effective date or confrimation date';
                    ApplicationArea = all;
                }
                field("Extended Probation Period"; "Extended Probation Period")
                {
                    ToolTip = 'Specifies the employee''s probation extension period';
                    ApplicationArea = all;
                }
                field("Probation End Date"; "Probation End Date")
                {
                    ToolTip = 'Specifies the employee''s probation extension period end date.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("&Update Probation")
            {
                Caption = '&Update Probation';
                Image = UpdateShipment;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                ToolTip = 'Specifies the Employee update probation details.';

                trigger OnAction();
                begin
                    EmployeeRec.RESET();
                    EmployeeRec.SETRANGE("No.", "Employee  Id");
                    if EmployeeRec.FINDFIRST() then begin
                        EmployeeRec."Ext. Probation Period" := "Extended Probation Period";
                        EmployeeRec.VALIDATE("Probation End Date", CALCDATE("Extended Probation Period", EmployeeRec."Probation End Date"));
                        EmployeeRec.MODIFY();
                    end;
                    MESSAGE(Text001Lbl);
                end;
            }
        }
        area(processing)
        {
            group(Print)
            {
                Caption = 'Print';
                action("&Print")
                {
                    Caption = '&Print';
                    Image = Print;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the option to choose print details.';

                    trigger OnAction();
                    begin
                        TESTFIELD("Appointment Date");
                        ProbationExtended.RESET();
                        ProbationExtended.SETRANGE("Id.", "Id.");
                        REPORT.RUNMODAL(33001271, true, false, ProbationExtended);
                    end;
                }
            }
        }
    }

    var
        EmployeeRec: Record "Employee B2B";
        ProbationExtended: Record "Probation Extended B2B";
        Text001Lbl: Label 'Records updated sucessfully';
}

