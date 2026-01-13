import * as esbuild from "esbuild";
import { spawn, ChildProcess } from "child_process";

const buildMode = "--build";
const watchMode = "--watch";

const helpString = `Mode must be provided as one of ${buildMode} or ${watchMode}`;

const args = process.argv.splice(2);

if (args.length !== 1) {
  console.error(helpString);
  process.exit(1);
}

const mode = args[0];

let serverProcess: ChildProcess | null = null;

const restartServerPlugin: esbuild.Plugin = {
  name: "restart-server",
  setup(build) {
    build.onEnd((result) => {
      if (result.errors.length > 0) {
        console.error("Build failed, not restarting server");
        return;
      }

      if (serverProcess) {
        console.log("Stopping server...");
        serverProcess.kill();
      }

      console.log("Starting server...");
      serverProcess = spawn("node", ["./build/index.js"], {
        stdio: "inherit",
        cwd: process.cwd(),
      });

      serverProcess.on("error", (err) => {
        console.error("Server process error:", err);
      });
    });
  },
};

const buildOptions: esbuild.BuildOptions = {
  entryPoints: ["src/index.ts"],
  outdir: "./build",
  bundle: true,
  metafile: true,
  format: "esm",
  packages: "external",
  sourcemap: true,
  platform: "node",
  target: "es2022",
  plugins: mode === watchMode ? [restartServerPlugin] : [],
};

switch (mode) {
  case buildMode:
    esbuild.build(buildOptions).catch(() => process.exit(1));
    break;
  case watchMode:
    esbuild
      .context({ ...buildOptions })
      .then((context) => context.watch())
      .catch(() => process.exit(1));
    break;
  default:
    console.error(helpString);
}
