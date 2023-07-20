import {
  BaseConfig,
  ContextBuilder,
} from "https://deno.land/x/ddc_vim@v3.9.0/types.ts";
import { Denops } from "https://deno.land/x/ddc_vim@v3.9.0/deps.ts";

export class Config extends BaseConfig {
  // deno-lint-ignore require-await
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
  }): Promise<void> {
    args.contextBuilder.patchGlobal({
      ui: "pum",
      sources: [
        "nvim-lsp",
        "buffer",
        "around",
        "file",
        "vsnip",
        "zsh",
        "mocword",
      ],
      autoCompleteEvents: [
        "InsertEnter",
        "TextChangedI",
        "TextChangedP",
        "CmdlineEnter",
        "CmdlineChanged",
        "TextChangedT",
      ],
      cmdlineSources: {
        ":": ["cmdline", "cmdline-history", "around"],
        "@": ["input", "cmdline-history", "file", "around"],
        ">": ["input", "cmdline-history", "file", "around"],
        "/": ["around", "line"],
        "?": ["around", "line"],
        "-": ["around", "line"],
        "=": ["input"],
      },
      sourceOptions: {
        _: {
          ignoreCase: true,
          matchers: ["matcher_fuzzy"],
          sorters: ["converter_fuzzy"],
          converters: ["converter_fuzzy"],
          timeout: 1000,
        },
        around: {
          mark: "A",
        },
        buffer: {
          mark: "B",
        },
        cmdline: {
          mark: "cmdline",
          forceCompletionPattern: "\\S/\\S*|\\.\\w*",
        },
        input: {
          mark: "input",
          forceCompletionPattern: "\\S/\\S*",
          isVolatile: true,
        },
        line: {
          mark: "line",
          matchers: ["matcher_vimregexp"],
        },
        "nvim-lsp": {
          mark: "lsp",
          forceCompletionPattern: "\\.\\w*|::\\w*|->\\w*",
          dup: "force",
        },
        file: {
          mark: "F",
          isVolatile: true,
          minAutoCompleteLength: 1000,
          forceCompletionPattern: "\\S/\\S*",
        },
        "cmdline-history": {
          mark: "history",
          sorters: [],
        },
        zsh: {
          mark: "zsh",
          isVolatile: true,
          forceCompletionPattern: "\\S/\\S*",
        },
        vsnip: {
          mark: "vsnip",
          dup: "keep",
        },
        mocword: {
          mark: "mocword",
          minAutoCompleteLength: 4,
          isVolatile: true,
        },
      },
    });
  }
}
