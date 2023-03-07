table 33001402 "Posted Expense Header B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Expense Header';
    DrillDownPageID = "Posted Expense Statements B2B";
    LookupPageID = "Posted Expense Statements B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(10; "Employee No."; Code[100])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B" WHERE(Blocked = const(false));
            DataClassification = CustomerContent;
        }
        field(11; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(12; Designation; Text[30])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            DataClassification = CustomerContent;
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
            DataClassification = CustomerContent;
        }
        field(60; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
            DataClassification = CustomerContent;
        }
        field(61; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
            DataClassification = CustomerContent;
        }
        field(62; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(72; "Travel Req. No."; Code[20])
        {
            Caption = 'Travel Req. No.';
            Editable = false;
            TableRelation = "Posted Travel Requisition B2B";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
            end;
        }
        field(80; "Mode of Travel"; Option)
        {
            Caption = 'Mode of Travel';
            OptionCaption = 'By Road,By Rail,By Sea,By Air';
            OptionMembers = "By Road","By Rail","By Sea","By Air";
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(490; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            TableRelation = Category_B2B;
            DataClassification = CustomerContent;
        }
        field(491; "City Type"; Code[20])
        {
            Caption = 'City Type';
            TableRelation = "Cities Type B2B".Code;
            DataClassification = CustomerContent;
        }
        field(492; "No.Series"; Code[10])
        {
            Caption = 'No.Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(500; "Time Stamp"; DateTime)
        {
            Caption = 'Time Stamp';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(501; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(502; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            Editable = false;
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(801; "Offset Account"; Code[20])
        {
            Caption = 'Offset Account';
            TableRelation = "G/L Account" WHERE(Blocked = CONST(false),
                                                 "Account Type" = CONST(Posting));
            DataClassification = CustomerContent;
        }
        field(802; "Posting Description"; Text[30])
        {
            Caption = 'Posting Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit 408;

    procedure Navigate();
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Posting Date", "No.");
        NavigateForm.RUN();
    end;

    procedure ShowDimensions();
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", CopyStr(STRSUBSTNO('%1 %2', TABLECAPTION(), "No."), 1, 250));
    end;
}

