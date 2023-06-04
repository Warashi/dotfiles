import {
  ddc,
  ddu,
  denops,
  libs,
  lsp,
  snippets,
  treesitter,
  ui,
} from "./plugins/mod.ts";
export * from "./plugins/types.ts";

export const plugins = [
  ...libs,
  ...denops,
  ...ui,
  ...snippets,
  ...lsp,
  ...treesitter,
  ...ddc,
  ...ddu,
];
