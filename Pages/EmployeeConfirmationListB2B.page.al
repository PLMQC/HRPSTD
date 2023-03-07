page 33001212 "Employee Confirmation List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Confirmation List';
    CardPageID = "Employee Confirmation B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Employee Confirm. Header B2B";
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Confirmation ID"; "Confirmation ID")
                {
                    ToolTip = 'Specifies / Select the Confirmation Id Number';
                    ApplicationArea = all;
                }
                field("Employee ID"; "Employee ID")
                {
                    ToolTip = 'Specifies / select the Probation Employee ID';
                    ApplicationArea = all;
                }
                field("Date of Confirmation"; "Date of Confirmation")
                {
                    ToolTip = 'Define the Date on which employee is going to be confirmed.';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Specifies the employee confirmation document status "Released / Open"';
                    ApplicationArea = all;
                }
                field("No.Series"; "No.Series")
                {
                    ToolTip = 'Specifies the Number series applicabale';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Confirm")
            {
                Caption = '&Confirm';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Employee Confirmation B2B";
                    RunPageLink = "Confirmation ID" = FIELD("Confirmation ID");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Confirmation ID details';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Update &Confirmation")
                {
                    Caption = 'Update &Confirmation';
                    Image = Confirm;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Update& Confirmation details';
                    trigger OnAction();
                    begin
                        TESTFIELD(Status, Status::Release);
                        if not CONFIRM(Text001Lbl) then
                            exit;

                        Employee.RESET();
                        Employee.SETRANGE("No.", "Employee ID");
                        Employee.SETRANGE("Confirmation Date", "Date of Confirmation");
                        if Employee.FINDFIRST() then
                            ERROR(Text004Lbl);

                        Employee.RESET();
                        Employee.SETRANGE("No.", "Employee ID");
                        if Employee.FINDFIRST() then begin
                            Employee.Probation := false;
                            Employee."Confirmation Date" := "Date of Confirmation";
                            Employee.MODIFY();
                        end;

                        EmpConfirmLine2.RESET();
                        EmpConfirmLine2.SETRANGE("Header No.", "Confirmation ID");
                        if EmpConfirmLine2.FINDFIRST() then
                            repeat
                                PayElements2.RESET();
                                PayElements2.SETRANGE("Employee Code", EmpConfirmLine2."No.");
                                if PayElements2.FINDSET() then
                                    repeat
                                        PayElements2."Active Pay Elements" := false;
                                        PayElements2.MODIFY();
                                    until PayElements2.NEXT() = 0;
                            until EmpConfirmLine2.NEXT() = 0;
                        EmpConfirmLine.RESET();
                        EmpConfirmLine.SETRANGE("Header No.", "Confirmation ID");
                        if EmpConfirmLine.FINDFIRST() then
                            repeat
                                PayElements.RESET();
                                PayElements.SETRANGE("Employee Code", EmpConfirmLine."No.");
                                if PayElements.FINDLAST() then
                                    repeat
                                        PayElements.INIT();
                                        PayElements.VALIDATE("Employee Code", EmpConfirmLine."No.");
                                        PayElements."Effective Start Date" := EmpConfirmLine."Confirmation Date";
                                        PayElements."Computation Type" := EmpConfirmLine."Revised Computation Type";
                                        PayElements."Fixed/Percent" := EmpConfirmLine."Revised Fixed / Percent";
                                        PayElements."Effective Start Date" := EmpConfirmLine."Confirmation Date";
                                        PayElements."Add/Deduct" := EmpConfirmLine."Add/Deduct";
                                        PayElements."Amount / Percent" := EmpConfirmLine."Revised Amount / Percent";
                                        PayElements.VALIDATE("Pay Element Code", EmpConfirmLine."Revised Pay Element");
                                        PayElements."Pay Cadre" := EmpConfirmLine."Pay Cadre";
                                        PayElements."Active Pay Elements" := true;
                                        PayElements.INSERT();
                                    until PayElements.NEXT() = 0;
                            until EmpConfirmLine.NEXT() = 0;
                        MESSAGE(Text003Lbl, "Employee ID");
                    end;
                }
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Document Status Release';
                    trigger OnAction();
                    begin
                        EmpConfirmHeaderRec.GET("Confirmation ID");
                        if (EmpConfirmHeaderRec.Status = EmpConfirmHeaderRec.Status::Release) then
                            ERROR(Text007Lbl)
                        else begin
                            EmpConfirmHeaderRec.Status := EmpConfirmHeaderRec.Status::Release;
                            EmpConfirmHeaderRec.MODIFY();
                        end;
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    ToolTip = 'Specicfies the Document Status Re-Open';
                    trigger OnAction();
                    begin
                        EmpConfirmHeaderRec2.GET("Confirmation ID");
                        if (EmpConfirmHeaderRec2.Status = EmpConfirmHeaderRec2.Status::Open) then
                            ERROR(Text008Lbl)
                        else begin
                            EmpConfirmHeaderRec2.Status := EmpConfirmHeaderRec2.Status::Open;
                            EmpConfirmHeaderRec2.MODIFY();
                        end;
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = Print;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;
                    ToolTip = 'Option to choose Print details';
                    trigger OnAction();
                    begin
                        EmpConfirmHeaderRec.RESET();
                        EmpConfirmHeaderRec.SETRANGE("Confirmation ID", "Confirmation ID");
                        EmpConfirmHeaderRec.SETRANGE("Employee ID", "Employee ID");
                        REPORT.RUNMODAL(33001270, true, false, EmpConfirmHeaderRec);
                    end;
                }
            }
        }
    }

    var
        EmpConfirmHeaderRec: Record "Employee Confirm. Header B2B";
        EmpConfirmHeaderRec2: Record "Employee Confirm. Header B2B";
        Employee: Record "Employee B2B";
        EmpConfirmLine: Record "Employee Confirmation Line B2B";
        PayElements: Record "Pay Elements B2B";
        PayElements2: Record "Pay Elements B2B";
        EmpConfirmLine2: Record "Employee Confirmation Line B2B";

        Text001Lbl: Label 'Employee %1 has been confirmed successfully.', Comment = '%1 = Name';
        Text003Lbl: Label 'Pay element already exists with effective date for the employee %1.', Comment = '%1 = Employee ID';
        Text004Lbl: Label 'Do you want to update the confirmation ?';

        Text007Lbl: Label 'Document is already Released';
        Text008Lbl: Label 'Document is already in Open status';
}

