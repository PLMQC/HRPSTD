report 33001286 "Exit Interview B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;

    RDLCLayout = 'Reports\Layout\Exit InterviewN1.rdl';
    Caption = 'Exit Interview';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee Seperation"; "Employee Seperation B2B")
        {
            RequestFilterFields = "Seperation ID";
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(EmpDesignation; EmpDesignation)
            {
            }
            column(HireDate; HireDate)
            {
            }
            column(HOD; HOD)
            {
            }
            column(Jobtitle; Jobtitle)
            {
            }
            column(ResignedDate; ResignedDate)
            {
            }
            column(EXIT_INTERVIEWCaption; EXIT_INTERVIEWCaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(DesignationCaption; DesignationCaptionLbl)
            {
            }
            column(Hire_DateCaption; Hire_DateCaptionLbl)
            {
            }
            column(HODCaption; HODCaptionLbl)
            {
            }
            column(LastWorkingDate_CaptionLbl; LastWorkingDate_CaptionLbl)
            {
            }
            column(Resigned_DateCaption; Resigned_DateCaptionLbl)
            {
            }
            column(Employee_Seperation_Seperation_ID; "Seperation ID")
            {
            }
            column(Employee_Seperation_Employee_ID; "Employee ID")
            {
            }
            column(Effective_Date; "Effective Date")
            { }
            column(Last_Working_Date; "Last Working Date")
            { }
            dataitem("Employee Separation Line"; "Employee Separation Line B2B")
            {
                DataItemLink = "Seperation ID" = FIELD("Seperation ID");

                column(Employee_Separation_Line_Question; Question)
                {
                }
                column(Employee_Separation_Line_Seperation_ID; "Seperation ID")
                {
                }
                column(Employee_Separation_Line_Line_No_; "Line No.")
                {
                }
                column(Employee_Separation_Line_Employee_ID; "Employee ID")
                { }


            }
            trigger OnAfterGetRecord();
            begin
                IF Employee.GET("Employee ID") then begin
                    EmployeeName := copystr(Employee.FullName(), 1, 100);
                    EmpDesignation := Employee.Designation;
                    HireDate := Employee."Employment Date";
                    ResignedDate := Employee."Resignation Date";
                    HOD := Employee."Reporting Name";

                end;
            end;

        }
    }

    requestpage
    {
        Caption = 'Exit Interview';

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

    trigger OnInitReport();
    begin
        CompInfo.GET();
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        Employee: Record "Employee B2B";
        CompInfo: Record "Company Information";
        EmployeeName: Text[100];
        EmpDesignation: Code[50];
        HireDate: Date;
        HOD: Code[20];
        Jobtitle: Text[50];
        ResignedDate: Date;
        "AnsNo.": Integer;
        EXIT_INTERVIEWCaptionLbl: Label 'EXIT INTERVIEW';
        Employee_NameCaptionLbl: Label 'Employee Name';
        DesignationCaptionLbl: Label 'Designation';
        Hire_DateCaptionLbl: Label 'Hire Date';
        HODCaptionLbl: Label 'HOD';
        //Job_TitleCaptionLbl: Label 'Job Title';
        Resigned_DateCaptionLbl: Label 'Resigned Date';
        Name_CaptionLbl: Label 'Name:';
        Signature_CaptionLbl: Label 'Signature:';
        Date_CaptionLbl: Label 'Date:';
        HR_Comment_CaptionLbl: Label 'HR Comment:';
        Human_Resources_RepresentativeCaptionLbl: Label 'Human Resources Representative';
        Signature_Caption_Control1102152034Lbl: Label 'Signature:';
        Date_Caption_Control1102152035Lbl: Label 'Date:';
        LastWorkingDate_CaptionLbl: Label 'Last Working Date';
}

