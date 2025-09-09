{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    # Use the stock package; no overrides → no `pname` issue.
    package = pkgs.vscode;  # or pkgs.vscodium if you prefer

    # Explicitly allow VS Code to manage ~/.vscode/extensions itself.
    mutableExtensionsDir = true;  # avoids the immutable marker file

    profiles.default = {
      # Install just your one extension declaratively
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        rust-lang.rust-analyzer
        golang.go
        streetsidesoftware.code-spell-checker
        usernamehw.errorlens
      ];

      # Keep settings simple & top-level (not profiles.*)
      userSettings = {
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;
        "disable-hardware-acceleration" = true;
        "editor.mouseWheelZoom" = true;
      };
    };
  };

  # Keybindings via the canonical settings location
  home.file.".config/Code/User/keybindings.json".text = builtins.toJSON [
    { key = "ctrl+'"; command = "editor.action.accessibleViewAcceptInlineCompletion";
      when = "accessibleViewIsShown && accessibleViewCurrentProviderId == 'inlineCompletions'"; }
    { key = "ctrl+shift+7"; command = "-editor.action.accessibleViewAcceptInlineCompletion";
      when = "accessibleViewIsShown && accessibleViewCurrentProviderId == 'inlineCompletions'"; }
    { key = "ctrl+'"; command = "github.copilot.acceptCursorPanelSolution";
      when = "github.copilot.panelVisible && activeWebviewPanelId == 'GitHub Copilot Suggestions'"; }
    { key = "ctrl+shift+7"; command = "-github.copilot.acceptCursorPanelSolution";
      when = "github.copilot.panelVisible && activeWebviewPanelId == 'GitHub Copilot Suggestions'"; }
    { key = "ctrl+'"; command = "notebook.commentSelectedCells";
      when = "notebookEditable && notebookEditorFocused && !inputFocus"; }
    { key = "ctrl+shift+7"; command = "-notebook.commentSelectedCells";
      when = "notebookEditable && notebookEditorFocused && !inputFocus"; }
    { key = "ctrl+'"; command = "editor.action.commentLine";
      when = "editorTextFocus && !editorReadonly"; }
    { key = "ctrl+shift+7"; command = "-editor.action.commentLine";
      when = "editorTextFocus && !editorReadonly"; }
    { key = "ctrl+'"; command = "terminalSuggestToggleExplainMode";
      when = "terminalFocus && terminalHasBeenCreated && terminalIsOpen && terminalSuggestWidgetVisible || terminalFocus && terminalIsOpen && terminalProcessSupported && terminalSuggestWidgetVisible"; }
    { key = "ctrl+shift+7"; command = "-terminalSuggestToggleExplainMode";
      when = "terminalFocus && terminalHasBeenCreated && terminalIsOpen && terminalSuggestWidgetVisible || terminalFocus && terminalIsOpen && terminalProcessSupported && terminalSuggestWidgetVisible"; }
    { key = "ctrl+'"; command = "toggleExplainMode"; when = "suggestWidgetVisible"; }
    { key = "ctrl+shift+7"; command = "-toggleExplainMode"; when = "suggestWidgetVisible"; }
    { key = "ctrl+'"; command = "workbench.action.chat.attachContext";
      when = "inChatInput && chatLocation == 'panel'"; }
    { key = "ctrl+shift+7"; command = "-workbench.action.chat.attachContext";
      when = "inChatInput && chatLocation == 'panel'"; }
    { key = "ctrl+'"; command = "workbench.action.terminal.sendSequence"; when = "terminalFocus"; }
    { key = "ctrl+shift+7"; command = "-workbench.action.terminal.sendSequence"; when = "terminalFocus"; }
    { key = "ctrl+alt+up"; command = "editor.action.insertCursorAbove"; when = "editorTextFocus"; }
    { key = "ctrl+shift+up"; command = "-editor.action.insertCursorAbove"; when = "editorTextFocus"; }
    { key = "ctrl+alt+down"; command = "editor.action.insertCursorBelow"; when = "editorTextFocus"; }
    { key = "ctrl+shift+down"; command = "-editor.action.insertCursorBelow"; when = "editorTextFocus"; }
    { key = "shift+alt+down"; command = "editor.action.copyLinesDownAction";
      when = "editorTextFocus && !editorReadonly"; }
    { key = "ctrl+shift+alt+down"; command = "-editor.action.copyLinesDownAction";
      when = "editorTextFocus && !editorReadonly"; }
    { key = "shift+alt+up"; command = "editor.action.copyLinesUpAction";
      when = "editorTextFocus && !editorReadonly"; }
    { key = "ctrl+shift+alt+up"; command = "-editor.action.copyLinesUpAction";
      when = "editorTextFocus && !editorReadonly"; }
  ];
}