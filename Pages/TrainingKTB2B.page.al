page 33001488 "Training KT B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Training KT';
    PageType = Worksheet;
    SourceTable = "Training Schedule Plan B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field("Employee No."; "Employee No.")
                {
                    ToolTip = 'Specifies the employee number of the involved entry or record, according to the specified number series';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        TraningLine.RESET();
                        TraningLine.SETRANGE("Training Header No.", "Document No.");
                        TraningLine.SETRANGE("Training Line No.", "Document Line No.");
                        TraningLine.SETRANGE("Employee No.", "Employee No.");
                        
                        if TraningLine.FINDFIRST() then
                            ERROR(Text001Lbl);
                    end;
                }
                field("Employee Name"; "Employee Name")
                {
                    Caption = 'Full Name';
                    ToolTip = 'Specifies the Employee Name.';
                    ApplicationArea = all;
                }
                field("Training Date"; "Training Date")
                {
                    ToolTip = 'Date on which knowledge transfer.';
                    Caption = 'KT Date';
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ToolTip = 'Remarks to given for training.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        TraningLine.RESET();
        TraningLine.SETRANGE("Training Header No.", "Document No.");
        TraningLine.SETRANGE("Training Line No.", "Document Line No.");

        /* if not TraningLine.IsEmpty() and ("employee No." <> '') then begin
             TESTFIELD("Training Date");
             TraningLine."KT Given" := true;
             TraningLine.MODIFY();
         end;*/
        //B2BMMOn08Feb2023>>
        IF TraningLine.FINDFIRST THEN BEGIN
            if (TraningLine.Attend = true) and (TraningLine."Attend Date" <> 0D) then
                //B2BMMOn08Feb2023<<
                //TESTFIELD("Training Date");
            TraningLine."KT Given" := TRUE;
            TraningLine.MODIFY;
        END;

    end;

    var
        TraningLine: Record "Training Line B2B";
        Text001Lbl: Label 'Self Knowledge Transfer is not Possible';
}

