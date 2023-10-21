import { u } from "../deps.ts";

const isCommandDefinition = u.isObjectOf({
  title: u.isOptionalOf(u.isString),
  command: u.isOptionalOf(u.isString),
  arguments: u.isOptionalOf(u.isArrayOf(u.isString)),
  os: u.isOptionalOf(u.isString),
});

const isToolDefinition = u.isObjectOf({
  env: u.isOptionalOf(u.isArrayOf(u.isString)),

  prefix: u.isOptionalOf(u.isString),

  formatCanRange: u.isOptionalOf(u.isBoolean),
  formatCommand: u.isOptionalOf(u.isString),
  formatStdin: u.isOptionalOf(u.isBoolean),

  hoverCommand: u.isOptionalOf(u.isString),
  hoverStdin: u.isOptionalOf(u.isBoolean),
  hoverType: u.isOptionalOf(u.isString),
  hoverChars: u.isOptionalOf(u.isString),

  lintCommand: u.isOptionalOf(u.isString),
  lintOffsetColumns: u.isOptionalOf(u.isNumber),
  lintCategoryMap: u.isOptionalOf(u.isAny),
  lintFormats: u.isOptionalOf(u.isArrayOf(u.isString)),
  lintIgnoreExitCode: u.isOptionalOf(u.isBoolean),
  lintOnSave: u.isOptionalOf(u.isBoolean),
  lintSeverity: u.isOptionalOf(u.isNumber),
  lintSource: u.isOptionalOf(u.isString),
  lintStdin: u.isOptionalOf(u.isBoolean),
  lintWorkspaceFolder: u.isOptionalOf(u.isBoolean),

  completionCommand: u.isOptionalOf(u.isString),
  completionStdin: u.isOptionalOf(u.isBoolean),

  symbolCommand: u.isOptionalOf(u.isString),
  symbolStdin: u.isOptionalOf(u.isBoolean),
  symbolFormats: u.isOptionalOf(u.isArrayOf(u.isString)),

  rootMakers: u.isOptionalOf(u.isArrayOf(u.isString)),
  requireMarker: u.isOptionalOf(u.isBoolean),

  commands: u.isOptionalOf(u.isArrayOf(isCommandDefinition)),
});

export type ToolDefinition = u.PredicateType<typeof isToolDefinition>;
