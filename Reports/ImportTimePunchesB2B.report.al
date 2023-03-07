report 33001284 "Import Time Punches B2B"
{
    // version B2BHR1.00.00

    Caption = 'Import Time Punches From Excel';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(DTP; "Daily Time Punches B2B")
        {
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    group("Import from")
                    {
                        Caption = 'Import from';
                        field(FileName; FileNameGVar)
                        {
                            ToolTip = 'Choose the File to import.';
                            Caption = 'Workbook File Name';
                            Editable = false;
                            ApplicationArea = all;

                            trigger OnAssistEdit();
                            begin
                                RequestFile();
                                //SheetNameGVar := ExcelBuf.SelectSheetsName(ServerFileName); //SG
                                SheetNameGVar := ExcelBuf.SelectSheetsNameStream(NavInstream)
                            end;

                            trigger OnValidate();
                            begin
                                FileNameOnAfterValidate();
                            end;
                        }
                        field(SheetName; SheetNameGVar)
                        {
                            ToolTip = 'Choose the Worksheet Name.';
                            Caption = 'Worksheet Name';
                            Editable = false;
                            ApplicationArea = all;

                            trigger OnAssistEdit();
                            begin
                                if ServerFileName = '' then
                                    RequestFile();

                                //SheetNameGVar := ExcelBuf.SelectSheetsName(ServerFileName); //SG
                                SheetNameGVar := ExcelBuf.SelectSheetsNameStream(NavInstream)
                            end;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            FileNameGVar := '';
            SheetNameGVar := '';
            Description := Text005Txt + FORMAT(WORKDATE());
        end;

        trigger OnQueryClosePage(CloseAction: Action): Boolean;
        begin
            if CloseAction = ACTION::OK then
                ValidateServerFileName();
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        ExcelBuf.DELETEALL();
    end;

    trigger OnPreReport();
    var

    begin
        ExcelBuf.LOCKTABLE();
        ExcelBuf.DELETEALL();
        //ExcelBuf.OpenBook(ServerFileName, SheetNameGVar); //SG
        ExcelBuf.OpenBookStream(NavInstream, SheetNameGVar);


        ExcelBuf.ReadSheet();

        AnalyzeData();
    end;

    var
        ExcelBuf: Record "Excel Buffer";
        ExcelBuf2: Record "Excel Buffer";
        DailyTimePunches: Record "Daily Time Punches B2B";
        FileMgt: Codeunit "File Management";
        NavInstream: InStream;
        Text005Txt: Label '"Imported from Excel "';
        Text007Txt: Label 'Analyzing Data...\\';
        FileNameGVar: Text;
        ServerFileName: Text;
        SheetNameGVar: Text[250];
        TotalRecNo: Integer;
        RecNo: Integer;
        Window: Dialog;
        Description: Text[50];
        Text029Txt: Label 'You must enter a file name.';

        TimeINVar: Time;
        TimeOutVar: Time;
        LineNoVar: Integer;
        Text030Txt: Label 'No Data is Imported';
        Text008Txt: Label '@1@@@@@@@@@@@@@@@@@@@@@@@@@\';
        Text0000Txt: Label 'A';
        Text00001Txt: Label 'B';
        Text00002Txt: Label 'C';
        Text00003Txt: Label 'D';
        Text00004Txt: Label 'E';


    local procedure AnalyzeData();
    var
        HeaderRowNo: Integer;
        TotalRowsImported: Integer;
        I: Integer;
    begin
        LineNoVar := 10000;
        Window.OPEN(Text007Txt + Text008Txt);
        Window.UPDATE(1, 0);
        TotalRecNo := ExcelBuf.COUNT();
        RecNo := 0;
        HeaderRowNo := 1;
        ExcelBuf.RESET();
        if ExcelBuf.FINDLAST() then
            TotalRowsImported := ExcelBuf."Row No."
        else
            ERROR(Text030Txt);
        for I := 2 to TotalRowsImported do begin
            ExcelBuf.RESET();
            ExcelBuf.SETRANGE("Row No.", I);
            if ExcelBuf.FINDFIRST() then
                repeat
                    RecNo := RecNo + 1;
                    Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                    if ExcelBuf.xlColID = Text0000Txt then begin
                        DailyTimePunches.INIT();
                        DailyTimePunches.VALIDATE("Employee No.", ExcelBuf."Cell Value as Text");
                    end;
                    if ExcelBuf.xlColID = Text00001Txt then
                        EVALUATE(DailyTimePunches.Date, ExcelBuf."Cell Value as Text");
                    if (DailyTimePunches."Employee No." <> '') and (DailyTimePunches.Date <> 0D) then begin
                        ExcelBuf2.RESET();
                        ExcelBuf2.SETRANGE("Row No.", I);
                        ExcelBuf2.SETRANGE(xlColID, Text00002Txt);
                        if ExcelBuf2.FINDFIRST() then begin
                            EVALUATE(TimeINVar, FORMAT(ExcelBuf2."Cell Value as Text"));
                            DailyTimePunches."Time IN" := TimeINVar;
                        end;
                        ExcelBuf2.RESET();
                        ExcelBuf2.SETRANGE("Row No.", I);
                        ExcelBuf2.SETRANGE(xlColID, Text00003Txt);
                        if ExcelBuf2.FINDFIRST() then begin
                            EVALUATE(TimeOutVar, FORMAT(ExcelBuf2."Cell Value as Text"));
                            DailyTimePunches."Time Out" := TimeOutVar;
                        end;
                        ExcelBuf2.RESET();
                        ExcelBuf2.SETRANGE("Row No.", I);
                        ExcelBuf2.SETRANGE(xlColID, Text00004Txt);
                        if ExcelBuf2.FINDFIRST() then
                            EVALUATE(DailyTimePunches."Shift Worked", ExcelBuf2."Cell Value as Text");

                        DailyTimePunches."Line No." := LineNoVar;
                        if DailyTimePunches.INSERT() then begin
                            CLEAR(DailyTimePunches."Employee No.");
                            CLEAR(DailyTimePunches.Date);
                            LineNoVar += 10000;
                        end;
                    end;
                until ExcelBuf.NEXT() = 0;

        end;
        Window.CLOSE();
    end;

    procedure RequestFile();
    var
        DialogCaptionLbl: Label 'Select File to upload';
    begin
        if FileNameGVar <> '' then
            //ServerFileName := FileMgt.UploadFile(Text006Txt, FileNameGVar) //SG
            UploadIntoStream(FileNameGVar, '', '', FileNameGVar, NavInstream)
        else
            //ServerFileName := FileMgt.UploadFile(Text006Txt, Text00005Txt);
            UploadIntoStream(FileNameGVar, '', '', FileNameGVar, NavInstream);


        if FileNameGVar <> '' then
            FileNameGVar := FileMgt.GetFileName(FileNameGVar);
        ServerFileName := FileNameGVar;
        ValidateServerFileName();

    end;

    local procedure FileNameOnAfterValidate();
    begin
        RequestFile();
    end;

    local procedure ValidateServerFileName();
    begin
        if ServerFileName = '' then begin
            FileNameGVar := '';
            SheetNameGVar := '';
            ERROR(Text029Txt);
        end;
    end;
}

