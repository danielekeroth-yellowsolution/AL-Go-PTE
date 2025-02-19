namespace YellowSolution.Y365Base.Log;

/// <summary> 
/// Codeunit YelBas GetLogJsonData
/// </summary>
codeunit 54763 "YelBas GetLogJsonData"
{
    /// <summary> 
    /// Get log Json Data as text from log entry blob
    /// </summary>
    /// <returns>Return Log Entry Json Data blob as text</returns>
    procedure GetJsonDataAsText(LogEntry: Record "YelBas Log Entry"): Text
    var
        IsHandled: Boolean;
        LogText: Text;
    begin
        OnBeforeGetJsonDataAsText(LogEntry, IsHandled);
        LogText := DoGetJsonDataAsText(LogEntry, IsHandled);
        OnAfterGetJsonDataAsText(LogEntry, LogText);
        exit(LogText);
    end;

    /// <summary> 
    /// Get Log Json Data as text
    /// </summary>
    /// <returns>Return Log Entry Json Data blob as text</returns>
    local procedure DoGetJsonDataAsText(var LogEntry: Record "YelBas Log Entry"; IsHandled: Boolean): Text
    var
        InStream: InStream;
        StreamText: Text;
    begin
        if IsHandled then
            exit;

        LogEntry.CalcFields("Json Data");
        if LogEntry."Json Data".HasValue then begin
            LogEntry."Json Data".CreateInStream(InStream);
            InStream.ReadText(StreamText);
            exit(StreamText);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetJsonDataAsText(var LogEntry: Record "YelBas Log Entry"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetJsonDataAsText(var LogEntry: Record "YelBas Log Entry"; var LogText: Text);
    begin
    end;
}