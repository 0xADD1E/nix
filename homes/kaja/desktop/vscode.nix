{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    profiles.default = {
      keybindings = [
        { key = "ctrl+0"; command = "workbench.action.zoomReset"; }
      ];
      userSettings = {
        # Updates
        "extensions.autoCheckUpdates" = false;
        "extensions.autoUpdate" = false;
        "update.mode" = "none";
        # Colours and Interface
        "window.titleBarStyle" = "custom";
        "window.autoDetectColorScheme" = true;
        "workbench.preferredDarkColorTheme" = "One Dark Pro";
        "workbench.preferredLightColorTheme" = "Atom One Light";
        "editor.fontFamily" = "'FiraCode Nerd Font', 'Fira Code', monospace";
        "terminal.integrated.fontLigatures.enabled" = true;
        "editor.fontLigatures" = true;
        # Editor
        "vim.useSystemClipboard" = true;
        # Terminals
        "terminal.integrated.profiles.linux" = {
          "bash" = {
            "path" = "bash";
            "icon" = "terminal-bash";
          };
          "zsh" = {
            "path" = "zsh";
          };
          "fish" = {
            "path" = "fish";
          };
          "tmux" = {
            "path" = "tmux";
            "icon" = "terminal-tmux";
          };
          "pwsh" = {
            "path" = "pwsh";
            "icon" = "terminal-powershell";
          };
          "nu" = {
            "path" = "nu";
          };
        };
        "terminal.integrated.defaultProfile.linux" = "nu";
        # Kubernetes
        "vscode-kubernetes.kubectl-path" = "${pkgs.kubectl}/bin/kubectl";
        "vs-kubernetes" = {
          "vs-kubernetes.crd-code-completion" = "enabled";
        };
        # Nix
        "nix.formatterPath" = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "nix.enableLanguageServer" = false;
        # Python
        "python.analysis.autoImportCompletions" = true;
        "python.analysis.inlayHints.callArgumentNames" = "partial";
        "python.analysis.inlayHints.functionReturnTypes" = true;
        "python.analysis.inlayHints.variableTypes" = true;
        "python.analysis.typeCheckingMode" = "basic";
        "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
        "python.languageServer" = "Pylance";
        # Debloat
        "chat.disableAIFeatures" = true;
        "chat.agent.enabled" = false;
        "chat.commandCenter.enabled" = false;
        "telemetry.feedback.enabled" = false;
        "geminicodeassist.enableTelemetry" = false;
      };
      extensions =
        with pkgs.vscode-extensions;
        [
          ms-vscode-remote.remote-containers
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit
          ms-vsliveshare.vsliveshare

          asciidoctor.asciidoctor-vscode
          jebbs.plantuml
          pkgs.vscode-extensions."4ops".terraform
          mechatroner.rainbow-csv
          #redhat.vscode-xml

          vscodevim.vim

          rust-lang.rust-analyzer

          ms-kubernetes-tools.vscode-kubernetes-tools
          redhat.vscode-yaml
          ms-azuretools.vscode-docker

          jnoortheen.nix-ide
          arrterian.nix-env-selector
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            # Theme: One Light
            name = "vscode-theme-onelight";
            publisher = "akamud";
            version = "2.3.0";
            sha256 = "sha256-CTD0s2lRMCi/WCGr6dP1Utrvtsdcbg4srRcrZJSFDqU=";
          }
          {
            # Theme: One Dark
            name = "material-theme";
            publisher = "zhuangtongfa";
            version = "3.19.0";
            sha256 = "sha256-K0eXeAEn4s3YZHJJU9jxtytNQTgaGwvd3fBUsZiKfPw=";
          }
          {
            # Gemini Code Assist
            name = "geminicodeassist";
            publisher = "Google";
            version = "2.36.0";
            sha256 = "sha256-9qNYsTCc7NiWPP9fW2GNHNglRA/wo4eYYtbB9j9RaM4=";
          }
        ];
    };
  };
}
