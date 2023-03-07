// page 33001238 "Leave Application List OLD B2B"
// {
//     // version B2BHR1.00.00

//     Caption = 'Leave Application List OLD';
//     CardPageID = "Leave Application - san B2B";
//     DelayedInsert = true;
//     PageType = List;
//     SourceTable = "Leave Application B2B";
//     UsageCategory = Lists;
//     ApplicationArea = all;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1102152000)
//             {
//                 field("Employee No."; "Employee No.")
//                 {
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Employe no';
//                 }
//                 field("Leave Code"; "Leave Code")
//                 {
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Leave Code';
//                 }
//                 field("Leave Duration"; "Leave Duration")
//                 {
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Leave Duration';
//                 }
//                 field("From Date"; "From Date")
//                 {
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the From date';
//                 }
//                 field("To Date"; "To Date")
//                 {
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the To Date';
//                 }
//                 field("No.of Days"; "No.of Days")
//                 {
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the no of days';
//                 }
//                 field("Reason for Leave"; "Reason for Leave")
//                 {
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Reason for leave';
//                 }
//                 field(Status; Status)
//                 {
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Status';
//                     trigger OnValidate();
//                     begin

//                     end;
//                 }
//                 field(Sanctioned; Sanctioned)
//                 {

//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Sanctioned';
//                 }
//                 field("Leaves avail.curr.Month"; "Leaves avail.curr.Month")
//                 {
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Leave avail current month';
//                 }
//                 field("Sanctioning Incharge"; "Sanctioning Incharge")
//                 {

//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Sanctioned incharge';
//                 }
//                 field("Date of Sanction"; "Date of Sanction")
//                 {

//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Date of sanction';
//                 }
//                 field("Date of Cancellation"; "Date of Cancellation")
//                 {
//                     ApplicationArea = all;
//                     ToolTip = 'Specifies the Date of cancellation';
//                 }
//             }

//         }

//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = Action;
//                 // action("Update &Leaves")
//                 // {
//                 //     Caption = 'Update &Leaves';
//                 //     Image = Absence;
//                 //     Promoted = true;
//                 //     PromotedOnly = true;
//                 //     PromotedCategory = Process;
//                 //     PromotedIsBig = true;
//                 //     ApplicationArea = all;
//                 //     ToolTip = 'Specifies the Update'
//                 //     
//                 //     begin
//                 //         UpdateAbsent();
//                 //     LeaveConvertion();
//             }

//         }
//     }
// }

//     // trigger OnInit();
//     // begin
//     //     "Date of SanctionEditable" := true;
//     //     "Sanctioning InchargeEditable" := true;
//     //     SanctionedEditable := true;
//     // end;



// }

