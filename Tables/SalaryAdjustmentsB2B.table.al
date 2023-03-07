table 33001286 "Salary Adjustments B2B"
{
    // version B2BHR1.00.00

    Caption = 'Salary Adjustments_B2B';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK then begin
                    "Employee Code" := Employee."No.";
                    "Employee Name" := Employee."First Name";
                end;
            end;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(2; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(3; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(5; Conveyance; Decimal)
        {
            Caption = 'Conveyance';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec.Conveyance + Conveyance;
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(6; "EnterTainment All."; Decimal)
        {
            Caption = 'EnterTainment All.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec."EnterTainment All." + "EnterTainment All.";
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(7; Medical; Decimal)
        {
            Caption = 'Medical';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec.Medical + Medical;
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(8; Subscription; Decimal)
        {
            Caption = 'Subscription';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec.Subscription + Subscription;
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(9; "Night Shift All."; Decimal)
        {
            Caption = 'Night Shift All.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec."Night Shift All." + "Night Shift All.";
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(10; Others; Decimal)
        {
            Caption = 'Others';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec.Others + Others;
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(11; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(12; Deductions; Decimal)
        {
            Caption = 'Deductions';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(13; "Net Payable"; Decimal)
        {
            Caption = 'Net Payable';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(14; Food; Decimal)
        {
            Caption = 'Food';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec.Food + Food;
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(15; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
        }
        field(16; "Journal Batch Name"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Journal Batch Name';
        }
        field(17; "Document No"; Code[20])
        {
            Caption = 'Document No';
            DataClassification = CustomerContent;
        }
        field(18; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(19; "No Series"; Code[20])
        {
            Caption = 'No Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(20; PSD; Decimal)
        {
            Caption = 'PSD';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec.PSD + PSD;
                "Net Payable" := "Total Amount" - Society;
            end;
        }
        field(21; "Trainee Nightshift All."; Decimal)
        {
            Caption = 'Trainee Nightshift All.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(22; "Trainee Jaguary All."; Decimal)
        {
            Caption = 'Trainee Jaguary All.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(23; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Posted';
            OptionMembers = Open,Posted;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(24; Trainee; Boolean)
        {
            Caption = 'Trainee';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
            end;
        }
        field(25; "Books and Peridicals"; Decimal)
        {
            Caption = 'Books and Peridicals';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec."Books and Peridicals" + "Books and Peridicals";
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(30; "Driver All."; Decimal)
        {
            Caption = 'Driver All.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec.Others + Others;
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(31; "Food All."; Decimal)
        {
            Caption = 'Food All.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec."Food All." + "Food All.";
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(32; "Car All."; Decimal)
        {
            Caption = 'Car All.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec."Car All." + "Car All.";
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(33; "TelePhone All."; Decimal)
        {
            Caption = 'TelePhone All.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec."TelePhone All." + "TelePhone All.";
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(34; "House All."; Decimal)
        {
            Caption = 'House All.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Total Amount" := "Total Amount" - xRec."House All." + "House All.";
                "Net Payable" := "Total Amount" - Deductions;
            end;
        }
        field(35; Society; Decimal)
        {
            Caption = 'Society';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatus();
                "Net Payable" := "Total Amount" - Society;
            end;
        }
    }

    keys
    {
        key(Key1; "Employee Code", Month, Year)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestStatus();
    end;

    trigger OnModify();
    begin
        TestStatus();
    end;

    trigger OnRename();
    begin
        TestStatus();
    end;

    var
        Employee: Record "Employee B2B";

    procedure TestStatus();
    begin
        TESTFIELD(Status, Status::Open);
    end;
}

