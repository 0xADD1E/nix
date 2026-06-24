{ pkgs, ... }: {
  home.file.".config/opencode/opencode.jsonc".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    "model" = "lechonk/qwen/qwen3.6-27b";
    "small_model" = "nightmaremoon/nvidia/nemotron-3-nano-4b";
    "autoupdate" = false;
    "server" = {
      "hostname" = "0.0.0.0";
      "port" = 4096;
    };
    "disabled_providers" = [
      "opencode-zen"
    ];
    "provider" = {
      "aperture" = {
        "npm" = "@ai-sdk/openai-compatible";
        "name" = "Aperture";
        "options" = {
          "baseURL" = "http://aperture.tail5410ad.ts.net/v1";
        };
        "models" = {
          "nvidia/nemotron-3-super" = {
            "name" = "Nemotron3 Super";
            "limit" = {
              "context" = 196608;
              "output" = 65536;
            };
          };
          "nvidia/nemotron-3-nano-4b" = {
            "name" = "Nemotron3 Nano4b";
            "limit" = {
              "context" = 196608;
              "output" = 65536;
            };
          };
          "moonshotai/Kimi-Linear-48B-A3B-Instruct-GGUF" = {
            "name" = "Kimi-Linear 48B-A3B";
            "limit" = {
              "context" = 1048570;
              "output" = 65536;
            };
          };
          "qwen/qwen3.6-27b" = {
            "name" = "Qwen3.6 Dense (27B)";
            "limit" = {
              "context" = 196608;
              "output" = 65536;
            };
          };
          "qwen/qwen3.6-35b-a3b" = {
            "name" = "Qwen3.6 Sparse (35B-A3B)";
            "limit" = {
              "context" = 196608;
              "output" = 65536;
            };
          };
        };
      };
      "nightmaremoon" = {
        "npm" = "@ai-sdk/openai-compatible";
        "name" = "Nightmare Moon";
        "options" = {
          "baseURL" = "http://nightmare-moon.tail5410ad.ts.net:1234/v1";
        };
        "models" = {
          "google/gemma4-26b-a4b" = {
            "name" = "NM Gemma4 28B-A4B";
            "limit" = {
              "context" = 196608;
              "output" = 65536;
            };
          };
          "qwen/qwen3.6-35b-a3b" = {
            "name" = "NM Qwen3.6 Sparse (35B-A3B)";
            "limit" = {
              "context" = 196608;
              "output" = 65536;
            };
          };
          "qwen/qwen3.6-27b" = {
            "name" = "NM Qwen3.6 Dense (27B)";
            "limit" = {
              "context" = 196608;
              "output" = 65536;
            };
          };
          "nvidia/nemotron-3-nano-4b" = {
            "name" = "NM Nemotron3 Nano4B";
            "limit" = {
              "context" = 196608;
              "output" = 65536;
            };
          };
        };
      };
    };
    "mcp" = {
      "excel" = {
        "type" = "local";
        "command" = [
          "${pkgs.nodejs}/bin/npx"
          "-y"
          "@negokaz/excel-mcp-server"
        ];
      };
    };
    "plugin" = [ "opencode-mem" "@simonwjackson/opencode-direnv" ];
    "permission" = {
      "*" = "allow";
    };
  };
  home.file.".config/opencode/opencode-mem.jsonc".text = builtins.toJSON {
    "storagePath" = "~/.opencode-mem/data";
    "userEmailOverride" = "kaja@weareprompt.com";
    "userNameOverride" = "Karolina Liskova";
    "memory" = {
      "defaultScope" = "project";
    };
    "webServerEnabled" = true;
    "webServerHost" = "0.0.0.0";
    "webServerPort" = 4747;

    "autoCaptureEnabled" = true;
    "autoCaptureLanguage" = "auto";

    "memoryProvider" = "openai-chat";
    "memoryModel" = "qwen/qwen3.6-27b";
    "memoryApiUrl" = "http://aperture.tail5410ad.ts.net/v1";
    "memoryApiKey" = "sk-lm-X0OylrVa:Mr8o9fybCdIIPFspT0WB";

    "embeddingModel" = "text-embedding-nomic-embed-text-v1.5";
    "embeddingApiUrl" = "http://nightmare-moon.tail5410ad.ts.net:1234/v1";
    "embeddingApiKey" = "sk-lm-X0OylrVa:Mr8o9fybCdIIPFspT0WB";

    "showAutoCaptureToasts" = true;
    "showUserProfileToasts" = true;
    "showErrorToasts" = true;

    "userProfileAnalysisInterval" = 10;
    "maxMemories" = 10;

    "compaction" = {
      "enabled" = true;
      "memoryLimit" = 10;
    };
    "chatMessage" = {
      "enabled" = true;
      "maxMemories" = 3;
      "excludeCurrentSession" = true;
      "injectOn" = "first";
    };
  };
}
