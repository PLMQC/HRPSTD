page 33001359 "Salary Process Error Logs B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Process Error Log List';
    Editable = false;
    PageType = List;
    SourceTable = "Salary Process Error Log B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Line No"; "Line No")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the LIne Number used in the Processed Checklist';
                }
                field("Checklist ID"; "Checklist ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Checklist ID Status of the Processed Checklist';
                }
                field("Checklist Sub ID"; "Checklist Sub ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Status of the Processed Checklist';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Description of the Processed Checklist';
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Displays the Status of the Processed Checklist';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Menu Button")
            {
                Caption = '&Form';
                Visible = "Menu ButtonVisible";
                action("&Card")
                {
                    Caption = '&Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'specify the card of the Employee';
                    trigger OnAction();
                    begin
                        OpenForm(Type, No);
                    end;
                }
            }
        }
    }

    trigger OnInit();
    begin
        "Menu ButtonVisible" := true;
    end;

    trigger OnOpenPage();
    begin
        if Check1 then
            "Menu ButtonVisible" := true
        else
            "Menu ButtonVisible" := false;
    end;

    var
        Check1: Boolean;
        [InDataSet]
        "Menu ButtonVisible": Boolean;
        Text001Lbl: Label 'Lookup';
        Text002Lbl: Label 'Employee';
        Text003Lbl: Label 'Loan';
        Text004Lbl: Label 'TDS Deduction';

    procedure OpenForm(ProcessType: Text[50]; ProcessNo: Text[50]);
    var
        Lookup_B2B: Record Lookup_B2B;
        Employee: Record "Employee B2B";
        Loan: Record Loan_B2B;
        EmpTDSDeduction: Record "Emp TDS Deduction B2B";
        OtherPayElements: Record "Other PayElements B2B";
        PayRevision: Record "Pay Revision Header B2B";
    begin
        if ProcessType = Text001Lbl then
            Lookup_B2B.RESET();


        if ProcessType = Text002Lbl then begin
            Employee.RESET();
            Employee.SETRANGE("No.", ProcessNo);
            PAGE.RUNMODAL(33001194, Employee);
        end;

        if ProcessType = Text003Lbl then begin
            Loan.RESET();
            Loan.SETRANGE(Id, ProcessNo);
            PAGE.RUNMODAL(33001245, Loan);
        end;

        if ProcessType = Text004Lbl then begin
            EmpTDSDeduction.RESET();
            EmpTDSDeduction.SETRANGE("Employee No.", ProcessNo);
            PAGE.RUNMODAL(33001257, EmpTDSDeduction);
        end;

        if ProcessType = Text004Lbl then begin
            OtherPayElements.RESET();
            PAGE.RUNMODAL(33001242, OtherPayElements);
        end;

        if ProcessType = Text004Lbl then begin
            PayRevision.RESET();
            PayRevision.SETRANGE("Id.", ProcessNo);
            PAGE.RUNMODAL(33001259, PayRevision);
        end;
    end;

    procedure SetValue(Check: Boolean);
    begin
        Check1 := Check;
    end;
}

