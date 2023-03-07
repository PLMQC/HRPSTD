page 33001222 "Shift Card B2B"
{
    // version B2BHR1.00.00

    Caption = 'Shift Card';
    PageType = Card;
    SourceTable = "Shift Master B2B";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Location Code"; "Location Code")
                {
                    Editable = LocEdit;
                    ToolTip = 'A work location is the place or building where you run your organisation. If your business has offices in different locations, it is important that you add all your work locations. The location classify your employees and affect the contributions towards the Professional Tax and Labour Welfare Fund.';
                    ApplicationArea = all;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        if PayrollUsers.GET(USERID()) then;
                        PayrollLoc.RESET();
                        PayrollLoc.SETFILTER("Location Code", PayrollUsers."Multiple Locations");
                        if PAGE.RUNMODAL(0, PayrollLoc) = ACTION::LookupOK then
                            "Location Code" := PayrollLoc."Location Code";
                        ;
                    end;

                    trigger OnValidate();
                    begin
                        if PayrollUsers.GET(USERID()) then
                            if PayrollUsers."Multiple Locations" <> '' then
                                if STRPOS(PayrollUsers."Multiple Locations", "Location Code") = 0 then
                                    ERROR(Text001Lbl, "Location Code");

                    end;
                }
                field("Shift Code"; "Shift Code")
                {
                    ToolTip = 'Specifies the In and Out time assigned to an Employee or Employee''s based on a time slot.';
                    ApplicationArea = all;
                }
                field(Decription; Decription)
                {
                    ToolTip = 'Specifies the In and Out time assigned to an Employee or Employee''s based on a time slot.';
                    ApplicationArea = all;
                }
                field("Starting Time"; "Starting Time")
                {
                    ToolTip = 'Specifies the In and Out time assigned to an Employee or Employee''s based on a time slot.';
                    ApplicationArea = all;
                }
                field("Ending Time"; "Ending Time")
                {
                    ToolTip = 'Specifies the In and Out time assigned to an Employee or Employee''s based on a time slot.';
                    ApplicationArea = all;
                }
                field("Break Start Time"; "Break Start Time")
                {
                    ToolTip = 'Specifies the In and Out time assigned to an Employee or Employee''s based on a time slot having a break time slot.';
                    ApplicationArea = all;
                }
                field("Break End time"; "Break End time")
                {
                    ToolTip = 'Specifies the In and Out time assigned to an Employee or Employee''s based on a time slot having a break time slot start and end.';
                    ApplicationArea = all;
                }
                field("Cut Off Min Start Time"; "Cut Off Min Start Time")
                {
                    ToolTip = 'Specifies the Shift time defined and applied to an employee or employees having a minmum time for all time punches';
                    ApplicationArea = all;
                }
                field("Cut Off End Time"; "Cut Off End Time")
                {
                    ToolTip = 'Specifies the Shift time defined and applied to an employee or employees having a minmum time for all time punches';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("S&hift")
            {
                Caption = 'S&hift';
                action("O&ff Days")
                {
                    Caption = 'O&ff Days';
                    Image = Holiday;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Shiftwise Offdays B2B";
                    RunPageLink = "Shift Code" = FIELD("Shift Code"),
                                  "Location Code" = FIELD("Location Code");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Off days details.';
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);
        SetLocEdit();
    end;

    var
        PayrollUsers: Record "Payroll Location Users B2B";
        PayrollLoc: Record "Payroll Locations B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";

        [InDataSet]
        LocEdit: Boolean;

        Text001Lbl: Label 'You are not authorized for the Location %1', Comment = '%1 = Location Code';

    procedure SetLocEdit();
    begin
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            LocEdit := true
        else
            LocEdit := false;
    end;
}

