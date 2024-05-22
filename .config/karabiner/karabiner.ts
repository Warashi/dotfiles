import { complexModifications } from "https://deno.land/x/karabinerts@1.29.0/config/complex-modifications.ts";
import * as k from "https://deno.land/x/karabinerts@1.29.0/deno.ts";
import { WriteTarget } from "https://deno.land/x/karabinerts@1.29.0/output.ts";
import { TupleToUnion } from "npm:type-fest";

const writeTarget = {
  name: "Default",
  dryRun: false,
} as const satisfies WriteTarget;

k.writeToProfile(writeTarget, [
  k.rule("Change spacebar to right shift. (Post spacebar if pressed alone)")
    .manipulators([
      k.withMapper(
        {
          "spacebar": "right_shift",
        } as const satisfies Record<
          TupleToUnion<k.KeyCode>,
          TupleToUnion<k.KeyCode>
        >,
      )((space, shift) =>
        k.map({ key_code: space, modifiers: { optional: ["any"] } })
          .to({ key_code: shift, lazy: true })
          .toIfAlone({ key_code: space })
          .description(
            `Change ${space} to ${shift} (Post ${space} if pressed alone)`,
          )
          .parameters({ "basic.to_if_held_down_threshold_milliseconds": 100 })
      ),
    ]),

  k.rule("Change left_shift + hjkl to arrow keys")
    .manipulators([
      k.withMapper(
        {
          "h": "left_arrow",
          "j": "down_arrow",
          "k": "up_arrow",
          "l": "right_arrow",
        } as const satisfies Record<
          TupleToUnion<k.KeyCode>,
          TupleToUnion<k.KeyCode>
        >,
      )((alph, arrow) =>
        k.map({
          key_code: alph,
          modifiers: { mandatory: ["left_shift"], optional: ["any"] },
        })
          .to({ key_code: arrow })
          .description(`Change left_shift + ${arrow} to arrow key ${arrow}`)
      ),
    ]),

  k.rule("Tap Cmd to Kana/Eisuu")
    .manipulators([
      k.withMapper(
        {
          "left_command": "japanese_eisuu",
          "right_command": "japanese_kana",
        } as const satisfies Record<
          TupleToUnion<k.ModifierKeyCode>,
          TupleToUnion<k.JapaneseKeyCode>
        >,
      )((cmd, lang) =>
        k.map({ key_code: cmd, modifiers: { optional: ["any"] } })
          .to({ key_code: cmd, lazy: true })
          .toIfAlone({ key_code: lang })
          .description(`Tap ${cmd} alone to switch to ${lang}`)
          .parameters({ "basic.to_if_alone_timeout_milliseconds": 100 })
      ),
    ]),

  k.rule("Change left_control to escape. (Post left_control if pressed alone)")
    .manipulators([
      k.withMapper(
        {
          "left_control": "escape",
        } as const satisfies Record<
          TupleToUnion<k.ModifierKeyCode>,
          TupleToUnion<k.KeyCode>
        >,
      )((ctrl, esc) =>
        k.map({ key_code: ctrl, modifiers: { optional: ["any"] } })
          .to({ key_code: ctrl, lazy: true })
          .toIfAlone({ key_code: esc })
          .description(
            `Change ${ctrl} to ${esc} (Post ${ctrl} if pressed alone)`,
          )
          .parameters({ "basic.to_if_held_down_threshold_milliseconds": 100 })
      ),
    ]),
]);
