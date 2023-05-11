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

async function update_git(dst: string): Promise<boolean> {
  const cmd = new Deno.Command("git", {
    args: ["-C", dst, "pull", "--rebase"],
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

async function source_vimscript(denops: Denops, path: string): Promise<void> {
  const target = `${path}/plugin/**/*.vim`;
  for await (const file of expandGlob(target)) {
    execute(denops, `source ${file.path}`);
  }
}

async function source_lua(denops: Denops, path: string): Promise<void> {
  const target = `${path}/plugin/**/*.lua`;
  for await (const file of expandGlob(target)) {
    execute(denops, `luafile ${file.path}`);
  }
}

async function source_vimscript_after(
  denops: Denops,
  path: string,
): Promise<void> {
  const target = `${path}/after/plugin/**/*.vim`;
  for await (const file of expandGlob(target)) {
    execute(denops, `source ${file.path}`);
  }
}

async function source_lua_after(denops: Denops, path: string): Promise<void> {
  const target = `${path}/after/plugin/**/*.lua`;
  for await (const file of expandGlob(target)) {
    execute(denops, `luafile ${file.path}`);
  }
}

async function register_denops(denops: Denops, path: string): Promise<void> {
  const target = `${path}/denops/*/main.ts`;
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

    async update_git(base, dst): Promise<boolean> {
      assertString(base);
      assertString(dst);
      return await update_git(`${base}/${dst}`);
    },

    async update_github(base, org, repo): Promise<boolean> {
      assertString(base);
      assertString(org);
      assertString(repo);
      return await update_git(`${base}/github.com/${org}/${repo}`);
    },

    async add_rtp_git(base, dst): Promise<void> {
      assertString(base);
      assertString(dst);

      await append_rtp(denops, `${base}/${dst}`);
    },

    async add_rtp_github(base, org, repo): Promise<void> {
      assertString(base);
      assertString(org);
      assertString(repo);

      await append_rtp(denops, `${base}/github.com/${org}/${repo}`);
    },

    async source_vimscript_git(base, dst): Promise<void> {
      assertString(base);
      assertString(dst);
      await source_vimscript(denops, `${base}/${dst}`);
      await source_vimscript_after(denops, `${base}/${dst}`);
    },

    async source_vimscript_github(base, org, repo): Promise<void> {
      assertString(base);
      assertString(org);
      assertString(repo);
      await source_vimscript(denops, `${base}/github.com/${org}/${repo}`);
      await source_vimscript_after(denops, `${base}/github.com/${org}/${repo}`);
    },

    async source_lua_git(base, dst): Promise<void> {
      assertString(base);
      assertString(dst);
      await source_lua(denops, `${base}/${dst}`);
      await source_lua_after(denops, `${base}/${dst}`);
    },

    async source_lua_github(base, org, repo): Promise<void> {
      assertString(base);
      assertString(org);
      assertString(repo);
      await source_lua(denops, `${base}/github.com/${org}/${repo}`);
      await source_lua_after(denops, `${base}/github.com/${org}/${repo}`);
    },

    async register_denops_git(base, dst): Promise<void> {
      assertString(base);
      assertString(dst);
      await register_denops(denops, `${base}/${dst}`);
    },

    async register_denops_github(base, org, repo): Promise<void> {
      assertString(base);
      assertString(org);
      assertString(repo);
      await register_denops(denops, `${base}/github.com/${org}/${repo}`);
    },
  };

  return Promise.resolve();
}
