page 33001375 "Resource Hierarchy B2B"
{
    // version B2BHR1.00.00

    Caption = 'Resource Hierarchy';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Resource Hierarchy B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(FromUSERID1; FromUserID)
                {
                    Caption = 'From User ID';
                    ApplicationArea = all;
                    ToolTip = 'Specify the user id details in general';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin

                        /*LoginMgt.LookupUserID(FromUserID);
                        LoginMgt.ResHeirLookupUserID(FromUserID);
                        SetDetails;*/
                    end;

                    trigger OnValidate();
                    begin
                        FromUserIDOnAfterValidate();
                    end;
                }
            }
            repeater(Control1102154003)
            {
                field("From User ID"; "From User ID")
                {
                    Visible = false;
                    ApplicationArea = all;
                    ToolTip = 'Specify the from user id details';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PAGE.RUNMODAL(33001376, User) = ACTION::LookupOK then
                            "From User ID" := User."User Name";
                    end;
                }
                field("To User ID"; "To User ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the to user id details';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        //LoginMgt.ResHeirLookupUserID("To User ID");
                    end;
                }
                field("To Employee ID"; "To Employee ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee id';
                }
                field("To Employee Name"; "To Employee Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specify the Employee name';
                }
            }
        }
    }

    actions
    {
    }

    var
        User: Record User;
        FromUserID: Code[20];

    procedure SetDetails();
    begin
        RESET();
        SETRANGE("From User ID", FromUserID);
        CurrPage.UPDATE(false);
    end;

    local procedure FromUserIDOnAfterValidate();
    begin
        SetDetails();
    end;
}

