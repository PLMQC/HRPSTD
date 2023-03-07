report 33001192 "Update Experience B2B"
{
    // version B2BHR1.00.00

    Caption = 'Update Experience';
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Resume Database"; "Resume Database B2B")
        {
            DataItemTableView = SORTING("No.");

            trigger OnAfterGetRecord();
            begin
                UpdateExpereince("Resume Database");
            end;
        }
    }

    requestpage
    {
        Caption = 'Update Experience';

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Year: Decimal;
        Days: Integer;
        Month: Integer;
        Month2: Integer;
        Month3: Integer;
        Month4: Integer;
        Year2: Integer;
        Date: Integer;

    procedure UpdateExpereince(var ResumeDatabase: Record "Resume Database B2B");
    begin
        if ResumeDatabase."Last Updated" < TODAY() then begin
            Date := TODAY() - ResumeDatabase."Last Updated";
            Year := Date div 365;
            Days := Date mod 365;
            Month := Days div 28;
            Month2 := ResumeDatabase.Months + Month;
            if Month2 > 12 then begin
                Month3 := Month2 div 12;
                Year2 := Year + Month3;
                Month4 := Month2 mod 12;
            end else
                if Month2 = 12 then begin
                    Year2 := Year + 1;
                    Month4 := 0;
                end else begin
                    Year2 := Year;
                    Month4 := Month2;
                end;
            ResumeDatabase."Experience(Years)" := ResumeDatabase."Experience(Years)" + Year2;
            ResumeDatabase.Months := Month4;
            ResumeDatabase."Last Updated" := TODAY();
            ResumeDatabase.MODIFY();
        end;
    end;
}

