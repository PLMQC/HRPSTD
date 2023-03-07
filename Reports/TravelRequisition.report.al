report 33001357 "Travel Requisition B2B"
{
    // version B2BHR1.00.00

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Travel Requisition.rdlc';
    Caption = 'Travel Requisition';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Travel Requisition"; "Travel Requisition B2B")
        {
            column(TravelReqFormCaption; TravelReqFormCaptionLbl)
            {
            }
            column(FromMrCaption; FromMrCaptionLbl)
            {
            }
            column(ToMrCaption; ToMrCaptionLbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(RequisitionDateCaption; RequisitionDateCaptionLbl)
            {
            }
            column(TravellingFromCaption; TravellingFromCaptionLbl)
            {
            }
            column(FromCaption; FromCaptionLbl)
            {
            }
            column(DateofTravelCaption; DateofTravelCaptionLbl)
            {
            }
            column(DateandTimeCaption; DateandTimeCaptionLbl)
            {
            }
            column(ModeofTransportCaption; ModeofTransportCaptionLbl)
            {
            }
            column(BoardingatEmptyCaption; BoardingatEmptyCaptionLbl)
            {
            }
            column(TravellingPersonDetailsCaption; TravellingPersonDetailsCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(DesignationCaption; DesignationCaptionLbl)
            {
            }
            column(AgeCaption; AgeCaptionLbl)
            {
            }
            column(SexCaption; SexCaptionLbl)
            {
            }
            column(BoardingatCaption; BoardingatCaptionLbl)
            {
            }
            column(DestinationCaption; DestinationCaptionLbl)
            {
            }
            column(ProjectNameandPlaceCaption; ProjectNameandPlaceCaptionLbl)
            {
            }
            column(ComponentsCaption; ComponentsCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(AuthorisedByCaption; AuthorisedByCaptionLbl)
            {
            }
            column(VerifiedByCaption; VerifiedByCaptionLbl)
            {
            }
            column(SignedbyFinanceHeadCaption; SignedbyFinanceHeadCaptionLbl)
            {
            }
            column(DeptHeadCaption; DeptHeadCaptionLbl)
            {
            }
            column(HRManagerCaption; HRManagerCaptionLbl)
            {
            }
            column(IncaseofflightfinalapprovedbyCaption; IncaseofflightfinalapprovedbyCaptionLbl)
            {
            }
            column(ReceivedByCaption; ReceivedByCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(TimeCaption; TimeCaptionLbl)
            {
            }
            column(TimeEmptyCaption; TimeEmptyCaptionLbl)
            {
            }
            column(REQUESTOFTOURADVANCECaption; REQUESTOFTOURADVANCECaptionLbl)
            {
            }
            column(ToCaption; ToCaptionLbl)
            {
            }
            column(FinanceDepartmentCaption; FinanceDepartmentCaptionLbl)
            {
            }
            column(ICaption; ICaptionLbl)
            {
            }
            column(requestCaption; requestCaptionLbl)
            {
            }
            column(youtosanctionanadvanceofRsCaption; youtosanctionanadvanceofRsCaptionLbl)
            {
            }
            column(forthetourofCaption; forthetourofCaptionLbl)
            {
            }
            column(daysCaption; daysCaptionLbl)
            {
            }
            column(KindlyarrangebydateCaption; KindlyarrangebydateCaptionLbl)
            {
            }
            column(toEmptyCaption; toEmptyCaptionLbl)
            {
            }
            column(itwillbesettledbymeaftermyreturnfromCaption; itwillbesettledbymeaftermyreturnfromCaptionLbl)
            {
            }
            column(thetourWithin3daysafterreturnCaption; thetourWithin3daysafterreturnCaptionLbl)
            {
            }
            column(RequestedByCaption; RequestedByCaptionLbl)
            {
            }
            column(timeSCaption; timeSCaptionLbl)
            {
            }
            column(CoachTypeCaption; CoachTypeCaptionLbl)
            {
            }
            column(EmployeeNo_TravelRequisition; "Employee No.")
            {
            }
            column(EmployeeName_TravelRequisition; "Employee Name")
            {
            }
            column(Designation_TravelRequisition; Designation)
            {
            }
            column(Age_TravelRequisition; Age)
            {
            }
            column(Gender_TravelRequisition; Gender)
            {
            }
            column(Boardingat_TravelRequisition; "Boarding at")
            {
            }
            column(Destination_TravelRequisition; Destination)
            {
            }
            column(ModeofTravel_TravelRequisition; "Mode of Travel")
            {
            }
            column(TravelToDate_TravelRequisition; "Travel To Date")
            {
            }
            column(TravelRequisitionDate_TravelRequisition; "Travel Requisition Date")
            {
            }
            column(TravelFrom_TravelRequisition; "Travel From")
            {
            }
            column(TravelFromDate_TravelRequisition; "Travel From Date")
            {
            }
            column(TravelTo_TravelRequisition; "Travel To")
            {
            }
            column(CustomerName_TravelRequisition; "Customer Name")
            {
            }
            column(TotdaysGVar; TotdaysGVar)
            {
            }
            column(CoachType_TravelRequisition; "Coach Type")
            {
            }
            column(CustomerName2_TravelRequisition; "Customer Name 2")
            {
            }
            column(ProjectnamenewGvar; ProjectnamenewGvar)
            {
            }
            dataitem("Travel Requisition Line"; "Travel Requisition Line B2B")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
                column(ComponentType_TravelRequisitionLine; "Component Type")
                {
                }
                column(Description_TravelRequisitionLine; Description)
                {
                }
                column(Quantity_TravelRequisitionLine; Quantity)
                {
                }
                column(Amount_TravelRequisitionLine; Amount)
                {
                }
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(TotdaysGVar);
                CLEAR(ProjectnamenewGvar);
                TotdaysGVar := ("Travel To Date" - "Travel From Date");
                ProjectnameGvar := ("Customer Name" + "Customer Name 2");
                ProjectnamenewGvar := CONVERTSTR(ProjectnameGvar, '|', ',');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }



    var
        TravelReqFormCaptionLbl: Label 'Travel Requisition Form';
        FromMrCaptionLbl: Label 'From: Mr./Ms';
        ToMrCaptionLbl: Label 'To: Mr./Ms';
        DepartmentCaptionLbl: Label 'Department';
        RequisitionDateCaptionLbl: Label 'Requisition Date:';
        TravellingFromCaptionLbl: Label 'Travelling From:';
        FromCaptionLbl: Label 'From:';
        DateofTravelCaptionLbl: Label 'Date of Travel:';
        DateandTimeCaptionLbl: Label 'Date and Time';
        ModeofTransportCaptionLbl: Label 'Mode of Transport:';
        BoardingatEmptyCaptionLbl: Label 'Boarding at:';
        TravellingPersonDetailsCaptionLbl: Label 'Travelling Person(s) Details';
        NameCaptionLbl: Label 'Name';
        DesignationCaptionLbl: Label 'Designation';
        AgeCaptionLbl: Label 'Age';
        SexCaptionLbl: Label 'Sex';
        BoardingatCaptionLbl: Label 'Boarding at';
        DestinationCaptionLbl: Label 'Destination';
        ProjectNameandPlaceCaptionLbl: Label 'Project Name and Place:';
        ComponentsCaptionLbl: Label 'Components';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        AmountCaptionLbl: Label 'Amount';
        AuthorisedByCaptionLbl: Label 'Authorised By';
        VerifiedByCaptionLbl: Label 'Verified By';
        SignedbyFinanceHeadCaptionLbl: Label 'Signed by Finance Head';
        DeptHeadCaptionLbl: Label 'Dept. Head';
        HRManagerCaptionLbl: Label 'HR Manager';
        IncaseofflightfinalapprovedbyCaptionLbl: Label '(In case of flight final approved by MD)';
        ReceivedByCaptionLbl: Label 'Received By';
        DateCaptionLbl: Label 'Date';
        TimeCaptionLbl: Label 'Time';
        TimeEmptyCaptionLbl: Label 'Time:';
        REQUESTOFTOURADVANCECaptionLbl: Label 'REQUEST OF TOUR ADVANCE';
        ToCaptionLbl: Label 'To';
        FinanceDepartmentCaptionLbl: Label 'Finance Department';
        ICaptionLbl: Label 'I';
        requestCaptionLbl: Label 'request';
        youtosanctionanadvanceofRsCaptionLbl: Label 'you to sanction an advance of Rs.';
        forthetourofCaptionLbl: Label 'for the tour of';
        daysCaptionLbl: Label 'days';
        KindlyarrangebydateCaptionLbl: Label 'Kindly arrange by date';
        toEmptyCaptionLbl: Label 'to:';
        itwillbesettledbymeaftermyreturnfromCaptionLbl: Label 'it will be settled by me after my return from';
        thetourWithin3daysafterreturnCaptionLbl: Label 'the tour(Within 3 days after return)';
        RequestedByCaptionLbl: Label 'Requested By';
        timeSCaptionLbl: Label 'time';
        TotdaysGVar: Integer;
        CoachTypeCaptionLbl: Label 'Coach Type:';
        ProjectnameGvar: Text;
        ProjectnamenewGvar: Text;
}

