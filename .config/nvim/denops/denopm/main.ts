import { assertString, Denops, fs, option } from "./deps.ts";
export function main(denops: Denops): Promise<void> {
  denops.dispatcher = {
    async download_github(base, org, repo): Promise<boolean> {
      assertString(base);
      assertString(org);
      assertString(repo);

      const dst = `${base}/github.com/${org}/${repo}`;
      if (await fs.exists(dst)) {
        return true;
      }

      const url = `https://github.com/${org}/${repo}`;
      const cmd = new Deno.Command("git", {
        args: ["clone", "--filter=blob:none", url, dst],
      });
      const status = await cmd.spawn().status;
      return status.success;
    },

    async add_rtp_github(base, org, repo): Promise<void> {
      assertString(base);
      assertString(org);
      assertString(repo);

      option.runtimepath.set(
        denops,
        (await option.runtimepath.get(denops)) + "," +
          `${base}/github.com/${org}/${repo}`,
      );
    },
  };

  return Promise.resolve();
}
