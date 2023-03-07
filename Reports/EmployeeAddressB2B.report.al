report 33001196 "Employee - Address B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Employee - Address.rdl';
    Caption = 'Employee-Addresses-';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            /*
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }*/
            column(USERID; USERID())
            {
            }
            column(Employee_B2B__No__; "No.")
            {
            }
            column(FullName; FullName())
            {
            }
            column(Address__Address_2_; Address + "Address 2")
            {
            }
            column(PostCodeCityText; PostCodeCityText)
            {
            }
            column(Employee_B2B__Phone_No__; "Phone No.")
            {
            }
            column(Employee_B2B__Mobile_Phone_No__; "Mobile Phone No.")
            {
            }
            column(SlNo; SlNo)
            {
            }
            column(EmployeeAddCap; EmployeeAddCap)
            {

            }
            column(Employee___AddressesCaption; Employee___AddressesCaptionLbl)
            {

            }



            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(AddressCaption; AddressCaptionLbl)
            {
            }
            column(Post_Code_CityCaption; Post_Code_CityCaptionLbl)
            {
            }
            column(Phone_No_Caption; Phone_No_CaptionLbl)
            {
            }
            column(Mobile__NoCaption; Mobile__NoCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Control1102152018Caption; Control1102152018CaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                SlNo := SlNo + 1;
                FormatAddr.FormatPostCodeCity(PostCodeCityText, CountyText, City, "Post Code", Country, "Country Code");
            end;

            trigger OnPreDataItem();
            begin
                LastFieldNo := FIELDNO("No.");
                PayrollUsers.GET(USERID());
                if PayrollUsers."Multiple Locations" <> '' then
                    "Employee B2B".SETFILTER("Location Code", PayrollUsers."Multiple Locations")
                else
                    "Employee B2B".SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {
        Caption = 'Employee - Address';

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
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        FormatAddr: Codeunit "Format Address";
        LastFieldNo: Integer;
        PostCodeCityText: Text[100];
        CountyText: Text[50];
        EmployeeFilter: Text;
        SlNo: Integer;
        Employee___AddressesCaptionLbl: Label 'Employee - Addresses';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        No_CaptionLbl: Label 'No.';
        AddressCaptionLbl: Label 'Address';
        Post_Code_CityCaptionLbl: Label 'Post Code/City';
        Phone_No_CaptionLbl: Label 'Phone No.';
        Mobile__NoCaptionLbl: Label 'Mobile  No';
        NameCaptionLbl: Label 'Name';
        Control1102152018CaptionLbl: Label 'S No.';
        EmployeeAddCap: Label 'Employee Address';

}

