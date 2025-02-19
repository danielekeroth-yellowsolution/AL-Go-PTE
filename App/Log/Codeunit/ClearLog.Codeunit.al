namespace YellowSolution.Y365Base.Log;

/// <summary>
/// Handles log cleanup 
/// </summary>
codeunit 54750 "YelBas Clear Log"
{
    /// <summary> 
    /// Clear log
    /// </summary>
    procedure Clear()
    var
        LogEntry: Record "YelBas Log Entry";
        ClearQst: Label 'Are you sure you want to clear the log?';
        IsHandled: Boolean;
    begin
        if not Confirm(ClearQst) then
            exit;

        OnBeforeClear(LogEntry, IsHandled);

        DoClear(LogEntry, IsHandled);

        OnAfterClear(LogEntry);
    end;

    /// <summary> 
    /// Clears the log
    /// </summary>
    local procedure DoClear(var LogEntry: Record "YelBas Log Entry"; IsHandled: Boolean);
    var
        ClearedMsg: Label 'The log is now cleared!';
    begin
        if IsHandled then
            exit;

        LogEntry.DeleteAll(true);
        Message(ClearedMsg);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeClear(var LogEntry: Record "YelBas Log Entry"; IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterClear(var LogEntry: Record "YelBas Log Entry");
    begin
    end;
}