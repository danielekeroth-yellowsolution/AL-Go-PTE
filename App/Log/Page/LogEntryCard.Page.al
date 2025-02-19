namespace YellowSolution.Y365Base.Log;

/// <summary>
/// Log Entry Card
/// </summary>
page 54751 "YelBas Log Entry Card"
{
    Caption = 'Log Card';
    Editable = false;
    PageType = Card;
    SourceTable = "YelBas Log Entry";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(EntryNo; Rec."Entry No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specific number series when the entry was created.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date and the time when this entry was created.';
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
                field(Message; Rec.Message)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the message of the log Entry';
                }
            }

            group(DataGroup)
            {
                Caption = 'Data';
                field(Data; GetLogData.GetDataAsText(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Data';
                    MultiLine = true;
                    ToolTip = 'Specifies the data of the log entry';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Download)
            {
                ApplicationArea = All;
                Caption = 'Download data';
                Image = Download;
                ToolTip = 'Download Log Entry data.';

                trigger OnAction()
                begin
                    DownloadDataFromLog.DownloadDataFromLog(Rec);
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

    var
        DownloadDataFromLog: Codeunit "YelBas DownloadDataFromLog";
        GetLogData: Codeunit "YelBas GetLogData";
}