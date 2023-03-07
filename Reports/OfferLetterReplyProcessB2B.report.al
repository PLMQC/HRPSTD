report 33001361 "Offer Letter Reply Process B2B"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    /*
    dataset
    {
        dataitem(DataItemName; SourceTableName)
        {
            column(ColumnName; SourceFieldName)
            {
                
            }
        }
    }*/

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Offer Letter Reply"; OfferLetterReplyGVar)
                    {
                        OptionCaption = ',Accepted,Rejected,Call Back';
                        ApplicationArea = All;
                        ToolTip = 'Specifies The Offer letter';
                    }
                }
            }
        }

        actions
        {

        }
    }
    trigger OnPreReport();
    begin
        if OfferLetterReplyGVar = OfferLetterReplyGVar::" " then
            Error(Text001Txt);
        RecruitmentLine."Offer Letter Reply" := OfferLetterReplyGVar;
        RecruitmentLine.Modify();
    end;

    procedure SetValues(RecruitLinePar: record "Recruitment Line B2B");
    begin
        RecruitmentLine := RecruitLinePar;
    end;

    var
        RecruitmentLine: Record "Recruitment Line B2B";
        OfferLetterReplyGVar: Option " ",Accepted,Rejected,"Call Back";
        Text001Txt: label 'Select any one option';


}