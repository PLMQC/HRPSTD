table 33001400 "Posted Travel Requisition B2B"
{
    // version B2BHR1.00.00

    Caption = 'Posted Travel Requisition';
    DrillDownPageID = "Posted Travel Requisitions B2B";
    LookupPageID = "Posted Travel Requisitions B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Document No.';
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
        field(13; Age; Integer)
        {
            Caption = 'Age';
            DataClassification = CustomerContent;
        }
        field(14; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = 'NA, Female,Male';
            OptionMembers = NA," Female",Male;
            DataClassification = CustomerContent;
        }
        field(15; "Boarding at"; Text[30])
        {
            Caption = 'Boarding at';
            DataClassification = CustomerContent;
        }
        field(16; Destination; Text[30])
        {
            Caption = 'Destination';
            DataClassification = CustomerContent;
        }
        field(17; "Customer / Client No."; Text[250])
        {
            Caption = 'Customer / Client No';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var

            begin
            end;
        }
        field(18; "Customer Name"; Text[250])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(19; "Customer Name 2"; Text[250])
        {
            Caption = 'Customer Name 2';
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
        field(30; "Travel Requisition Date"; Date)
        {
            Caption = 'Travel Requisition Date';
            DataClassification = CustomerContent;
        }
        field(31; "Travel From"; Text[30])
        {
            Caption = 'Travel From';
            DataClassification = CustomerContent;
        }
        field(32; "Travel To"; Text[30])
        {
            Caption = 'Travel To';
            DataClassification = CustomerContent;
        }
        field(33; "Travel From Date"; Date)
        {
            Caption = 'Travel From Date';
            DataClassification = CustomerContent;
        }
        field(34; "Travel To Date"; Date)
        {
            Caption = 'Travel To Date';
            DataClassification = CustomerContent;
        }
        field(51; "Account No."; Code[20])
        {
            Caption = 'Account  No.';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                 Blocked = CONST(false));
            DataClassification = CustomerContent;
        }
        field(53; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
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
        field(80; "Mode of Travel"; Option)
        {
            Caption = 'Mode of Travel';
            OptionCaption = 'By Road,By Rail,By Sea,By Air';
            OptionMembers = "By Road","By Rail","By Sea","By Air";
            DataClassification = CustomerContent;
        }
        field(81; "Coach Type"; Option)
        {
            Caption = 'Coach Type';
            OptionCaption = ' ,A/C Sleeper,1st Class A/c,Business Class,Economy Class';
            OptionMembers = " ","A/C Sleeper","1st Class A/c","Business Class","Economy Class";
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
        field(801; "Posting Description"; Text[30])
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

    procedure Navigate(var TravelRequisition: Record "Posted Travel Requisition B2B");
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

