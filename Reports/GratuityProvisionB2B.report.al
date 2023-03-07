report 33001221 "Gratuity Provision B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Gratuity Provision.rdl';
    Caption = 'Gratuity Provision';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Employee B2B"; "Employee B2B")
        {
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            /*
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }*/
            column(USERID; USERID())
            {
            }
            column(Employee_B2B__No__; "No.")
            {
            }
            column(FullName; FullName())
            {
            }
            column(Noofyears; Noofyears)
            {
            }
            column(Totalamt; Totalamt)
            {
            }
            column(Check; Check)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(Employee_B2B__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(No__of_YearsCaption; No__of_YearsCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Gratuity_ProvisionCaption; Gratuity_ProvisionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Gratuity_Provision_Caption; Gratuity_Provision_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                Check := false;
                Noofyears := ROUND(((Processingdate - "Employment Date") / 365), 0.01, '=');
                if Noofyears >= Hrsetup."Min. No.of Years" then
                    Calcgratuity("Employee B2B");
            end;

            trigger OnPreDataItem();
            begin
                Hrsetup.GET();
                SETRANGE("Location Code", LocWiseMiscGCU.ReturnUserLocationCode());
                Check := false;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                //Caption = '<Control1900000001>';//Phani
                group("<Control1900000002>")
                {
                    Caption = 'Options';
                    field("<Control1900000003>"; Processingdate)
                    {
                        ToolTip = 'Enter the date for grautity provision.';
                        Caption = 'Posting Date';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        Payelements.RESET();
        if Payelements.FINDFIRST() then
            repeat
                Payelements.Processed := false;
                Payelements.MODIFY();
            until Payelements.NEXT() = 0
    end;

    trigger OnPreReport();
    begin
        Hrsetup.GET();
        if Processingdate = 0D then
            ERROR(Text001Txt);
    end;

    var
        Hrsetup: Record "HR Setup B2B";
        Payelements: Record "Pay Elements B2B";
        Payelements2: Record "Pay Elements B2B";
        LocWiseMiscGCU: Codeunit "Payroll Branch wise Misc B2B";
        Processingdate: Date;
        Noofyears: Decimal;
        Amount: Decimal;
        Totalamt: Decimal;

        Check: Boolean;
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        GrandTotal: Decimal;
        NameCaptionLbl: Label 'Name';
        No__of_YearsCaptionLbl: Label 'No. of Years';
        AmountCaptionLbl: Label 'Amount';
        Gratuity_ProvisionCaptionLbl: Label 'Pay Elements';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Gratuity_Provision_CaptionLbl: Label '"Gratuity Provision "';
        Text001Txt: Label 'Enter a valid Data';
        BASICTxt: Label 'BASIC';
        DATxt: Label 'DA';
        AFTERBASICTxt: Label 'AFTER BASIC';
        AFTERBASICANDDATxt: Label 'AFTER BASIC AND DA';

    procedure Calcgratuity(Emp: Record "Employee B2B");
    begin
        Totalamt := 0;
        Total := 0;
        Payelements.SETFILTER("Employee Code", Emp."No.");
        Payelements.SETRANGE(Gratuity, true);
        Payelements.SETRANGE(Processed, false);
        if Payelements.FINDFIRST() then begin
            repeat
                Payelements2.SETRANGE("Employee Code", Payelements."Employee Code");
                Payelements2.SETRANGE("Pay Element Code", Payelements."Pay Element Code");
                if Payelements2.FINDFIRST() then begin
                    repeat
                        Payelements2.Processed := true;
                        Payelements2.MODIFY();
                    until Payelements2.NEXT() = 0;
                    Amount := 0;
                    if Payelements2."Effective Start Date" <= Processingdate then begin
                        Payelements2.FINDLAST();
                        if (Payelements2."Fixed/Percent" = Payelements2."Fixed/Percent"::Fixed) then begin
                            Total := Payelements2."Amount / Percent";
                            if Payelements2."Pay Element Code" = BASICTxt then
                                Basic := Total
                            else
                                if Payelements2."Pay Element Code" = DATxt then
                                    DA := Total;
                        end else
                            if (Payelements2."Fixed/Percent" = Payelements2."Fixed/Percent"::Percent) and
                                         (Payelements2."Computation Type" = AFTERBASICTxt) then
                                Total := (Payelements2."Amount / Percent" * Basic) / 100
                            else
                                if (Payelements2."Fixed/Percent" = Payelements2."Fixed/Percent"::Percent) and
                                             (Payelements2."Computation Type" = AFTERBASICANDDATxt) then
                                    Total := (Payelements2."Amount / Percent" * (Basic + DA)) / 100;
                        Amount := (((Total) * Hrsetup."No.of Days Salary" * Noofyears) / Hrsetup."No.of Days in Month");
                    end;
                    Totalamt += Amount;
                end;
            until Payelements.NEXT() = 0;
            GrandTotal := GrandTotal + Totalamt;
        end;
        Check := true;
    end;
}

