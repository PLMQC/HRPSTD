codeunit 33001191 "Lookup B2B"
{
    // version B2BHR1.00.00


    trigger OnRun();
    begin
        if LookupTypes.FINDFIRST() then
            ERROR(Text000Txt)
        else begin
            LookupTypes.INIT();
            LookupTypes."No." := 1;
            LookupTypes.Name := Text33001Txt;
            LookupTypes.Description := Text33001Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 2;
            LookupTypes.Name := Text33002Txt;
            LookupTypes.Description := Text33002Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 3;
            LookupTypes.Name := Text33003Txt;
            LookupTypes.Description := Text33003Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 4;
            LookupTypes.Name := Text33005Txt;
            LookupTypes.Description := Text33004Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 5;
            LookupTypes.Name := Text33006Txt;
            LookupTypes.Description := Text33006Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 6;
            LookupTypes.Name := Text33007Txt;
            LookupTypes.Description := Text33007Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 7;
            LookupTypes.Name := Text33008Txt;
            LookupTypes.Description := Text33008Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 8;
            LookupTypes.Name := Text33009Txt;
            LookupTypes.Description := Text33009Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 9;
            LookupTypes.Name := Text33010Txt;
            LookupTypes.Description := Text33010Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 10;
            LookupTypes.Name := Text33011Txt;
            LookupTypes.Description := Text33011Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 11;
            LookupTypes.Name := Text33012Txt;
            LookupTypes.Description := Text33012Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 12;
            LookupTypes.Name := Text33013Txt;
            LookupTypes.Description := Text33013Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 13;
            LookupTypes.Name := Text33014Txt;
            LookupTypes.Description := Text33014Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 14;
            LookupTypes.Name := Text33015Txt;
            LookupTypes.Description := Text33015Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 15;
            LookupTypes.Name := Text33016Txt;
            LookupTypes.Description := Text33016Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 16;
            LookupTypes.Name := Text33017Txt;
            LookupTypes.Description := Text33018Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 17;
            LookupTypes.Name := Text33019Txt;
            LookupTypes.Description := Text33020Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 18;
            LookupTypes.Name := Text33021Txt;
            LookupTypes.Description := Text33021Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 19;
            LookupTypes.Name := Text33022Txt;
            LookupTypes.Description := Text33022Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 20;
            LookupTypes.Name := Text33023Txt;
            LookupTypes.Description := Text33023Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 21;
            LookupTypes.Name := Text33024Txt;
            LookupTypes.Description := Text33024Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 22;
            LookupTypes.Name := Text33025Txt;
            LookupTypes.Description := Text33025Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 23;
            LookupTypes.Name := Text33026Txt;
            LookupTypes.Description := Text33026Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 24;
            LookupTypes.Name := Text33027Txt;
            LookupTypes.Description := Text33027Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 25;
            LookupTypes.Name := Text33028Txt;
            LookupTypes.Description := Text33029Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 26;
            LookupTypes.Name := Text33030Txt;
            LookupTypes.Description := Text33030Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();

            LookupTypes."No." := 27;
            LookupTypes.Name := Text33031Txt;
            LookupTypes.Description := Text33032Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();
            // CHB2BOCT202022<<
            LookupTypes.Init();
            LookupTypes."No." := 28;
            LookupTypes.Name := Text33065Txt;
            LookupTypes.Description := Text33068Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();
            // CHB2BOCT202022>>
            //CHB2BJAN52023<<

            LookupTypes.Init();
            LookupTypes."No." := 29;
            LookupTypes.Name := Text33066Txt;
            LookupTypes.Description := Text33069Txt;
            LookupTypes."System Defined" := true;
            LookupTypes.INSERT();
            //CHB2BJAN52023>>

            // LookupTypes."No." := 34;
            // LookupTypes.Name := Text33078Txt;
            // LookupTypes.Description := Text33078Txt;
            // LookupTypes."System Defined" := true;
            // LookupTypes.INSERT();

            // LookupTypes."No." := 35;
            // LookupTypes.Name := Text33079Txt;
            // LookupTypes.Description := Text33079Txt;
            // LookupTypes."System Defined" := true;
            // LookupTypes.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 16;
            Lookup_B2B."Lookup Type" := 16;
            Lookup_B2B."LookupType Name" := Text33017Txt;
            Lookup_B2B."Lookup Name" := Text33033Txt;
            Lookup_B2B.Description := Text33033Txt;
            Lookup_B2B."Add/Deduct" := Lookup_B2B."Add/Deduct"::Addition;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 16;
            Lookup_B2B."Lookup Type" := 16;
            Lookup_B2B."LookupType Name" := Text33017Txt;
            Lookup_B2B."Lookup Name" := Text33034Txt;
            Lookup_B2B.Description := Text33035Txt;
            Lookup_B2B."Add/Deduct" := Lookup_B2B."Add/Deduct"::Addition;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 16;
            Lookup_B2B."Lookup Type" := 16;
            Lookup_B2B."LookupType Name" := Text33017Txt;
            Lookup_B2B."Lookup Name" := Text33036Txt;
            Lookup_B2B.Description := Text33037Txt;
            Lookup_B2B."Add/Deduct" := Lookup_B2B."Add/Deduct"::Addition;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 16;
            Lookup_B2B."Lookup Type" := 16;
            Lookup_B2B."LookupType Name" := Text33017Txt;
            Lookup_B2B."Lookup Name" := Text33038Txt;
            Lookup_B2B.Description := Text33039Txt;
            Lookup_B2B."Add/Deduct" := Lookup_B2B."Add/Deduct"::Deduction;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();


            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 16;
            Lookup_B2B."Lookup Type" := 16;
            Lookup_B2B."LookupType Name" := Text33017Txt;
            Lookup_B2B."Lookup Name" := Text33040Txt;
            Lookup_B2B.Description := Text33041Txt;
            Lookup_B2B."Add/Deduct" := Lookup_B2B."Add/Deduct"::Deduction;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 16;
            Lookup_B2B."Lookup Type" := 16;
            Lookup_B2B."LookupType Name" := Text33017Txt;
            Lookup_B2B."Lookup Name" := Text33042Txt;
            Lookup_B2B.Description := Text33043Txt;
            Lookup_B2B."Add/Deduct" := Lookup_B2B."Add/Deduct"::Deduction;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 16;
            Lookup_B2B."Lookup Type" := 16;
            Lookup_B2B."LookupType Name" := Text33017Txt;
            Lookup_B2B."Lookup Name" := Text33044Txt;
            Lookup_B2B.Description := Text33045Txt;
            Lookup_B2B."Add/Deduct" := Lookup_B2B."Add/Deduct"::Deduction;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 16;
            Lookup_B2B."Lookup Type" := 16;
            Lookup_B2B."LookupType Name" := Text33017Txt;
            Lookup_B2B."Lookup Name" := Text33046Txt;
            Lookup_B2B.Description := Text33047Txt;
            Lookup_B2B."Add/Deduct" := Lookup_B2B."Add/Deduct"::Deduction;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 16;
            Lookup_B2B."Lookup Type" := 16;
            Lookup_B2B."LookupType Name" := Text33017Txt;
            Lookup_B2B."Lookup Name" := Text33048Txt;
            Lookup_B2B.Description := Text33049Txt;
            Lookup_B2B."Add/Deduct" := Lookup_B2B."Add/Deduct"::Addition;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 16;
            Lookup_B2B."Lookup Type" := 16;
            Lookup_B2B."LookupType Name" := Text33017Txt;
            Lookup_B2B."Lookup Name" := Text33050Txt;
            Lookup_B2B.Description := Text33050Txt;
            Lookup_B2B."Add/Deduct" := Lookup_B2B."Add/Deduct"::Addition;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 16;
            Lookup_B2B."Lookup Type" := 16;
            Lookup_B2B."LookupType Name" := Text33017Txt;
            Lookup_B2B."Lookup Name" := Text33051Txt;
            Lookup_B2B.Description := Text33051Txt;
            Lookup_B2B."Add/Deduct" := Lookup_B2B."Add/Deduct"::Addition;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 16;
            Lookup_B2B."Lookup Type" := 16;
            Lookup_B2B."LookupType Name" := Text33017Txt;
            Lookup_B2B."Lookup Name" := Text33052Txt;
            Lookup_B2B.Description := Text33052Txt;
            Lookup_B2B."Add/Deduct" := Lookup_B2B."Add/Deduct"::Addition;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 17;
            Lookup_B2B."Lookup Type" := 17;
            Lookup_B2B."LookupType Name" := Text33019Txt;
            Lookup_B2B."Lookup Name" := Text33053Txt;
            Lookup_B2B.Description := Text33053Txt;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 17;
            Lookup_B2B."Lookup Type" := 17;
            Lookup_B2B."LookupType Name" := Text33019Txt;
            Lookup_B2B."Lookup Name" := Text33054Txt;
            Lookup_B2B.Description := Text33054Txt;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 17;
            Lookup_B2B."Lookup Type" := 17;
            Lookup_B2B."LookupType Name" := Text33019Txt;
            Lookup_B2B."Lookup Name" := Text33055Txt;
            Lookup_B2B.Description := Text33055Txt;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 17;
            Lookup_B2B."Lookup Type" := 17;
            Lookup_B2B."LookupType Name" := Text33019Txt;
            Lookup_B2B."Lookup Name" := Text33056Txt;
            Lookup_B2B.Description := Text33056Txt;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 19;
            Lookup_B2B."Lookup Type" := 19;
            Lookup_B2B."LookupType Name" := Text33022Txt;
            Lookup_B2B."Lookup Name" := Text33057Txt;
            Lookup_B2B.Description := Text33058Txt;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 19;
            Lookup_B2B."Lookup Type" := 19;
            Lookup_B2B."LookupType Name" := Text33022Txt;
            Lookup_B2B."Lookup Name" := Text33059Txt;
            Lookup_B2B.Description := Text33060Txt;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 19;
            Lookup_B2B."Lookup Type" := 19;
            Lookup_B2B."LookupType Name" := Text33022Txt;
            Lookup_B2B."Lookup Name" := Text33061Txt;
            Lookup_B2B.Description := Text33061Txt;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();

            Lookup_B2B.Init();
            Lookup_B2B."Lookup Id" := 19;
            Lookup_B2B."Lookup Type" := 19;
            Lookup_B2B."LookupType Name" := Text33022Txt;
            Lookup_B2B."Lookup Name" := Text33062Txt;
            Lookup_B2B.Description := Text33062Txt;
            Lookup_B2B."System Defined" := true;
            Lookup_B2B.INSERT();





            MESSAGE(Text001Txt);
        end;
    end;

    var
        LookupTypes: Record "Lookup Type B2B";
        Lookup_B2B: Record Lookup_B2B;
        Text000Txt: Label 'Lookup Types are already defined';
        Text001Txt: Label 'Lookup records are inserted.';
        Text33001Txt: Label 'Skill Set';
        Text33002Txt: Label 'Qualification';
        Text33003Txt: Label 'Certification';
        Text33004Txt: Label 'Dept';
        Text33005Txt: Label 'DEPARTMENTS';
        Text33006Txt: Label 'Designations';
        Text33007Txt: Label 'Interview Types';
        Text33008Txt: Label 'Interview Status';
        Text33009Txt: Label 'Performance Appraisal';
        Text33010Txt: Label 'Performance Rating Scale';
        Text33011Txt: Label 'Type of Training';
        Text33012Txt: Label 'Need for Training';
        Text33013Txt: Label 'Staff Types';
        Text33014Txt: Label 'Status';
        Text33015Txt: Label 'Causes of Inactivity';
        Text33016Txt: Label 'Grounds of Termination';
        Text33017Txt: Label 'ADDITIONS AND DEDUCTIONS';
        Text33018Txt: Label 'Add & Ded';
        Text33019Txt: Label 'COMPUTATION TYPE';
        Text33020Txt: Label 'Computation';
        Text33021Txt: Label 'Loan Types';
        Text33022Txt: Label 'Payroll Years';
        Text33023Txt: Label 'Pay Cadre';
        Text33024Txt: Label 'Priority';
        Text33025Txt: Label 'Leave Pay Cadre';
        Text33026Txt: Label 'Physical Locations';
        Text33027Txt: Label 'Employee Status';
        Text33028Txt: Label 'CONFIDENTIAL';
        Text33029Txt: Label 'Confidential Information';
        Text33030Txt: Label 'Relatives';
        Text33031Txt: Label 'ARTICLE INFO';
        Text33032Txt: Label 'Article Information';
        Text33033Txt: Label 'Basic';
        Text33034Txt: Label 'DA';
        Text33035Txt: Label 'Dearness Allowance';
        Text33036Txt: Label 'HRA';
        Text33037Txt: Label 'House Rent Allowance';
        Text33038Txt: Label 'PF';
        Text33039Txt: Label 'Provident Fund';
        Text33040Txt: Label 'ESI';
        Text33041Txt: Label 'Employee State Insurence';
        Text33042Txt: Label 'PT';
        Text33043Txt: Label 'Professional Tax';
        Text33044Txt: Label 'TDS';
        Text33045Txt: Label 'Tax Deduction at Source';
        Text33046Txt: Label 'LOAN';
        Text33047Txt: Label 'Loans';
        Text33048Txt: Label 'OT';
        Text33049Txt: Label 'Over Time';
        Text33050Txt: Label 'Bonus';
        Text33051Txt: Label 'Ex-gratia';
        Text33052Txt: Label 'Gratuity';
        Text33053Txt: Label 'On Attendance';
        Text33054Txt: Label 'Non Attendance';
        Text33055Txt: Label 'After Basic';
        Text33056Txt: Label 'After Basic and DA';
        Text33057Txt: Label 'LEAVE YEAR';
        Text33058Txt: Label 'Leave Year Definition';
        Text33059Txt: Label 'FINANCIAL YEAR';
        Text33060Txt: Label 'Financial Year Definition';
        Text33061Txt: Label 'PF Year';
        Text33062Txt: Label 'ESI Year';
        // Text33078Txt: Label 'CHECK LIST';
        // Text33079Txt: Label 'TYPE OF INDUSTRY';

        // CHB2BOCT202022<<
        Text33065Txt: Label 'EXIT REASONCODE FOR PF';
        Text33068Txt: Label 'Exit reasoncode for pf';
        // CHB2BOCT202022>>
        //CHB2BJAN52023<<
        Text33066Txt: Label 'EXIT REASONCODE FOR ESI';
        Text33069Txt: Label 'exit reasoncode for esi';

    //CHB2BJAN52023>>








}

