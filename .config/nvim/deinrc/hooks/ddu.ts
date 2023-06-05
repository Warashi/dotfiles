import {
  BaseConfig,
  ContextBuilder,
} from "https://deno.land/x/ddu_vim@v3.0.0/types.ts";
import { Denops } from "https://deno.land/x/ddu_vim@v3.0.0/deps.ts";

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
    args.contextBuilder.patchLocal("emoji", {
      sources: [{ name: "emoji" }],
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
          previewSplit: "no",
          highlights: {
            floating: "Normal",
            floatingBorder: "Special",
          },
          updateTime: 0,
          winWidth: 100,
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
      },
    });
  }
}
