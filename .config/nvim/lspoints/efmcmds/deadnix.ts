import type { Denops } from "../deps.ts";
import type { ToolDefinition } from "./types.ts";

// deno-lint-ignore require-await
export async function deadnix(_denops: Denops): Promise<ToolDefinition> {
  return {
    prefix: "deadnix",
    lintCommand:
      `deadnix -o json \${INPUT} | jq -r '{file:.file,result:.results[]} | "\\(.file):\\(.result.line):\\(.result.column):\\(.result.endColumn): \\(.result.message)"'`,
    lintFormats: ["%f:%l:%c:%k: %m"],
    lintIgnoreExitCode: true,
  };
}
