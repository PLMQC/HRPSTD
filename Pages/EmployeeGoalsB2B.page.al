page 33001508 "Employee Goals B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Employee Goals';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Employee Goals B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Quarter; Quarter)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Quarter';
                }
                field(KPA; KPA)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The KPA';
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The serial no';
                }
                field("Goals Description"; "Goals Description")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The goal description';
                }
                field("Q1 Goals"; "Q1 Goals")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Q1Goals';
                }
                field("Budget Weightage"; "Budget Weightage")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The budget weightage';
                    trigger OnValidate();
                    begin
                        BudgetValidation();
                    end;
                }
                field("Target Date"; "Target Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The target date';
                }
                field("Actual Weightage"; "Actual Weightage")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The actual weightage';
                    trigger OnValidate();
                    begin
                        if "Actual Weightage" > "Budget Weightage" then
                            ERROR(Text003Lbl);
                        ActualBudgetValidation();
                    end;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Remarks';
                }
                field(Period; Period)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Period';
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The from date';
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The To date';
                }
                field("Weightage Status"; "Weightage Status")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The weightage status';
                }
                field("Actual Weightage Status"; "Actual Weightage Status")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Actual weightage';
                }
                field("Approvar ID"; "Approvar ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The Approvar ID';
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
                action("Weightage Approval")
                {
                    Caption = 'Weightage Approval';
                    Image = Approval;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The weightage approval';

                    trigger OnAction();
                    begin
                        CLEAR(ApprovalID);
                        HRApprovalSetup.RESET();
                        HRApprovalSetup.SETRANGE("Document Type", HRApprovalSetup."Document Type"::"Resource Indent");
                        HRApprovalSetup.SETRANGE(User, USERID());
                        if HRApprovalSetup.FINDFIRST() then
                            ApprovalID := HRApprovalSetup."HR Approval";

                        EmployeeGoals.RESET();
                        EmployeeGoals.SETRANGE("Employee Code", "Employee Code");
                        EmployeeGoals.SETFILTER("Weightage Status", '<>%1', EmployeeGoals."Weightage Status"::"Approved");
                        EmployeeGoals.SETFILTER("Budget Weightage", '<>%1', 0);
                        if EmployeeGoals.FINDFIRST() then begin
                            repeat
                                EmployeeGoals."Weightage Status" := EmployeeGoals."Weightage Status"::"Pending Approval";
                                EmployeeGoals."Approvar ID" := ApprovalID;
                                EmployeeGoals.MODIFY();
                            until EmployeeGoals.NEXT() = 0;
                            MESSAGE(Text002Lbl);
                        end else
                            ERROR(Text000Lbl);
                    end;
                }
                action("Actual Weightage Approval")
                {
                    Caption = 'Actual Weightage Approval';
                    Image = Approvals;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The actual weightage approval';

                    trigger OnAction();
                    begin
                        CLEAR(ApprovalID2);
                        HRApprovalSetup.RESET();
                        HRApprovalSetup.SETRANGE("Document Type", HRApprovalSetup."Document Type"::"Resource Indent");
                        HRApprovalSetup.SETRANGE(User, USERID());
                        if HRApprovalSetup.FINDFIRST() then
                            ApprovalID2 := HRApprovalSetup."HR Approval";

                        EmployeeGoals.RESET();
                        EmployeeGoals.SETRANGE("Employee Code", "Employee Code");
                        EmployeeGoals.SETFILTER("Actual Weightage Status", '<>%1', EmployeeGoals."Actual Weightage Status"::"Approved");
                        EmployeeGoals.SETFILTER("Actual Weightage", '<>%1', 0);
                        if EmployeeGoals.FINDFIRST() then
                            repeat
                                EmployeeGoals."Actual Weightage Status" := EmployeeGoals."Actual Weightage Status"::"Pending Approval";
                                EmployeeGoals."Approvar ID" := ApprovalID2;
                                EmployeeGoals.MODIFY();
                            until EmployeeGoals.NEXT() = 0;

                    end;
                }
            }
        }
    }

    var
        EmployeeGoals: Record "Employee Goals B2B";
        HRApprovalSetup: Record "HR Approval setup B2B";
        ApprovalID: Code[50];
        Percentage: Decimal;
        ApprovalID2: Code[50];
        Text000Lbl: Label '"You Must  enter a value in  Weightage  while weightage is going for approval "';
        Text002Lbl: Label '"Sent for approval "';
        Text003Lbl: Label 'You cannot enter more than budget weight';
        Text004Lbl: Label 'You cannot enter more than 100  Quantity';
        BudgetValue: Decimal;

    procedure BudgetValidation();
    begin
        CLEAR(BudgetValue);
        BudgetValue := 0;
        EmployeeGoals.RESET();
        EmployeeGoals.SETRANGE("Employee Code", "Employee Code");
        EmployeeGoals.SETRANGE(Quarter, Quarter);
        EmployeeGoals.SETFILTER("Line No.", '<>%1', "Line No.");
        if EmployeeGoals.FINDFIRST() then
            repeat
                BudgetValue += EmployeeGoals."Budget Weightage";
            until EmployeeGoals.NEXT() = 0;
        if (BudgetValue + "Budget Weightage") > 100 then
            ERROR(Text004Lbl);
    end;

    procedure ActualBudgetValidation();
    begin
        CLEAR(Percentage);
        EmployeeGoals.RESET();
        EmployeeGoals.SETRANGE("Employee Code", "Employee Code");
        EmployeeGoals.SETRANGE(Quarter, Quarter);
        EmployeeGoals.SETFILTER("Line No.", '<>%1', "Line No.");
        if EmployeeGoals.FINDFIRST() then
            repeat
                Percentage += EmployeeGoals."Actual Weightage";
            until EmployeeGoals.NEXT() = 0;
        if (Percentage + "Actual Weightage") > 100 then
            ERROR(Text004Lbl);
    end;
}

