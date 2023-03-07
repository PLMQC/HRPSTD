page 33001310 "Train. Need. Identi. Sub B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Train. Need. Identi. Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Train. Need Identi. Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Name of Person"; "Name of Person")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Name of the Person to whom the Training is Initiated is displayed here';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                    ToolTip = 'The designation of the Employee nominated is shown here';
                }
                field(Responsibilities; Responsibilities)
                {
                    ApplicationArea = all;
                    ToolTip = 'The Responsibilities related to the Job towards a Employee is displayed';
                }
                field("Behavioural Training Needed"; "Behavioural Training Needed")
                {
                    ApplicationArea = all;
                    ToolTip = 'These are Type of Trainings';
                }
                field("Technical Training Needed"; "Technical Training Needed")
                {
                    ApplicationArea = all;
                    ToolTip = 'These are Type of Trainings';
                }
                field("Years of Experience"; "Years of Experience")
                {
                    ApplicationArea = all;
                    ToolTip = 'Employees Years of Experience is displayed here';
                }
                field("Area of Working"; "Area of Working")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Area of working';
                }
                field(Priority; Priority)
                {
                    ApplicationArea = all;
                    ToolTip = 'Mention the Priority of Training';
                }
                field(Status; Status)
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'The Training document status is shown as Released / Open';
                }
            }
        }
    }

    actions
    {
    }
}

