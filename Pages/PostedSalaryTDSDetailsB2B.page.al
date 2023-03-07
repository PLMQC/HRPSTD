page 33001447 "Posted Salary TDS Details B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Salary TDS Details';
    DelayedInsert = true;
    DeleteAllowed = false;
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
                    ToolTip = 'Choose the Employee Number.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Month; Month)
                {
                    ToolTip = 'Specifies the month.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Year; Year)
                {
                    ToolTip = 'Spcifies the year.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("TDS Amount"; "TDS Amount")
                {
                    ToolTip = 'Specifies the TDS Amount deducted.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Sal. Posting Date"; "Sal. Posting Date")
                {
                    ToolTip = 'Spcifies the Salary posting date.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Sal. Posting Document No."; "Sal. Posting Document No.")
                {
                    ToolTip = 'Spcifies the Salary posting document number.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Select; Select)
                {
                    ToolTip = 'Spcifies True mark if any.';
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        UpdateDocDetails();
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage();
    begin
        TDSSalDet.RESET();
        TDSSalDet.SETRANGE(Select, true);
        if TDSSalDet.FINDFIRST() then
            repeat
                TDSAmt += TDSSalDet."TDS Amount";
            until TDSSalDet.NEXT() = 0;
        if TDSAmt <> 0 then begin
            GenJnlLineGRec.VALIDATE("Debit Amount", TDSAmt);
            GenJnlLineGRec.MODIFY();
        end;
    end;

    trigger OnOpenPage();
    var
        PayrollUsers: Record "Payroll Location Users B2B";
    begin
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
    end;

    var
        GenJnlLineGRec: Record "Gen. Journal Line";
        TDSSalDet: Record "TDS Salary Details B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        TDSAmt: Decimal;

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
            "TDS Payment Date" := 17540101D;
        end;
    end;
}

