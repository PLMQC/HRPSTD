page 33001296 "Emp Alternative Add Card B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp. Alternative Address Card';
    DataCaptionExpression = Caption();
    PageType = Card;
    PopulateAllFields = true;
    SourceTable = "Emp Alternative Address B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter the code e.g.Permanent Address / Temporary value assigned to the employee';
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter the Name against the code value assigned to the employee';
                }
                field(Address; Address)
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter the Alternative Address of the employee';
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter the Alternative Address of the employee';
                }
                field("Post Code"; "Post Code")
                {
                    Caption = 'Post Code/City';
                    ApplicationArea = all;
                    ToolTip = 'Enter the Post code of the city and assigned the value to the employee';
                }
                field("Permanent Address"; "Permanent Address")
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter the Permanent Address towards a employee';
                }
                field(City; City)
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter the city name which is picked from Post Code and is assigned to the employee';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter the Phone number applicable to the employee';
                }
                field("Fax No."; "Fax No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter the FAX number applicable to the employee';
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter the Email Address applicable to the employee';
                }
            }
        }
    }

    actions
    {
    }

    var
        Employee: Record "Employee B2B";
        Text000Lbl: Label 'untitled';


    procedure Caption(): Text[110];
    begin
        if Employee.GET("Employee No.") then
            exit(CopyStr("Employee No." + ' ' + Employee.FullName() + ' ' + Code, 1, 110))
        else
            exit(Text000Lbl);
    end;
}

