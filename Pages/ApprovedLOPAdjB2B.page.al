page 33001523 "Approved LOP Adj. B2B"
{
    // version B2BHR1.00.00

    Caption = 'Approved LOP Adj.';
    Editable = false;
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Attendance Header B2B";
    SourceTableView = WHERE("Document Type" = CONST("Lop Adj"),
                            Status = CONST(Approved));
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
                    ToolTip = 'Choose the No. sereis defined from drop down.';
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Creation Date"; "Creation Date")
                {
                    ToolTip = 'Choose the Date of Creation.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Select the Physical location of the Employee.';
                    ApplicationArea = all;
                }
                field("Code"; Code)
                {
                    ToolTip = 'Choose the Employee No.';
                    Caption = 'Employee Code';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Select the Month for lop Adjustment.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Select the Year for lop Adjustment.';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Shows the Status of Document.';
                    ApplicationArea = all;
                }
            }
            part(LopAdjSubForm; "Approved LOP Adj. Subform B2B")
            {
                Caption = 'LopAdjSubForm';
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                ApplicationArea = all;

            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Type := Type::Employee;
    end;
}

