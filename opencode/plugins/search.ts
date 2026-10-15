import { Plugin } from "@opencode/plugin"
import { spawn } from "node:child_process"
import path from "node:path"

export default Plugin.define({
  id: "local.search",
  async setup(ctx) {
    await ctx.tool.transform((editor) => {
      editor.add({
        name: "ripgrep",
        description: "Search file contents with ripgrep (rg)",
        input: {
          type: "object",
          properties: {
            pattern: { type: "string", description: "Regex pattern to search for" },
            path: { type: "string", description: "Directory to search in (defaults to current directory)" },
            include: { type: "string", description: "Glob filter like *.ts or *.{ts,tsx}" },
            ignoreCase: { type: "boolean" },
          },
          required: ["pattern"],
          additionalProperties: false,
        },
        options: { codemode: false },
        async execute(input, context) {
          const args = input as { pattern: string; path?: string; include?: string; ignoreCase?: boolean }
          const session = await ctx.session.get({ sessionID: context.sessionID })
          const cwd = session.location.directory
          const searchPath = args.path ? path.resolve(cwd, args.path) : cwd
          const command = ["--line-number", "--no-heading", "--color", "never"]
          if (args.ignoreCase) command.push("-i")
          if (args.include) command.push("--glob", args.include)
          command.push("--", args.pattern, searchPath)
          const result = await run("rg", command, cwd, context.signal)
          if (result.code === 1) return { content: "No matches found" }
          if (result.code !== 0) throw new Error(result.stderr.trim() || `rg failed with exit code ${result.code}`)
          return { content: result.stdout.trim() || "No matches found" }
        },
      })
      editor.add({
        name: "fdfind",
        description: "Find files and directories with fdfind/fd",
        input: {
          type: "object",
          properties: {
            pattern: { type: "string", description: "Search pattern (regex-like). Defaults to matching everything" },
            path: { type: "string", description: "Directory to search in (defaults to current directory)" },
            type: { type: "string", enum: ["any", "file", "directory"] },
            extension: { type: "string" },
            hidden: { type: "boolean" },
            maxDepth: { type: "integer", minimum: 1 },
          },
          additionalProperties: false,
        },
        options: { codemode: false },
        async execute(input, context) {
          const args = input as { pattern?: string; path?: string; type?: string; extension?: string; hidden?: boolean; maxDepth?: number }
          const session = await ctx.session.get({ sessionID: context.sessionID })
          const cwd = session.location.directory
          const searchPath = args.path ? path.resolve(cwd, args.path) : cwd
          const command = ["--color", "never"]
          if (args.type === "file") command.push("--type", "f")
          if (args.type === "directory") command.push("--type", "d")
          if (args.extension) command.push("--extension", args.extension)
          if (args.hidden) command.push("--hidden")
          if (args.maxDepth) command.push("--max-depth", String(args.maxDepth))
          command.push("--", args.pattern ?? ".", searchPath)
          let result
          try {
            result = await run("fdfind", command, cwd, context.signal)
          } catch (error) {
            if ((error as NodeJS.ErrnoException).code !== "ENOENT") throw error
            result = await run("fd", command, cwd, context.signal)
          }
          if (result.code !== 0) throw new Error(result.stderr.trim() || `fd failed with exit code ${result.code}`)
          return { content: result.stdout.trim() || "No matches found" }
        },
      })
    })
  },
})

async function run(binary: string, args: string[], cwd: string, signal: AbortSignal) {
  return new Promise<{ stdout: string; stderr: string; code: number | null }>((resolve, reject) => {
    const child = spawn(binary, args, { cwd, signal, stdio: ["ignore", "pipe", "pipe"] })
    let stdout = ""
    let stderr = ""
    child.stdout.on("data", (chunk) => { stdout += chunk })
    child.stderr.on("data", (chunk) => { stderr += chunk })
    child.on("error", reject)
    child.on("close", (code) => resolve({ stdout, stderr, code }))
  })
}
