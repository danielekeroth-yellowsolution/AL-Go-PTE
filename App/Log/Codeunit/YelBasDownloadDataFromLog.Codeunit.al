namespace YellowSolution.Y365Base.Log;

using System.Utilities;

/// <summary> 
/// Download data from log
/// </summary>
codeunit 54754 "YelBas DownloadDataFromLog"
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="LogEntry"></param>
    procedure DownloadDataFromLog(LogEntry: Record "YelBas Log Entry")
    var
        IsHandled: Boolean;
    begin
        OnBeforeDownloadDataFromLog(LogEntry, IsHandled);
        DoDownloadDataFromLogEntry(LogEntry, IsHandled);
        OnAfterDownloadDataFromLog(LogEntry);
    end;

    /// <summary>
    /// 
    /// </summary>
    /// <param name="LogEntry"></param>
    /// <param name="IsHandled"></param>
    procedure DoDownloadDataFromLogEntry(var LogEntry: Record "YelBas Log Entry"; IsHandled: Boolean)
    var
        TempBlob: Codeunit "Temp Blob";
        GetLogData: Codeunit "YelBas GetLogData";
        InStream: InStream;
        TitleLbl: Label 'Download log data file';
        OutStream: OutStream;
        ToFile: Text;
    begin
        if IsHandled then
            exit;

        TempBlob.CreateInStream(InStream, TextEncoding::UTF8);
        TempBlob.CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.Write(GetLogData.GetDataAsText(LogEntry));
        ToFile := 'LogEntry_' + Format(LogEntry."Entry No") + '.txt';
        DownloadFromStream(InStream, TitleLbl, '', '(*.*)|*.*', ToFile);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDownloadDataFromLog(var LogEntry: Record "YelBas Log Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDownloadDataFromLog(var LogEntry: Record "YelBas Log Entry")
    begin
    end;

}