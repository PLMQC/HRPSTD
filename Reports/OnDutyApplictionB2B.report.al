report 33001272 "On Duty Appliction B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\On Duty Appliction.rdl';
    Caption = 'On Duty Appliction';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Attendance Header"; "Attendance Header B2B")
        {


            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(Attendance_Header_Document_Type; "Document Type")
            {
            }
            column(Attendance_Header_No_; "No.")
            {
            }
            column(FORMAT_NoOfDays_; FORMAT(NoOfDays))
            {
            }



            dataitem("Attendance Lines"; "Attendance Lines B2B")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Employee Code", "Start Date");
                column(Attendance_Lines__Employee_Name_; "Employee Name")
                {
                }
                column(Department; Department)
                {
                }
                column(Attendance_Header___Start_Date_; "Attendance Header"."Start Date")
                {
                }
                column(to_______FORMAT__Attendance_Header___End_Date__; 'to' + '   ' + FORMAT("Attendance Header"."End Date"))
                {
                }

                column(ToLocation; ToLocation)
                {
                }
                column(AssaignmentDetails; AssaignmentDetails)
                {
                }
                column(Attendance_Header___Advance_Request_; "Attendance Header"."Advance Request")
                {
                }
                column(NoText_1______NoText_2_; NoText[1] + ' ' + NoText[2])
                {
                }
                column(Date_Caption; Date_CaptionLbl)
                {
                }
                column(Managing_Director_Caption; Managing_Director_CaptionLbl)
                {
                }
                column(Signature_of_Applicant_Caption; Signature_of_Applicant_CaptionLbl)
                {
                }
                column(Head_of_Dept__Caption; Head_of_Dept__CaptionLbl)
                {
                }
                column(Places_Caption; Places_CaptionLbl)
                {
                }
                column(days_toCaption; days_toCaptionLbl)
                {
                }
                column(Intend_to_proceed_on_tour_from_Caption; Intend_to_proceed_on_tour_from_CaptionLbl)
                {
                }
                column(Dept_Caption; Dept_CaptionLbl)
                {
                }
                column(ForCaption; ForCaptionLbl)
                {
                }
                column(TOUR_INTIMATIONCaption; TOUR_INTIMATIONCaptionLbl)
                {
                }
                column(Special_Note___No_fresh_Advance_to_be_paid_unless_earlier_settledCaption; Special_Note___No_fresh_Advance_to_be_paid_unless_earlier_settledCaptionLbl)
                {
                }
                column(To_Caption; To_CaptionLbl)
                {
                }
                column(Accounts___HR_Department__Caption; Accounts___HR_Department__CaptionLbl)
                {
                }
                column(ICaption; ICaptionLbl)
                {
                }
                column(Assignment_No____Name__Caption; Assignment_No____Name__CaptionLbl)
                {
                }
                column(Any_Other_Details__Caption; Any_Other_Details__CaptionLbl)
                {
                }
                column(Kindly_arrange_to_pay_me_tour_advance_of_Rs_Caption; Kindly_arrange_to_pay_me_tour_advance_of_Rs_CaptionLbl)
                {
                }
                column(In_Words_Caption; In_Words_CaptionLbl)
                {
                }
                column(I_have_settled_previous_tour_advances_Caption; I_have_settled_previous_tour_advances_CaptionLbl)
                {
                }
                column(Attendance_Lines_Document_Type; "Document Type")
                {
                }
                column(Attendance_Lines_Document_No_; "Document No.")
                {
                }
                column(Attendance_Lines_Employee_Code; "Employee Code")
                {
                }
                column(Attendance_Lines_Start_Date; "Start Date")
                {
                }
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(ToLocation);
                if "Attendance Header"."To Location" <> '' then
                    ToLocation := "Attendance Header"."To Location"
                else
                    ToLocation := "Attendance Header"."Places To Visit";

                CLEAR(AssaignmentDetails);
                if "Attendance Header"."Assignment No." <> '' then
                    AssaignmentDetails := "Attendance Header"."Assignment No." + '  ' + "Attendance Header"."Assignment Name"
                else
                    AssaignmentDetails := "Attendance Header"."Global Dimension 2 Code";

                CheckGRec.InitTextVariable();
                CheckGRec.FormatNoText(NoText, "Attendance Header"."Advance Request", ' ');


                NoOfDays := ("Attendance Header"."End Date" - "Attendance Header"."Start Date") + 1;



            end;

            trigger OnPreDataItem();
            begin
                CompInfo.GET();
                CompInfo.CALCFIELDS(Picture);
            end;
        }
    }


    requestpage
    {
        Caption = 'On Duty Appliction';

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



    end;

    var
        CheckGRec: Codeunit "Approval Mgmt B2B";
        CompInfo: Record "Company Information";
        CheckRepGRec: Report "Check Report B2B";
        Department: Code[20];
        NoOfDays: Integer;
        NoofDaysGvar: integer;

        ToLocation: Text[250];
        AssaignmentDetails: Text[250];
        NoText: array[2] of Text[80];
        Date_CaptionLbl: Label 'Date:';
        Managing_Director_CaptionLbl: Label '(Managing Director)';
        Signature_of_Applicant_CaptionLbl: Label '(Signature of Applicant)';
        Head_of_Dept__CaptionLbl: Label '(Head of Dept.)';
        Places_CaptionLbl: Label 'Places.';
        days_toCaptionLbl: Label 'days to';
        Intend_to_proceed_on_tour_from_CaptionLbl: Label 'Intend to proceed on tour from ';
        Dept_CaptionLbl: Label 'Dept.';
        ForCaptionLbl: Label 'For';
        TOUR_INTIMATIONCaptionLbl: Label 'TOUR INTIMATION';
        Special_Note___No_fresh_Advance_to_be_paid_unless_earlier_settledCaptionLbl: Label 'Special Note : No fresh Advance to be paid unless earlier settled';
        To_CaptionLbl: Label 'To,';
        Accounts___HR_Department__CaptionLbl: Label 'Accounts / HR Department ,';
        ICaptionLbl: Label 'I';
        Assignment_No____Name__CaptionLbl: Label 'Assignment No. & Name :';
        Any_Other_Details__CaptionLbl: Label 'Any Other Details :';
        Kindly_arrange_to_pay_me_tour_advance_of_Rs_CaptionLbl: Label 'Kindly arrange to pay me tour advance of Rs.';
        In_Words_CaptionLbl: Label '(In Words)';
        I_have_settled_previous_tour_advances_CaptionLbl: Label 'I have settled previous tour advances.';
}

