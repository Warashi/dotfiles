import {
  BaseConfig,
  ContextBuilder,
} from "https://deno.land/x/ddu_vim@v3.2.7/types.ts";
import { Denops } from "https://deno.land/x/ddu_vim@v3.2.7/deps.ts";

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
        },
      },
    });
    args.contextBuilder.patchLocal("lsp-references", {
      sync: true,
      sources: [{ name: "lsp_references" }],
      uiParams: {
        ff: {
          immediateAction: "open",
        },
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
          autoAction: {
            name: "preview",
          },
        },
        filer: {
          split: "no",
          sort: "filename",
          sortTreesFirst: true,
          toggle: true,
        },
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
