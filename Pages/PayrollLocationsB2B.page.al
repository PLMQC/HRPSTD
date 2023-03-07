page 33001286 "Payroll Locations B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Locations';
    PageType = Card;
    SourceTable = "Payroll Locations B2B";
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
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Location code';
                }
                field("Location Name"; "Location Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Location name';
                }
                field("Location Type"; "Location Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the location type';
                }
                field("Location Incharge"; "Location Incharge")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the location incharge';
                }
            }
            
            group(Address)
            {
                Caption = 'Address';
                field(Control1102154022; Address)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the address';
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the address 2';
                }
                field(TeleFax; TeleFax)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the telefax';
                }
                field(State; State)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the state';
                }
                field(Country; Country)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the country';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Picture")
            {
                Caption = '&Picture';
                // action("PF Import")
                // {
                //     Caption = 'PF Import';
                //     Ellipsis = true;
                //     ApplicationArea = all;
                //     Image = Import;
                //     Visible = false;
                //     trigger OnAction();
                //     begin
                //         // if not GuiAllowed() then begin
                //         //     PictureExists := "PF Logo".HASVALUE();
                //         //     if "PF Logo".IMPORT(Text003Lbl) = '' then
                //         //         exit;
                //         //     if PictureExists then
                //         //         if not CONFIRM(Text001Lbl, false) then
                //         //             exit;
                //         //     CurrPage.SAVERECORD();
                //         // end;
                //     end;
                // }
                // action("PF E&xport")
                // {
                //     Caption = 'PF E&xport';
                //     Ellipsis = true;
                //     ApplicationArea = all;
                //     Image = Export;
                //     Visible = false;
                //     trigger OnAction();
                //     begin
                //         // if not GuiAllowed() then 
                //         //     if "PF Logo".HASVALUE() then
                //         //         "PF Logo".EXPORT(Text003Lbl);

                //     end;
                // }
                // action("PF Delete")
                // {
                //     Caption = 'PF Delete';
                //     Image = Delete;
                //     ApplicationArea = all;
                //     Visible = false;
                //     trigger OnAction();
                //     begin
                //         // if not GuiAllowed() then
                //         //     if "PF Logo".HASVALUE() then
                //         //         if CONFIRM(Text002Lbl, false) then begin
                //         //             CLEAR("PF Logo");
                //         //             CurrPage.SAVERECORD();
                //         //         end;

                //     end;
                // }
                // action("ESIC Import")
                // {
                //     Caption = 'ESIC Import';
                //     Image = Import;
                //     Visible = false;
                //     ApplicationArea = all;
                //     trigger OnAction();
                //     begin
                //         // if not GuiAllowed() then begin
                //         //     PictureExists := "ESIC Logo".HASVALUE();
                //         //     if "ESIC Logo".IMPORT(Text003Lbl) = '' then
                //         //         exit;
                //         //     if PictureExists then
                //         //         if not CONFIRM(Text001Lbl, false) then
                //         //             exit;
                //         //     CurrPage.SAVERECORD();
                //         // end;
                //     end;
                // }
                // action("ESIC Export")
                // {
                //     Caption = 'ESIC Export';
                //     Image = Export;
                //     Visible = false;
                //     ApplicationArea = all;
                //     trigger OnAction();
                //     begin
                //         // if not GuiAllowed() then 
                //         //     if "ESIC Logo".HASVALUE then
                //         //         "ESIC Logo".EXPORT(Text003Lbl);

                //     end;
                // }
                // action("ESIC Delete")
                // {
                //     Caption = 'ESIC Delete';
                //     Image = Delete;
                //     Visible = false;
                //     ApplicationArea = all;
                //     trigger OnAction();
                //     begin
                //         // if not GuiAllowed() then
                //         //     if "ESIC Logo".HASVALUE then
                //         //         if CONFIRM(Text002Lbl, false) then begin
                //         //             CLEAR("ESIC Logo");
                //         //             CurrPage.SAVERECORD();
                //         //         end;

                //     end;
                // }
            }
            group("&Locations")
            {
                Caption = '&Locations';
                Visible = false;
                action("TDS Acknowledgment")
                {
                    Caption = 'TDS Acknowledgment';
                    Image = Alerts;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "TDS Acknowledgement B2B";
                    RunPageLink = "Location Code" = FIELD("Location Code");
                    ToolTip = 'Specifies the TDS acknowledgment';
                }
            }
        }
    }

    var
    // PictureExists: Boolean;
    // Text001Lbl: Label 'Do you want to replace the existing picture?';
    // Text002Lbl: Label 'Do you want to delete the picture?';
    // Text003Lbl: Label '*.BMP';
}

