{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    zed-editor
    ollama-vulkan
    nixd
    nil
  ];

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan; 
    loadModels = [
      "qwen2.5-coder:14b"
      "llama3-groq-tool-use:8b"
      "llama3.1:8b"
    ];
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "2m";
    };
  };
}
