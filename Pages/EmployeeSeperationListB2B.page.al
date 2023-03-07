page 33001463 "Employee Seperation List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Seperation List';
    CardPageID = "Employee Seperation B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Employee Seperation B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Seperation ID"; "Seperation ID")
                {
                    ToolTip = 'Choose Unique Seperation ID';
                    ApplicationArea = all;
                }
                field("Employee ID"; "Employee ID")
                {
                    ToolTip = 'Choose the Employee No.';
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Specifies the Employee Name.';
                    ApplicationArea = all;
                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Specifies the Effictive date of Sepration.';
                    ApplicationArea = all;
                }
                field("Seperation Type"; "Seperation Type")
                {
                    ToolTip = 'Spcifies the Seperation type.';
                    ApplicationArea = all;
                }
                field("Grouds of Termination Group"; "Grouds of Termination Group")
                {
                    ToolTip = 'Specifies the Grounds of Terminationn Group.';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Specifies the Status of open/Released.';
                    ApplicationArea = all;
                }
                field("No. Series"; "No. Series")
                {
                    ToolTip = 'Specifies Number the Series.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Print")
            {
                Caption = '&Print';

                action("&Termination Letter")
                {
                    ToolTip = 'prints employee Termination Letter.';
                    Caption = '&Termination Letter';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        if "Seperation Type" = "Seperation Type"::Termination then begin
                            Employee.RESET();
                            Employee.SETRANGE("No.", "Employee ID");
                            REPORT.RUN(33001269, true, false, Employee);
                        end else
                            MESSAGE(Text001Lbl);
                    end;
                }
                action("&Relieving Cum Experience Letter")
                {
                    ToolTip = 'Prints Relieving cum Experience Letter.';
                    Caption = '&Relieving Cum Experience Letter';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        if "Seperation Type" <> "Seperation Type"::Termination then begin
                            Employee.RESET();
                            Employee.SETRANGE("No.", "Employee ID");
                            REPORT.RUN(33001291, true, false, Employee);
                        end else
                            MESSAGE(Text002Lbl);
                    end;
                }
                action("Print Exit Interview")
                {
                    ToolTip = 'Specifies print  Exit interview.';
                    Caption = 'Print Exit Interview';
                    Image = Print;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        EmpSeperation.RESET();
                        EmpSeperation.SETRANGE("Employee ID", "Employee ID");
                        REPORT.RUN(33001286, true, false, EmpSeperation);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&untions")
            {
                Caption = 'F&untions';

                action("Re&lease")
                {
                    ToolTip = 'Specifies the Document is in Release state.';
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Release(Rec);
                    end;
                }
                action("Re&open")
                {
                    ToolTip = 'Sepcifies the Re-open of the document.';
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Reopen();
                    end;
                }
                action("&Terminate the Employee")
                {
                    ToolTip = 'Specifies if Employee is Terminated.';
                    Caption = '&Terminate the Employee';
                    Image = Cancel;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        TerminateEmployee();
                    end;
                }
                action("&Update Retirement/Resignation")
                {
                    ToolTip = 'Specifies the Employee Retirement or Resignation.';
                    Caption = '&Update Retirement/Resignation';
                    Image = UpdateUnitCost;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        UpdateRetirementandResignation();
                    end;
                }
                action("&Conduct Exit Interview")
                {
                    ToolTip = 'Specifies the Conduct Exit interview.';
                    Caption = '&Conduct Exit Interview';
                    Image = TerminationDescription;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        ExitInterview();
                    end;
                }
            }
        }
    }

    var
        EmpSeperation: Record "Employee Seperation B2B";
        Employee: Record "Employee B2B";
        Text001Lbl: Label 'You can''t generate Termination Letter for a Resigned/Retired employee';
        Text002Lbl: Label 'You cant generate Relieving Letter for a terminated employee';
}

