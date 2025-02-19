namespace YellowSolution.Y365Base.Log;

/// <summary>
/// Log Entries
/// </summary>
page 54750 "YelBas Log Entries"
{
    ApplicationArea = All;
    Caption = 'Yellow Log';
    PageType = List;
    CardPageId = "YelBas Log Entry Card";
    SourceTable = "YelBas Log Entry";
    UsageCategory = Administration;
    Editable = false;
    SourceTableView = sorting("Entry No") order(descending);
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Message; Rec.Message)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Message field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Extension field.';
                }
                field("Function"; Rec."Function")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Function field.';
                }
                field("Source Id 1"; Rec."Source Id 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Id 1 field.';
                }
                field("Source Id 2"; Rec."Source Id 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Id 2 field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ClearLog)
            {
                ApplicationArea = All;
                Caption = 'Clear Log';
                ToolTip = 'Clear all records in the log';
                Image = ClearLog;

                trigger OnAction()
                var
                    ClearLog: Codeunit "YelBas Clear Log";
                begin
                    ClearLog.Clear();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetJsonViewerData();
    end;

    /// <summary>
    /// Reads the data in "Json Data" field and formats it for display in the json viewer factbox.
    /// </summary>
    local procedure SetJsonViewerData()
    var
        lIStreamRequest: InStream;
    begin
        Rec.CalcFields("Json Data");
        Rec."Json Data".CreateInStream(lIStreamRequest);
    end;
}