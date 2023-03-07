report 33001274 "Concise Report B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Concise Report.rdlc';
    Caption = 'Concise Report';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            column(CONCISE_REPORT_; 'CONCISE REPORT')
            {
            }
            column(COMPANYNAME____; COMPANYNAME() + ',')
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Form______FORMAT_FromDate______To_____FORMAT_ToDate_; 'Form :- ' + FORMAT(FromDate) + '   To:- ' + FORMAT(ToDate))
            {
            }
            column(CompanyInfo_Address_CompanyInfo__Address_2_____; CompanyInfo.Address + CompanyInfo."Address 2" + ',')
            {
            }
            column(CompanyInfo_City_____CompanyInfo__Post_Code_; CompanyInfo.City + ' ' + CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
            {
            }
            column(TODAY; TODAY())
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(V1_; '1')
            {
            }
            column(V3_; '3')
            {
            }
            column(V2_; '2')
            {
            }
            column(V7_; '7')
            {
            }
            column(V6_; '6')
            {
            }
            column(V5_; '5')
            {
            }
            column(V4_; '4')
            {
            }
            column(V15_; '15')
            {
            }
            column(V14_; '14')
            {
            }
            column(V13_; '13')
            {
            }
            column(V12_; '12')
            {
            }
            column(V11_; '11')
            {
            }
            column(V10_; '10')
            {
            }
            column(V9_; '9')
            {
            }
            column(V8_; '8')
            {
            }
            column(V23_; '23')
            {
            }
            column(V22_; '22')
            {
            }
            column(V21_; '21')
            {
            }
            column(V20_; '20')
            {
            }
            column(V19_; '19')
            {
            }
            column(V18_; '18')
            {
            }
            column(V17_; '17')
            {
            }
            column(V16_; '16')
            {
            }
            column(V31_; '31')
            {
            }
            column(V30_; '30')
            {
            }
            column(V29_; '29')
            {
            }
            column(V28_; '28')
            {
            }
            column(V27_; '27')
            {
            }
            column(V25_; '25')
            {
            }
            column(V24_; '24')
            {
            }
            column(V26_; '26')
            {
            }
            column(Emp_No__; 'Emp No.')
            {
            }
            column(H___Holiday_; 'H - Holiday')
            {
            }
            column(PL___1_Day_Leave_Paid__; 'PL - 1 Day Leave(Paid)')
            {
            }
            column(HL___Half_Day_Leave_; 'HL - Half Day Leave')
            {
            }
            column(AA___Absent_; 'AA - Absent')
            {
            }
            column(PP___Present_Full_Day_; 'PP - Present Full Day')
            {
            }
            column(Print_DateCaption; Print_DateCaptionLbl)
            {
            }
            column(page_No_Caption; page_No_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102152025; EmptyStringCaption_Control1102152025Lbl)
            {
            }
            column(Employee_B2B_No_; "No.")
            {
            }
            dataitem("Daily Attendance"; "Daily Attendance B2B")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", Date) ORDER(Ascending);
                column(Daily_Attendance__Daily_Attendance___Employee_No__; "Daily Attendance"."Employee No.")
                {
                }
                column(Value_1_; Value[1])
                {
                }
                column(Value_3_; Value[3])
                {
                }
                column(Value_2_; Value[2])
                {
                }
                column(Value_7_; Value[7])
                {
                }
                column(Value_6_; Value[6])
                {
                }
                column(Value_5_; Value[5])
                {
                }
                column(Value_4_; Value[4])
                {
                }
                column(Value_15_; Value[15])
                {
                }
                column(Value_14_; Value[14])
                {
                }
                column(Value_13_; Value[13])
                {
                }
                column(Value_12_; Value[12])
                {
                }
                column(Value_11_; Value[11])
                {
                }
                column(Value_10_; Value[10])
                {
                }
                column(Value_9_; Value[9])
                {
                }
                column(Value_8_; Value[8])
                {
                }
                column(Value_23_; Value[23])
                {
                }
                column(Value_22_; Value[22])
                {
                }
                column(Value_21_; Value[21])
                {
                }
                column(Value_20_; Value[20])
                {
                }
                column(Value_19_; Value[19])
                {
                }
                column(Value_18_; Value[18])
                {
                }
                column(Value_17_; Value[17])
                {
                }
                column(Value_16_; Value[16])
                {
                }
                column(Value_31_; Value[31])
                {
                }
                column(Value_30_; Value[30])
                {
                }
                column(Value_29_; Value[29])
                {
                }
                column(Value_28_; Value[28])
                {
                }
                column(Value_27_; Value[27])
                {
                }
                column(Value_26_; Value[26])
                {
                }
                column(Value_25_; Value[25])
                {
                }
                column(Value_24_; Value[24])
                {
                }
                column(EmployeeRec__First_Name______EmployeeRec__Middle_Name______EmployeeRec__Last_Name_; "Employee B2B"."First Name" + ' ' + "Employee B2B"."Middle Name" + ' ' + "Employee B2B"."Last Name")
                {
                }
                column(Daily_Attendance_Date; Date)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    Value[Index] := '--';
                    if "Non-Working" then
                        Value[Index] := Text000Txt
                    else
                        if "Attendance Type" = "Attendance Type"::Absent then
                            Value[Index] := Text0001Txt
                        else
                            if "Attendance Type" = "Attendance Type"::Present then
                                Value[Index] := Text0002Txt
                            else
                                if "Attendance Type" = "Attendance Type"::Leave then
                                    Value[Index] := Text0003Txt;

                    if ("Session Time" = "Session Time"::"First Half") or ("Session Time" = "Session Time"::"Second Half") then
                        Value[Index] := Text0004Txt;

                    Index += 1;
                end;

                trigger OnPreDataItem();
                begin
                    "Daily Attendance".SETRANGE(Date, FromDate, ToDate);
                    Index := 1;
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

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("From Date"; FromDate)
                    {
                        ToolTip = 'Enter from date.';
                        Caption = 'From Date';
                        ApplicationArea = all;
                    }
                    field("To Date"; ToDate)
                    {
                        ToolTip = 'Enter To date.';
                        Caption = 'To Date';
                        ApplicationArea = all;
                    }
                }
            }
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
        Value: array[31] of Text[30];
        Index: Integer;
        FromDate: Date;
        ToDate: Date;
        Print_DateCaptionLbl: Label 'Print Date';
        page_No_CaptionLbl: Label 'page No.';
        EmptyStringCaptionLbl: Label ':';
        EmptyStringCaption_Control1102152025Lbl: Label ':';
        Text000Txt: Label 'H';
        Text0001Txt: Label 'AA';
        Text0002Txt: Label 'PP';
        Text0003Txt: Label 'PL';
        Text0004Txt: Label 'HL';
}

