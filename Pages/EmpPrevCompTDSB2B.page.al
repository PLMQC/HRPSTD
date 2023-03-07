page 33001441 "Emp. Prev. Comp. TDS B2B"
{
    // version B2BHR1.00.00

    Caption = 'Emp. Prev. Comp. TDS Details';
    DeleteAllowed = false;
    PageType = Document;
    SourceTable = "Employee B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group("Previous Company Salary")
            {
                Caption = 'Previous Company Salary';
                part("Emp Previous Company Salary"; "Emp. Prev. Company Salary. B2B")
                {
                    SubPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = all;
                }
            }
            group("Previous TDS History")
            {
                Caption = 'Previous TDS History';
                part(Control1102154002; "Emp. Prev. TDS History B2B")
                {
                    SubPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

