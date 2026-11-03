import { spawnSync } from "node:child_process";
import { existsSync } from "node:fs";
import { unlink } from "node:fs/promises";
import { SessionManager, type ExtensionAPI } from "@earendil-works/pi-coding-agent";

const RETENTION_DAYS = 30;
const DAY_MS = 24 * 60 * 60 * 1000;

async function deleteSessionFile(sessionPath: string): Promise<string | undefined> {
  const trashArgs = sessionPath.startsWith("-") ? ["--", sessionPath] : [sessionPath];
  const trashResult = spawnSync("trash", trashArgs, { encoding: "utf-8" });
  
  if (trashResult.status === 0 || !existsSync(sessionPath)) {
    return undefined;
  }

  try {
    await unlink(sessionPath);

    return undefined;
  } catch (error) {
    const unlinkError = error instanceof Error ? error.message : String(error);
    const trashDetails = [
      trashResult.error?.message,
      trashResult.stderr?.trim().split("\n")[0],
    ].filter(Boolean);
    const trashHint = trashDetails.length > 0 ? ` (trash: ${trashDetails.join(" · ")})` : "";

    return `${sessionPath}: ${unlinkError}${trashHint}`;
  }
}

export default function (pi: ExtensionAPI) {
  pi.on("session_shutdown", async (event) => {
    if (event.reason !== "quit") {
      return;
    }

    const cutoff = Date.now() - RETENTION_DAYS * DAY_MS;
    const sessions = await SessionManager.listAll();
    const failures: string[] = [];

    for (const session of sessions) {
      if (session.modified.getTime() >= cutoff) {
        continue;
      }

      const failure = await deleteSessionFile(session.path);
      if (failure) {
        failures.push(failure);
      }
    }

    if (failures.length > 0) {
      throw new Error(`Failed to remove ${failures.length} expired session(s): ${failures.slice(0, 5).join("; ")}`);
    }
  });
}
