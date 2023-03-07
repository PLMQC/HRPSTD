page 33001362 "Salary TDS Details List B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary TDS Details List';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    PageType = Worksheet;
    SourceTable = "TDS Salary Details B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

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
                    ToolTip = 'Specifies the Employee code';
                }
                field(Month; Month)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the month';
                }
                field(Year; Year)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the year';
                }
                field("TDS Amount"; "TDS Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the tDS amount';
                }
                field("Sal. Posting Date"; "Sal. Posting Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the sal posting date';
                }
                field("Sal. Posting Document No."; "Sal. Posting Document No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the sal posting document no';
                }
                field("TDS Payment Date"; "TDS Payment Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the TDS Payment date';
                }
                field("TDS Payment Doc. No."; "TDS Payment Doc. No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the TDS payment doc no';
                }
            }
        }
    }

    actions
    {
    }

    var
        GenJnlLineGRec: Record "Gen. Journal Line";


    procedure PayTDS1(GenJnlLine: Record "Gen. Journal Line");
    begin
        GenJnlLineGRec.COPY(GenJnlLine);
    end;

    procedure UpdateDocDetails();
    begin
        if Select then begin
            "TDS Payment Doc. No." := GenJnlLineGRec."Document No.";
            "TDS Payment Date" := GenJnlLineGRec."Posting Date";
        end else begin
            "TDS Payment Doc. No." := '';
            "TDS Payment Date" := 0D;
        end;
    end;
}

