const { execSync } = require("child_process");

function overrideApiKey(model: any) {
  const cmd = model.apiKey.substr(1).trim();
  Object.defineProperty(model, "apiKey", {
    get() {
      return execSync(cmd, { encoding: "utf8" }).trim();
    },
  });
}

export function modifyConfig(config: Config): Config {
  config.models
    .filter((model) => model.apiKey && model.apiKey.startsWith("$"))
    .forEach((model) => {
      overrideApiKey(model);
    });

  if (
    config.tabAutocompleteModel.apiKey &&
    config.tabAutocompleteModel.apiKey.startsWith("$")
  ) {
    overrideApiKey(config.tabAutocompleteModel);
  }

  if (
    config.embeddingsProvider.apiKey &&
    config.embeddingsProvider.apiKey.startsWith("$")
  ) {
    overrideApiKey(config.embeddingsProvider);
  }

  if (config.reranker.apiKey && config.reranker.apiKey.startsWith("$")) {
    overrideApiKey(config.reranker);
  }

  return config;
}
