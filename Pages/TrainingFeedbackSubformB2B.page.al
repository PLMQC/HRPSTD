page 33001494 "Training Feedback Subform B2B"
{
    // version B2BHR1.00.00

    AutoSplitKey = true;
    Caption = 'Training Feedback Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Tranining Feedback Line B2B";


    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                field(Categories; Categories)
                {
                    ToolTip = 'Choose the Category for Training Feedback form.';
                    ApplicationArea = all;
                }
                field("1"; "1")
                {
                    ToolTip = 'Specifies 1.';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        TESTFIELD("2", false);
                        TESTFIELD("3", false);
                        TESTFIELD("4", false);
                    end;
                }
                field("2"; "2")
                {
                    ToolTip = 'Sepcifies field 2.';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        TESTFIELD("1", false);
                        TESTFIELD("3", false);
                        TESTFIELD("4", false);
                    end;
                }
                field("3"; "3")
                {
                    ToolTip = 'Sepcifies field 2.';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        TESTFIELD("1", false);
                        TESTFIELD("2", false);
                        TESTFIELD("4", false);
                    end;
                }
                field("4"; "4")
                {
                    ToolTip = 'Sepcifies field 4.';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        TESTFIELD("1", false);
                        TESTFIELD("2", false);
                        TESTFIELD("3", false);
                    end;
                }
                field(Remarks; Remarks)
                {
                    ToolTip = 'Enter the Remarks for Training Feedback form.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

