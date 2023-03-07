page 33001340 "Probation Extended List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Probation Extended List';
    CardPageID = "Probation Extension Card B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Probation Extended B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Id."; "Id.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Number as defined in the Setup.';
                }
                field("Employee  Id"; "Employee  Id")
                {
                    ApplicationArea = all;
                    ToolTip = 'Pick the Employee ID who is under Probation as per list displayed';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Employee Name is Populated as soon as the Employee ID as per list displayed is picked';
                }
                field("Joining Date"; "Joining Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee Joining Date';
                }
                field("Appointment Date"; "Appointment Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employees Appoitment Date';
                }
                field(Department; Department)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employees Department Code and Name';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employees Designation';
                }
                field("Probation Period"; "Probation Period")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Pronation Period';
                }
                field("Extended Probation Period"; "Extended Probation Period")
                {
                    ApplicationArea = all;
                    ToolTip = 'Dsiplays the Extension if the Probation needs to be extebded';

                }
                field("Effective Date"; "Effective Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the New Effective Date towards Probation Extension';
                }
                field("No.Series"; "No.Series")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the Applicable Number Series';
                }
                field("Probation End Date"; "Probation End Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Probation end date is computed based on the New Effective Date';
                }
            }
        }
    }

    actions
    {
        area(processing)
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
                ToolTip = 'Update Probation';

                trigger OnAction();
                begin
                    EmployeeRec.RESET();
                    EmployeeRec.SETRANGE("No.", "Employee  Id");
                    if EmployeeRec.FINDFIRST() then begin
                        EmployeeRec."Ext. Probation Period" := "Extended Probation Period";
                        EmployeeRec.MODIFY();
                    end;
                    MESSAGE(Text001Lbl);
                end;
            }
            action("&Print")
            {
                Caption = '&Print';
                Image = Print;
                ShortCutKey = 'Ctrl+P';
                ApplicationArea = all;
                ToolTip = 'Specify the Print Action';
                trigger OnAction();
                begin
                    TESTFIELD("Appointment Date");
                    ProbationExtended.RESET();
                    ProbationExtended.SETRANGE(ProbationExtended."Id.", "Employee  Id");
                    REPORT.RUNMODAL(REPORT::"Probation Extention Period B2B", true, false, ProbationExtended);
                end;
            }
        }
    }

    var
        EmployeeRec: Record "Employee B2B";
        ProbationExtended: Record "Probation Extended B2B";
        Text001Lbl: Label 'Records updated sucessfully.';
}

