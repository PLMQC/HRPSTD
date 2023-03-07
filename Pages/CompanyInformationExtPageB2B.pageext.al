pageextension 33001582 "CompanyInformationExtPage B2B" extends "Company Information"
{
    // version NAVW111.00.00.19846,B2BHR1.00.00

    layout
    {
        addafter(Picture)
        {
            field("T.A.N. No. B2B"; "T.A.N. No. B2B")
            {
                ToolTip = 'Specifies the company''s T.A.N No.';
                ApplicationArea = all;


            }
            field("P.A.N. No. B2B"; "P.A.N. No. B2B")
            {
                ToolTip = 'Specifies the company''s P.A.N No.';
                ApplicationArea = all;
            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

