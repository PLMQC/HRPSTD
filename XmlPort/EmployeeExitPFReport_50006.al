xmlport 50006 EmployeeExitPfReport
{
    Caption = 'EmployeeExitPfReport';

    Direction = Export;
    FieldSeparator = '#~#';
    TextEncoding = UTF8;
    //TextEncoding = MSDOS;
    UseRequestPage = false;
    Format = VariableText;
    RecordSeparator = '<NewLine>';
    TableSeparator = '';
    DefaultFieldsValidation = true;
    FieldDelimiter = '';
    PreserveWhiteSpace = false;
    schema
    {
        textelement(Root)
        {
            tableelement("MonthlyAttendanceB2B"; "Monthly Attendance B2B")
            {
                XmlName = 'MonthlyAttendanceb2b';
                RequestFilterFields = "Pay Slip Month", Year;

                textelement(EmployeeUANGvar)
                { }
                textelement(EmployeeNameGvar)
                { }
                textelement(ExitReasonCodeGvar)
                { }
                textelement(ExitDate)
                { }

                trigger OnAfterGetRecord()
                begin

                    Clear(MonthGvar);
                    clear(YearGvar);
                    clear(TerminatedDateGvar);
                    EmployeeB2B.Reset();
                    EmployeeB2B.SetRange("No.", MonthlyAttendanceB2B."Employee Code");
                    if EmployeeB2B.FindSet() then
                        ExitReasonCodeGvar := format(EmployeeB2B."Exit ReasonCode For Pf");
                    EmployeeNameGvar := format(EmployeeB2B."First Name");
                    EmployeeUANGvar := format(EmployeeB2B."UAN No.");
                    if not EmployeeB2B.Blocked then
                        currXMLport.Skip();
                    case EmployeeB2B.Status of
                        EmployeeB2B.status::Terminated:
                            begin
                                TerminatedDateGvar := EmployeeB2B."Termination Date";

                                MonthGvar := Date2DMY(TerminatedDateGvar, 2);
                                YearGvar := Date2DMY(TerminatedDateGvar, 3);
                                ExitDate := format(EmployeeB2B."Termination Date");

                            end;
                        EmployeeB2B.status::Inactive:
                            begin
                                TerminatedDateGvar := EmployeeB2B."Inactive Date";

                                MonthGvar := Date2DMY(TerminatedDateGvar, 2);
                                YearGvar := Date2DMY(TerminatedDateGvar, 3);
                                ExitDate := format(EmployeeB2B."Inactive Date");

                            end;
                    end;
                    if (MonthGvar <> MonthlyAttendanceB2B."Pay Slip Month") or (YearGvar <> MonthlyAttendanceB2B.Year) then
                        currXMLport.Skip();


                end;

            }


        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    /* field(Name; SourceExpression)
                     {

                     }*/
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }

    var
        myInt: Integer;
        MonthGvar: Integer;
        YearGvar: Integer;
        TerminatedDateGvar: Date;
        DayGvar: Integer;
        EmployeeB2B: Record "Employee B2B";





}