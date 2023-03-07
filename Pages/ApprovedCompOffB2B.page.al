page 33001546 "Approved Comp Off B2B"
{
    // version B2BHR1.00.00

    Caption = 'Approved Comp Off';
    Editable = false;
    PageType = Document;
    SourceTable = "Attendance Header B2B";
    SourceTableView = WHERE("Document Type" = CONST("Comp Off"),
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
                    ToolTip = 'Choose the Comp off ID.';
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Creation Date"; "Creation Date")
                {
                    ToolTip = 'Shows the Creation Date.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Choose the Physical location of Employee.';
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ToolTip = 'Choose the Type from drop down. ex. department/Employee.';
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Choose the Department code of Employee.';
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Choose the Month.';
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Choose the YEar.';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Displays the Document status as open,pending for approval,Approved.';
                    ApplicationArea = all;
                }
            }
            part(Control1102152001; "Approved CompOff Subform B2B")
            {
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                ApplicationArea = all;

            }
        }

    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

    end;
}

