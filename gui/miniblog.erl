%% A micro-blog, which sets up a frame with menus, and allows an
%% "about" box to be displayed.

-module(miniblog).
-compile(export_all).

-include_lib("wx/include/wx.hrl").

-define(ABOUT,?wxID_ABOUT).
-define(EXIT,?wxID_EXIT).
-define(APPEND,131).
-define(UNDO,132).
-define(OPEN,133).
-define(SAVE,134).
-define(NEW,135).

%% Top-level function: create the wx-server, the graphical objects,
%% show the application, process and clean up on termination.

start() ->
  wx:new(),
  Frame = wxFrame:new(wx:null(), ?wxID_ANY, "MiniBlog"),
  Text = wxTextCtrl:new(Frame, ?wxID_ANY,
                        [{value,"MiniBlog"},
                        {style,?wxTE_MULTILINE}]),
  setup(Frame,Text),
  wxFrame:show(Frame),
  loop(Frame,Text),
  wx:destroy().

%% Top-level frame: create a menu bar, two menus, two menu items
%% and a status bar. Connect the frame to handle events.

setup(Frame, Text) ->
  MenuBar = wxMenuBar:new(),
  File = wxMenu:new(),
  Edit = wxMenu:new(),
  Help = wxMenu:new(),

  wxMenu:append(Help,?ABOUT,"About MicroBlog"),
  wxMenu:append(File,?EXIT,"Quit"),
  wxMenu:append(File,?NEW,"New\tCtrl-N"),
  wxMenu:append(File,?OPEN,"Open saved\tCtrl-O"),
  wxMenu:appendSeparator(File),
  wxMenu:append(File,?SAVE,"Save\tCtrl-S"),
  wxMenu:append(Edit,?APPEND,"Add en&try\tCtrl-T"),
  wxMenu:append(Edit,?UNDO,"Undo latest\tCtrl-U"),

  wxMenuBar:append(MenuBar,Edit,"&Edit"),
  wxMenuBar:append(MenuBar,File,"&File"),
  wxMenuBar:append(MenuBar,Help,"&Help"),

  wxTextCtrl:setEditable(Text,false),

  wxFrame:setMenuBar(Frame,MenuBar),
  wxFrame:createStatusBar(Frame),
  wxFrame:setStatusText(Frame,"Welcome to wxErlang"),
  wxFrame:connect(Frame, command_menu_selected),
  wxFrame:connect(Frame, close_window).

lastLineRange(Text) ->
    LastLineNum = wxTextCtrl:getNumberOfLines(Text),
    LastLineLength = wxTextCtrl:getLineLength(Text, LastLineNum - 1),
    % io:format("LastLineNum ~p~n", [LastLineNum]),
    % io:format("LastLineLength ~p~n", [LastLineLength]),
    StartPos = wxTextCtrl:xYToPosition(Text, 0, LastLineNum - 1),
    EndPos =  wxTextCtrl:xYToPosition(Text, LastLineLength - 1, LastLineNum - 1),
    % io:format("StartPos ~p~n", [StartPos]),
    % io:format("EndPos ~p~n", [EndPos]),
    { StartPos + 1, EndPos + 1 }.

loop(Frame,Text) ->
  receive
    #wx{id=?APPEND, event=#wxCommand{type=command_menu_selected}} ->
        Prompt = "Please enter text here.",
        MD = wxTextEntryDialog:new(Frame,Prompt,
                                  [{caption, "New blog entry"}]),
        case wxTextEntryDialog:showModal(MD) of
            ?wxID_OK ->
                Str = wxTextEntryDialog:getValue(MD),
                % wxTextCtrl:appendText(Text,[10]++dateNow()++Str);
                wxTextCtrl:appendText(Text,[10]++Str);
            _ -> ok
        end,
        wxDialog:destroy(MD),
        loop(Frame,Text);

    #wx{id=?UNDO, event=#wxCommand{type=command_menu_selected}} ->
        {StartPos,EndPos} = lastLineRange(Text),
        wxTextCtrl:remove(Text,StartPos-2,EndPos+1),
        loop(Frame,Text);

    #wx{id=?OPEN, event=#wxCommand{type=command_menu_selected}} ->
        wxTextCtrl:loadFile(Text,"BLOG"),
        loop(Frame,Text);

    #wx{id=?SAVE, event=#wxCommand{type=command_menu_selected}} ->
        wxTextCtrl:saveFile(Text,[{file,"BLOG"}]),
        loop(Frame,Text);

    #wx{id=?NEW, event=#wxCommand{type=command_menu_selected}} ->
        {_,EndPos} = lastLineRange(Text),
        StartPos = wxTextCtrl:xYToPosition(Text,0,0),
        wxTextCtrl:replace(Text,StartPos,EndPos,"MiniBlog"),
        % LastLineNum = wxTextCtrl:getNumberOfLines(Text),
        % LastLineLength = wxTextCtrl:getLineLength(Text, LastLineNum - 1),
        % io:format("LastLineText ~p~n", [wxTextCtrl:getLineText(Text, LastLineNum)]),
        % io:format("LastLineNum ~p~n", [LastLineNum]),
        % io:format("LastLineLength ~p~n", [LastLineLength]),
        loop(Frame,Text);

    #wx{id=?ABOUT, event=#wxCommand{}} ->
        Str = "MicroBlog is a minimal WxErlang example.",
        MD = wxMessageDialog:new(Frame,Str,
                                [{style, ?wxOK bor ?wxICON_INFORMATION},
                                {caption, "About MicroBlog"}]),
        wxDialog:showModal(MD),
        wxDialog:destroy(MD),
        loop(Frame, Text);

    #wx{id=?EXIT, event=#wxCommand{type=command_menu_selected}} ->
        wxWindow:close(Frame,[])
  end.

