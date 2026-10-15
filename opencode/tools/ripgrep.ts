import { tool } from "@opencode-ai/plugin"
import path from "node:path"

export default tool({
  description: "Search file contents with ripgrep (rg)",
  args: {
    pattern: tool.schema.string().describe("Regex pattern to search for"),
    path: tool.schema
      .string()
      .optional()
      .describe("Directory to search in (defaults to current directory)"),
    include: tool.schema
      .string()
      .optional()
      .describe("Glob filter like *.ts or *.{ts,tsx}"),
    ignoreCase: tool.schema
      .boolean()
      .optional()
      .describe("Case-insensitive search when true"),
  },
  async execute(args, context) {
    const searchPath = args.path
      ? path.isAbsolute(args.path)
        ? args.path
        : path.join(context.directory, args.path)
      : context.directory

    const cmd = ["rg", "--line-number", "--no-heading", "--color", "never"]

    if (args.ignoreCase) cmd.push("-i")
    if (args.include) cmd.push("--glob", args.include)

    cmd.push(args.pattern, searchPath)

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

    if (exitCode === 1) return "No matches found"
    if (exitCode !== 0) {
      throw new Error(stderr.trim() || `rg failed with exit code ${exitCode}`)
    }

    return stdout.trim() || "No matches found"
  },
})
