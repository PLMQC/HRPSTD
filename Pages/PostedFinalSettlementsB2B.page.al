page 33001406 "Posted Final Settlements B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Final Settlement List';
    CardPageID = "Posted Final Settlement B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Final Settlement Header B2B";
    SourceTableView = SORTING()
                      WHERE(Posted = FILTER(true));
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
                    ApplicationArea = all;
                    ToolTip = 'specify the employee no';
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the employee name';
                }
                field("Pay Cadre"; "Pay Cadre")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the pay cadre details';
                }
                field("Date of Leaving"; "Date of Leaving")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the date of leaving details';
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the document no details';
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
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(33001239),
                                  "No." = FIELD("Employee No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    ToolTip = 'specify the dimension while posting document';
                }
            }
        }
        area(processing)
        {


            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("FFS Print")
                {
                    Caption = 'FFS Print';
                    Image = PrintForm;
                    ApplicationArea = all;
                    ToolTip = 'specify the FFS print details';
                    trigger OnAction();
                    begin
                        FSHeader.RESET();
                        FSHeader.SETRANGE("Employee No.", "Employee No.");
                        REPORT.RUNMODAL(33001264, true, true, FSHeader);
                    end;
                }
                action("FFS Att Print")
                {
                    Caption = 'FFS Att Print';
                    Image = PrintCheck;
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the FFS attendance print details';
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
        MonthlyAttRec: Record "Monthly Attendance B2B";
        FSFAttReport: Report "FSF Att Report B2B";


}

