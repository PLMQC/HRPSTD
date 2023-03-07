codeunit 33001210 "Auto Test Hr And Payroll B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
        Window.OPEN(Text001Txt +
                    Text002Txt +
                    Text003Txt +
                    Text004Txt +
                    Text005Txt +
                    Text006Txt +
                    Text007Txt +
                    Text008Txt +
                    Text009Txt +
                    Text010Txt);
        SLEEP(1000);
        InsertHRSetup();
        InsertSetupData();
        CreateLocationsAndUsers();
        InsertAttendanceSetup();
        CreateStatutorySetups();
        InsertSalaryAdjustmentSetup();
        Window.CLOSE();
    end;

    var
        Lookup: Record Lookup_b2b;
        OffDay: Record "Off Day B2B";
        PayYear: Record "Payroll Year B2B";
        NoSeriesLine: Record "No. Series Line";
        PayrollLocation: Record "Payroll Locations B2B";
        Window: Dialog;
        Text001Txt: Label 'Testing Status \';
        Text002Txt: Label 'Creating Hr Setup             @1@@@@@@@@@@@@@@@@@\';
        Text003Txt: Label 'Checking No Series            @2@@@@@@@@@@@@@@@@@\';
        Text004Txt: Label 'Updating Lookups              @3@@@@@@@@@@@@@@@@@\';
        Text005Txt: Label 'Inserting LookupData          @4@@@@@@@@@@@@@@@@@ \';
        Text006Txt: Label 'Inserting Posting Groups      @5@@@@@@@@@@@@@@@@@\';
        Text007Txt: Label 'Updating Lookups Data         @6@@@@@@@@@@@@@@@@@ \';
        Text008Txt: Label 'Creating Location             @7@@@@@@@@@@@@@@@@@ \';
        Text009Txt: Label 'Creating Attendance Setup     @8@@@@@@@@@@@@@@@@@ \';
        Text010Txt: Label 'Create Statutory Setup        @9@@@@@@@@@@@@@@@@@ \';
        Text011Txt: Label 'Lookups Are not Updated';
        Text012Txt: Label 'SKILL SET';
        Text013Txt: Label 'ORACLE';
        Text014Txt: Label 'Oracle Developer';
        Text015Txt: Label 'AUTOCAD';
        Text016Txt: Label 'AUTOCAD Developer';
        Text017Txt: Label 'QUALIFICATION';
        Text018Txt: Label 'BCOM';
        Text019Txt: Label 'B.TECH';
        Text020Txt: Label 'CERTIFICATION';
        Text021Txt: Label 'MBS - FINANCE';
        Text022Txt: Label 'MBS-DEV';
        Text023Txt: Label 'DEPARTMENTS';
        Text024Txt: Label 'ACCOUNTS';
        Text025Txt: Label 'ASSEMBLY';
        Text026Txt: Label 'PRODUCTION';
        Text027Txt: Label 'DESIGNATIONS';
        Text028Txt: Label 'ASSISTANT MANAGER';
        Text029Txt: Label 'C E O';
        Text030Txt: Label 'EXE ASSISTANT';
        Text031Txt: Label 'EXECUTIVE';
        Text032Txt: Label 'INTERVIEW TYPES';
        Text033Txt: Label 'TELEPHONIC';
        Text034Txt: Label 'VEDIO CONFIRANCE';
        Text035Txt: Label 'HR';
        Text036Txt: Label 'INTERVIEW STATUS';
        Text037Txt: Label 'SELECTED';
        Text038Txt: Label 'REJECTED';
        Text039Txt: Label 'ON HOLD';
        Text040Txt: Label 'PERFORMANCE RATING SCALE';
        Text041Txt: Label 'AVERAGE';
        Text042Txt: Label 'GOOD';
        Text043Txt: Label 'EXCELENT';
        Text044Txt: Label 'BELOW AVERAGE';
        Text045Txt: Label 'EXTRA ORDINARY';
        Text046Txt: Label 'TYPE OF TRAINING';
        Text047Txt: Label 'INDUCTION TRAINING';
        Text048Txt: Label 'COMMUNINTRAINING';
        Text049Txt: Label 'COMMUNICATION TRAINING';
        Text050Txt: Label 'SKILDEVELOPMPROGRAM';
        Text051Txt: Label 'SKILLDEVELOPMENTPROGRAM';
        Text052Txt: Label 'GENERAL TRAINING';
        Text053Txt: Label 'PRODUCT DEVELOPMENT';
        Text054Txt: Label 'SAFTEY MESUREMENT';
        Text055Txt: Label 'NEED FOR TRAINING';
        Text056Txt: Label 'MANDATORY';
        Text057Txt: Label 'OPTIONAL';
        Text058Txt: Label 'SKILL ENH';
        Text059Txt: Label 'SKILL ENHANCEMENT';
        Text060Txt: Label 'TECH ENH';
        Text061Txt: Label 'TECH ENHANCEMENT';
        Text062Txt: Label 'GENERAL';
        Text063Txt: Label 'STAFF TYPES';
        Text064Txt: Label 'GENERAL STAFF';
        Text065Txt: Label 'GENERAL staff';
        Text066Txt: Label 'ADMIN STAFF';
        Text067Txt: Label 'PRODUCTION STAFF';
        Text068Txt: Label 'CAUSES OF INACTIVITY';
        Text069Txt: Label 'CRIMINAL CASE';
        Text070Txt: Label 'LONG LEAVE';
        Text071Txt: Label 'MATERNITY';
        Text073Txt: Label 'GROUNDS OF TERMINATION';
        Text074Txt: Label 'CRIMINAL BG';
        Text075Txt: Label 'CRIMINAL BACK GROUND';
        Text076Txt: Label 'LONG ABSENTEESIM';
        Text077Txt: Label 'RUDE BEHAVIOUR';
        Text078Txt: Label 'LOAN TYPES';
        Text079Txt: Label 'SA';
        Text080Txt: Label 'Salary Advance';
        Text081Txt: Label 'HBL';
        Text082Txt: Label 'House Building Loan';
        Text083Txt: Label 'PAY CADRE';
        Text084Txt: Label 'STAFF';
        Text085Txt: Label 'staff';
        Text086Txt: Label 'WORKMEN';
        Text087Txt: Label 'Workmen';
        Text088Txt: Label 'LEAVE PAY CADRE';
        Text089Txt: Label 'MALE EMPLOYEE';
        Text090Txt: Label 'FEMALE EMPLOYEE';
        Text091Txt: Label 'TRAINEES';
        Text092Txt: Label 'LEAVE PAY CADRE';
        Text093Txt: Label 'PHYSICAL LOCATIONS';
        Text094Txt: Label 'HYDERABAD';
        Text095Txt: Label 'BANGALORE';
        Text096Txt: Label 'EMPLOYEE STATUS';
        Text097Txt: Label 'GENERAL WORKERS';
        Text098Txt: Label 'GENERAL STAFF';
        Text099Txt: Label 'SUPERVISORS';
        Text100Txt: Label 'MANAGER';
        Text1001Txt: Label 'EMP';
        Text1002Txt: Label 'Employee';
        Text1003Txt: Label 'TRAINEE';
        Text1004Txt: Label 'Trainee';
        Text1005Txt: Label 'WORKER';
        Text1006Txt: Label 'Worker';
        Text1007Txt: Label 'ADDITIONS AND DEDUCTIONS';
        Text1008Txt: Label '8720';
        Text1009Txt: Label '9220';
        Text1010Txt: Label '5429';
        Text1011Txt: Label 'AP';
        Text1012Txt: Label 'Andhra Pradesh';
        Text1013Txt: Label 'System Created';
        Text1014Txt: Label 'GENERAL';
        Text1015Txt: Label 'General Shift';
        Text1016Txt: Label 'causal leave';
        Text1017Txt: Label 'CL';
        Text1018Txt: Label '1M';
        Text1019Txt: Label 'EL';
        Text1020Txt: Label 'paid leave';
        Text1021Txt: Label 'Employee';
        Text1022Txt: Label 'EMP';
        Text1023Txt: Label 'EMP000001';
        Text1024Txt: Label 'RDB';
        Text1025Txt: Label 'Resume DataBase';
        Text1026Txt: Label 'RDB-000001';
        Text1027Txt: Label 'RES';
        Text1028Txt: Label 'Recruitment';
        Text1029Txt: Label 'RES-000001';
        Text1030Txt: Label 'PR';
        Text1031Txt: Label 'Pay Revision';
        Text1032Txt: Label 'PAYR000001';
        Text1033Txt: Label 'LOAN';
        Text1034Txt: Label 'LOAN000001';
        Text1035Txt: Label 'TR';
        Text1036Txt: Label 'Training';
        Text1037Txt: Label 'TR-000001';
        Text1038Txt: Label 'APP';
        Text1039Txt: Label 'Appraisal Nos';
        Text1040Txt: Label 'APP-000001';
        Text1041Txt: Label 'LA';
        Text1042Txt: Label 'Leave Application Nos';
        Text1043Txt: Label 'LA-000001';
        Text1044Txt: Label 'LENCASH';
        Text1045Txt: Label 'Leave Encash Nos';
        Text1046Txt: Label 'LA-000001';
        Text1048Txt: Label 'OT';
        Text1049Txt: Label 'OverTime';
        Text1050Txt: Label 'OT-000001';
        Text1051Txt: Label 'OD';
        Text1052Txt: Label 'OD-000001';
        Text1053Txt: Label 'On Duty';
        Text1054Txt: Label 'TN';
        Text1055Txt: Label 'Tour Numb';
        Text1056Txt: Label 'TOUR-000001';
        Text1057Txt: Label 'SS';
        Text1058Txt: Label 'Shift';
        Text1059Txt: Label 'SHIFT-00001';
        Text1060Txt: Label 'PS';
        Text1061Txt: Label 'Permission';
        Text1062Txt: Label 'PS-000001';
        Text1063Txt: Label 'LOP';
        Text1064Txt: Label 'LOP Adjust';
        Text1065Txt: Label 'LOPADJ-000001';
        Text1066Txt: Label 'COM OFF AD';
        Text1067Txt: Label 'COMP Off';
        Text1068Txt: Label 'COFF000001';
        Text1069Txt: Label 'JOBDESCRIP';
        Text1071Txt: Label 'Job Description';
        Text1072Txt: Label 'JD-000001';
        Text1073Txt: Label 'ITS';
        Text1074Txt: Label 'Ind Training No';
        Text1075Txt: Label 'INDT000001';
        Text1076Txt: Label 'TNI';
        Text1077Txt: Label 'Training Need Identi';
        Text1078Txt: Label 'TNI000001';
        Text1079Txt: Label 'APP';
        Text1080Txt: Label 'Appraisal No';
        Text1081Txt: Label 'APP-000001';
        Text1082Txt: Label 'TRA';
        Text1083Txt: Label 'Training Schedule Nos';
        Text1084Txt: Label 'TRSCH000001';
        Text1085Txt: Label 'EMP-CONF';
        Text1086Txt: Label 'Confirmation ID';
        Text1087Txt: Label 'CONF-000001';
        Text1088Txt: Label 'SEPARATION';
        Text1089Txt: Label 'Seperation ID';
        Text1090Txt: Label 'SEPA-000001';
        Text1091Txt: Label 'DRIVER SAL';
        Text1092Txt: Label 'Driver Salary';
        Text1093Txt: Label 'MEDICAL ALL';
        Text1094Txt: Label 'Medical Allowance';
        Text1095Txt: Label '8730';
        Text1096Txt: Label 'BASIC';
        Text1097Txt: Label 'ESI YEAR';
        Text1098Txt: Label 'FINANCIAL YEAR';
        Text1099Txt: Label 'LEAVE YEAR';
        Text10100Txt: Label 'PF YEAR';
        Text10101Txt: Label 'DA';
        Text10102Txt: Label 'AFTER BASIC';
        Text10103Txt: Label 'HRA';
        Text10104Txt: Label 'ON ATTENDANCE';
        Text10105Txt: Label '1Y';

    procedure InsertSetupData();
    var
        LookupType: Record "Lookup Type B2B";
        UpdateLookups: Codeunit "Lookup B2B";
    begin
        LookupType.RESET();
        if LookupType.IsEmpty() then begin
            Window.UPDATE(3, 1000);
            SLEEP(1000);
            Window.UPDATE(3, 2000);
            SLEEP(1000);
            Window.UPDATE(3, 5000);
            SLEEP(1000);
            UpdateLookups.RUN();
            Window.UPDATE(3, 8000);
            SLEEP(1000);
            Window.UPDATE(3, 9000);
            SLEEP(1000);
            Window.UPDATE(3, 10000);
            SLEEP(1000);
        end;
        InsertSampleLookupData();
        InsertPostingGroups();
    end;

    procedure InsertSampleLookupData();
    var
    begin
        Window.UPDATE(4, 1000);
        SLEEP(1000);
        LookUp.INIT();
        LookUp."Lookup Type" := 1;
        LookUp."LookupType Name" := Text012Txt;
        LookUp."Lookup Name" := Text013Txt;
        LookUp.Description := Text014Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 1;
        LookUp."LookupType Name" := Text012Txt;
        LookUp."Lookup Name" := Text015Txt;
        LookUp.Description := Text016Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 2;
        LookUp."LookupType Name" := Text017Txt;
        LookUp."Lookup Name" := Text018Txt;
        LookUp.Description := Text018Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 2;
        LookUp."LookupType Name" := Text017Txt;
        LookUp."Lookup Name" := Text019Txt;
        LookUp.Description := Text019Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 3;
        LookUp."LookupType Name" := Text020Txt;
        LookUp."Lookup Name" := Text021Txt;
        LookUp.Description := Text021Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 3;
        LookUp."LookupType Name" := Text020Txt;
        LookUp."Lookup Name" := Text022Txt;
        LookUp.Description := Text022Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        Window.UPDATE(4, 2000);
        SLEEP(1000);

        LookUp.INIT();
        LookUp."Lookup Type" := 4;
        LookUp."LookupType Name" := Text023Txt;
        LookUp."Lookup Name" := Text024Txt;
        LookUp.Description := Text024Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 4;
        LookUp."LookupType Name" := Text023Txt;
        LookUp."Lookup Name" := Text025Txt;
        LookUp.Description := Text025Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 4;
        LookUp."LookupType Name" := Text023Txt;
        LookUp."Lookup Name" := Text026Txt;
        LookUp.Description := Text026Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 5;
        LookUp."LookupType Name" := Text027Txt;
        LookUp."Lookup Name" := Text028Txt;
        LookUp.Description := Text028Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 5;
        LookUp."LookupType Name" := Text027Txt;
        LookUp."Lookup Name" := Text029Txt;
        LookUp.Description := Text029Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 5;
        LookUp."LookupType Name" := Text027Txt;
        LookUp."Lookup Name" := Text030Txt;
        LookUp.Description := Text030Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 5;
        LookUp."LookupType Name" := Text027Txt;
        LookUp."Lookup Name" := Text031Txt;
        LookUp.Description := Text031Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 6;
        LookUp."LookupType Name" := Text032Txt;
        LookUp."Lookup Name" := Text033Txt;
        LookUp.Description := Text033Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 6;
        LookUp."LookupType Name" := Text032Txt;
        LookUp."Lookup Name" := Text034Txt;
        LookUp.Description := Text034Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 6;
        LookUp."LookupType Name" := Text032Txt;
        LookUp."Lookup Name" := Text035Txt;
        LookUp.Description := Text035Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        Window.UPDATE(4, 3000);
        SLEEP(1000);

        LookUp.INIT();
        LookUp."Lookup Type" := 7;
        LookUp."LookupType Name" := Text036Txt;
        LookUp."Lookup Name" := Text037Txt;
        LookUp.Description := Text037Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 7;
        LookUp."LookupType Name" := Text036Txt;
        LookUp."Lookup Name" := Text038Txt;
        LookUp.Description := Text038Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 7;
        LookUp."LookupType Name" := Text036Txt;
        LookUp."Lookup Name" := Text039Txt;
        LookUp.Description := Text039Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 9;
        LookUp."LookupType Name" := Text040Txt;
        LookUp."Lookup Name" := Text041Txt;
        LookUp.Description := Text041Txt;
        LookUp."Performance Scale Value" := 10;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 9;
        LookUp."LookupType Name" := Text040Txt;
        LookUp."Lookup Name" := Text042Txt;
        LookUp.Description := Text042Txt;
        LookUp."Performance Scale Value" := 20;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 9;
        LookUp."LookupType Name" := Text040Txt;
        LookUp."Lookup Name" := Text043Txt;
        LookUp.Description := Text043Txt;
        LookUp."Performance Scale Value" := 30;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        Window.UPDATE(4, 4000);
        SLEEP(1000);

        LookUp.INIT();
        LookUp."Lookup Type" := 9;
        LookUp."LookupType Name" := Text040Txt;
        LookUp."Lookup Name" := Text044Txt;
        LookUp.Description := Text044Txt;
        LookUp."Performance Scale Value" := 5;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 9;
        LookUp."LookupType Name" := Text040Txt;
        LookUp."Lookup Name" := Text045Txt;
        LookUp.Description := Text045Txt;
        LookUp."Performance Scale Value" := 35;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 10;
        LookUp."LookupType Name" := Text046Txt;
        LookUp."Lookup Name" := Text047Txt;
        LookUp.Description := Text047Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 10;
        LookUp."LookupType Name" := Text046Txt;
        LookUp."Lookup Name" := Text048Txt;
        LookUp.Description := Text049Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 10;
        LookUp."LookupType Name" := Text046Txt;
        LookUp."Lookup Name" := Text050Txt;
        LookUp.Description := Text051Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 10;
        LookUp."LookupType Name" := Text046Txt;
        LookUp."Lookup Name" := Text052Txt;
        LookUp.Description := Text052Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 10;
        LookUp."LookupType Name" := Text046Txt;
        LookUp."Lookup Name" := Text053Txt;
        LookUp.Description := Text053Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 10;
        LookUp."LookupType Name" := Text046Txt;
        LookUp."Lookup Name" := Text054Txt;
        LookUp.Description := Text054Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 11;
        LookUp."LookupType Name" := Text055Txt;
        LookUp."Lookup Name" := Text056Txt;
        LookUp.Description := Text056Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 11;
        LookUp."LookupType Name" := Text055Txt;
        LookUp."Lookup Name" := Text057Txt;
        LookUp.Description := Text057Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 11;
        LookUp."LookupType Name" := Text055Txt;
        LookUp."Lookup Name" := Text058Txt;
        LookUp.Description := Text059Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 11;
        LookUp."LookupType Name" := Text055Txt;
        LookUp."Lookup Name" := Text060Txt;
        LookUp.Description := Text061Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 11;
        LookUp."LookupType Name" := Text055Txt;
        LookUp."Lookup Name" := Text062Txt;
        LookUp.Description := Text062Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        Window.UPDATE(4, 5000);
        SLEEP(1000);

        LookUp.INIT();
        LookUp."Lookup Type" := 12;
        LookUp."LookupType Name" := Text063Txt;
        LookUp."Lookup Name" := Text064Txt;
        LookUp.Description := Text065Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 12;
        LookUp."LookupType Name" := Text063Txt;
        LookUp."Lookup Name" := Text066Txt;
        LookUp.Description := Text066Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 12;
        LookUp."LookupType Name" := Text063Txt;
        LookUp."Lookup Name" := Text067Txt;
        LookUp.Description := Text067Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        Window.UPDATE(4, 6000);
        SLEEP(1000);

        LookUp.INIT();
        LookUp."Lookup Type" := 14;
        LookUp."LookupType Name" := Text068Txt;
        LookUp."Lookup Name" := Text069Txt;
        LookUp.Description := Text069Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 14;
        LookUp."LookupType Name" := Text068Txt;
        LookUp."Lookup Name" := Text070Txt;
        LookUp.Description := Text070Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 14;
        LookUp."LookupType Name" := Text068Txt;
        LookUp."Lookup Name" := Text071Txt;
        LookUp.Description := Text071Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 14;
        LookUp."LookupType Name" := Text068Txt;
        LookUp."Lookup Name" := Text069Txt;
        LookUp.Description := Text069Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        Window.UPDATE(4, 7000);
        SLEEP(1000);


        LookUp.INIT();
        LookUp."Lookup Type" := 15;
        LookUp."LookupType Name" := Text073Txt;
        LookUp."Lookup Name" := Text074Txt;
        LookUp.Description := Text075Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 15;
        LookUp."LookupType Name" := Text073Txt;
        LookUp."Lookup Name" := Text076Txt;
        LookUp.Description := Text076Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 15;
        LookUp."LookupType Name" := Text073Txt;
        LookUp."Lookup Name" := Text077Txt;
        LookUp.Description := Text077Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();


        LookUp.INIT();
        LookUp."Lookup Type" := 18;
        LookUp."LookupType Name" := Text078Txt;
        LookUp."Lookup Name" := Text079Txt;
        LookUp.Description := Text080Txt;
        LookUp."All Grades" := true;
        LookUp."Max.Amt.Type" := LookUp."Max.Amt.Type"::"Gross Salary";
        LookUp."Max.Amt" := 3.0;
        LookUp."Max.No. of instalments" := 12;
        LookUp."Loan Priority No." := 1;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 18;
        LookUp."LookupType Name" := Text078Txt;
        LookUp."Lookup Name" := Text081Txt;
        LookUp.Description := Text082Txt;
        LookUp."All Grades" := true;
        LookUp."Max.Amt.Type" := LookUp."Max.Amt.Type"::Amount;
        LookUp."Max.Amt" := 1000000.0;
        LookUp."Max.No. of instalments" := 120;
        LookUp."Loan Priority No." := 2;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        Window.UPDATE(4, 8000);
        SLEEP(1000);


        LookUp.INIT();
        LookUp."Lookup Type" := 20;
        LookUp."LookupType Name" := Text083Txt;
        LookUp."Lookup Name" := Text084Txt;
        LookUp.Description := Text085Txt;
        LookUp.VALIDATE("Period Start Date", 20120401D);
        LookUp."Incentive Applicable" := LookUp."Incentive Applicable"::Bonus;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 20;
        LookUp."LookupType Name" := Text083Txt;
        LookUp."Lookup Name" := Text086Txt;
        LookUp.Description := Text087Txt;
        LookUp.VALIDATE("Period Start Date", 20120401D);
        LookUp."Incentive Applicable" := LookUp."Incentive Applicable"::"Ex-gratia";
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 22;
        LookUp."LookupType Name" := Text088Txt;
        LookUp."Lookup Name" := Text089Txt;
        LookUp.Description := Text089Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 22;
        LookUp."LookupType Name" := Text092Txt;
        LookUp."Lookup Name" := Text090Txt;
        LookUp.Description := Text090Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 22;
        LookUp."LookupType Name" := Text092Txt;
        LookUp."Lookup Name" := Text091Txt;
        LookUp.Description := Text091Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();


        LookUp.INIT();
        LookUp."Lookup Type" := 23;
        LookUp."LookupType Name" := Text093Txt;
        LookUp."Lookup Name" := Text094Txt;
        LookUp.Description := Text094Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 23;
        LookUp."LookupType Name" := Text093Txt;
        LookUp."Lookup Name" := Text095Txt;
        LookUp.Description := Text095Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        Window.UPDATE(4, 9000);
        SLEEP(1000);

        LookUp.INIT();
        LookUp."Lookup Type" := 24;
        LookUp."LookupType Name" := Text096Txt;
        LookUp."Lookup Name" := Text097Txt;
        LookUp.Description := Text097Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 24;
        LookUp."LookupType Name" := Text096Txt;
        LookUp."Lookup Name" := Text098Txt;
        LookUp.Description := Text098Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 24;
        LookUp."LookupType Name" := Text096Txt;
        LookUp."Lookup Name" := Text099Txt;
        LookUp.Description := Text099Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        LookUp.INIT();
        LookUp."Lookup Type" := 24;
        LookUp."LookupType Name" := Text096Txt;
        LookUp."Lookup Name" := Text100Txt;
        LookUp.Description := Text100Txt;
        LookUp."System Defined" := false;
        LookUp.INSERT();

        Window.UPDATE(4, 10000);
        SLEEP(1000);
    end;

    procedure InsertPostingGroups();
    var
        BusinessPosting: Record "Payroll Bus. Post Group B2B";
        ProductPosting: Record "Payroll Prod. Post. Group B2B";
        GeneralPosting: Record "Payroll Gen. Posting Group B2B";
        EmployeePosting: Record "Employee Posting Group B2B";
        LoanPosting: Record "Loan Posting Groups B2B";
        StaturyPosting: Record "Employer Stat. Post. Group B2B";

    begin

        Window.UPDATE(5, 1000);
        SLEEP(1000);

        BusinessPosting.INIT();
        BusinessPosting.Code := Text1001Txt;
        BusinessPosting.Description := Text1002Txt;
        BusinessPosting.INSERT();

        BusinessPosting.INIT();
        BusinessPosting.Code := Text1003Txt;
        BusinessPosting.Description := Text1004Txt;
        BusinessPosting.INSERT();

        BusinessPosting.INIT();
        BusinessPosting.Code := Text1005Txt;
        BusinessPosting.Description := Text1006Txt;
        BusinessPosting.INSERT();

        Window.UPDATE(5, 2000);
        SLEEP(1000);


        Lookup.RESET();
        Lookup.SETRANGE("LookupType Name", Text1007Txt);
        if Lookup.FINDFIRST() then
            repeat
                ProductPosting.INIT();
                ProductPosting.Code := Lookup."Lookup Name";
                ProductPosting.Description := Lookup."Lookup Name";
                ProductPosting.INSERT();
            until Lookup.NEXT() = 0
        else
            ERROR(Text011Txt);

        Window.UPDATE(5, 3000);
        SLEEP(1000);

        BusinessPosting.RESET();
        if BusinessPosting.FINDFIRST() then
            repeat
                ProductPosting.RESET();
                if ProductPosting.FINDFIRST() then
                    repeat
                        GeneralPosting.INIT();
                        GeneralPosting."Payroll Bus. Posting Group" := BusinessPosting.Code;
                        GeneralPosting."Payroll Prod. Posting Group" := ProductPosting.Code;
                        GeneralPosting."G/L Code" := Text1008Txt;
                        GeneralPosting.INSERT();
                    until ProductPosting.NEXT() = 0;
            until BusinessPosting.NEXT() = 0;


        Window.UPDATE(5, 4000);
        SLEEP(1000);

        BusinessPosting.RESET();
        if BusinessPosting.FINDFIRST() then
            repeat
                EmployeePosting.INIT();
                EmployeePosting.Code := BusinessPosting.Code;
                EmployeePosting.Description := LOWERCASE(BusinessPosting.Code);
                EmployeePosting."Salary Payable Acc." := Text1008Txt;
                EmployeePosting."PF Payable Acc." := Text1008Txt;
                EmployeePosting."TDS Payable Acc." := Text1008Txt;
                EmployeePosting."ESI Payable Acc." := Text1008Txt;
                EmployeePosting."EPS Payable Acc." := Text1008Txt;
                EmployeePosting."EDLI Charges Acc." := Text1008Txt;
                EmployeePosting."PF Admin Charge Payable Acc." := Text1008Txt;
                EmployeePosting."PT Payable Account" := Text1008Txt;
                EmployeePosting."RIFA Charges Acc." := Text1008Txt;
                EmployeePosting."Arrear Salary Payable Acc." := Text1008Txt;
                EmployeePosting."Bonus Payable Acc." := Text1008Txt;
                EmployeePosting."Employee Imprest Account" := Text1008Txt;
                EmployeePosting."LTA Posting Group" := Text1008Txt;
                EmployeePosting."LeaveEncash Payable Acc." := Text1008Txt;
                EmployeePosting.INSERT();
            until BusinessPosting.NEXT() = 0;

        Window.UPDATE(5, 5000);
        SLEEP(1000);

        Lookup.RESET();
        Lookup.SETRANGE("LookupType Name", Text078Txt);
        if Lookup.FINDFIRST() then
            repeat
                LoanPosting.INIT();
                LoanPosting.Code := Lookup."Lookup Name";
                LoanPosting.Description := copystr(Lookup.Description, 1, 50);
                LoanPosting."Loan Refundable Acc." := Text1009Txt;
                LoanPosting.INSERT();
            until Lookup.NEXT() = 0;


        Window.UPDATE(5, 6000);
        SLEEP(1000);

        BusinessPosting.RESET();
        if BusinessPosting.FINDFIRST() then
            repeat
                StaturyPosting.INIT();
                StaturyPosting.Code := BusinessPosting.Code;
                StaturyPosting.Description := BusinessPosting.Description;
                StaturyPosting."Employer PF" := Text1010Txt;
                StaturyPosting."Employer EPS" := Text1010Txt;
                StaturyPosting."PF Admin. Charges" := Text1010Txt;
                StaturyPosting."EDLI Charges" := Text1010Txt;
                StaturyPosting."Employer ESI" := Text1010Txt;
                StaturyPosting."RIFA Charges" := Text1010Txt;
                StaturyPosting."Cash Account" := Text1010Txt;
                StaturyPosting."Bank Account" := Text1010Txt;
                StaturyPosting.INSERT();
            until BusinessPosting.NEXT() = 0;

        Window.UPDATE(5, 7000);
        SLEEP(1000);

        UpdateSampleLookupData();
        Window.UPDATE(5, 10000);
        SLEEP(1000);
    end;

    procedure CreateLocationsAndUsers();
    var

    begin
        Window.UPDATE(7, 5000);
        SLEEP(1000);
        Window.UPDATE(7, 10000);
        SLEEP(1000);
    end;

    procedure CreateStatutorySetups();
    var
        ProfessionalTaxHeader: Record "Professional Tax Header B2B";
        ProfessionalTaxLine: Record "Professional Tax Line B2B";
        PF: Record PF_B2B;
        ESI: Record ESI_B2B;

    begin
        Window.UPDATE(9, 1000);
        SLEEP(1000);
        ProfessionalTaxHeader.INIT();
        ProfessionalTaxHeader."Branch Code" := Text1011Txt;
        ProfessionalTaxHeader."Effective Date" := DMY2DATE(1, 1, 2012);
        ProfessionalTaxHeader.Description := Text1012Txt;
        if ProfessionalTaxHeader.INSERT() then begin
            ProfessionalTaxLine.INIT();
            ProfessionalTaxLine."Branch Code" := ProfessionalTaxHeader."Branch Code";
            ProfessionalTaxLine.VALIDATE("Effective Date", ProfessionalTaxHeader."Effective Date");
            ProfessionalTaxLine."Line No." := 10000;
            ProfessionalTaxLine."Income From" := 0.01;
            ProfessionalTaxLine."Income To" := 3000.0;
            ProfessionalTaxLine."Tax Amount" := 0.0;
            ProfessionalTaxLine.INSERT();

            ProfessionalTaxLine.INIT();
            ProfessionalTaxLine."Branch Code" := ProfessionalTaxHeader."Branch Code";
            ProfessionalTaxLine.VALIDATE("Effective Date", ProfessionalTaxHeader."Effective Date");
            ProfessionalTaxLine."Line No." := 20000;
            ProfessionalTaxLine."Income From" := 3001.0;
            ProfessionalTaxLine."Income To" := 5000.0;
            ProfessionalTaxLine."Tax Amount" := 25.0;
            ProfessionalTaxLine.INSERT();

            ProfessionalTaxLine.INIT();
            ProfessionalTaxLine."Branch Code" := ProfessionalTaxHeader."Branch Code";
            ProfessionalTaxLine.VALIDATE("Effective Date", ProfessionalTaxHeader."Effective Date");
            ProfessionalTaxLine."Line No." := 30000;
            ProfessionalTaxLine."Income From" := 5001.0;
            ProfessionalTaxLine."Income To" := 8000.0;
            ProfessionalTaxLine."Tax Amount" := 60.0;
            ProfessionalTaxLine.INSERT();

            ProfessionalTaxLine.INIT();
            ProfessionalTaxLine."Branch Code" := ProfessionalTaxHeader."Branch Code";
            ProfessionalTaxLine.VALIDATE("Effective Date", ProfessionalTaxHeader."Effective Date");
            ProfessionalTaxLine."Line No." := 40000;
            ProfessionalTaxLine."Income From" := 8001.0;
            ProfessionalTaxLine."Income To" := 10000.0;
            ProfessionalTaxLine."Tax Amount" := 80.0;
            ProfessionalTaxLine.INSERT();

            ProfessionalTaxLine.INIT();
            ProfessionalTaxLine."Branch Code" := ProfessionalTaxHeader."Branch Code";
            ProfessionalTaxLine.VALIDATE("Effective Date", ProfessionalTaxHeader."Effective Date");
            ProfessionalTaxLine."Line No." := 50000;
            ProfessionalTaxLine."Income From" := 10001.0;
            ProfessionalTaxLine."Income To" := 15000.0;
            ProfessionalTaxLine."Tax Amount" := 120.0;
            ProfessionalTaxLine.INSERT();

            ProfessionalTaxLine.INIT();
            ProfessionalTaxLine."Branch Code" := ProfessionalTaxHeader."Branch Code";
            ProfessionalTaxLine.VALIDATE("Effective Date", ProfessionalTaxHeader."Effective Date");
            ProfessionalTaxLine."Line No." := 60000;
            ProfessionalTaxLine."Income From" := 15001.0;
            ProfessionalTaxLine."Income To" := 20000.0;
            ProfessionalTaxLine."Tax Amount" := 150.0;
            ProfessionalTaxLine.INSERT();

            ProfessionalTaxLine.INIT();
            ProfessionalTaxLine."Branch Code" := ProfessionalTaxHeader."Branch Code";
            ProfessionalTaxLine.VALIDATE("Effective Date", ProfessionalTaxHeader."Effective Date");
            ProfessionalTaxLine."Line No." := 70000;
            ProfessionalTaxLine."Income From" := 20001.0;
            ProfessionalTaxLine."Income To" := 99999999.0;
            ProfessionalTaxLine."Tax Amount" := 200.0;
            ProfessionalTaxLine.INSERT();
        end;

        Window.UPDATE(9, 6000);
        SLEEP(1000);

        PF.INIT();
        PF.Id := 1;
        PF."Effective Date" := DMY2DATE(1, 1, 2012);
        PF."Employer Contribution" := 3.67;
        PF."Employee Contribution" := 12.0;
        PF."Rounding Amount" := 1;
        PF."Rounding Method" := PF."Rounding Method"::Nearest;
        PF."EPS %" := 8.33;
        PF."Admin Charges %" := 1.1;
        PF."EDLI %" := 0.05;
        PF."RIFA %" := 0.01;
        PF."PF Amount" := 6500;
        PF."Employer EPS Max.Amt Lmt" := 0;
        PF."PF Applicable On" := 0;
        PF.INSERT();

        Window.UPDATE(9, 8000);
        SLEEP(1000);

        ESI.INIT();
        ESI.Id := 1;
        ESI."Effective Date" := DMY2DATE(1, 1, 2012);
        ESI."Employer %" := 4.75;
        ESI."Employee %" := 1.75;
        ESI."Rounding Amount" := 1;
        ESI."Rounding Method" := ESI."Rounding Method"::Nearest;
        ESI."ESI Salary Amount" := 15000;
        ESI.INSERT();
        Window.UPDATE(9, 10000);
        SLEEP(1000);
    end;

    procedure InsertAttendanceSetup();
    var
        Holiday: Record Holiday_B2B;
        HolidaysLRec: Record Holiday_B2B;

        ShiftMaster: Record "Shift Master B2B";
        LeaveMaster: Record "Leave Master B2B";
        ShiftWiseoffday: Record "Shiftwise Offday B2B";
        CurrentLoc: Code[20];
        I: Integer;
        J: Integer;
        CheckDate: Date;
        Num: Integer;
    begin
        Window.UPDATE(8, 500);
        SLEEP(1000);

        GetPayrollLocation(CurrentLoc);
        CheckDate := DMY2DATE(1, 1, 2012);
        RANDOMIZE();
        while I < 12 do begin
            J := RANDOM(365);
            if J <= 365 then begin
                Holiday.INIT();
                Holiday.Date := CheckDate + J;
                Holiday."Location Code" := CurrentLoc;
                Holiday.Description := Text1013Txt;
                Holiday.Updated := false;
                HolidaysLRec.RESET();
                HolidaysLRec.SETRANGE(Date, Holiday.Date);
                HolidaysLRec.SETRANGE("Location Code", CurrentLoc);
                if HolidaysLRec.IsEmpty() then
                    Holiday.INSERT();
                I := I + 1;
            end;
        end;
        Window.UPDATE(8, 2000);
        SLEEP(1000);

        OffDay.RESET();
        if OffDay.FINDLAST() then
            Num := OffDay.ID + 1
        else
            Num := 1;

        OffDay.RESET();
        OffDay.INIT();
        OffDay.ID := Num;
        OffDay."Location Code" := CurrentLoc;
        OffDay.VALIDATE(Day, OffDay.Day::Saturday);
        OffDay."Weekly Off" := OffDay."Weekly Off"::"Full Day";
        OffDay."Week No." := OffDay."Week No."::All;
        OffDay.INSERT();
        Num += 1;
        OffDay.INIT();
        OffDay.ID := Num;
        OffDay."Location Code" := CurrentLoc;
        OffDay.VALIDATE(Day, OffDay.Day::Sunday);
        OffDay."Weekly Off" := OffDay."Weekly Off"::"Full Day";
        OffDay."Week No." := OffDay."Week No."::All;
        OffDay.INSERT();

        Window.UPDATE(8, 4000);
        SLEEP(1000);


        ShiftMaster.INIT();
        ShiftMaster."Shift Code" := Text1014Txt;
        ShiftMaster."Location Code" := CurrentLoc;
        ShiftMaster.Decription := Text1015Txt;
        ShiftMaster."Starting Time" := 090000T;
        ShiftMaster."Ending Time" := 180000T;
        ShiftMaster.VALIDATE("Break Start Time", 130000T);
        ShiftMaster.VALIDATE("Break End time", 140000T);
        if ShiftMaster.INSERT() then begin
            OffDay.RESET();
            OffDay.SETRANGE("Location Code", CurrentLoc);
            if OffDay.FINDSET() then
                repeat
                    ShiftWiseoffday.INIT();
                    ShiftWiseoffday.TRANSFERFIELDS(OffDay);
                    ShiftWiseoffday."Shift Code" := ShiftMaster."Shift Code";
                    ShiftWiseoffday."Location Code" := OffDay."Location Code";
                    ShiftWiseoffday.INSERT();
                until OffDay.NEXT() = 0;
        end;

        Window.UPDATE(8, 6000);
        SLEEP(1000);

        LeaveMaster.INIT();
        LeaveMaster."Leave Code" := Text1017Txt;
        LeaveMaster."Type of Leave" := LeaveMaster."Type of Leave"::Casual;
        LeaveMaster."Location Code" := CurrentLoc;
        LeaveMaster.Description := Text1016Txt;
        LeaveMaster.VALIDATE("Leaves in Crediting Interval", 1.0);
        EVALUATE(LeaveMaster."Crediting Interval", Text1018Txt);
        LeaveMaster.VALIDATE(LeaveMaster."Crediting Interval");
        LeaveMaster."Crediting Type" := LeaveMaster."Crediting Type"::"Before the Period";
        LeaveMaster."Applicable Date" := DMY2DATE(1, 1, 2012);
        LeaveMaster."Carry Forward" := false;
        LeaveMaster."Max.Leaves to Carry Forward" := 0;
        LeaveMaster."All Cadres" := true;
        LeaveMaster."Off Days b/w Leaves" := false;
        LeaveMaster."Update Leaves On Salary Post" := true;
        LeaveMaster.Encashable := false;
        LeaveMaster."Max. Encashable" := 0;
        LeaveMaster.INSERT();

        Window.UPDATE(8, 8000);
        SLEEP(1000);

        LeaveMaster.INIT();
        LeaveMaster."Leave Code" := Text1019Txt;
        LeaveMaster."Type of Leave" := LeaveMaster."Type of Leave"::Earned;
        LeaveMaster."Location Code" := CurrentLoc;
        LeaveMaster.Description := Text1020Txt;
        LeaveMaster.VALIDATE("Leaves in Crediting Interval", 30.0);
        EVALUATE(LeaveMaster."Crediting Interval", Text10105Txt);
        LeaveMaster.VALIDATE(LeaveMaster."Crediting Interval");
        LeaveMaster."Crediting Type" := LeaveMaster."Crediting Type"::"After the Period";
        LeaveMaster."Applicable Date" := DMY2DATE(1, 1, 2012);
        LeaveMaster."Carry Forward" := true;
        LeaveMaster."Max.Leaves to Carry Forward" := 90;
        LeaveMaster."All Cadres" := true;
        LeaveMaster."Off Days b/w Leaves" := true;
        LeaveMaster."Update Leaves On Salary Post" := true;
        LeaveMaster.Encashable := true;
        LeaveMaster."Max. Encashable" := 60;
        LeaveMaster.INSERT();
        Window.UPDATE(8, 10000);
        SLEEP(1000);
    end;

    procedure InsertHRSetup();
    var
        HRSetup: Record "HR Setup B2B";
    begin
        Window.UPDATE(1, 100);
        SLEEP(1000);

        HRSetup.INIT();
        HRSetup."Salary Processing month" := 4;
        HRSetup."Salary Processing Year" := 2012;
        HRSetup."Default Attendance Type" := HRSetup."Default Attendance Type"::Absent;
        HRSetup."Rounding Type" := HRSetup."Rounding Type"::"To the nearest value";
        HRSetup."Rounding Precision" := 1.0;
        HRSetup."Activate Leave Approvals" := false;
        Window.UPDATE(1, 800);
        SLEEP(500);

        CheckForNoSeries(Text1022Txt, Text1021Txt, Text1023Txt);
        HRSetup."Employee Nos." := Text1022Txt;

        Window.UPDATE(1, 1000);
        SLEEP(500);
        CheckForNoSeries(Text1024Txt, Text1025Txt, Text1026Txt);
        HRSetup."Resume DB Nos." := Text1024Txt;

        Window.UPDATE(1, 1500);
        SLEEP(500);
        CheckForNoSeries(Text1027Txt, Text1028Txt, Text1029Txt);
        HRSetup."Recruitment Nos." := Text1027Txt;

        Window.UPDATE(1, 2000);
        SLEEP(500);
        CheckForNoSeries(Text1030Txt, Text1031Txt, Text1032Txt);
        HRSetup."Pay Revision Nos." := Text1030Txt;

        Window.UPDATE(1, 2500);
        SLEEP(500);
        CheckForNoSeries(Text1033Txt, Text1033Txt, Text1034Txt);
        HRSetup."Loan Nos." := Text1033Txt;

        Window.UPDATE(1, 3000);
        SLEEP(500);
        CheckForNoSeries(Text1035Txt, Text1036Txt, Text1037Txt);
        HRSetup."Training Nos." := Text1035Txt;

        Window.UPDATE(1, 3500);
        SLEEP(500);
        CheckForNoSeries(Text1038Txt, Text1039Txt, Text1040Txt);
        HRSetup."Appraisal Nos." := Text1038Txt;

        Window.UPDATE(1, 4000);
        SLEEP(500);
        CheckForNoSeries(Text1041Txt, Text1042Txt, Text1043Txt);
        HRSetup."Leave Application Nos." := Text1041Txt;
        CheckForNoSeries(Text1044Txt, Text1045Txt, Text1046Txt);
        HRSetup."Leave Encashment Nos." := Text1044Txt;


        Window.UPDATE(1, 4500);
        SLEEP(500);
        CheckForNoSeries(Text1048Txt, Text1049Txt, Text1050Txt);
        HRSetup."Over Time Nos." := Text1048Txt;

        Window.UPDATE(1, 5000);
        SLEEP(500);
        CheckForNoSeries(Text1051Txt, Text1053Txt, Text1052Txt);
        HRSetup."On Duty Nos." := Text1051Txt;

        Window.UPDATE(1, 5500);
        SLEEP(500);
        CheckForNoSeries(Text1054Txt, Text1055Txt, Text1056Txt);
        HRSetup."Tour intimation Nos." := Text1054Txt;

        Window.UPDATE(1, 6000);
        SLEEP(500);
        CheckForNoSeries(Text1057Txt, Text1058Txt, Text1059Txt);
        HRSetup."Shift Nos." := Text1057Txt;

        Window.UPDATE(1, 6500);
        SLEEP(500);
        CheckForNoSeries(Text1060Txt, Text1061Txt, Text1062Txt);
        HRSetup."Permission Nos." := Text1060Txt;
        CheckForNoSeries(Text1063Txt, Text1064Txt, Text1065Txt);
        HRSetup."LOP Adj. Nos." := Text1063Txt;
        CheckForNoSeries(Text1066Txt, Text1067Txt, Text1068Txt);
        HRSetup."Comp Off Nos." := Text1066Txt;

        Window.UPDATE(1, 7000);
        SLEEP(500);
        CheckForNoSeries(Text1069Txt, Text1071Txt, Text1072Txt);
        HRSetup."Job Desciption Nos." := Text1069Txt;
        CheckForNoSeries(Text1073Txt, Text1074Txt, Text1075Txt);
        HRSetup."Ind. Training Nos." := Text1073Txt;
        CheckForNoSeries(Text1076Txt, Text1077Txt, Text1078Txt);
        HRSetup."Training Need Identi.Nos." := Text1076Txt;
        CheckForNoSeries(Text1079Txt, Text1080Txt, Text1081Txt);
        HRSetup."Appraisal Nos." := Text1079Txt;

        Window.UPDATE(1, 7500);
        SLEEP(500);
        CheckForNoSeries(Text1082Txt, Text1083Txt, Text1084Txt);
        HRSetup."Training Schedule Nos." := Text1082Txt;
        CheckForNoSeries(Text1085Txt, Text1086Txt, Text1087Txt);
        HRSetup."Confirmation Nos." := Text1085Txt;
        CheckForNoSeries(Text1088Txt, Text1089Txt, Text1090Txt);
        HRSetup."Seperation Nos." := Text1088Txt;

        Window.UPDATE(1, 8000);
        SLEEP(500);

        HRSetup."Min. No.of Years" := 5.0;
        HRSetup."No.of Days Salary" := 15;
        HRSetup."No.of Days in Month" := 26;

        HRSetup."Linking Factor1" := 4.7;
        HRSetup."Linking Factor2" := 4.9;
        HRSetup."Neutralisation Points" := 2500.0;
        HRSetup."VDA Rate" := 2.0;
        HRSetup."FDA Amount" := 15.0;

        Window.UPDATE(1, 9000);
        SLEEP(500);

        HRSetup."Paid Days Per Month" := 31.0;
        HRSetup."Educational Cess" := 3.0;
        HRSetup.Locked := true;
        HRSetup.INSERT();

        Window.UPDATE(1, 10000);
        SLEEP(1000);
    end;

    procedure InsertSalaryAdjustmentSetup();
    var
        SalaryAdjustSetup: Record "Salary Adjustment Setup B2B";
    begin
        SalaryAdjustSetup.INIT();
        SalaryAdjustSetup.Code := Text1091Txt;
        SalaryAdjustSetup.Description := Text1092Txt;
        SalaryAdjustSetup."G/L Account" := Text1008Txt;
        SalaryAdjustSetup.Active := true;
        SalaryAdjustSetup.Perk := false;
        SalaryAdjustSetup.INSERT();

        SalaryAdjustSetup.INIT();
        SalaryAdjustSetup.Code := Text1093Txt;
        SalaryAdjustSetup.Description := Text1094Txt;
        SalaryAdjustSetup."G/L Account" := Text1095Txt;
        SalaryAdjustSetup.Active := true;
        SalaryAdjustSetup.Perk := true;
        SalaryAdjustSetup.INSERT();
    end;

    procedure UpdateSampleLookupData();
    var

        CadrePayElement: Record "Pay Cadre Pay Element B2B";
        I: Decimal;
        J: Decimal;
    begin
        Window.UPDATE(6, 1000);
        SLEEP(1000);

        LookUp.RESET();
        LookUp.SETRANGE("LookupType Name", Text1007Txt);
        if LookUp.FINDFIRST() then
            repeat
                LookUp."Payroll Prod. Posting Group" := LookUp."Lookup Name";
                if LookUp."Lookup Name" = Text1096Txt then begin
                    LookUp."Applicable for OT" := true;
                    LookUp.ESI := LookUp.ESI::"Regular Element";
                    LookUp.PF := true;
                    LookUp.PT := true;
                end;
                LookUp.MODIFY();
            until LookUp.NEXT() = 0;


        Window.UPDATE(6, 2000);
        SLEEP(1000);

        PayYear.RESET();
        PayYear.INIT();
        PayYear."Year Type" := Text1097Txt;
        PayYear."Year Start Date" := DMY2DATE(1, 4, 2012);
        PayYear."Year End Date" := DMY2DATE(30, 9, 2012);
        PayYear.Closed := false;
        PayYear.INSERT();
        PayYear.RESET();
        PayYear.INIT();
        PayYear."Year Type" := Text1097Txt;
        PayYear."Year Start Date" := DMY2DATE(1, 4, 2012);
        PayYear."Year End Date" := DMY2DATE(31, 3, 13);
        PayYear.Closed := false;
        PayYear.INSERT();

        Window.UPDATE(6, 4000);
        SLEEP(1000);

        PayYear.RESET();
        PayYear.INIT();
        PayYear."Year Type" := Text1098Txt;
        PayYear."Year Start Date" := DMY2DATE(1, 4, 2012);
        PayYear."Year End Date" := DMY2DATE(31, 3, 13);
        PayYear.Closed := false;
        PayYear.INSERT();
        PayYear.RESET();
        PayYear.INIT();
        PayYear."Year Type" := Text1099Txt;
        PayYear."Year Start Date" := DMY2DATE(1, 1, 2012);
        PayYear."Year End Date" := DMY2DATE(31, 12, 2012);
        PayYear.Closed := false;
        PayYear.INSERT();

        PayYear.RESET();
        PayYear.INIT();
        PayYear."Year Type" := Text10100Txt;
        PayYear."Year Start Date" := DMY2DATE(1, 3, 2012);
        PayYear."Year End Date" := DMY2DATE(28, 2, 2013);
        PayYear.Closed := false;
        PayYear.INSERT();

        Window.UPDATE(6, 6000);
        SLEEP(1000);


        Window.UPDATE(5, 8000);
        SLEEP(1000);


        I := 1000;
        J := 10;
        LookUp.RESET();
        LookUp.SETRANGE("LookupType Name", Text083Txt);
        if LookUp.FINDFIRST() then
            repeat
                PayYear.RESET();
                PayYear.SETRANGE("Year Type", Text1099Txt);
                PayYear.SETRANGE(Closed, false);
                if PayYear.FINDFIRST() then;
                CadrePayElement.INIT();
                CadrePayElement."Pay Cadre Code" := LookUp."Lookup Name";
                CadrePayElement."Effective Start Date" := PayYear."Year Start Date";
                CadrePayElement.VALIDATE("Pay Element Code", Text1096Txt);
                CadrePayElement."Amount / Percent" := 12000 + I;
                CadrePayElement.INSERT();
                I += 1000;
                CadrePayElement.INIT();
                CadrePayElement."Pay Cadre Code" := LookUp."Lookup Name";
                CadrePayElement."Effective Start Date" := PayYear."Year Start Date";
                CadrePayElement.VALIDATE("Pay Element Code", Text10101Txt);
                CadrePayElement."Fixed/Percent" := CadrePayElement."Fixed/Percent"::Percent;
                CadrePayElement."Amount / Percent" := 12 + J;
                CadrePayElement."Computation Type" := Text10102Txt;
                CadrePayElement.INSERT();
                J += 2;
                CadrePayElement.INIT();
                CadrePayElement."Pay Cadre Code" := LookUp."Lookup Name";
                CadrePayElement."Effective Start Date" := PayYear."Year Start Date";
                CadrePayElement.VALIDATE("Pay Element Code", Text10103Txt);
                CadrePayElement."Fixed/Percent" := CadrePayElement."Fixed/Percent"::Fixed;
                CadrePayElement."Amount / Percent" := 12000 + I;
                CadrePayElement."Computation Type" := Text10104Txt;
                CadrePayElement.INSERT();
                I += 1000;
            until LookUp.NEXT() = 0;

        Window.UPDATE(6, 10000);
        SLEEP(1000);


        Window.UPDATE(5, 9000);
        SLEEP(1000);
    end;

    procedure CheckForNoSeries(NoSeriesCodePar: Code[20]; NoSeriesDescPar: Text[50]; NoSeriesStartPar: Code[20]);
    var
        NoSeries: Record "No. Series";
        NoSeriesLRec: Record "No. Series";
        NoSeriesLineLRec: Record "No. Series Line";
        NoSeriesCodeLoc: Code[20];
        NoSeriesDescLoc: Text[50];
        NoSeriesStartLoc: Code[20];

    begin
        Window.UPDATE(2, 600);
        SLEEP(1000);

        CLEAR(NoSeriesCodeLoc);
        CLEAR(NoSeriesDescLoc);
        CLEAR(NoSeriesStartLoc);

        NoSeriesCodeLoc := NoSeriesCodePar;
        NoSeriesDescLoc := NoSeriesDescPar;
        NoSeriesStartLoc := NoSeriesStartPar;

        Window.UPDATE(2, 2000);
        SLEEP(1000);

        NoSeries.RESET();
        NoSeries.SETRANGE(Code, NoSeriesCodeLoc);
        if NoSeries.IsEmpty() then begin
            NoSeriesLRec.INIT();
            NoSeriesLRec.Code := NoSeriesCodeLoc;
            NoSeriesLRec.Description := NoSeriesDescLoc;
            NoSeriesLRec."Default Nos." := true;
            if NoSeriesLRec.INSERT() then begin
                NoSeriesLine.INIT();
                NoSeriesLine."Series Code" := NoSeriesCodeLoc;
                NoSeriesLine."Line No." := 10000;
                NoSeriesLine."Starting Date" := DMY2DATE(1, 1, 2012);
                NoSeriesLine."Starting No." := NoSeriesStartLoc;
                NoSeriesLine."Increment-by No." := 1;
                NoSeriesLine.INSERT();
            end;
            Window.UPDATE(2, 4000);
            SLEEP(1000);
        end else begin
            NoSeriesLine.RESET();
            NoSeriesLine.SETRANGE("Series Code", NoSeriesCodeLoc);
            if not NoSeriesLine.IsEmpty() then begin
                NoSeriesLineLRec.INIT();
                NoSeriesLineLRec."Series Code" := NoSeriesCodeLoc;
                NoSeriesLineLRec."Line No." := 10000;
                NoSeriesLineLRec."Starting Date" := DMY2DATE(1, 1, 2012);
                NoSeriesLineLRec."Starting No." := NoSeriesStartLoc;
                NoSeriesLineLRec."Increment-by No." := 1;
                NoSeriesLineLRec.INSERT();
                Window.UPDATE(2, 6000);
                SLEEP(1000);
            end else begin
                if NoSeriesLine."Starting Date" <> 0D then
                    if not (NoSeriesLine."Starting Date" < DMY2DATE(1, 1, 2012)) then begin
                        NoSeriesLine."Starting Date" := DMY2DATE(1, 1, 2012);
                        NoSeriesLine.MODIFY();
                    end;

                if NoSeriesLine."Starting No." = '' then begin
                    NoSeriesLine."Starting No." := NoSeriesStartLoc;
                    NoSeriesLine."Increment-by No." := 1;
                    NoSeriesLine.MODIFY();
                end;
                Window.UPDATE(2, 8000);
                SLEEP(1000);
                if NoSeriesLine."Increment-by No." = 0 then begin
                    NoSeriesLine."Increment-by No." := 1;
                    NoSeriesLine.MODIFY();
                end;
            end;
        end;
        Window.UPDATE(2, 10000);
        SLEEP(1000);
    end;

    procedure GetPayrollLocation(var LocationCode: Code[20]);
    var

    begin
        PayrollLocation.RESET();
        PayrollLocation.SETRANGE("Location Incharge", USERID());
        if PayrollLocation.FINDFIRST() then
            LocationCode := PayrollLocation."Location Code";
    end;
}

