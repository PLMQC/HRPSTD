table 33001363 "Payroll Location Users B2B"
{
    // version B2BHR1.00.00

    Caption = 'Payroll Location Users';
    DrillDownPageID = "Payroll Location User List B2B";
    LookupPageID = "Payroll Location User List B2B";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = true;
            DataClassification = CustomerContent;
            trigger OnLookup();
            var
                User: Record User;
            begin
                "User ID" := LoginMgt.OpenUserPageForSelectedUser(User);
            end;
        }
        field(2; Name; Text[65])
        {
            Caption = 'Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Payroll Locations B2B"."Location Code";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if xRec."Location Code" <> "Location Code" then
                    if xRec."Location Code" <> '' then begin
                        PayrollLocGRec.RESET();
                        PayrollLocGRec.GET(xRec."Location Code");
                        if LOWERCASE(USERID()) <> LOWERCASE(PayrollLocGRec."Location Incharge") then
                            ERROR(Text002Lbl, PayrollLocGRec."Location Incharge");
                    end;

            end;
        }
        field(4; "Multiple Locations"; Code[250])
        {
            Caption = 'Multiple Locations';
            DataClassification = CustomerContent;
            trigger OnLookup();
            begin
                PayrollLocGRec.RESET();
                PayrollLocGRec.SETRANGE("Location Incharge", USERID());
                if not PayrollLocGRec.FINDFIRST() then
                    ERROR(Text003Lbl, USERID());

                PayrollLocGRec.RESET();
                if PAGE.RUNMODAL(0, PayrollLocGRec) = ACTION::LookupOK then
                    if "Multiple Locations" <> '' then begin
                        if not (STRPOS("Multiple Locations", PayrollLocGRec."Location Code") > 0) then
                            "Multiple Locations" := copystr("Multiple Locations" + '|' + PayrollLocGRec."Location Code", 1, 250);
                    end else
                        "Multiple Locations" := PayrollLocGRec."Location Code";

            end;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        RestrictUnAuthorisedActs();
    end;

    trigger OnRename();
    begin
        ERROR(Text001Lbl);
    end;

    var
        PayrollLocGRec: Record "Payroll Locations B2B";
        LoginMgt: Codeunit "Payroll Branch wise Misc B2B";
        Text001Lbl: Label 'Un Authorised Activity';
        Text002Lbl: Label '%1 is authorised to perfom the activity', Comment = '%1 = Locationn Incharge';
        Text003Lbl: Label '%1 must be a Loction Incharge to any location to perform this activity', Comment = '%1 = UserId';

    procedure RestrictUnAuthorisedActs();
    begin
        if "Location Code" <> '' then begin
            PayrollLocGRec.RESET();
            PayrollLocGRec.GET("Location Code");
            if LOWERCASE(USERID()) <> LOWERCASE(PayrollLocGRec."Location Incharge") then
                ERROR(Text002Lbl, PayrollLocGRec."Location Incharge");
        end;
    end;
}

