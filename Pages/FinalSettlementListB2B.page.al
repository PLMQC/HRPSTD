page 33001502 "Final Settlement List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Final Settlement List';
    CardPageID = "Final Settlement B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Final Settlement Header B2B";
    SourceTableView = SORTING()
                      WHERE(Posted = FILTER(false));
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
                field("Employee Name"; "Employee Name")
                {
                    ToolTip = 'Shows the Employee Name';
                    ApplicationArea = all;
                }
                field("Pay Cadre"; "Pay Cadre")
                {
                    ToolTip = 'Choose the Pay cadre of the Employee.';
                    ApplicationArea = all;
                }
                field("Date of Leaving"; "Date of Leaving")
                {
                    ToolTip = 'Enter the date of leaveing.';
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
                {
                    ToolTip = 'Enter the document Number.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    ToolTip = 'Enter the Dimensions of the Employee.';
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(33001239),
                                  "No." = FIELD("Employee No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Get Pay &Elements")
                {
                    ToolTip = 'Get the Employee pay elements.';
                    Caption = 'Get Pay &Elements';
                    Image = GetLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        GetPayElements();
                    end;
                }
                action("Calculate &Amount")
                {
                    ToolTip = ' on clicking Calculates the amount in final Settlement.';
                    Caption = 'Calculate &Amount';
                    Image = CalculateCost;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        GetPayElements();
                        CalculateSalary();
                    end;
                }
                action("Calculate Bonus")
                {
                    ToolTip = 'On clicking Calculates the bonus in final settlement.';
                    Caption = 'Calculate Bonus';
                    Image = CalculateDiscount;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        BonusCal();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("P&ost")
                {
                    ToolTip = ' Post the Document.';
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        if CONFIRM(Text001Lbl) then begin
                            FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                            FinalSettleLine.SETRANGE(Posted, true);
                            if FinalSettleLine.FINDFIRST() then
                                ERROR(Text000Lbl);
                            FinalPosting.ProcessPosting(Rec);
                        end;
                    end;
                }
            }
            group("&Print")
            {
                ToolTip = 'prints the document.';
                Caption = '&Print';
                Image = Print;
                action("FFS Print")
                {
                    Caption = 'FFS Print';
                    Image = PrintForm;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee Option to Choose the FFS Print Details';

                    trigger OnAction();
                    begin
                        FSHeader.RESET();
                        FSHeader.SETRANGE("Employee No.", "Employee No.");
                        REPORT.RUNMODAL(33001264, true, true, FSHeader);
                    end;
                }
                action("FFS Att Print")
                {
                    ToolTip = 'Prints the employee Full and final settlement.';
                    Caption = 'FFS Att Print';
                    Image = PrintCheck;
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        MonthlyAttRec.RESET();
                        MonthlyAttRec.SETRANGE("Employee Code", "Employee No.");
                        if MonthlyAttRec.FINDSET() then begin
                            FSFAttReport.SetValues(Year, Month);
                            FSFAttReport.SETTABLEVIEW(MonthlyAttRec);
                            FSFAttReport.RUN();
                        end;
                    end;
                }
            }
        }
    }

    var
        FSHeader: Record "Final Settlement Header B2B";
        FinalSettleLine: Record "Final Settlement Line B2B";
        MonthlyAttRec: Record "Monthly Attendance B2B";
        FSFAttReport: Report "FSF Att Report B2B";
        FinalPosting: Codeunit "Final Settlement Posting B2B";
        Text000Lbl: Label 'Records are already Posted';
        Text001Lbl: Label '"Do you want to Post "';
}

