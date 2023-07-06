import {
  BaseConfig,
  ContextBuilder,
} from "https://deno.land/x/ddu_vim@v3.2.7/types.ts";
import type { Denops } from "https://deno.land/x/ddu_vim@v3.2.7/deps.ts";
import type { Params as FfParams } from "https://deno.land/x/ddu_ui_ff@v1.0.2/ff.ts";

export class Config extends BaseConfig {
  // deno-lint-ignore require-await
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
  }): Promise<void> {
    args.contextBuilder.patchLocal("source", {
      sources: [{ name: "source" }],
    });
    args.contextBuilder.patchLocal("copilot", {
      sources: [{ name: "copilot" }],
    });
    args.contextBuilder.patchLocal("lsp-definition", {
      sync: true,
      sources: [{ name: "lsp_definition" }],
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
    args.contextBuilder.patchGlobal({
      ui: "ff",
      uiParams: {
        ff: {
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
          updateTime: 0,
          winWidth: 100,
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
          matchers: [
            "matcher_kensaku",
          ],
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
      },
    });
  }
}
