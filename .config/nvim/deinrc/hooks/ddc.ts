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
        "skkeleton",
        "nvim-lsp",
        "buffer",
        "around",
        "file",
        "vsnip",
        "shell-native",
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
          dup: "keep",
          keywordPattern: "\\k+",
          sorters: ["sorter_lsp-kind"],
          converters: ["converter_kind_labels"],
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
        "shell-native": {
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
        skkeleton: {
          mark: "skkeleton",
          matchers: ["skkeleton"],
          sorters: [],
          isVolatile: true,
        },
      },
      sourceParams: {
        "shell-native": {
          shell: "zsh",
        },
        "nvim-lsp": {
          enableResolveItem: true,
          enableAdditionalTextEdit: true,
          confirmBehavior: "replace",
          snippetEngine: (body: string) =>
            args.denops.call("vsnip#anonymous", body),
        },
      },
      filterParams: {
        converter_kind_labels: {
          kindLabels: {
            Text: "",
            Method: "",
            Function: "",
            Constructor: "",
            Field: "",
            Variable: "",
            Class: "",
            Interface: "",
            Module: "",
            Property: "",
            Unit: "",
            Value: "",
            Enum: "",
            Keyword: "",
            Snippet: "",
            Color: "",
            File: "",
            Reference: "",
            Folder: "",
            EnumMember: "",
            Constant: "",
            Struct: "",
            Event: "",
            Operator: "",
            TypeParameter: "",
          },
          kindHlGroups: {
            Method: "Function",
            Function: "Function",
            Constructor: "Function",
            Field: "Identifier",
            Variable: "Identifier",
            Class: "Structure",
            Interface: "Structure",
          },
        },
      },
    });
  }
}
