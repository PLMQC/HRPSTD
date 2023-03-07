page 33001492 "Employee Promotion B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee Promotion';
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Change in Cadre B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Emp No."; "Emp No.")
                {
                    ToolTip = 'Specifies the employee number of the involved entry or record, according to the specified number series';
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ToolTip = 'Specify Employee''s Department Code';
                    ApplicationArea = all;
                }
                field(Designation; Designation)
                {
                    ToolTip = 'Specify Designation of the Employee';
                    ApplicationArea = all;
                }
                field("Physical Location Code"; "Physical Location Code")
                {
                    ToolTip = 'Specify the Physcial Code of the Employee';
                    ApplicationArea = all;
                }
                field("Effective Date"; "Effective Date")
                {
                    ToolTip = 'Specify the effictive date from which it applicable';
                    ApplicationArea = all;
                }
                field("New Department Code"; "New Department Code")
                {
                    ToolTip = 'Specify the New Department of the Employee';
                    ApplicationArea = all;
                }
                field("New Designation"; "New Designation")
                {
                    ToolTip = 'Specify the Designation of the Employee';
                    ApplicationArea = all;
                }
                field("New Physical Location"; "New Physical Location")
                {
                    ToolTip = 'Specify New Phycial Location of the Employee';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Specifies the staus of the card "Open"  or "Release"';
                    ApplicationArea = all;
                }
                field("Document Status"; "Document Status")
                {
                    ToolTip = 'Reflect the Status of the Dcoument';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Update")
                {
                    ToolTip = 'Updates the document of employee promotion.';
                    Caption = '&Update';
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        TESTFIELD("Effective Date");
                        TESTFIELD("New Physical Location");

                        if Rec.DocumentPosted() then
                            ERROR(Text0000Lbl, "Emp No.", "Effective Date");


                        Emp.RESET();
                        Emp.SETRANGE("No.", "Emp No.");
                        if Emp.FINDFIRST() then begin
                            EmpHis.RESET();
                            EmpHis.SETRANGE("Effective Date", Emp."Employment Date");
                            EmpHis.SETRANGE("Emp No.", Emp."No.");
                            if EmpHis.IsEmpty() then begin
                                EmpHis.INIT();
                                EmpHis."Effective Date" := Emp."Employment Date";
                                EmpHis."Emp No." := Emp."No.";
                                EmpHis."Department Code" := Emp."Department Code";
                                EmpHis.Designation := Emp.Designation;
                                EmpHis."Location code" := Emp."Physical Location";
                                EmpHis.INSERT();
                            end;

                            if ("Department Code" <> "New Department Code") and ("New Department Code" <> '') then
                                Emp."Department Code" := "New Department Code"
                            else
                                Emp."Department Code" := "Department Code";
                            Emp.MODIFY();
                            if (Emp.Designation <> "New Designation") and ("New Designation" <> '') then begin
                                Emp.Designation := "New Designation";

                                EmpHis.INIT();
                                EmpHis."Effective Date" := "Effective Date";
                                EmpHis."Emp No." := "Emp No.";
                                EmpHis."Department Code" := "New Department Code";
                                EmpHis.Designation := "New Designation";
                                EmpHis."Location code" := "New Physical Location";
                                EmpHis.INSERT();
                                Emp.MODIFY();
                            end else begin
                                Emp.Designation := Designation;
                                Emp.MODIFY();

                                EmpHis.INIT();
                                EmpHis."Effective Date" := "Effective Date";
                                EmpHis."Emp No." := "Emp No.";
                                EmpHis."Department Code" := "New Department Code";
                                EmpHis.Designation := Designation;
                                EmpHis."Location code" := "New Physical Location";
                                EmpHis.INSERT();

                            end;




                            ChangeCadre.GET("Emp No.", "Effective Date");
                            ChangeCadre."Posting Date" := workdate();
                            ChangeCadre."Document Status" := ChangeCadre."Document Status"::Posted;
                            ChangeCadre.MODIFY();


                        end;
                        MESSAGE(Text0001Lbl);
                    end;
                }
                action("Re&lease")
                {
                    ToolTip = 'Show the document in release state.';
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Release();
                    end;
                }
                action("Re&open")
                {
                    ToolTip = 'on click the Re- opens the document.';
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Reopen();
                    end;
                }
            }
            group(Print)
            {
                ToolTip = 'Prints the document.';
                Caption = 'Print';
                Image = Print;
                action("&Print")
                {
                    Caption = '&Print';
                    ToolTip = 'Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        ChangeCadre.RESET();
                        ChangeCadre.SETRANGE("Emp No.", "Emp No.");
                        ChangeCadre.SetRange("Effective Date", "Effective Date");
                        REPORT.RUN(33001261, true, false, ChangeCadre);
                    end;
                }
            }
        }
    }

    var
        Emp: Record "Employee B2B";
        ChangeCadre: Record "Change in Cadre B2B";
        EmpHis: Record "Emp History B2B";
        Text0000Lbl: Label 'You cannot update employee %1 cadre has been already updated with effective date %2.', Comment = '%1 =  No; %2 = Effective Date';
        Text0001Lbl: Label 'Employee cadre changed successfully';
}

