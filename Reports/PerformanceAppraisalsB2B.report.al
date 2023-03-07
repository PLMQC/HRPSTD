report 33001283 "Performance Appraisals B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Performance Appraisals.rdl';
    Caption = 'Performance Appraisals';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee Performance Header"; "Employee PerformanceHeader B2B")
        {
            DataItemTableView = SORTING("Apprisal No") ORDER(Ascending);
            RequestFilterFields = "Employee No.";
            column(Employee_Performance_Header_Period; Period)
            {
            }
            column(Employee_Performance_Header__Employee_Name_; "Employee Name")
            {
            }
            column(Employee_Performance_Header__Date_of_Joining_; "Date of Joining")
            {
            }
            column(Employee_Performance_Header__Employee_No__; "Employee No.")
            {
            }
            column(Employee_Performance_Header__Division_Code_; "Division Code")
            {
            }
            column(Employee_Performance_Header__Physical_Location_; "Physical Location")
            {
            }
            column(HOD_Name_; "HOD Name")
            {
            }
            column(HOD_Id_; "HOD Id")
            {
            }
            column(PERFORMANCE_APPRAISALSCaption; PERFORMANCE_APPRAISALSCaptionLbl)
            {
            }
            column(Period_Of_appraisalCaption; Period_Of_appraisalCaptionLbl)
            {
            }
            column(Name_of_the_EmployeeCaption; Name_of_the_EmployeeCaptionLbl)
            {
            }
            column(Date_of_JoiningCaption; Date_of_JoiningCaptionLbl)
            {
            }
            column(Employee_NumberCaption; Employee_NumberCaptionLbl)
            {
            }
            column(Employee_Performance_Header__Division_Code_Caption; FIELDCAPTION("Division Code"))
            {
            }
            column(Name_Of_HODCaption; Name_Of_HODCaptionLbl)
            {
            }
            column(Location_of_workCaption; Location_of_workCaptionLbl)
            {
            }
            column(HOD_No_Caption; HOD_No_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152061; EmptyStringCaption_Control1102152061Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152062; EmptyStringCaption_Control1102152062Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152063; EmptyStringCaption_Control1102152063Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152064; EmptyStringCaption_Control1102152064Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152065; EmptyStringCaption_Control1102152065Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152066; EmptyStringCaption_Control1102152066Lbl)
            {
            }
            column(EmptyStringCaption_Control1102152067; EmptyStringCaption_Control1102152067Lbl)
            {
            }
            column(Employee_Performance_Header_Apprisal_No; "Apprisal No")
            {
            }

            dataitem("Employee Performance Line"; "Employee Performance Line B2B")
            {
                DataItemLink = "Employee No." = FIELD("Employee No."), "Appraisal No." = FIELD("Apprisal No");
                //DataItemTableView = SORTING("Appraisal No.", "Line No.") ORDER(Ascending) WHERE("KRA Type" = CONST(Question));
                column(Employee_Performance_Line__KRA_Points_; "KRA Points")
                {
                }
                column(TotalTargetsGvar; TotalTargetsGvar)
                {

                }
                column(TotalTargetsAchievedGvar; TotalTargetsAchievedGvar)
                {

                }
                column(Employee_Performance_Line_Weightage; Weightage)
                {
                }
                column(Employee_Performance_Line__Self_Rating_; "Self Rating")
                {
                }
                column(Employee_Performance_Line__HOD_Rating_; "HOD Rating")
                {
                }
                column(Employee_Performance_Line__Total_Target_; "Total Target")
                {
                }
                column(Employee_Performance_Line__Total_Target_Achived_; "Total Target Achived")
                {
                }

                column(Employee_Performance_Line__Total_Self_Rating_; "Total Self Rating")
                {
                }
                column(Employee_Performance_Line__Total_HOD_Rating_; "Total HOD Rating")
                {
                }
                column(KRA_PointsCaption; KRA_PointsCaptionLbl)
                {
                }
                column(WeightageCaption; WeightageCaptionLbl)
                {
                }
                column(Self_RatingCaption; Self_RatingCaptionLbl)
                {
                }
                column(Rating_by_HODCaption; Rating_by_HODCaptionLbl)
                {
                }
                column(Total_Self_RatingCaption; Total_Self_RatingCaptionLbl)
                {
                }
                column(Total_HOD_RatingCaption; Total_HOD_RatingCaptionLbl)
                {
                }
                column(Employee_Performance_Line_Appraisal_No_; "Appraisal No.")
                {
                }
                column(Employee_Performance_Line_Line_No_; "Line No.")
                {
                }
                column(Employee_Performance_Line_Employee_No_; "Employee No.")
                {
                }

                trigger OnAfterGetRecord();

                begin
                    PageCounter -= 1;
                    PageCounter -= 1;
                    if "Employee Performance Line"."KRA Type" = "Employee Performance Line"."KRA Type"::"End" then begin
                        TotalTargetsGvar += "Employee Performance Line"."Total Target";
                        TotalTargetsAchievedGvar += "Employee Performance Line"."Total Target Achived";
                        //Message('%1 %2', TotalTargetsGvar, TotalTargetsAchievedGvar);
                    end;
                end;

            }
            dataitem("Employee Performance Line2"; "Employee Performance Line B2B")
            {
                DataItemLink = "Employee No." = FIELD("Employee No."), "Appraisal No." = FIELD("Apprisal No");
                // DataItemTableView = SORTING("Appraisal No.", "Line No.") ORDER(Ascending) WHERE("KRA Type" = CONST(Answer));
                column(Employee_Performance_Line2_Weightage; Weightage)
                {
                }
                column(Employee_Performance_Line2__Self_Rating_; "Self Rating")
                {
                }
                column(Employee_Performance_Line2__HOD_Rating_; "HOD Rating")
                {
                }
                column(Employee_Performance_Line2__Total_Self_Rating_; "Total Self Rating")
                {
                }
                column(Employee_Performance_Line2__Total_HOD_Rating_; "Total HOD Rating")
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Employee_Performance_Line2_Appraisal_No_; "Appraisal No.")
                {
                }
                column(Employee_Performance_Line2_Line_No_; "Line No.")
                {
                }
                column(Employee_Performance_Line2_Employee_No_; "Employee No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    PageCounter -= 1;
                end;
            }
            dataitem(Achievements; "Employee Performance Line B2B")
            {
                DataItemLink = "Employee No." = FIELD("Employee No."), "Appraisal No." = FIELD("Apprisal No");
                DataItemLinkReference = "Employee Performance Header";
                DataItemTableView = SORTING("Appraisal No.", "Line No.") ORDER(Ascending) WHERE("KRA Type" = FILTER(<> Begin));
                column(TXT001___FORMAT_Period_; TXT001Txt + FORMAT(Period))
                {
                }
                column(Achievements_Target; Target)
                {
                }
                column(FORMAT__AcheiveSrNo_________; FORMAT("AcheiveSrNo.") + ')')
                {
                }
                column(Achievements__Total_Target_; "Total Target")
                {
                }
                column(Achievements__Total_Target_Achived_; "Total Target Achived")
                {
                }
                column(Total_TargetCaption; Total_TargetCaptionLbl)
                {
                }
                column(Target_AchivedCaption; Target_AchivedCaptionLbl)
                {
                }
                column(EmptyStringCaption_Control1102152072; EmptyStringCaption_Control1102152072Lbl)
                {
                }
                column(Achievements_Appraisal_No_; "Appraisal No.")
                {
                }
                column(Achievements_Line_No_; "Line No.")
                {
                }
                column(Achievements_Employee_No_; "Employee No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    "AcheiveSrNo." += 1;
                    PageCounter -= 1;
                    PageCounter -= 1;
                end;
            }
            dataitem(PageLoop; "Integer")
            {
                DataItemTableView = SORTING(Number) ORDER(Descending);
                column(PageLoop_Number; Number)
                {
                }
                column(I; I)
                {
                }
                column(Ratings_ArrayIndex_; Ratings[ArrayIndex])
                {
                }
                column(PERFORMANCE_RATING_SCALECaption; PERFORMANCE_RATING_SCALECaptionLbl)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    ArrayIndex := Number;
                    if GuiAllowed() then
                        if Number <= I then
                            ArrayIndex := Number;


                    if GuiAllowed() then
                        if Number > I then
                            exit;


                    if GuiAllowed() then
                        if Number = I then;

                end;

                trigger OnPreDataItem();
                begin
                    ArrayIndex := 1;
                    SETRANGE(Number, 1, PageCounter);

                    Lookup2.RESET();
                    Lookup2.SETRANGE("Lookup Type", 9);
                    I := Lookup2.COUNT();
                    if Lookup2.FINDFIRST() then
                        repeat
                            Ratings[ArrayIndex] := FORMAT(Lookup2."Performance Scale Value") + '  -->  ' + Lookup2."Lookup Name";
                            ArrayIndex += 1;
                        until Lookup2.NEXT() = 0;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                "EmployeeNo.Grec" := "Employee Performance Header"."Employee No.";
                "AppraisalNo.Grec" := "Employee Performance Header"."Apprisal No";
                Employee.GET("Employee No.");
                "HOD Id" := Employee."Reporting To";
                "HOD Name" := Employee."Reporting Name";
            end;

            trigger OnPreDataItem();
            begin
                CLEAR("EmployeeNo.Grec");
                CLEAR("AppraisalNo.Grec");
                PageCounter := 25;
            end;
        }
    }

    requestpage
    {
        Caption = 'Performance Appraisals';

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
        Employee: Record "Employee B2B";
        Lookup2: Record Lookup_B2B;
        "EmployeeNo.Grec": Code[20];
        "AppraisalNo.Grec": Code[20];
        "AcheiveSrNo.": Integer;
        TXT001Txt: Label '"SUMMARY OF EMPLOYEE''S ACHIEVEMENTS IN "';
        "HOD Id": Code[20];
        "HOD Name": Text[120];
        PageCounter: Integer;
        I: Integer;
        Ratings: array[15] of Code[120];
        ArrayIndex: Integer;
        PERFORMANCE_APPRAISALSCaptionLbl: Label 'PERFORMANCE APPRAISALS';
        Period_Of_appraisalCaptionLbl: Label 'Period Of appraisal';
        Name_of_the_EmployeeCaptionLbl: Label 'Name of the Employee';
        Date_of_JoiningCaptionLbl: Label 'Date of Joining';
        Employee_NumberCaptionLbl: Label 'Employee Number';
        Name_Of_HODCaptionLbl: Label 'Name Of HOD';
        Location_of_workCaptionLbl: Label 'Location of work';
        HOD_No_CaptionLbl: Label 'HOD No.';
        EmptyStringCaptionLbl: Label ':-';
        EmptyStringCaption_Control1102152061Lbl: Label ':-';
        EmptyStringCaption_Control1102152062Lbl: Label ':-';
        EmptyStringCaption_Control1102152063Lbl: Label ':-';
        EmptyStringCaption_Control1102152064Lbl: Label ':-';
        EmptyStringCaption_Control1102152065Lbl: Label ':-';
        EmptyStringCaption_Control1102152066Lbl: Label ':-';
        EmptyStringCaption_Control1102152067Lbl: Label ':-';
        KRA_PointsCaptionLbl: Label 'KRA Points';
        WeightageCaptionLbl: Label 'Weightage';
        Self_RatingCaptionLbl: Label 'Self Rating';
        Rating_by_HODCaptionLbl: Label 'Rating by HOD';
        Total_Self_RatingCaptionLbl: Label 'Total Self Rating';
        Total_HOD_RatingCaptionLbl: Label 'Total HOD Rating';
        TotalCaptionLbl: Label 'Total';
        Total_TargetCaptionLbl: Label 'Total Target';
        Target_AchivedCaptionLbl: Label 'Target Achived';
        EmptyStringCaption_Control1102152072Lbl: Label ':-';
        PERFORMANCE_RATING_SCALECaptionLbl: Label 'PERFORMANCE RATING SCALE';
        TotalTargetsGvar: Decimal;
        TotalTargetsAchievedGvar: Decimal;
}

