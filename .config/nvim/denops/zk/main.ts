import type { Denops } from "https://deno.land/x/denops_std@v6.5.0/mod.ts";

function execute(...args: string[]): string {
  const cmd = new Deno.Command("zk", { args });
  const stdout = cmd.outputSync().stdout;
  const decoder = new TextDecoder();
  return decoder.decode(stdout);
}

export function main(denops: Denops): void {
  denops.dispatcher = {
    new: () =>
      denops.cmd(`split ${execute("new", "--no-input", "--print-path")}`),
    amend: () =>
      denops.cmd(
        `split ${
          execute(
            "list",
            "--sort",
            "modified",
            "--limit",
            "1",
            "--format",
            "{{abs-path}}",
            "--no-pager",
            "--quiet",
          )
        }`,
      ),
  };
}
