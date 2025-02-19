namespace YellowSolution.Y365Base.Log;

using System.Reflection;

/// <summary>
/// Get Log Data
/// </summary>
codeunit 54753 "YelBas GetLogData"
{
    /// <summary> 
    /// Get log data as text from log entry blob
    /// </summary>
    /// <returns>Return Log Entry data blob as text</returns>
    procedure GetDataAsText(LogEntry: Record "YelBas Log Entry"): Text
    var
        IsHandled: Boolean;
        LogText: Text;
    begin
        OnBeforeGetDataAsText(LogEntry, IsHandled);
        LogText := DoGetDataAsText(LogEntry, IsHandled);
        OnAfterGetDataAsText(LogEntry, LogText);
        exit(LogText);
    end;

    /// <summary> 
    /// Get Log data as text
    /// </summary>
    /// <returns>Return Log Entry data blob as text</returns>
    local procedure DoGetDataAsText(var LogEntry: Record "YelBas Log Entry"; IsHandled: Boolean): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        if IsHandled then
            exit;

        LogEntry.CalcFields(Data);
        if LogEntry.Data.HasValue then begin
            LogEntry.Data.CreateInStream(InStream, TextEncoding::UTF8);
            exit(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator()));
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDataAsText(var LogEntry: Record "YelBas Log Entry"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetDataAsText(var LogEntry: Record "YelBas Log Entry"; var LogText: Text);
    begin
    end;
}