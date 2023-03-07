report 33001197 "Employee -Credentials B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Employee -Credentials.rdlc';
    Caption = 'Employee -Credentials';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
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
            }*///B2BBP
            column(USERID; USERID())
            {
            }
            column(Employee___CredentialsCaption; Employee___CredentialsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }
            dataitem(Credentials; "Credentials B2B")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Employee B2B";
                DataItemTableView = SORTING("Document No.", "Skill Type", "Line No.", Designation) WHERE(Employee = FILTER(true));
                RequestFilterFields = "Skill Type";
                column(Emp__No__; Emp."No.")
                {
                }
                column(Emp_FullName; Emp.FullName())
                {
                }
                column(Emp_Designation; Emp.Designation)
                {
                }
                column(Credentials__Skill_Type_; "Skill Type")
                {
                }
                column(Credentials__Credential_Code_; "Credential Code")
                {
                }
                column(Credentials_Description; Description)
                {
                }
                column(Employee_No_Caption; Employee_No_CaptionLbl)
                {
                }
                column(NameCaption; NameCaptionLbl)
                {
                }
                column(DesignationCaption; DesignationCaptionLbl)
                {
                }
                column(Credentials__Skill_Type_Caption; FIELDCAPTION("Skill Type"))
                {
                }
                column(CodeCaption; CodeCaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(Credentials_Document_No_; "Document No.")
                {
                }
                column(Credentials_Document_Type; "Document Type")
                {
                }
                column(Credentials_Line_No_; "Line No.")
                {
                }
            }

            trigger OnPreDataItem();
            begin
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
            end;
        }
    }

    requestpage
    {
        Caption = 'Employee -Credentials';

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
        EmployeeQualificationFilter := Credentials.GETFILTERS();
    end;

    var
        Emp: Record "Employee B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        EmployeeQualificationFilter: Text;

        Employee___CredentialsCaptionLbl: Label 'Employee - Credentials';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_No_CaptionLbl: Label 'Employee No.';
        NameCaptionLbl: Label 'Name';
        DesignationCaptionLbl: Label 'Designation';
        CodeCaptionLbl: Label 'Code';
        DescriptionCaptionLbl: Label 'Description';
}

