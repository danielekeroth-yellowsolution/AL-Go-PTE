namespace YellowSolution.Y365Base.Log;


/// <summary>
/// Log Entries
/// </summary>
table 54750 "YelBas Log Entry"
{
    DataClassification = SystemMetadata;
    Caption = 'Yellow Log Entry';
    LookupPageId = "YelBas Log Entries";
    DrillDownPageId = "YelBas Log Entry Card";

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            ToolTip = 'Test tooltip.';
        }
        field(2; Date; DateTime)
        {
            Caption = 'Date';
        }
        field(3; Type; Enum "YelBas Log Type")
        {
            Caption = 'Type';
        }
        field(4; Message; Text[250])
        {
            Caption = 'Message';
        }
        field(5; Data; Blob)
        {
            Caption = 'Data';
        }
        field(6; Extension; Text[40])
        {
            Caption = 'Extension';
        }
        field(7; Function; Text[100])
        {
            Caption = 'Function';
        }
        field(8; "Source Id 1"; Text[40])
        {
            Caption = 'Source Id 1';
        }
        field(9; "Source Id 2"; Text[40])
        {
            Caption = 'Source Id 2';
        }
        field(10; "Json Data"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Json Data';
        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        SetDefaultDate();
    end;

    local procedure SetDefaultDate()
    begin
        if Date = 0DT then
            Date := CurrentDateTime;
    end;
}