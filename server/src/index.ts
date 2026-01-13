import fs from "fs";
import path from "path";
import url from "url";

import {
  Networked3dWebExperienceServer,
  Networked3dWebExperienceServerConfig,
} from "@mml-io/3d-web-experience-server";
import type { CharacterDescription } from "@mml-io/3d-web-user-networking";
import express from "express";
import enableWs from "express-ws";

import { BasicUserAuthenticator } from "./BasicUserAuthenticator";

const dirname = url.fileURLToPath(new URL(".", import.meta.url));

const PORT = process.env.PORT || 3000;

// Default avatar - simple bot model
const characterDescription: CharacterDescription = {
  meshFileUrl: "https://public.mml.io/bot.glb",
};

const userAuthenticator = new BasicUserAuthenticator(characterDescription, {
  devAllowUnrecognizedSessions: true,
});

const webClientBuildDir = path.join(dirname, "../../client/build/");
const indexContent = fs.readFileSync(path.join(webClientBuildDir, "index.html"), "utf8");
const mmlDocumentsDirectoryRoot = path.resolve(dirname, "../mml-documents");
const mmlDocumentsWatchPath = "**/*.html";

const { app } = enableWs(express());
app.enable("trust proxy");

const networked3dWebExperienceServer = new Networked3dWebExperienceServer({
  networkPath: "/network",
  userAuthenticator,
  mmlServing: {
    documentsWatchPath: mmlDocumentsWatchPath,
    documentsDirectoryRoot: mmlDocumentsDirectoryRoot,
    documentsUrl: "/mml-documents/",
  },
  webClientServing: {
    indexUrl: "/",
    indexContent,
    clientBuildDir: webClientBuildDir,
    clientUrl: "/web-client/",
    clientWatchWebsocketPath:
      process.env.NODE_ENV !== "production" ? "/web-client-build" : undefined,
  },
  enableChat: true,
} satisfies Networked3dWebExperienceServerConfig);

networked3dWebExperienceServer.registerExpressRoutes(app);

// Start listening
console.log(`
===========================================
   MINESWEPT - 3D Multiplayer Minesweeper
===========================================
   Server running on http://localhost:${PORT}
===========================================
`);
app.listen(PORT);
