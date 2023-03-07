tableextension 33001404 "CompanyInformationExt B2B" extends "Company Information"
{
    // version NAVW111.00.00.27667,B2BHR1.00.00

    // *******************************************************************************
    // B2B     : B2B Software Technologies
    // Project : HR & Payroll Addon
    // *******************************************************************************
    // VER           SIGN       DATE         DESCRIPTION
    // *******************************************************************************
    // 1.00.00       B2BHR      01-Apr-19    Added New Fields 33001190-"T.A.N. No." and  33001191-"P.A.N. No."
    fields
    {
        field(33001190; "T.A.N. No. B2B"; Code[11])
        {
            Caption = 'T.I.N. No.';
            DataClassification = CustomerContent;
        }
        field(33001191; "P.A.N. No. B2B"; Code[20])
        {
            Caption = 'P.A.N. No.';
            DataClassification = CustomerContent;
        }
    }
}

