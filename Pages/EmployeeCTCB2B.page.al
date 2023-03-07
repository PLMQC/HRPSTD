page 33001347 "Employee CTC B2B"
{
    // version B2BHR1.00.00

    Caption = 'Employee CTC';
    Editable = false;
    PageType = Worksheet;
    SourceTable = "Employee CTC B2B";
    UsageCategory = Tasks;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Emp Code"; "Emp Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee code details';
                }
                field("Letter Code"; "Letter Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee letter code details';

                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee first name details';
                }
                field("Middle Name"; "Middle Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee middle name details';
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee lase name details';
                }
                field(Month; Month)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee CTC month details';
                }
                field(year; year)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee CTC year  details';
                }
                field(Basic; Basic)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee payelemnt Basic details';
                }
                field(HRA; HRA)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee Payelement HRA etails';
                }
                field(CA; CA)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee payelement CA details';
                }
                field(CCA; CCA)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee payelement CCA details';
                }
                field(WA; WA)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee Payelement WA details';
                }
                field(FDA; FDA)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee payelement FDA details';
                }
                field(VDA; VDA)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee payelement VDA details';
                }
                field("SPEL ALL"; "SPEL ALL")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee payelement Spel all details';
                }
                field(PF; PF)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee PF details';
                }
                field(ESI; ESI)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee ESI details';
                }
                field(Medical; Medical)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee Payelement Medical details';
                }
                field(Stipend; Stipend)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee Payelement stipend details';
                }
                field(Conreim; Conreim)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee Payelement Conreim details';
                }
                field(Trainee; Trainee)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee trainee details';
                }
                field(Total; Total)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the employee total payelement details';
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
                action("Update CTC")
                {
                    Caption = 'Update CTC';
                    Image = Cost;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "Relieving cum Exp Letter B2B";
                    ApplicationArea = all;
                    ToolTip = 'Specify the employee update CTC details';
                }
            }
        }
    }
}

