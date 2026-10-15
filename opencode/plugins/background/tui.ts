import { Plugin } from "@opencode/plugin/tui"

export default Plugin.define({
  id: "local.background",
  setup(ctx) {
    ctx.keymap.layer(() => ({
      mode: "global",
      commands: [
        {
          id: "local.background.run",
          title: "Background running tools",
          group: "Session",
          palette: true,
          slash: { name: "background" },
          run() {
            ctx.keymap.dispatch("session.background")
          },
        },
      ],
    }))
  },
})
