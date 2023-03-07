pageextension 33001583 "DefaultDimMultipleExt B2B" extends "Default Dimensions-Multiple"
{
    // version NAVW111.00,B2BHR1.00.00

    local procedure "-----B2BHR1.00.00-----"();
    begin
    end;

    procedure SetMultiEmployeeB2B(var EmployeeB2B: Record "Employee B2B");
    var
        TempDefaultDim2: Record "Default Dimension";
    begin

        TempDefaultDim2.DELETEALL();
        with EmployeeB2B do
            if FINDFIRST() then
                repeat
                    CopyDefaultDimToDefaultDim(DATABASE::"Employee B2B", "No.");
                until NEXT() = 0;
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

