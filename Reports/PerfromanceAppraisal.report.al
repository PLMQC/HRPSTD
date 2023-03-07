report 33001362 "Perfromance Appraisal B2B"
{
    Caption = 'Perfromance Appraisal Document';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {

            DataItemTableView = sorting("no.") order(ascending);
            RequestFilterFields = "No.", "Next Appraisal Date";

            trigger OnPreDataItem()

            begin
                if "Employee B2B".GetFilters() = '' then
                    Error(Text003Txt);
                Window.Open('Employee No. @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

            end;

            trigger OnAfterGetRecord();
            begin

                if ("Next Appraisal Date" <> 0D) or ("No." <> '') then begin
                    EmpPerformanceHeader.Init();
                    EmpPerformanceHeader."Apprisal No" := '';
                    EmpPerformanceHeader.insert(true);
                    EmpPerformanceHeader."Employee No." := "Employee B2B"."No.";
                    EmpPerformanceHeader."Period Type" := "Employee B2B"."Period Type";
                    EmpPerformanceHeader.Designation := "Employee B2B".Designation;
                    EmpPerformanceHeader.Modify();
                    Window.Update(1, "Employee B2B"."No.");
                    ShowMessage := true;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
                if ShowMessage then
                    Message(Text001Txt)
                else
                    Message(Text002Txt);
            end;
        }
    }
    /*
        requestpage
        {
            layout
            {
                area(Content)
                {
                    group(GroupName)
                    {
                        field(Name; SourceExpression)
                        {
                            ApplicationArea = All;

                        }
                    }
                }
            }

            actions
            {
                area(processing)
                {
                    action(ActionName)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
    */
    var
        EmpPerformanceHeader: Record "Employee PerformanceHeader B2B";
        Text001Txt: label 'Records Inserted For Employee';
        Text002Txt: Label 'No Records were found';
        Window: Dialog;
        ShowMessage: Boolean;
        Text003Txt: Label 'You have to select the filters';
}