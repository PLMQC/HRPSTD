report 33001195 "Employee List B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Employee List.rdlc';
    Caption = 'Employee List';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Employee_B2B; "Employee B2B")
        {
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(Employee_B2B__No__; Employee_B2B."No.")
            {
            }
            column(First_Name___Middle_Name___Last_Name_; "First Name" + "Middle Name" + "Last Name")
            {
            }
            column(Employee_B2B__Birth_Date_; "Birth Date")
            {
            }
            column(Employee_B2B__Employment_Date_; "Employment Date")
            {
            }
            column(Employee_B2B__Department_Code_; "Department Code")
            {
            }
            column(Employee_B2B_Designation; Designation)
            {
            }
            column(SerialNo; SerialNo)
            {
            }
            column(Employee_listCaption; Employee_listCaptionLbl)
            {
            }
            column(Employee_B2B_Employee_B2B__No__Caption; Employee_B2B_Employee_B2B__No__CaptionLbl)
            {
            }
            column(Employee_B2B__Birth_Date_Caption; FIELDCAPTION("Birth Date"))
            {
            }
            column(Employee_B2B__Employment_Date_Caption; FIELDCAPTION("Employment Date"))
            {
            }
            column(Employee_B2B__Department_Code_Caption; FIELDCAPTION("Department Code"))
            {
            }
            column(Employee_B2B_DesignationCaption; FIELDCAPTION(Designation))
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(Serial_No_Caption; Serial_No_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                SerialNo := SerialNo + 1;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {
        Caption = 'Employee List';

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
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        SerialNo: Integer;
        Employee_listCaptionLbl: Label 'Employee list';
        Employee_B2B_Employee_B2B__No__CaptionLbl: Label 'No.';
        Employee_NameCaptionLbl: Label 'Employee Name';
        Serial_No_CaptionLbl: Label 'Serial No.';
}

