import {
  BaseConfig,
  ContextBuilder,
} from "https://deno.land/x/ddc_vim@v5.0.1/types.ts";
import { Denops } from "https://deno.land/x/ddc_vim@v5.0.1/deps.ts";

export class Config extends BaseConfig {
  // deno-lint-ignore require-await
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
  }): Promise<void> {
    args.contextBuilder.patchGlobal({
      ui: "pum",
      sources: [
        "sekken",
        "lsp",
        "buffer",
        "around",
        "file",
        "denippet",
        "shell-native",
      ],
      autoCompleteDelay: 0,
      autoCompleteEvents: [
        "InsertEnter",
        "TextChangedI",
        "TextChangedP",
        "CmdlineEnter",
        "CmdlineChanged",
        "TextChangedT",
      ],
      backspaceCompletion: true,
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
          timeout: 10,
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
        lsp: {
          mark: "lsp",
          dup: "keep",
          keywordPattern: "\\.\\w*|:\\w*|->\\w*",
          sorters: ["sorter_lsp-kind"],
          converters: ["converter_kind_labels"],
          timeout: 1000,
        },
        file: {
          mark: "F",
          isVolatile: true,
          minAutoCompleteLength: 10,
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
        denippet: {
          mark: "denippet",
          dup: "keep",
        },
        skkeleton: {
          mark: "skkeleton",
          matchers: ["skkeleton"],
          sorters: [],
          isVolatile: true,
          minAutoCompleteLength: 1,
        },
        sekken: {
          mark: "sekken",
          matchers: [],
          sorters: [],
          isVolatile: true,
          minAutoCompleteLength: 1,
          keywordPattern: "[!-~]+",
          maxItems: 3,
          timeout: 1000,
        },
      },
      sourceParams: {
        "shell-native": {
          shell: "zsh",
        },
        lsp: {
          confirmBehavior: "replace",
          enableAdditionalTextEdit: true,
          enableResolveItem: true,
          lspEngine: "lspoints",
          snippetEngine: (body: string) =>
            args.denops.call("denippet#anonymous", body),
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
