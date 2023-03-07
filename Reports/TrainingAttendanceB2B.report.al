report 33001278 "Training Attendance B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Training Attendance.rdlc';
    Caption = 'Training Attendance';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Training Header"; "Training Header B2B")
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Course Name", "Training Faculty", "Initiating Dept", Faculty;
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Training_Header__Training_Header___Course_Name_; "Training Header"."Course Name")
            {
            }
            column(Training_Header__Training_Header___Training_Subject_; "Training Header"."Training Subject")
            {
            }
            column(Training_Header__Training_Header___Training_Premises_; "Training Header"."Training Premises")
            {
            }
            column(Training_Header__Training_Header___Training_interval_; "Training Header"."Training interval")
            {
            }
            column(Training_Header__Training_Header___Starting_Date_; "Training Header"."Starting Date")
            {
            }
            column(Training_Header__Training_Header___Ending_Date_; "Training Header"."Ending Date")
            {
            }
            column(Training_Header__Training_Header__Faculty; "Training Header".Faculty)
            {
            }
            column(Training_Header__Training_Header__Faculty_Control1102154004; "Training Header".Faculty)
            {
            }
            column(Training_Line__EmployeeName; "Training Line".EmployeeName)
            {
            }
            column(Training_Line__Designation; "Training Line".Designation)
            {
            }
            column(Training_Line__Remarks; "Training Line".Remarks)
            {
            }
            column(TRAINING_ATTENDANCECaption; TRAINING_ATTENDANCECaptionLbl)
            {
            }
            column(NAME_OF_THE_PROGRAMMECaption; NAME_OF_THE_PROGRAMMECaptionLbl)
            {
            }
            column(Training_Header__Training_Header___Training_Subject_Caption; Training_Header__Training_Header___Training_Subject_CaptionLbl)
            {
            }
            column(Training_Header__Training_Header___Training_Premises_Caption; Training_Header__Training_Header___Training_Premises_CaptionLbl)
            {
            }
            column(Training_Header__Training_Header___Training_interval_Caption; Training_Header__Training_Header___Training_interval_CaptionLbl)
            {
            }
            column(Training_Header__Training_Header___Starting_Date_Caption; Training_Header__Training_Header___Starting_Date_CaptionLbl)
            {
            }
            column(Training_Header__Training_Header___Ending_Date_Caption; Training_Header__Training_Header___Ending_Date_CaptionLbl)
            {
            }
            column(Training_Header__Training_Header__FacultyCaption; Training_Header__Training_Header__FacultyCaptionLbl)
            {
            }
            column(FACULTY_SIGNATURECaption; FACULTY_SIGNATURECaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154048; EmptyStringCaption_Control1102154048Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154049; EmptyStringCaption_Control1102154049Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154050; EmptyStringCaption_Control1102154050Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154056; EmptyStringCaption_Control1102154056Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154057; EmptyStringCaption_Control1102154057Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154058; EmptyStringCaption_Control1102154058Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154059; EmptyStringCaption_Control1102154059Lbl)
            {
            }
            column(S_No_Caption; S_No_CaptionLbl)
            {
            }
            column(EnameCaption; EnameCaptionLbl)
            {
            }
            column(SubjectCaption; SubjectCaptionLbl)
            {
            }
            column(SignatureCaption; SignatureCaptionLbl)
            {
            }
            column(Training_Header__Training_Header__Faculty_Control1102154004Caption; Training_Header__Training_Header__Faculty_Control1102154004CaptionLbl)
            {
            }
            column(Training_Line__EmployeeNameCaption; Training_Line__EmployeeNameCaptionLbl)
            {
            }
            column(Training_Line__DesignationCaption; Training_Line__DesignationCaptionLbl)
            {
            }
            column(Training_Line__RemarksCaption; Training_Line__RemarksCaptionLbl)
            {
            }
            column(SIGNATURECaption_Control1102154014; SIGNATURECaption_Control1102154014Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154051; EmptyStringCaption_Control1102154051Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154052; EmptyStringCaption_Control1102154052Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154053; EmptyStringCaption_Control1102154053Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154054; EmptyStringCaption_Control1102154054Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154055; EmptyStringCaption_Control1102154055Lbl)
            {
            }
            column(Training_Header_No_; "No.")
            {
            }
            dataitem("Training Line"; "Training Line B2B")
            {
                DataItemLink = "Training Header No." = FIELD ("No.");
                DataItemTableView = SORTING ("Training Header No.", "Emp no.", "Department Code", "Internal/External", "Training Line No.");
                column(Sno__; "Sno.")
                {
                }
                column(Ename; Ename)
                {
                }
                column(Training_Line__Training_Line__Subject; "Training Line".Subject)
                {
                }
                column(Training_Line_Training_Header_No_; "Training Header No.")
                {
                }
                column(Training_Line_Training_Line_No_; "Training Line No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    "Sno." += 1;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                Ename := "Training Line".Name;
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET();
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

            end;
        }
    }

    requestpage
    {
        Caption = 'Training Attendance';

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
        "Sno.": Integer;
        Ename: Text[30];
        TRAINING_ATTENDANCECaptionLbl: Label 'TRAINING ATTENDANCE';
        NAME_OF_THE_PROGRAMMECaptionLbl: Label 'NAME OF THE PROGRAMME';
        Training_Header__Training_Header___Training_Subject_CaptionLbl: Label 'TOPICS COVERED';
        Training_Header__Training_Header___Training_Premises_CaptionLbl: Label 'EXTERNAL/INTERNAL';
        Training_Header__Training_Header___Training_interval_CaptionLbl: Label 'DURATION';
        Training_Header__Training_Header___Starting_Date_CaptionLbl: Label 'FROM';
        Training_Header__Training_Header___Ending_Date_CaptionLbl: Label 'TO';
        Training_Header__Training_Header__FacultyCaptionLbl: Label 'FACULTY NAME';
        FACULTY_SIGNATURECaptionLbl: Label 'FACULTY SIGNATURE';
        EmptyStringCaptionLbl: Label ':';
        EmptyStringCaption_Control1102154048Lbl: Label ':';
        EmptyStringCaption_Control1102154049Lbl: Label ':';
        EmptyStringCaption_Control1102154050Lbl: Label ':';
        EmptyStringCaption_Control1102154056Lbl: Label ':';
        EmptyStringCaption_Control1102154057Lbl: Label ':';
        EmptyStringCaption_Control1102154058Lbl: Label ':';
        EmptyStringCaption_Control1102154059Lbl: Label ':';
        S_No_CaptionLbl: Label 'S.No.';
        EnameCaptionLbl: Label 'Ename';
        SubjectCaptionLbl: Label 'Subject';
        SignatureCaptionLbl: Label 'Signature';
        Training_Header__Training_Header__Faculty_Control1102154004CaptionLbl: Label 'PROGRAMME EVALUATED BY';
        Training_Line__EmployeeNameCaptionLbl: Label 'Name';
        Training_Line__DesignationCaptionLbl: Label 'Designation';
        Training_Line__RemarksCaptionLbl: Label 'EFFECTIVENESS RATING';
        SIGNATURECaption_Control1102154014Lbl: Label 'SIGNATURE';
        EmptyStringCaption_Control1102154051Lbl: Label ':';
        EmptyStringCaption_Control1102154052Lbl: Label ':';
        EmptyStringCaption_Control1102154053Lbl: Label ':';
        EmptyStringCaption_Control1102154054Lbl: Label ':';
        EmptyStringCaption_Control1102154055Lbl: Label ':';
}

