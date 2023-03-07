page 33001403 "VDA Subform B2B"
{
    // version B2BHR1.00.00

    Caption = 'VDA Subform';
    PageType = ListPart;
    SourceTable = "VDA Line B2B";

    layout
    {
        area(content)
        {
            //Caption = 'VDA Subform';//Phani
            repeater(Control1102154001)
            {
                field(Month; Month)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'specify the month details';
                }
                field(Points; Points)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the points detail';
                }
                field("Point Value"; "Point Value")
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the point value details';
                }
                field(Values; Values)
                {
                    ApplicationArea = all;
                    ToolTip = 'specify the values detail';
                }
            }
        }
    }

    actions
    {
    }
}

