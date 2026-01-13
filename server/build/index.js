// src/index.ts
import fs from "fs";
import path from "path";
import url from "url";
import {
  Networked3dWebExperienceServer
} from "@mml-io/3d-web-experience-server";
import express from "express";
import enableWs from "express-ws";

// src/BasicUserAuthenticator.ts
import crypto from "crypto";
var defaultOptions = {
  devAllowUnrecognizedSessions: false
};
var BasicUserAuthenticator = class {
  constructor(characterDescription2, options = defaultOptions) {
    this.characterDescription = characterDescription2;
    this.options = options;
  }
  usersByClientId = /* @__PURE__ */ new Map();
  userBySessionToken = /* @__PURE__ */ new Map();
  async generateAuthorizedSessionToken(req) {
    const sessionToken = crypto.randomBytes(20).toString("hex");
    const authUser = {
      clientId: null,
      sessionToken
    };
    this.userBySessionToken.set(sessionToken, authUser);
    return sessionToken;
  }
  async onClientConnect(clientId, sessionToken, userIdentityPresentedOnConnection) {
    console.log(`Client ID: ${clientId} joined with token`);
    let user = this.userBySessionToken.get(sessionToken);
    if (!user && this.options.devAllowUnrecognizedSessions) {
      console.warn(`Dev mode: allowing unrecognized session token`);
      user = {
        clientId: null,
        sessionToken
      };
      this.userBySessionToken.set(sessionToken, user);
    }
    if (!user) {
      console.error(`Invalid initial user-update for clientId ${clientId}, unknown session`);
      return new Error(`Invalid initial user-update for clientId ${clientId}, unknown session`);
    }
    if (user.clientId !== null) {
      console.error(`Session token already connected`);
      return new Error(`Session token already connected`);
    }
    user.clientId = clientId;
    user.userData = {
      username: `Player ${clientId}`,
      characterDescription: userIdentityPresentedOnConnection?.characterDescription ?? this.characterDescription,
      colors: userIdentityPresentedOnConnection?.colors ?? []
    };
    console.log(`Client ID: ${clientId} connected with user data`, user.userData);
    this.usersByClientId.set(clientId, user);
    return user.userData;
  }
  getClientIdForSessionToken(sessionToken) {
    const user = this.userBySessionToken.get(sessionToken);
    if (!user) {
      return null;
    }
    if (user.clientId === null) {
      return null;
    }
    return { id: user.clientId };
  }
  onClientUserIdentityUpdate(clientId, msg) {
    const user = this.usersByClientId.get(clientId);
    if (!user) {
      return new Error(`onClientUserIdentityUpdate - unknown clientId ${clientId}`);
    }
    if (!user.userData) {
      return new Error(`onClientUserIdentityUpdate - no user data for clientId ${clientId}`);
    }
    const newUserData = {
      username: msg.username ?? user.userData.username,
      characterDescription: msg.characterDescription ?? user.userData.characterDescription,
      colors: msg.colors ?? user.userData.colors
    };
    this.usersByClientId.set(clientId, { ...user, userData: newUserData });
    return newUserData;
  }
  onClientDisconnect(clientId) {
    console.log(`Remove user-session for ${clientId}`);
    const userData = this.usersByClientId.get(clientId);
    if (userData) {
      userData.clientId = null;
      this.usersByClientId.delete(clientId);
    }
  }
};

// src/index.ts
var dirname = url.fileURLToPath(new URL(".", import.meta.url));
var PORT = process.env.PORT || 3e3;
var characterDescription = {
  meshFileUrl: "https://public.mml.io/bot.glb"
};
var userAuthenticator = new BasicUserAuthenticator(characterDescription, {
  devAllowUnrecognizedSessions: true
});
var webClientBuildDir = path.join(dirname, "../../client/build/");
var indexContent = fs.readFileSync(path.join(webClientBuildDir, "index.html"), "utf8");
var mmlDocumentsDirectoryRoot = path.resolve(dirname, "../mml-documents");
var mmlDocumentsWatchPath = "**/*.html";
var { app } = enableWs(express());
app.enable("trust proxy");
var networked3dWebExperienceServer = new Networked3dWebExperienceServer({
  networkPath: "/network",
  userAuthenticator,
  mmlServing: {
    documentsWatchPath: mmlDocumentsWatchPath,
    documentsDirectoryRoot: mmlDocumentsDirectoryRoot,
    documentsUrl: "/mml-documents/"
  },
  webClientServing: {
    indexUrl: "/",
    indexContent,
    clientBuildDir: webClientBuildDir,
    clientUrl: "/web-client/",
    clientWatchWebsocketPath: process.env.NODE_ENV !== "production" ? "/web-client-build" : void 0
  },
  enableChat: true
});
networked3dWebExperienceServer.registerExpressRoutes(app);
console.log(`
===========================================
   MINESWEPT - 3D Multiplayer Minesweeper
===========================================
   Server running on http://localhost:${PORT}
===========================================
`);
app.listen(PORT);
//# sourceMappingURL=index.js.map
