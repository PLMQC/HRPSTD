page 33001476 "Training Schedule History B2B"
{
    // version B2BHR1.00.00

    Caption = 'Training Schedule History';
    DeleteAllowed = false;
    Editable = false;
    PageType = Document;
    SourceTable = "Training Schedule Header B2B";
    SourceTableView = WHERE("Training Created" = CONST(true));
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
                    ToolTip = 'Specifies the unique number.';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Specfies the Description of training schedulee.';
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ToolTip = 'Choose the Dimension values.';
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ToolTip = 'Choose the Dimenision Value.';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Physical Location for which the training is being provided';
                }
                field(Frequency; Frequency)
                {
                    ToolTip = 'Specifices the Frequency for Training Schedule.';
                    ApplicationArea = all;
                }
                field(Period; Period)
                {
                    ToolTip = 'Specifies the period of Training Schedule.';
                    ApplicationArea = all;
                }
                field("Training Starting Date"; "Training Starting Date")
                {
                    ToolTip = 'Specifies Training Start date.';
                    ApplicationArea = all;
                }
                field("Type of Training"; "Type of Training")
                {
                    ToolTip = 'Specifies the Type of Training.';
                    ApplicationArea = all;
                }
                field("Type of Training Description"; "Type of Training Description")
                {
                    ToolTip = 'Specifies the Type of Training Description.';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Shows the Document status as open or released state.';
                    ApplicationArea = all;
                }
            }
            part(Control1102154020; "Training Schedule Subform B2B")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }
}

