import {
  assertString,
  Denops,
  execute,
  fnamemodify,
  fs,
  option,
} from "./deps.ts";
import { expandGlob } from "https://deno.land/std@0.186.0/fs/expand_glob.ts";

async function download_git(dst: string, url: string): Promise<boolean> {
  if (await fs.exists(dst)) {
    return true;
  }

  const cmd = new Deno.Command("git", {
    args: ["clone", "--filter=blob:none", url, dst],
  });
  const status = await cmd.spawn().status;
  return status.success;
}

async function append_rtp(denops: Denops, path: string): Promise<void> {
  option.runtimepath.set(
    denops,
    (await option.runtimepath.get(denops)) + "," + path,
  );
}

export function main(denops: Denops): Promise<void> {
  denops.dispatcher = {
    async download_git(base, dst, url): Promise<boolean> {
      assertString(base);
      assertString(dst);
      assertString(url);
      return await download_git(`${base}/${dst}`, url);
    },

    async download_github(base, org, repo): Promise<boolean> {
      assertString(base);
      assertString(org);
      assertString(repo);

      return await download_git(
        `${base}/github.com/${org}/${repo}`,
        `https://github.com/${org}/${repo}`,
      );
    },

    async add_rtp_github(base, org, repo): Promise<void> {
      assertString(base);
      assertString(org);
      assertString(repo);

      await append_rtp(denops, `${base}/github.com/${org}/${repo}`);
    },

    async source_vimscript_github(base, org, repo): Promise<void> {
      assertString(base);
      assertString(org);
      assertString(repo);

      const target = `${base}/github.com/${org}/${repo}/plugin/**/*.vim`;
      for await (const file of expandGlob(target)) {
        execute(denops, `source ${file.path}`);
      }
    },

    async source_lua_github(base, org, repo): Promise<void> {
      assertString(base);
      assertString(org);
      assertString(repo);

      const target = `${base}/github.com/${org}/${repo}/plugin/**/*.lua`;
      for await (const file of expandGlob(target)) {
        execute(denops, `luafile ${file.path}`);
      }
    },

    async register_denops_github(base, org, repo): Promise<void> {
      assertString(base);
      assertString(org);
      assertString(repo);

      const target = `${base}/github.com/${org}/${repo}/denops/*/main.ts`;
      for await (const file of expandGlob(target)) {
        const name = await fnamemodify(denops, file.path, ":h:t");
        if (await denops.call("denops#plugin#is_loaded", name)) {
          continue;
        }
        if (await denops.call("denops#server#status") === "running") {
          await denops.call("denops#plugin#register", name, { mode: "skip" });
        }
        await denops.call("denops#plugin#wait", name);
      }
    },
  };

  return Promise.resolve();
}
