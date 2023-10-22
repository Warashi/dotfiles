import type { Denops } from "../deps.ts";
import type { ToolDefinition } from "./types.ts";

// deno-lint-ignore require-await
export async function statix(_denops: Denops): Promise<ToolDefinition> {
  return {
    prefix: "statix",
    lintCommand:
      `statix check -o json \${INPUT} | jq -r '{file:.file,message:.report[].note,severity:.report[].severity,diagnostic:.report[].diagnostics[]} | "\\(.file):\\(.diagnostic.at.from.line):\\(.diagnostic.at.from.column):\\(.diagnostic.at.to.line):\\(.diagnostic.at.to.column):\\(.severity[0:1]):\\(.message): \\(.diagnostic.message)"'`,
    lintFormats: ["%f:%l:%c:%e:%k:%t:%m"],
    lintIgnoreExitCode: true,
  };
}
