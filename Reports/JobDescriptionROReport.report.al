report 33001282 "Job Description RO Report B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Job Description RO Report.rdl';
    Caption = 'Job Description RO Report';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Job Description Header(RO)"; "Job Description Header(RO) B2B")
        {
            RequestFilterFields = "No.";
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Job_Description_Header_RO___Job_Description_Header_RO____Job_Description_; "Job Description Header(RO)"."Job Description")
            {
            }
            column(Job_Description_Header_RO___Job_Description_Header_RO____Reports_To_Designation_; "Job Description Header(RO)"."Reports To Designation")
            {
            }
            column(Job_Description_Header_RO___Job_Description_Header_RO___Department; "Job Description Header(RO)".Department)
            {
            }
            column(Job_Description_Header_RO___Job_Description_Header_RO____Type_of_Position_; "Job Description Header(RO)"."Type of Position")
            {
            }
            column(Job_Description_Header_RO___Job_Description_Header_RO____Job_Designation_; "Job Description Header(RO)"."Job Designation")
            {
            }
            column(Job_Description_Header_RO___Job_Description_Header_RO____Global_Dimension_1_; "Job Description Header(RO)"."Global Dimension 1")
            {
            }
            column(JOB_DESCRIPTION_FORMCaption; JOB_DESCRIPTION_FORMCaptionLbl)
            {
            }
            column(Completion_of_this_Form_is_mandatoryCaption; Completion_of_this_Form_is_mandatoryCaptionLbl)
            {
            }
            column(Job_DescriptionCaption; Job_DescriptionCaptionLbl)
            {
            }
            column(Reports_to_DesignationCaption; Reports_to_DesignationCaptionLbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(Type_of_PostionCaption; Type_of_PostionCaptionLbl)
            {
            }
            column(Job_DesignationCaption; Job_DesignationCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152020; EmptyStringCaption_Control1102152020Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152021; EmptyStringCaption_Control1102152021Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152027; EmptyStringCaption_Control1102152027Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152037; EmptyStringCaption_Control1102152037Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152051; EmptyStringCaption_Control1102152051Lbl)
            {
            }
            column(Issue_CodeCaption; Issue_CodeCaptionLbl)
            {
            }
            column(Job_Description_Header_RO__No_; "No.")
            {
            }
            dataitem("Job Description Line"; "Job Description Line B2B")
            {
                DataItemLink = "Job Code" = FIELD("No.");
                DataItemTableView = SORTING("Job Code", Type) ORDER(Ascending) WHERE(Type = CONST(Responsibilities));
                column(Job_Description_Line_RO___Job_Description_Line_RO___Description; "Job Description Line".Responsibilities)
                {
                }
                column(SNo; SNo)
                {
                }
                column(Job_HeadingCaption; Job_HeadingCaptionLbl)
                {
                }
                column(JobResponseCaption; JobResponseCaptionLbl)
                {
                }
                column(Job_Description_Line_Job_Code; "Job Code")
                {
                }
                column(Job_Description_Line_Line_No_; "Line No.")
                {
                }
                column(Job_Description_Line_Type; Type)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    SNo += 1;
                end;
            }
            dataitem("<Job Description Line2>"; "Job Description Line B2B")
            {
                DataItemLink = "Job Code" = FIELD("No.");
                DataItemTableView = SORTING("Job Code", Type) ORDER(Ascending) WHERE(Type = CONST(Requirements));
                column(Job_Description_Line__Requirements; "<Job Description Line2>".Requirements)
                {
                }
                column(SNo_Control1102152046; SNo)
                {
                }
                column(JobReqCaption; JobReqCaptionLbl)
                {
                }
                column(Job_Description_Line2__Job_Code; "Job Code")
                {
                }
                column(Job_Description_Line2__Line_No_; "Line No.")
                {
                }
                column(Job_Description_Line2__Type; Type)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    SNo += 1;
                end;
            }
            dataitem("<Job Description Line3>"; "Job Description Line B2B")
            {
                DataItemLink = "Job Code" = FIELD("No.");
                DataItemTableView = SORTING("Job Code", Type) ORDER(Ascending) WHERE(Type = CONST(Competences));
                column(Job_Description_Line__Competences; "<Job Description Line3>".Competences)
                {
                }
                column(SNo_Control1102152060; SNo)
                {
                }
                column(JobCompCaption; JobCompCaptionLbl)
                {
                }
                column(Job_Description_Line3__Job_Code; "Job Code")
                {
                }
                column(Job_Description_Line3__Line_No_; "Line No.")
                {
                }
                column(Job_Description_Line3__Type; Type)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    SNo += 1;
                end;
            }

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {
        Caption = 'Job Description RO Report';

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
        CompanyInfo: Record "Company Information";
        SNo: Integer;
        JOB_DESCRIPTION_FORMCaptionLbl: Label 'JOB DESCRIPTION FORM';
        Completion_of_this_Form_is_mandatoryCaptionLbl: Label 'Completion of this Form is mandatory';
        Job_DescriptionCaptionLbl: Label 'Job Description';
        Reports_to_DesignationCaptionLbl: Label 'Reports to Designation';
        DepartmentCaptionLbl: Label 'Department';
        Type_of_PostionCaptionLbl: Label 'Type of Postion';
        Job_DesignationCaptionLbl: Label 'Job Designation';
        EmptyStringCaptionLbl: Label ':';
        EmptyStringCaption_Control1102152020Lbl: Label ':';
        EmptyStringCaption_Control1102152021Lbl: Label ':';
        EmptyStringCaption_Control1102152027Lbl: Label ':';
        EmptyStringCaption_Control1102152037Lbl: Label ':';
        EmptyStringCaption_Control1102152051Lbl: Label ':';
        Issue_CodeCaptionLbl: Label 'Issue Code';
        Job_HeadingCaptionLbl: Label 'Job Description';
        JobResponseCaptionLbl: Label 'Job Responsibilities';
        JobReqCaptionLbl: Label 'Job Requirements';
        JobCompCaptionLbl: Label 'Job Competences';
}

