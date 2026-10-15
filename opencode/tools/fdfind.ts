import { tool } from "@opencode-ai/plugin"
import path from "node:path"

type EntryType = "any" | "file" | "directory"

async function runFd(cmd: string[]) {
  const process = Bun.spawn({
    cmd,
    stdout: "pipe",
    stderr: "pipe",
  })

  const [stdout, stderr, exitCode] = await Promise.all([
    new Response(process.stdout).text(),
    new Response(process.stderr).text(),
    process.exited,
  ])

  return { stdout, stderr, exitCode }
}

export default tool({
  description: "Find files and directories with fdfind/fd",
  args: {
    pattern: tool.schema
      .string()
      .optional()
      .describe("Search pattern (regex-like). Defaults to matching everything"),
    path: tool.schema
      .string()
      .optional()
      .describe("Directory to search in (defaults to current directory)"),
    type: tool.schema
      .enum(["any", "file", "directory"])
      .optional()
      .describe("Filter by entry type"),
    extension: tool.schema
      .string()
      .optional()
      .describe("Filter by extension, like ts or py"),
    hidden: tool.schema
      .boolean()
      .optional()
      .describe("Include hidden files and directories"),
    maxDepth: tool.schema
      .number()
      .int()
      .positive()
      .optional()
      .describe("Maximum recursion depth"),
  },
  async execute(args, context) {
    const searchPath = args.path
      ? path.isAbsolute(args.path)
        ? args.path
        : path.join(context.directory, args.path)
      : context.directory

    const entryType: EntryType = args.type ?? "any"
    const baseArgs = ["--color", "never"]

    if (entryType === "file") baseArgs.push("--type", "f")
    if (entryType === "directory") baseArgs.push("--type", "d")
    if (args.extension) baseArgs.push("--extension", args.extension)
    if (args.hidden) baseArgs.push("--hidden")
    if (args.maxDepth) baseArgs.push("--max-depth", String(args.maxDepth))

    const pattern = args.pattern ?? "."

    let lastError = ""
    for (const bin of ["fdfind", "fd"]) {
      try {
        const { stdout, stderr, exitCode } = await runFd([
          bin,
          ...baseArgs,
          pattern,
          searchPath,
        ])

        if (exitCode === 0) return stdout.trim() || "No matches found"
        if (exitCode === 1) return "No matches found"

        lastError = stderr.trim() || `${bin} failed with exit code ${exitCode}`
      } catch (error) {
        lastError = error instanceof Error ? error.message : String(error)
      }
    }

    throw new Error(lastError || "Neither fdfind nor fd is available")
  },
})
