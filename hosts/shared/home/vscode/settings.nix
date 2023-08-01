{
  breadcrumbs.enabled = false;
  emmet.useInlineCompletions = true;
  javascript.updateImportsOnFileMove.enabled = "always";
  scss.lint.unknownAtRules = "ignore";
  security.workspace.trust.untrustedFiles = "open";
  update.mode = "none";

  "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
  "[html]".editor.defaultFormatter = "esbenp.prettier-vscode";
  "[javascript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
  "[json]".editor.defaultFormatter = "esbenp.prettier-vscode";
  "[jsonc]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
  "[nix]".editor.defaultFormatter = "kamadorueda.alejandra";
  "[rust]".editor.defaultFormatter = "rust-lang.rust-analyzer";
  "[scss]".editor.defaultFormatter = "sibiraj-s.vscode-scss-formatter";
  "[typescript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
  "[typescriptreact]".eslint.validate = [
    "javascript"
    "javascriptreact"
    "typescript"
    "typescriptreact"
  ];

  editor = {
    cursorBlinking = "smooth";
    cursorSmoothCaretAnimation = "on";
    cursorWidth = 2;
    defaultFormatter = "rvest.vs-code-prettier-eslint";
    fontFamily = "'Iosevka Nerd Font'";
    fontLigatures = true;
    fontSize = 14;
    formatOnSave = true;
    guides.bracketPairs = true;
    inlineSuggest.enabled = true;
    largeFileOptimizations = false;
    lineNumbers = "on";
    linkedEditing = true;
    renderWhitespace = "all";
    smoothScrolling = true;
    suggest.showStatusBar = true;
    suggestSelection = "first";

    bracketPairColorization = {
      enabled = true;
      independentColorPoolPerBracketType = true;
    };

    codeActionsOnSave.source = {
      organizeImports = true;
      fixAll.eslint = true;
    };
  };

  eslint = {
    format.enable = true;
    lintTask.enable = true;
    useESLintClass = true;
  };

  files = {
    autoSave = "afterDelay";
    eol = "\n";

    exclude = {
      "**/.classpath" = true;
      "**/.direnv" = true;
      "**/.factorypath" = true;
      "**/.git" = true;
      "**/.project" = true;
      "**/.settings" = true;
    };
  };

  git = {
    enableSmartCommit = true;
  };

  terminal.integrated = {
    cursorBlinking = true;
    fontFamily = "'Iosevka Nerd Font'";
    fontSize = 14;
    smoothScrolling = true;

    ignoreProcessNames = [
      "starship"
      "bash"
      "zsh"
      "fish"
      "nu"
    ];
  };

  window = {
    titleBarStyle = "custom";
    zoomLevel = 1;
  };

  workbench = {
    colorTheme = "Catppuccin Mocha";
    iconTheme = "catppuccin-mocha";
    smoothScrolling = true;
  };
}
