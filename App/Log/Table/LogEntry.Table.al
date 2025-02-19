namespace YellowSolution.Y365Base.Log;

/// <summary>
/// Log Entries
/// </summary>
table 54750 "YelBas Log Entry"
{
    DataClassification = SystemMetadata;
    Caption = 'Yellow Log Entry';

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Caption = 'Entry No.';
            ToolTip = 'Test tooltip.';
        }
        field(2; Date; DateTime)
        {
            DataClassification = SystemMetadata;
            Caption = 'Date';
        }
        field(3; Type; Enum "YelBas Log Type")
        {
            DataClassification = SystemMetadata;
            Caption = 'Type';
        }
        field(4; Message; Text[250])
        {
            DataClassification = SystemMetadata;
            Caption = 'Message';
        }
        field(5; Data; Blob)
        {
            DataClassification = SystemMetadata;
            Caption = 'Data';
        }
        field(6; Extension; Text[40])
        {
            DataClassification = SystemMetadata;
            Caption = 'Extension';
        }
        field(7; Function; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Function';
        }
        field(8; "Source Id 1"; Text[40])
        {
            DataClassification = SystemMetadata;
            Caption = 'Source Id 1';
        }
        field(9; "Source Id 2"; Text[40])
        {
            DataClassification = SystemMetadata;
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