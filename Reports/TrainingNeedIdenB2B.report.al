report 33001193 "Training Need Iden B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Training Need Identification.rdl';
    Caption = 'Training Need Identification_';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Training Header"; "Training Header B2B")
        {
            PrintOnlyIfDetail = true;

            column(Training_Header__No__; "No.")
            {
            }
            column(Course_Name; "Course Name")
            {

            }
            column(EmpNoCap; EmpNoCap)
            {

            }
            column(EmpNameCap; EmpNameCap)
            {

            }


            column(Training_Header__Need__for_Training_; "Need  for Training")
            {
            }
            column(Training_Header__Starting_Date_; "Starting Date")
            {
            }


            column(Training_Header__Ending_Date_; "Ending Date")
            {
            }
            column(Training_Header__Training_Subject_; "Training Subject")
            {
            }
            column(TRAINING_NEED_IDENTIFICATION_FORMCaption; TRAINING_NEED_IDENTIFICATION_FORMCaptionLbl)
            {
            }
            column(Training_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Training_Header__Need__for_Training_Caption; FIELDCAPTION("Need  for Training"))
            {
            }
            column(Training_Header__Training_Subject_Caption; FIELDCAPTION("Training Subject"))
            {
            }
            column(Training_Header__Starting_Date_Caption; FIELDCAPTION("Starting Date"))
            {
            }
            column(Training_Header__Ending_Date_Caption; FIELDCAPTION("Ending Date"))
            {
            }






            dataitem("Training Line"; "Training Line B2B")
            {
                DataItemLink = "Training Header No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.") ORDER(Ascending);
                PrintOnlyIfDetail = false;
                column(Training_Line__Employee_No__; "Employee No.")
                {
                }
                column(Training_Line_Name; Name)
                {
                }
                column(Training_Line__Employee_No__Caption; FIELDCAPTION("Employee No."))
                {
                }
                column(Training_Line_NameCaption; FIELDCAPTION(Name))
                {
                }
                column(Training_Line_Training_Header_No_; "Training Header No.")
                {
                }
                column(Training_Line_Training_Line_No_; "Training Line No.")
                {
                }


            }
        }
    }

    requestpage
    {
        Caption = 'Training Need Identification';

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
        TRAINING_NEED_IDENTIFICATION_FORMCaptionLbl: Label 'TRAINING NEED IDENTIFICATION FORM';
        EmpNoCap: label 'Emp No.';
        EmpNameCap: label 'Emp Name';
    //GTraingHeader: Record "Training Header B2B";
}

