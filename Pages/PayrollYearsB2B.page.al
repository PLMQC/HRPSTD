page 33001218 "Payroll Years B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Years';
    Editable = false;
    PageType = Worksheet;
    SourceTable = "Payroll Year B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Year Type"; "Year Type")
                {
                    ToolTip = 'Specifies the various pay roll years to used run the HR and Payroll "Leave Year, Financial Year, ESI Year and PF Year"';
                    ApplicationArea = all;
                }
                field("Year Start Date"; "Year Start Date")
                {
                    ToolTip = 'Specifies the various pay roll years to used run the HR and Payroll "Leave Year, Financial Year, ESI Year and PF Year" Every year associated has a "Start Date and End Date"';
                    ApplicationArea = all;
                }
                field("Year End Date"; "Year End Date")
                {
                    ToolTip = 'Specifies the various pay roll years to used run the HR and Payroll "Leave Year, Financial Year, ESI Year and PF Year" Every year associated has a "Start Date and End Date"';
                    ApplicationArea = all;
                }
                field(Closed; Closed)
                {
                    ToolTip = 'Specifies the various pay roll years to used run the HR and Payroll "Leave Year, Financial Year, ESI Year and PF Year" Every year associated has a "Start Date and End Date" and its closure.';
                    ApplicationArea = all;
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

                action("C&reate Year")
                {
                    Caption = 'C&reate Year';
                    Image = CreateYear;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Create year details.';

                    trigger OnAction();
                    begin
                        CLEAR(CreateYear);
                        CreateYear.YearTypeInsert("Year Type");
                        CreateYear.RUNMODAL();
                    end;
                }
                action("Cl&ose Year")
                {
                    Caption = 'Cl&ose Year';
                    Image = CloseYear;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Close year details.';

                    trigger OnAction();
                    begin
                        TESTFIELD(Closed, false);
                        if CONFIRM(Text001Lbl, false, "Year Type") then begin
                            Closed := true;
                            MODIFY();
                        end;
                    end;
                }
            }
        }
    }

    var
        CreateYear: Page "Create Year B2B";
        Text001Lbl: Label 'Do you want to Close the %1', Comment = '%1 = Year Type';
}

