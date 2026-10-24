{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zed-editor
    ollama-vulkan
  ];

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan; 
    loadModels = [
      "huihui_ai/qwen2.5-coder-abliterate:14b"
      "qwen2.5-coder:14b"
      "phi4-mini"
    ];
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "2m";
    };
  };
}
