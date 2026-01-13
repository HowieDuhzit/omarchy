import crypto from "crypto";

import type { CharacterDescription, UserData } from "@mml-io/3d-web-user-networking";
import express from "express";

export type AuthUser = {
  clientId: number | null;
  userData?: UserData;
  sessionToken: string;
};

export type BasicUserAuthenticatorOptions = {
  devAllowUnrecognizedSessions: boolean;
};

const defaultOptions: BasicUserAuthenticatorOptions = {
  devAllowUnrecognizedSessions: false,
};

export class BasicUserAuthenticator {
  private usersByClientId = new Map<number, AuthUser>();
  private userBySessionToken = new Map<string, AuthUser>();

  constructor(
    private characterDescription: CharacterDescription,
    private options: BasicUserAuthenticatorOptions = defaultOptions,
  ) {}

  public async generateAuthorizedSessionToken(req: express.Request): Promise<string> {
    const sessionToken = crypto.randomBytes(20).toString("hex");
    const authUser: AuthUser = {
      clientId: null,
      sessionToken,
    };

    this.userBySessionToken.set(sessionToken, authUser);
    return sessionToken;
  }

  public async onClientConnect(
    clientId: number,
    sessionToken: string,
    userIdentityPresentedOnConnection?: UserData,
  ): Promise<UserData | true | Error> {
    console.log(`Client ID: ${clientId} joined with token`);
    let user = this.userBySessionToken.get(sessionToken);
    if (!user && this.options.devAllowUnrecognizedSessions) {
      console.warn(`Dev mode: allowing unrecognized session token`);
      user = {
        clientId: null,
        sessionToken,
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
      characterDescription:
        userIdentityPresentedOnConnection?.characterDescription ?? this.characterDescription,
      colors: userIdentityPresentedOnConnection?.colors ?? [],
    };
    console.log(`Client ID: ${clientId} connected with user data`, user.userData);
    this.usersByClientId.set(clientId, user);
    return user.userData;
  }

  public getClientIdForSessionToken(sessionToken: string): { id: number } | null {
    const user = this.userBySessionToken.get(sessionToken);
    if (!user) {
      return null;
    }
    if (user.clientId === null) {
      return null;
    }
    return { id: user.clientId };
  }

  public onClientUserIdentityUpdate(clientId: number, msg: UserData): UserData | true | Error {
    const user = this.usersByClientId.get(clientId);

    if (!user) {
      return new Error(`onClientUserIdentityUpdate - unknown clientId ${clientId}`);
    }

    if (!user.userData) {
      return new Error(`onClientUserIdentityUpdate - no user data for clientId ${clientId}`);
    }

    const newUserData: UserData = {
      username: msg.username ?? user.userData.username,
      characterDescription: msg.characterDescription ?? user.userData.characterDescription,
      colors: msg.colors ?? user.userData.colors,
    };

    this.usersByClientId.set(clientId, { ...user, userData: newUserData });
    return newUserData;
  }

  public onClientDisconnect(clientId: number) {
    console.log(`Remove user-session for ${clientId}`);
    const userData = this.usersByClientId.get(clientId);
    if (userData) {
      userData.clientId = null;
      this.usersByClientId.delete(clientId);
    }
  }
}
