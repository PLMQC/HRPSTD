page 33001285 "Payroll Locations List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Locations List';
    CardPageID = "Payroll Locations B2B";
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Locations B2B";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Define the locations in payroll locations list';
                }
                field("Location Name"; "Location Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the location name in payroll location list';
                }
                field("Location Type"; "Location Type")

                {
                    ApplicationArea = all;
                    ToolTip = ' Specify the location type metro or non-metro in payroll locations list';
                }
                field("Location Incharge"; "Location Incharge")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the location incharge details  in payroll location list';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Locations")
            {
                Caption = '&Locations';
                action("TDS Acknowledgment")
                {
                    Caption = 'TDS Acknowledgment';
                    Image = Alerts;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "TDS Acknowledgement B2B";
                    RunPageLink = "Location Code" = FIELD("Location Code");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the  employee TDS acknowledgment details in posted TDS details';
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);
    end;
}

