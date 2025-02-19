namespace YellowSolution.Y365Base.Log;

/// <summary>
/// Codeunit implementing FluentAPI for constructing and logging log entries.
/// </summary>
/// <remarks>Need to call LogAsInfo, LogAsWarning, LogAsError or LogAsTrace to commit log to database.</remarks>
codeunit 54751 "YelBas Log"
{
    /// <summary> 
    /// Simple quick log
    /// </summary>
    [Obsolete('Use FluentAPI logging instead')]
    procedure QuickLog(Type: Enum "YelBas Log Type"; Message: Text[250])
    var
        data: Text;
    begin
        if Type = "YelBas Log Type"::Error then
            data := GetLastErrorCallStack();
        InsertLog(Type, Message, data, '', "YelBas Log Extension"::" ", '', '', '');
    end;

    /// <summary>
    /// Standard log
    /// </summary>
    [Obsolete('Use FluentAPI logging instead')]
    procedure StdLog(Type: Enum "YelBas Log Type"; Message: Text[250]; Data: Text; Extension: Enum "YelBas Log Extension"; Function: Text[100]; SourceId1: Text[40]; SourceId2: Text[40])
    begin
        InsertLog(Type, Message, Data, '', Extension, Function, SourceId1, SourceId2);
    end;

    /// <summary>
    /// Standard log
    /// </summary>
    [Obsolete('Use FluentAPI logging instead')]
    procedure StdLog(Type: Enum "YelBas Log Type"; Message: Text[250]; Data: Text; JsonData: Text; Extension: Enum "YelBas Log Extension"; Function: Text[100]; SourceId1: Text[40]; SourceId2: Text[40])
    begin
        InsertLog(Type, Message, Data, JsonData, Extension, Function, SourceId1, SourceId2);
    end;

    /// <summary>
    /// Quick Error Log
    /// </summary>
    [Obsolete('Use FluentAPI logging instead')]
    procedure QuickErrLog(Message: Text[250]; Extension: Enum "YelBas Log Extension")
    begin
        InsertLog("YelBas Log Type"::Error, Message, GetLastErrorCallStack(), '', Extension, '', '', '');
    end;

    /// <summary>
    /// Insert log Entry
    /// </summary>
    local procedure InsertLog(Type: Enum "YelBas Log Type"; Message: Text[250]; Data: Text; JsonData: Text; Extension: Text[40]; Function: Text[100]; SourceId1: Text[40]; SourceId2: Text[40])
    var
        LogEntry: Record "YelBas Log Entry";
        IsHandled: Boolean;
        OutStream: OutStream;
    begin
        LogEntry.Init();
        LogEntry.Validate(Type, Type);
        LogEntry.Validate(Message, Message);
        LogEntry.Validate(Extension, Format(Extension));
        LogEntry.Validate(Function, Function);
        LogEntry.Validate("Source Id 1", SourceId1);
        LogEntry.Validate("Source Id 2", SourceId2);

        LogEntry.Data.CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(Data);

        Clear(OutStream);
        LogEntry."Json Data".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(JsonData);

        OnBeforeInsertLog(LogEntry, IsHandled);

        if IsHandled then
            exit;

        LogEntry.Insert(true);

        OnAfterInsertLog(LogEntry);
    end;

    /// <summary>
    /// Insert log Entry
    /// </summary>
    local procedure InsertLog(Type: Enum "YelBas Log Type"; Message: Text[250]; Data: Text; JsonData: Text; Extension: Enum "YelBas Log Extension"; Function: Text[100]; SourceId1: Text[40]; SourceId2: Text[40])
    begin
        InsertLog(Type, Message, Data, JsonData, Format(Extension), Function, SourceId1, SourceId2);
    end;


    /// <summary>
    /// Sets the message of the log entry
    /// </summary>
    /// <param name="Message"></param>
    /// <returns></returns>
    procedure WithMessage(Message: Text[250]): Codeunit "YelBas Log"
    begin
        CurrentMessage := Message;
        exit(this);
    end;

    /// <summary>
    /// Set the function name where the log is being called
    /// </summary>
    /// <param name="FunctionName"></param>
    /// <returns></returns>
    procedure WithFunction(FunctionName: Text[100]): Codeunit "YelBas Log"
    begin
        CurrentFunction := FunctionName;
        exit(this);
    end;

    /// <summary>
    /// Add non-structured data to the log entry
    /// </summary>
    /// <param name="Data"></param>
    /// <returns></returns>
    procedure WithData(Data: Text): Codeunit "YelBas Log"
    begin
        CurrentData := Data;
        exit(this);
    end;

    /// <summary>
    /// Add structured data to the log entry
    /// </summary>
    /// <param name="JsonData">JSON as text</param>
    /// <returns></returns>
    procedure WithJsonData(JsonData: Text): Codeunit "YelBas Log"
    begin
        CurrentJsonData := JsonData;
        exit(this);
    end;

    /// <summary>
    /// Add structured data to the log entry
    /// </summary>
    /// <param name="JsonData">JsonObject to be logged, will be formatted to Text</param>
    /// <returns></returns>
    procedure WithJsonData(JsonData: JsonObject): Codeunit "YelBas Log"
    begin
        exit(this);
    end;

    /// <summary>
    /// Set the primary source id for the log entry such as the Codeunit or Page name
    /// </summary>
    /// <param name="sourceId"></param>
    /// <returns></returns>
    procedure WithPrimarySourceId(sourceId: Text[40]): Codeunit "YelBas Log"
    begin
        CurrentSourceId1 := sourceId;
        exit(this);
    end;

    /// <summary>
    /// Set the secondary source id for the log entry such as the Codeunit or Page ID
    /// </summary>
    /// <param name="sourceId"></param>
    /// <returns></returns>
    procedure WithSecondarySourceId(sourceId: Text[40]): Codeunit "YelBas Log"
    begin
        CurrentSourceId2 := sourceId;
        exit(this);
    end;

    /// <summary>
    /// Commits the log to the database with INFO severity level
    /// </summary>
    procedure LogAsInfo()
    var
        ModuleInfo: ModuleInfo;
    begin
        NavApp.GetCallerModuleInfo(ModuleInfo);
        InsertLog(Enum::"YelBas Log Type"::Info,
        CurrentMessage, CurrentData, CurrentJsonData,
        ModuleInfo.Name[40], CurrentFunction, CurrentSourceId1, CurrentSourceId2);
        ClearAll();
    end;

    /// <summary>
    /// Commits the log to the database with WARNING severity level
    /// </summary>
    procedure LogAsWarning()
    var
        ModuleInfo: ModuleInfo;
    begin
        NavApp.GetCallerModuleInfo(ModuleInfo);
        InsertLog(Enum::"YelBas Log Type"::Warning,
        CurrentMessage, CurrentData, CurrentJsonData,
        ModuleInfo.Name[40], CurrentFunction, CurrentSourceId1, CurrentSourceId2);
        ClearAll();
    end;

    /// <summary>
    /// Commits the log to the database with ERROR severity level
    /// </summary>
    procedure LogAsError()
    var
        ModuleInfo: ModuleInfo;
    begin
        NavApp.GetCallerModuleInfo(ModuleInfo);
        InsertLog(Enum::"YelBas Log Type"::Error,
        CurrentMessage, CurrentData, CurrentJsonData,
        ModuleInfo.Name[40], CurrentFunction, CurrentSourceId1, CurrentSourceId2);
        ClearAll();
    end;

    /// <summary>
    /// Commits the log to the database with TRACE severity level
    /// </summary>
    procedure LogAsTrace()
    var
        ModuleInfo: ModuleInfo;
    begin
        NavApp.GetCallerModuleInfo(ModuleInfo);
        InsertLog(Enum::"YelBas Log Type"::Trace,
        CurrentMessage, CurrentData, CurrentJsonData,
        ModuleInfo.Name[40], CurrentFunction, CurrentSourceId1, CurrentSourceId2);
        ClearAll();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertLog(var LogEntry: Record "YelBas Log Entry"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertLog(var LogEntry: Record "YelBas Log Entry");
    begin
    end;

    var
        CurrentMessage: Text[250];
        CurrentFunction: Text[100];
        CurrentData: Text;
        CurrentJsonData: Text;
        CurrentSourceId1: Text[40];
        CurrentSourceId2: Text[40];
}