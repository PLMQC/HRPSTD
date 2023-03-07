page 33001240 "LeaveEncashmentSubform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'LeaveEncashmentSubform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Leave Encashment Line B2B";
    SourceTableView = SORTING("Employee Code")
                      ORDER(Ascending);


    layout
    {
        area(content)
        {
            repeater(Control1102154000)
            {
                field("Employee Code"; "Employee Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The employee code';
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The employee name';
                }
                field("Leave Pay Cadre"; "Leave Pay Cadre")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leave pay cadre';
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The dimension';
                }
                field("Leave Code"; "Leave Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leave code';
                }
                field("Available Leaves"; "Available Leaves")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The available leaves';
                }
                field("Leaves To Encash"; "Leaves To Encash")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies The leaves to encash';
                }
                field("Encash Amount"; "Encash Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies The encash amount';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Specifies The dimension';
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        Showdimentions();
                    end;
                }
            }
        }
    }

    var
        DimMgt: Codeunit 408;

    procedure Showdimentions();
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', "Employee Code", "Employee Name"));

        if OldDimSetID <> "Dimension Set ID" then
            MODIFY();
    end;
}

