page 33001191 "Lookup Types B2B"
{
    // version B2BHR1.00.00

    Caption = 'Lookup Types';
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = "Lookup Type B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("No."; "No.")
                {
                    ToolTip = 'Specifies the number of the Lookup . The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = all;
                }
                field(Name; Name)
                {
                    ToolTip = 'Specifies the Lookup Name';
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies the Lookup Description associated with Lookup no';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

