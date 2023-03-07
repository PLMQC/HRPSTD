page 33001194 "Employee Card B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee';
    PageType = Card;
    SourceTable = "Employee B2B";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the Emloyee number series of the involved entry or record, according to the specified number series.';
                    ApplicationArea = all;

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("First Name"; "First Name")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s first name.';
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s Last name.';
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    Caption = 'Middle Name/Initials';
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s middle name.';
                    ApplicationArea = all;
                }
                field(Initials; Initials)
                {
                    ToolTip = 'Specifies the employee''s initials.';
                    ApplicationArea = all;
                }
                field("Reporting To"; "Reporting To")
                {
                    ToolTip = 'Specifies the employee''s reporting hirearchy';
                    ApplicationArea = all;
                }
                field("Reporting Name"; "Reporting Name")
                {
                    ToolTip = 'Specifies the employee''s reporting hirearchy name.';
                    ApplicationArea = all;
                }
                field("Search Name"; "Search Name")
                {
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                    ApplicationArea = all;
                }
                field(Gender; Gender)
                {
                    ToolTip = 'Specifies the employee''s gender.';
                    ApplicationArea = all;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ToolTip = 'Specifies the date of last modification done to the record.';
                    ApplicationArea = all;
                }
                field("Confirmation Date"; "Confirmation Date")
                {
                    ToolTip = 'Specifies the date when the employee probation employee is confirmed to work for the company.';
                    ApplicationArea = all;
                }
                field("Social Security No."; "Social Security No.")
                {
                    ToolTip = 'Specifies the social security number of the employee.';
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Department code detail.';
                }
                field("Aadhar No."; "Aadhar No.")
                {
                    ToolTip = 'Specifies the Aadhar Card number of the employee.';
                    ApplicationArea = all;
                }
                field("Period Start Date"; "Period Start Date")
                {
                    ToolTip = 'Specifies the Pay cadre cycle start and end date.';
                    ApplicationArea = all;
                }
                field("Period End Date"; "Period End Date")
                {
                    ToolTip = 'Specifies the Pay cadre cycle start and end date.';
                    ApplicationArea = all;
                }
                field("No G/L Posting"; "No G/L Posting")
                {
                    Caption = 'Outsourced Employee';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Outsourced employee details.';

                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field(Address; Address)
                {
                    ToolTip = 'Specifies the employeecommunication details.';
                    ApplicationArea = all;
                }
                field("Address 2"; "Address 2")
                {
                    ToolTip = 'Specifies the employee''s address2 details.';
                    ApplicationArea = all;
                }
                field("Post Code"; "Post Code")
                {
                    Caption = 'Post Code/City';
                    ToolTip = 'Specifies the employee''s post code';
                    ApplicationArea = all;
                }
                field(City; City)
                {
                    Caption = 'City';
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s Postal city.';
                    ApplicationArea = all;
                }
                field("Country Code"; "Country Code")
                {
                    ToolTip = 'Specifies the employee''s Country.';
                    ApplicationArea = all;
                }
                field("Phone No."; "Phone No.")
                {
                    ToolTip = 'Specifies the employee''s phone number';
                    ApplicationArea = all;
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    ToolTip = 'Specifies the employee''s mobile number.';
                    ApplicationArea = all;
                }
                field(Pager; Pager)
                {
                    ToolTip = 'Specifies the employee''s pager number.';
                    ApplicationArea = all;
                }
                field("E-Mail"; "E-Mail")
                {
                    ToolTip = 'Specifies the employee''s Email ID.';
                    ApplicationArea = all;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s company Email ID.';
                    ApplicationArea = all;
                }
                field(Extension; Extension)
                {
                    ToolTip = 'Specifies the employee''s extension number.';
                    ApplicationArea = all;
                }
                field("Period Type"; "Period Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee period type details.';
                }
                field("Last Appraisal Date"; "Last Appraisal Date")
                {
                    Editable = true;
                    ToolTip = 'Specifies the employee''s last Appraisal date.';
                    ApplicationArea = all;
                }
                field("Next Appraisal Date"; "Next Appraisal Date")
                {
                    Editable = EditFieldValue;
                    ToolTip = 'Specifies the employee''s Next Appraisal date.';
                    ApplicationArea = all;
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Employment Date"; "Employment Date")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                    ApplicationArea = all;
                }
                field(Designation; Designation)
                {
                    ToolTip = 'Specifies the employee''s designation';
                    ApplicationArea = all;
                }
                field("Pay Cadre"; "Pay Cadre")
                {
                    ToolTip = 'Specifies the employee''s pay grade / pay cadre.';
                    ApplicationArea = all;
                }
                field("Leave Pay Cadre"; "Leave Pay Cadre")
                {
                    ToolTip = 'Specifies the employee''s leave cadre.';
                    ApplicationArea = all;
                }
                field("User Id"; "User Id")
                {
                    ToolTip = 'Specifies the employee''s User ID';
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean;
                    var
                        User: Record User;
                        TempUserId: Code[50];

                    begin
                        "User Id" := LocWiseMiscGCU.OpenUserPageForSelectedUser(User);
                        Employee.RESET();
                        Employee.SETRANGE("User Id", "User Id");
                        if (Employee.FINDFIRST()) and (Employee."No." <> "No.") then begin
                            TempUserId := "User Id";
                            "User Id" := xRec."User Id";
                            ERROR(Text004Lbl, TempUserId);
                        end;
                    end;
                }
                field(Qualification; Qualification)
                {
                    ToolTip = 'Specifies the employee''s Qualifications';
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ToolTip = 'Specifies the employee''s status e.g Active, Non Active';
                    ApplicationArea = all;
                }
                field(Probation; Probation)
                {
                    ToolTip = 'Specifies the employee is under probation';
                    ApplicationArea = all;
                }
                field("Probation Period"; "Probation Period")
                {
                    ToolTip = 'Specifies the employee''s probation period';
                    ApplicationArea = all;
                }
                field("Ext. Probation Period"; "Ext. Probation Period")
                {
                    ToolTip = 'Specifies the employee''s probation period in case of extension';
                    ApplicationArea = all;
                }
                field("Probation End Date"; "Probation End Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the employee''s probation / contract end date';
                    ApplicationArea = all;
                }
                field("Emp Posting Group"; "Emp Posting Group")
                {
                    ToolTip = 'Specifies the employee''s type to link business transactions made for the employee with the appropriate account in the general ledger.';
                    ApplicationArea = all;
                }
                field("Payroll Bus. Posting Group"; "Payroll Bus. Posting Group")
                {
                    Caption = 'Bus. Posting Group';
                    ToolTip = 'Specifies the employee''s type to link business transactions made for the employee with the appropriate account in the general ledger.';
                    ApplicationArea = all;
                }
                field("Employee StatutoryPostingGroup"; "Employee StatutoryPostingGroup")
                {
                    ToolTip = 'Specifies the employee''s type to link business transactions made for the employee with the appropriate account in the general ledger.';
                    ApplicationArea = all;
                }
                field("Location Code"; "Location Code")
                {
                    ToolTip = 'Specifies the employee Location code defined based on city location';
                    ApplicationArea = all;
                }
                field("Physical Location"; "Physical Location")
                {
                    ToolTip = 'Specifies the physical Location of the employee';
                    ApplicationArea = all;
                }
                field("Employee Status"; "Employee Status")
                {
                    ToolTip = 'Specifies the employee''s status.';
                    ApplicationArea = all;
                }
                field(Experience; Experience)
                {
                    ToolTip = 'Specifies the employee''s experience.';
                    ApplicationArea = all;
                }
                field(Resigned; Resigned)
                {
                    ToolTip = 'Specifies whether the employee has resigned.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Resignation Date"; "Resignation Date")
                {
                    ToolTip = 'Specifies the employee''s resignation date.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Last Working Day"; "Last Working Day")
                {
                    ToolTip = 'Specifies the employee''s last working date in the company.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Inactive Date"; "Inactive Date")
                {
                    ToolTip = 'Specifies the employee''s inactive date.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Cause of Inactivity Code"; "Cause of Inactivity Code")
                {
                    ToolTip = 'Specifies the employee''s inactive code / status.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Blocked; Blocked)
                {
                    ToolTip = 'Specifies the employee''s blocked.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Termination Date"; "Termination Date")
                {
                    ToolTip = 'Specifies the employee''s termination date.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Grounds for Term. Code"; "Grounds for Term. Code")
                {
                    ToolTip = 'Specifies the employee''s Grounds for Termination.';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Notice Period Last Date"; "Notice Period Last Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee Notice period last date.';
                }
                // CHB2B15SEP2022<<
                field("Exit ReasonCode For Pf"; Rec."Exit ReasonCode For Pf")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the EXIT REASONCODE FOR PF field.';
                }
                // CHB2B15SEP2022>>
                //CHB2BJAN52023<<
                field("Exit ReasonCode For ESI"; Rec."Exit ReasonCode For ESI")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the EXIT REASONCODE FOR ESI field.';
                }
                //CHB2BJAN52023>>

            }
            group(Personal)
            {
                Caption = 'Personal';
                field("Birth Date"; "Birth Date")
                {
                    ToolTip = 'Specifies the employee''s date of Birth.';
                    ApplicationArea = all;
                }
                field("Father/Husband"; "Father/Husband")
                {
                    ToolTip = 'Specifies the employee''s Father / Husband''s Name.';
                    ApplicationArea = all;
                }
                field("Blood Group"; "Blood Group")
                {
                    ToolTip = 'Specifies employee''s Blood Group.';
                    ApplicationArea = all;
                }
                field(Control1102152111; '')
                {
                    CaptionClass = Text19060022Lbl;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Present Contact Information';
                }
                field("Place of Birth"; "Place of Birth")
                {
                    ToolTip = 'Specifies employee''s Place of Birth.';
                    ApplicationArea = all;
                }
                field(Nationality; Nationality)
                {
                    ToolTip = 'Specifies employee''s Nationality.';
                    ApplicationArea = all;
                }
                field("Present  Address"; "Present  Address")
                {
                    ToolTip = 'Specifies the employee''s alternative address.';
                    ApplicationArea = all;
                }
                field("Present Address 2"; "Present Address 2")
                {
                    ToolTip = 'Specifies the employee''s alternative address.';
                    ApplicationArea = all;
                }
                field("Present City"; "Present City")
                {
                    ToolTip = 'Specifies the employee''s alternative Prent City.';
                    ApplicationArea = all;
                }
                field("Present Post Code"; "Present Post Code")
                {
                    ToolTip = 'Specifies the employee''s alternative Postal / Post Code.';
                    ApplicationArea = all;
                }
                field("Present Country"; "Present Country")
                {
                    ToolTip = 'Specifies the employee''s alternative present country.';
                    ApplicationArea = all;
                }
                field("Present Phone No."; "Present Phone No.")
                {
                    ToolTip = 'Specifies the employee''s alternative phone number.';
                    ApplicationArea = all;
                }
                field(Picture; Picture)
                {
                    ToolTip = 'Specifies the employee''s picture.';
                    ApplicationArea = all;
                }
            }
            group("Pay Method")
            {
                Caption = 'Pay Method';
                field("Payment Method"; "Payment Method")
                {
                    ToolTip = 'Specifies the employee''s payment method.';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        if ("Payment Method" = "Payment Method"::Cash) or ("Payment Method" = "Payment Method"::Cheque) then begin
                            "Bank CodeEditable" := false;
                            "Bank NameEditable" := false;
                            "Bank BranchEditable" := false;
                            "Account TypeEditable" := false;
                            "Account NoEditable" := false;
                        end else begin
                            "Bank CodeEditable" := true;
                            "Bank NameEditable" := true;
                            "Bank BranchEditable" := true;
                            "Account TypeEditable" := true;
                            "Account NoEditable" := true;
                        end;
                    end;
                }
                field("Bank Code"; "Bank Code")
                {
                    Editable = "Bank CodeEditable";
                    ToolTip = 'Specifies employee''s Bank code.';
                    ApplicationArea = all;
                }
                field("Bank Name"; "Bank Name")
                {
                    Editable = "Bank NameEditable";
                    ToolTip = 'Specifies the employee''s Bank Name.';
                    ApplicationArea = all;
                }
                field("Bank IFCS Code"; "Bank IFCS Code")
                {
                    ToolTip = 'Specifies the employee''s Bank IFSC''s Code.';
                    ApplicationArea = all;
                }
                field("Bank Branch"; "Bank Branch")
                {
                    Editable = "Bank BranchEditable";
                    ToolTip = 'Specifies the employee''s Bank''s Branch Name.';
                    ApplicationArea = all;
                }
                field("Account Type"; "Account Type")
                {
                    Editable = "Account TypeEditable";
                    ToolTip = 'Specifies the employee''s Account Type -Savings';
                    ApplicationArea = all;
                }
                field("Account No"; "Account No")
                {
                    Editable = "Account NoEditable";
                    ToolTip = 'Specifies the employee''s Bank Account No.';
                    ApplicationArea = all;
                }
                field("Bank/Cash Account"; "Bank/Cash Account")
                {
                    ToolTip = 'Specifies the employee''s Cash / Bank Name.';
                    ApplicationArea = all;
                }
                field("Balance Amt(LCY)"; "Balance Amt(LCY)")
                {
                    Editable = false;
                    ToolTip = 'Specifies the Employee''s Salary Balance Name.';
                    ApplicationArea = all;
                }
                field("Stop Payment"; "Stop Payment")
                {
                    ToolTip = 'Specifies if the payment of salary needs to be stopped.';
                    ApplicationArea = all;
                }
                field(Scale; Scale)
                {
                    ToolTip = 'Specifies the Employee''s Salary Scale.';
                    ApplicationArea = all;
                }
            }
            group(Taxation)
            {
                Caption = 'Taxation';
                field("ESI Applicable"; "ESI Applicable")
                {
                    ToolTip = 'Specifies whether the ESI is applicable YES / NO.';
                    ApplicationArea = all;

                }
                field("ESI No"; "ESI No")
                {
                    ToolTip = 'Specifies the Employee''s ESI number applicable';
                    ApplicationArea = all;
                }
                field("ESI Dispensary"; "ESI Dispensary")
                {
                    ToolTip = 'Specifies Employee''s ESI Dispensary name';
                    ApplicationArea = all;
                }
                field("PF Applicable"; "PF Applicable")
                {
                    ToolTip = 'Specifies whether the PF is applicable YES / NO.';
                    ApplicationArea = all;
                }
                field("UAN No."; "UAN No.")
                {
                    ToolTip = 'Specifies the employee''s UAN Number is applicable';
                    ApplicationArea = all;
                }
                field("PF No"; "PF No")
                {
                    ToolTip = 'Specifies the employee''s PF Number is applicable';
                    ApplicationArea = all;
                }
                field("PF Applicability"; "PF Applicability")
                {
                    ToolTip = 'Specifies the PF Applicability Type - Stautory, Actual Basic';
                    ApplicationArea = all;
                }
                field("PF Amount"; "PF Amount")
                {
                    ToolTip = 'Specifies the employee''s PF amount applicable';
                    ApplicationArea = all;
                }
                field("VPF Applicable"; "VPF Applicable")
                {
                    ToolTip = 'Specifies whether the VPF is applicable to said employee''s';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CheckEdit();
                    end;
                }
                field("VPF Per/Amount"; "VPF Per/Amount")
                {
                    Editable = "VPF Applicable";
                    ToolTip = 'Specifies the VPF Percantage / Amount applicable to employee if VPF is applicable';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        CheckEdit();
                    end;
                }
                field("VPF %"; "VPF %")
                {
                    Editable = EditPerGVar;
                    ToolTip = 'Specifies the employee''s VPF % applicable.';
                    ApplicationArea = all;
                }
                field("VPF Amount"; "VPF Amount")
                {
                    Editable = EditAmtGVar;
                    ToolTip = 'Specifies the employee''s VPF amount';
                    ApplicationArea = all;
                }
                field("LWF Applicable"; "LWF Applicable")
                {
                    ToolTip = 'Specifies whether LWF - Labor Welfare Fund is applicable to the employee';
                    ApplicationArea = all;
                }
                field("Sr. Citizen PF Applicability"; "Sr. Citizen PF Applicability")
                {
                    ToolTip = 'Specifies the PF is applicable for Senior Citizen''se';
                    ApplicationArea = all;
                }
                field("PAN No"; "PAN No")
                {
                    ToolTip = 'Specifies the employee''s PAN Number is applicable';
                    ApplicationArea = all;
                }
                field("Exgratia %"; "Exgratia %")
                {
                    ToolTip = 'Specifies the employee''s Exgratia percentage.';
                    ApplicationArea = all;
                }
                field("PT Applicable"; "PT Applicable")
                {
                    ToolTip = 'Specifies whether PT is applicable to the said employee';
                    ApplicationArea = all;
                }
                field("PT Branch Code"; "PT Branch Code")
                {
                    Caption = 'PT Branch Code';
                    ToolTip = 'Specifies the PT Branch Code applicable to the said employee''s';
                    ApplicationArea = all;
                }
                field("IT Slab Type"; "IT Slab Type")
                {
                    ToolTip = 'Specifies the IT Slab Type applicable to the employee''s';
                    ApplicationArea = all;
                }
                field("OT Applicable"; "OT Applicable")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the OT applicable in Employee Master.';
                }
                field("OT Calculation Rate"; "OT Calculation Rate")
                {
                    ApplicationArea = all;
                    Tooltip = 'Specifies the OT Calculation Rate Details in Employee Master';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "HR Comment Sheet B2B";
                    RunPageLink = "Table Name" = CONST("Employee B2B"),
                                  "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the comments of Employee from HR Department.';
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(33001193),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Dimensions while posting document.';
                }
                action("Alternative A&ddresses")
                {
                    Caption = 'Alternative A&ddresses';
                    Image = AlternativeAddress;
                    RunObject = Page "Emp Alternative Add List B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee alternative address.';
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the attachment';

                    trigger OnAction();
                    var
                        DocumentDetails: Record "Document Attachment";
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GETTABLE(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentDetails.Reset();
                        DocumentDetails.SetRange("No.", "No.");
                        DocumentDetails.SetRange("Table ID", RecRef.Number());
                        DocumentAttachmentDetails.SetTableView(DocumentDetails);
                        DocumentAttachmentDetails.RUNMODAL();
                    end;
                }
                separator(Separator1102152032)
                {
                }
                action("Employee Job History")
                {
                    Caption = 'Employee Job History';
                    Image = ViewDetails;
                    RunObject = Page "Job History List B2B";
                    RunPageLink = "SNo." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Job History details.';

                }
                // action("Employee Check List")
                // {
                //     Caption = 'Employee Check List';
                //     image = CheckList;
                //     RunObject = page "Employee Check List B2B";
                //     //RunPageView = sorting ("Document Type", "No.") where ("document type" = filter (1));

                //     RunPageLink = "No." = field("No.");
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies the Employee Check list Details.';

                //     trigger OnAction()
                //     begin

                //     end;
                // }
                action("App&raisal")
                {
                    Caption = 'App&raisal';
                    Image = MoveUp;
                    RunObject = Page "Employee Performance List B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    RunPageMode = View;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee appraisal details.';
                }
                separator(Separator1102154042)
                {
                }
                separator(Separator1102152042)
                {
                }
                action("S&hift")
                {
                    Caption = 'S&hift';
                    Image = ImplementRegAbsence;
                    RunObject = Page "Employee Shift B2B";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee shift details.';
                }
                separator(Separator1102152073)
                {
                }
                action("Lea&ves")
                {
                    Caption = 'Lea&ves';
                    Image = AbsenceCategories;
                    RunObject = Page "Emp Leave List B2B";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Leave details.';
                }
                separator(Separator1102152066)
                {
                }
                action("&Family Details")
                {
                    Caption = '&Family Details';
                    Image = Relatives;
                    RunObject = Page "Family Details & Relation B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee family details.';
                }
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    RunObject = Page "Employee Qualifications B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Qualifications detail.';
                }
                action("<Action1102152086>")
                {
                    Caption = 'Employee &Languages';
                    Image = Language;
                    RunObject = Page "Employee Languages B2B";
                    RunPageLink = "Employee No." = FIELD("No."),
                                  "Line Type" = CONST(Language);
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee language details.';
                }
                action("Article Info. Overview")
                {
                    Caption = 'Article Info. Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview-B2B";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee article info.Overview details.';
                }
                action("Article Information")
                {
                    Caption = 'Article Information';
                    Image = Filed;
                    RunObject = Page "Misc. Article Information B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee article information.';
                }
                action("&Confidential Information")
                {
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = Page "Confidential Information B2B";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee confidential information.';
                }
                action("Co&nfidential Info. Overview")
                {
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Over B2B";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee confidential information overview.';
                }
                separator(Separator1102154321)
                {
                }
                group("T&DS")
                {
                    Caption = 'T&DS';
                    Image = CalculateSalesTax;
                    action("Previous Company Details")
                    {
                        Caption = 'Previous Company Details';
                        Image = CompanyInformation;
                        RunObject = Page "Emp. Prev. Comp. TDS B2B";
                        RunPageLink = "No." = FIELD("No.");
                        ApplicationArea = all;
                        ToolTip = 'Specifies the Employee previous company details.';
                    }
                    action("Previous IT Savings")
                    {
                        Caption = 'Previous IT Savings';
                        Image = History;
                        RunObject = Page "Empployee Prev. IT Savings B2B";
                        RunPageLink = "Employee Code" = FIELD("No.");
                        ApplicationArea = all;
                        ToolTip = 'Specifies the Employee previous IT savings.';

                    }
                    separator(Separator1102154327)
                    {
                    }
                    action("Salary Adjustment Limits")
                    {
                        Caption = 'Salary Adjustment Limits';
                        Image = LimitedCredit;
                        RunObject = Page "Emp. Salary Adj. Limits B2B";
                        RunPageLink = "Employee Code" = FIELD("No.");
                        ApplicationArea = all;
                        ToolTip = 'Specifies the Employee salary adjustment limit details.';
                    }
                    action(Archive)
                    {
                        Caption = 'Archive';
                        Image = Archive;
                        RunObject = Page "Employee History B2B";
                        RunPageLink = "Emp No." = FIELD("No.");
                        ApplicationArea = all;
                        ToolTip = 'Specifies the document archive details.';
                    }
                }
            }
            group("&Payroll")
            {
                Caption = '&Payroll';
                action("Pay &Elements")
                {
                    Caption = 'Pay &Elements';
                    Image = CashFlow;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Pay Elements B2B";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee Pay elements details.';
                }
                action("&Loans")
                {
                    Caption = '&Loans';
                    Image = Loaner;
                    RunObject = Page "Loan List B2B";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Employee loan details.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("New E&mployee Leaves")
                {
                    Caption = 'New E&mployee Leaves';
                    Image = NewTimesheet;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the New Employee leave details.';

                    trigger OnAction();
                    begin
                        GenerateNewEmpLeaves();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if ("Employment Date" <> 0D) and (Blocked = false) then begin
            EmpMonth := DATE2DMY("Employment Date", 2);
            EmpYear := DATE2DMY("Employment Date", 3);
            CurrMonth := DATE2DMY(TODAY(), 2);
            CurrYear := DATE2DMY(TODAY(), 3);
            if EmpMonth <= CurrMonth then begin
                "Experience (Years)" := CurrYear - EmpYear;
                "Experience (Months)" := CurrMonth - EmpMonth;
            end else begin
                "Experience (Years)" := CurrYear - (EmpYear + 1);
                "Experience (Months)" := (CurrMonth + 12) - EmpMonth;
            end;
        end;

        if "Birth Date" <> 0D then begin
            EmpDetailsMonth := DATE2DMY("Birth Date", 2);
            EmpDetailsYear := DATE2DMY("Birth Date", 3);
            CurrMonth := DATE2DMY(TODAY(), 2);
            CurrYear := DATE2DMY(TODAY(), 3);
            if EmpDetailsMonth <= CurrMonth then begin
                "Current Age (Years)" := CurrYear - EmpDetailsYear;
                "Current Age (Months)" := CurrMonth - EmpDetailsMonth;
            end else begin
                "Current Age (Years)" := CurrYear - (EmpDetailsYear + 1);
                "Current Age (Months)" := (CurrMonth + 12) - EmpDetailsMonth;
            end;
        end;

        SETRANGE("No.");
        if ("Payment Method" = "Payment Method"::Cash) or ("Payment Method" = "Payment Method"::Cheque) then begin
            "Bank CodeEditable" := false;
            "Bank NameEditable" := false;
            "Bank BranchEditable" := false;
            "Account TypeEditable" := false;
            "Account NoEditable" := false;
        end else begin
            "Bank CodeEditable" := true;
            "Bank NameEditable" := true;
            "Bank BranchEditable" := true;
            "Account TypeEditable" := true;
            "Account NoEditable" := true;
        end;
        CheckEdit();
    end;

    trigger OnInit();
    begin
        "Account NoEditable" := true;
        "Account TypeEditable" := true;
        "Bank BranchEditable" := true;
        "Bank NameEditable" := true;
        "Bank CodeEditable" := true;
    end;

    trigger OnOpenPage();
    begin
        RESET();
        FILTERGROUP(2);
        PayrollUsers.GET(USERID());
        if PayrollUsers."Multiple Locations" <> '' then
            SETFILTER("Location Code", PayrollUsers."Multiple Locations")
        else
            SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
        FILTERGROUP(0);

        Employee.RESET();
        Employee.SETRANGE(Blocked, false);
        Employee.SETFILTER("Birth Date", '<>%1', 0D);
        if Employee.FINDFIRST() then
            repeat
                if (DATE2DMY(Employee."Birth Date", 1) = DATE2DMY(WORKDATE(), 1)) and (DATE2DMY(Employee."Birth Date", 2) = DATE2DMY(WORKDATE(), 2)) then
                    MESSAGE(Text007Lbl, Employee."No.", Employee."First Name", Employee."Birth Date");
            until Employee.NEXT() = 0;


        Employee.RESET();
        Employee.SETRANGE(Blocked, false);
        Employee.SETFILTER("Probation End Date", '<>%1', 0D);
        if Employee.FINDFIRST() then
            repeat
                if Employee."Probation End Date" = WORKDATE() then
                    MESSAGE(Text008Lbl, Employee."No.", Employee."First Name", Employee."Probation End Date");
            until Employee.NEXT() = 0;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        if "Next Appraisal Date" = 0D then
            EditFieldValue := true;

    end;

    var
        Employee: Record "Employee B2B";
        PayrollYearRec: Record "Payroll Year B2B";
        GradeWiseLeaves: Record "Grade Wise Leaves B2B";
        GradeWiseLeaves2: Record "Grade Wise Leaves B2B";
        TempEmpLeaves: Record "Employee Leaves B2B" temporary;
        PayrollUsers: Record "Payroll Location Users B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Text004Lbl: Label 'The User Id %1 is already attached to another employee.', Comment = '%1 = UserId';
        EmpMonth: Integer;
        EmpYear: Integer;
        CurrYear: Integer;
        CurrMonth: Integer;
        EmpDetailsYear: Integer;
        EmpDetailsMonth: Integer;

        Months: Decimal;
        [InDataSet]
        "Bank CodeEditable": Boolean;
        [InDataSet]
        "Bank NameEditable": Boolean;
        [InDataSet]
        "Bank BranchEditable": Boolean;
        [InDataSet]
        "Account TypeEditable": Boolean;
        [InDataSet]
        "Account NoEditable": Boolean;
        Text19060022Lbl: Label 'Present Contact Information';
        TotLeaves: Decimal;
        StDate: Date;
        EnDate: Date;
        ActualMonDays: Integer;
        Days: Decimal;
        LeaveYearStartDate: Date;

        EditPerGVar: Boolean;
        EditAmtGVar: Boolean;
        Text007Lbl: Label 'The Employee %1..%2 Birthday .%3', Comment = '%1 = No. ; %2 = First Name;%3 = BirthDate';
        Text008Lbl: Label 'The Employee %1..%2 Probation ends on .%3', Comment = '%1 =  No; %2 = First Name;%3 = ProbitationEnd Date';
        Text009Lbl: Label 'Leaves already inserted for this employee';
        Text0010Lbl: Label 'LEAVE YEAR';
        Text0011Lbl: Label '<CM>';
        Text0012Lbl: Label '<1Y>';
        EditFieldValue: Boolean;


    procedure ShowDetails();
    begin
    end;

    procedure GenerateNewEmpLeaves();
    var
        StartDate: Date;
    begin
        TempEmpLeaves.DELETEALL();
        if not "Leaves Not Generated" then begin
            MESSAGE(Text009Lbl);
            exit;
        end else begin
            TESTFIELD("Leave Pay Cadre");
            TESTFIELD("Employment Date");
            GradeWiseLeaves2.RESET();
            GradeWiseLeaves2.SETRANGE(GradeWiseLeaves2."Leave Pay Cadre", "Leave Pay Cadre");
            GradeWiseLeaves2.SETRANGE(GradeWiseLeaves2."Crediting Type", GradeWiseLeaves2."Crediting Type"::"Before the Period");
            GradeWiseLeaves2.SETRANGE("Location Code", "Location Code");
            if GradeWiseLeaves2.FINDFIRST() then
                repeat
                    TempEmpLeaves.INIT();
                    TempEmpLeaves."No." := "No.";
                    TempEmpLeaves."Leave Pay Cadre" := "Leave Pay Cadre";
                    TempEmpLeaves."Leave Code" := GradeWiseLeaves2."Leave Code";
                    TempEmpLeaves."Leave Description" := GradeWiseLeaves2."Leave Description";
                    TempEmpLeaves."Leaves for the Current Period" := GradeWiseLeaves2."Leaves in Crediting Interval";
                    GetPayrollYearRec();
                    GradeWiseLeaves.RESET();
                    GradeWiseLeaves.SETRANGE("Leave Code", TempEmpLeaves."Leave Code");
                    GradeWiseLeaves.SETRANGE("Leave Pay Cadre", "Leave Pay Cadre");
                    GradeWiseLeaves.FINDFIRST();
                    if "Employment Date" >= PayrollYearRec."Year Start Date" then begin
                        StartDate := "Employment Date";
                        repeat
                            StartDate := CALCDATE(GradeWiseLeaves."Crediting Interval", StartDate);
                        until ("Employment Date" < StartDate) or (StartDate > PayrollYearRec."Year End Date");
                        TempEmpLeaves."Next Leave Period" := StartDate;
                    end else
                        TempEmpLeaves."Next Leave Period" := CalcDate(GradeWiseLeaves."Crediting Interval", PayrollYearRec."Year Start Date");

                    TempEmpLeaves.INSERT();
                until GradeWiseLeaves2.NEXT() = 0;
            PAGE.RUNMODAL(33001373, TempEmpLeaves);
        end;
    end;

    procedure GetPayrollYearRec();
    begin
        PayrollYearRec.RESET();
        PayrollYearRec.SETRANGE("Year Type", Text0010Lbl);
        PayrollYearRec.SETRANGE(Closed, false);
        PayrollYearRec.FINDFIRST();
    end;

    procedure GenerateNewEmpLeaves1();
    var
        StartDate: Date;
    begin
        TempEmpLeaves.DELETEALL();
        if not "Leaves Not Generated" then begin
            MESSAGE(Text009Lbl);
            exit;
        end else begin
            CLEAR(Months);
            CLEAR(TotLeaves);
            GetPayrollYearRec();
            if "Employment Date" > PayrollYearRec."Year Start Date" then begin
                Months := ROUND(((PayrollYearRec."Year End Date" - "Employment Date") / 30), 0.1, '=');
                StDate := DMY2DATE(1, DATE2DMY("Employment Date", 2), DATE2DMY("Employment Date", 3));
                EnDate := CALCDATE(Text0011Lbl, StDate);
                Days := EnDate - "Employment Date";
            end else begin
                Months := ROUND(((PayrollYearRec."Year End Date" - PayrollYearRec."Year Start Date") / 30), 0.1, '=');
                StDate := DMY2DATE(1, DATE2DMY(PayrollYearRec."Year Start Date", 2), DATE2DMY(PayrollYearRec."Year Start Date", 3));
                EnDate := CALCDATE(Text0011Lbl, StDate);
                Days := EnDate - PayrollYearRec."Year Start Date";
            end;
            ActualMonDays := DATE2DMY(EnDate, 1);
            Days := Days / ActualMonDays;
            GradeWiseLeaves2.RESET();
            GradeWiseLeaves2.SETRANGE(GradeWiseLeaves2."Leave Pay Cadre", "Leave Pay Cadre");
            if GradeWiseLeaves2.FINDFIRST() then
                repeat
                    TempEmpLeaves.INIT();
                    TempEmpLeaves."No." := Employee."No.";
                    TempEmpLeaves."Leave Pay Cadre" := "Leave Pay Cadre";
                    TempEmpLeaves."Leave Code" := GradeWiseLeaves2."Leave Code";
                    TempEmpLeaves."Leave Description" := GradeWiseLeaves2."Leave Description";
                    if FORMAT(GradeWiseLeaves2."Crediting Interval") = Text0012Lbl then
                        TotLeaves := ROUND(((GradeWiseLeaves2."Leaves in Crediting Interval" / 12) * Months), 1, '=')
                    else begin
                        TotLeaves := (GradeWiseLeaves2."Leaves in Crediting Interval") * Days;
                        if TotLeaves < 0.5 then
                            TotLeaves := 0
                        else
                            TotLeaves := ROUND((GradeWiseLeaves2."Leaves in Crediting Interval" * Days), 1, '=');
                    end;
                    TempEmpLeaves.INIT();
                    TempEmpLeaves."No." := "No.";
                    TempEmpLeaves."Leave Pay Cadre" := "Leave Pay Cadre";
                    TempEmpLeaves."Leave Code" := GradeWiseLeaves2."Leave Code";
                    TempEmpLeaves."Leave Description" := GradeWiseLeaves2."Leave Description";
                    TempEmpLeaves."Leaves for the Current Period" := TotLeaves;
                    GetPayrollYearRec();
                    GradeWiseLeaves.RESET();
                    GradeWiseLeaves.SETRANGE("Leave Code", TempEmpLeaves."Leave Code");
                    GradeWiseLeaves.SETRANGE("Leave Pay Cadre", "Leave Pay Cadre");
                    GradeWiseLeaves.FINDFIRST();
                    if "Employment Date" < PayrollYearRec."Year Start Date" then begin
                        LeaveYearStartDate := PayrollYearRec."Year Start Date";
                        if LeaveYearStartDate >= PayrollYearRec."Year Start Date" then begin
                            StartDate := PayrollYearRec."Year Start Date";
                            repeat
                                StartDate := CALCDATE(GradeWiseLeaves."Crediting Interval", StartDate);
                            until (LeaveYearStartDate < StartDate) or (StartDate > PayrollYearRec."Year End Date");
                        end;
                        TempEmpLeaves."Next Leave Period" := StartDate;
                        TempEmpLeaves.INSERT();
                    end else begin
                        if "Employment Date" >= PayrollYearRec."Year Start Date" then begin
                            StartDate := PayrollYearRec."Year Start Date";
                            repeat
                                StartDate := CALCDATE(GradeWiseLeaves."Crediting Interval", StartDate);
                            until ("Employment Date" < StartDate) or (StartDate > PayrollYearRec."Year End Date");
                        end;
                        TempEmpLeaves."Next Leave Period" := StartDate;
                        TempEmpLeaves.INSERT();
                    end;
                until GradeWiseLeaves2.NEXT() = 0;
            PAGE.RUNMODAL(33001373, TempEmpLeaves);
        end;
    end;

    local procedure CheckEdit();
    begin
        if "VPF Applicable" then begin
            if "VPF Per/Amount" = "VPF Per/Amount"::Percentage then begin
                EditPerGVar := true;
                EditAmtGVar := false;
                CLEAR("VPF Amount");
            end else begin
                EditAmtGVar := true;
                EditPerGVar := false;
                CLEAR("VPF %");
            end;
        end else begin
            EditPerGVar := false;
            EditAmtGVar := false;
            CLEAR("VPF Amount");
            CLEAR("VPF %");
        end;
    end;
}

