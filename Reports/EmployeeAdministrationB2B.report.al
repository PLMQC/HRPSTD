report 33001200 "Employee Administration B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Employee Administration.rdlc';
    Caption = 'Employee - Addresses';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            //ReqFilterHeading = 'Employee';
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(Employee_B2B__No__; "No.")
            {
            }
            column(FullName; FullName())
            {
            }
            column(Employee_B2B__PF_No_; "PF No")
            {
            }
            column(Employee_B2B__ESI_No_; "ESI No")
            {
            }
            column(Employee_B2B__PAN_No_; "PAN No")
            {
            }
            column(Employee___AdministrationCaption; Employee___AdministrationCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(PF_No_Caption; PF_No_CaptionLbl)
            {
            }
            column(ESI_No_Caption; ESI_No_CaptionLbl)
            {
            }
            column(PAN_No_Caption; PAN_No_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                FormatAddr.FormatPostCodeCity(PostCodeCityText, CountyText, City, "Post Code", Country, "Country Code");
            end;

            trigger OnPreDataItem();
            begin
                LastFieldNo := FIELDNO("No.");
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {
        Caption = 'Employee Administration';

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

    trigger OnPreReport();
    begin
        EmployeeFilter := "Employee B2B".GETFILTERS();
    end;

    var
        FormatAddr: Codeunit "Format Address";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        LastFieldNo: Integer;
        PostCodeCityText: Text[100];
        CountyText: Text[50];
        EmployeeFilter: Text;

        Employee___AdministrationCaptionLbl: Label 'Employee - Administration';
        No_CaptionLbl: Label 'No.';
        NameCaptionLbl: Label '" Name"';
        PF_No_CaptionLbl: Label 'PF No.';
        ESI_No_CaptionLbl: Label 'ESI No.';
        PAN_No_CaptionLbl: Label 'PAN No.';
}

