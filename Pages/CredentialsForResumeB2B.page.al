page 33001460 "Credentials For Resume B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Credentials For Resume';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Credentials B2B";
    SourceTableView = SORTING("Line No.")
                      ORDER(Ascending);


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Skill Type"; "Skill Type")
                {
                    ToolTip = 'Choose the Skill Type.';
                    OptionCaption = '" ,SKILL SET,QUALIFICATION,CERTIFICATION,TYPE OF INDUSTRY,EXPERIENCE TYPE"';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        Type := FORMAT("Skill Type");
                        "Resume Database" := true;
                    end;
                }
                field("Credential Code"; "Credential Code")
                {
                    ToolTip = 'Choose the Credential code.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Choose the Description.';
                    ApplicationArea = all;
                }
                field("Name of Institute/University"; "Name of Institute/University")
                {
                    ToolTip = 'Specifies name of institue or university of the Employee.';
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ToolTip = 'Select the Start date.';
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ToolTip = 'Select the Start date.';
                    ApplicationArea = all;
                }
                field(Percentage; Percentage)
                {
                    ToolTip = 'Specifies the Percentage.';
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ToolTip = 'Specifies the Remarks.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
}

