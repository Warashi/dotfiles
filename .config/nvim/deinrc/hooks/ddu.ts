import {
  BaseConfig,
  ContextBuilder,
} from "https://deno.land/x/ddu_vim@v3.4.3/types.ts";
import type { Denops } from "https://deno.land/x/ddu_vim@v3.4.3/deps.ts";
import type { Params as FfParams } from "https://deno.land/x/ddu_ui_ff@v1.1.0/ff.ts";

const ffWindowSizeParams = {
  winWidth: "&columns * 4 / 5",
  winHeight: "&lines * 4 / 5",
  winRow: "&lines / 10",
  winCol: "&columns / 10",
  previewWidth: "&columns * 2 / 5 - 1",
  previewHeight: "&lines * 4 / 5 - 2",
  previewRow: "&lines / 10 + 1",
  previewCol: "&columns / 2 - 1",
} as Partial<FfParams>;

export class Config extends BaseConfig {
  // deno-lint-ignore require-await
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
  }): Promise<void> {
    args.contextBuilder.patchLocal("lsp-definition", {
      sync: true,
      sources: [
        {
          name: "lsp_definition",
          params: { method: "textDocument/definition" },
        },
        {
          name: "lsp_definition",
          params: { method: "textDocument/typeDefinition" },
        },
        {
          name: "lsp_definition",
          params: { method: "textDocument/declaration" },
        },
        {
          name: "lsp_definition",
          params: { method: "textDocument/implementation" },
        },
      ],
      uiParams: {
        ff: {
          immediateAction: "open",
        } as Partial<FfParams>,
      },
    });
    args.contextBuilder.patchLocal("lsp-references", {
      sync: true,
      sources: [{ name: "lsp_references" }],
      uiParams: {
        ff: {
          immediateAction: "open",
        } as Partial<FfParams>,
      },
    });
    args.contextBuilder.patchLocal("lsp-diagnostic", {
      sync: true,
      sources: [{
        name: "lsp_diagnostic",
        params: {
          buffer: 0,
        },
      }],
    });
    args.contextBuilder.patchLocal("lsp-codeAction", {
      sync: true,
      sources: [{ name: "lsp_codeAction" }],
    });
    args.contextBuilder.patchLocal("git-ls-files", {
      sources: [{
        name: "file_external",
        params: { "cmd": ["git", "ls-files"] },
      }],
    });
    args.contextBuilder.patchGlobal({
      ui: "ff",
      uiParams: {
        ff: {
          ...ffWindowSizeParams,
          split: "floating",
          floatingBorder: "single",
          filterSplitDirection: "floating",
          previewFloating: true,
          previewFloatingBorder: "single",
          previewSplit: "vertical",
          highlights: {
            floating: "Normal",
            floatingBorder: "Special",
          },
          startAutoAction: true,
          autoAction: {
            name: "preview",
          },
        } as Partial<FfParams>,
      },

      sources: [],
      sourceParams: {},
      sourceOptions: {
        _: {
          ignoreCase: true,
          matchers: ["matcher_substring"],
        },
        copilot: {
          defaultAction: "append",
        },
        emoji: {
          defaultAction: "append",
        },
        line: {
          matchers: ["matcher_kensaku"],
        },
      },

      kindOptions: {
        command_history: { defaultAction: "edit" },
        file: { defaultAction: "open" },
        source: { defaultAction: "execute" },
        ui_select: { defaultAction: "select" },
        url: { defaultAction: "browse" },
        word: { defaultAction: "append" },
        lsp: { defaultAction: "open" },
        lsp_codeAction: { defaultAction: "apply" },
        help: { defaultAction: "tabopen" },
        window: { defaultAction: "open" },
      },
    });
  }
}
