namespace YellowSolution.Y365Base.Log;

using System.Utilities;

/// <summary> 
/// Download data from log
/// </summary>
codeunit 54754 "YelBas DownloadDataFromLog"
{
    /// <summary> 
    /// Download Log Entry data as file
    /// </summary>
    procedure DownloadDataFromLog(LogEntry: Record "YelBas Log Entry")
    var
        IsHandled: Boolean;
    begin
        OnBeforeDownloadDataFromLog(LogEntry, IsHandled);
        DoDownloadDataFromLogEntry(LogEntry, IsHandled);
        OnAfterDownloadDataFromLog(LogEntry);
    end;

    /// <summary> 
    /// Do Download Log Entry data as file
    /// </summary>
    procedure DoDownloadDataFromLogEntry(var LogEntry: Record "YelBas Log Entry"; IsHandled: Boolean)
    var
        TempBlob: Codeunit "Temp Blob";
        GetLogData: Codeunit "YelBas GetLogData";
        InStream: InStream;
        TitleLbl: Label 'Download log data file';
        OutStream: OutSTream;
        ToFile: Text;
    begin
        if IsHandled then
            exit;

        TempBlob.CreateInStream(InStream, TextEncoding::UTF8);
        TempBlob.CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.Write(GetLogData.GetDataAsText(LogEntry));
        ToFile := 'LogEntry_' + format(LogEntry."Entry No") + '.txt';
        DownloadFromStream(InStream, TitleLbl, '', '(*.*)|*.*', ToFile);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDownloadDataFromLog(var LogEntry: Record "YelBas Log Entry"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDownloadDataFromLog(var LogEntry: Record "YelBas Log Entry");
    begin
    end;

}