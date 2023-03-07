tableextension 33001405 "GenJournalLineExt B2B" extends "Gen. Journal Line"
{
    // version NAVW111.00.00.27667,B2BHR1.00.00

    fields
    {
        field(33001190; "Employee No. B2B"; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "Employee B2B";
            DataClassification = CustomerContent;
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

