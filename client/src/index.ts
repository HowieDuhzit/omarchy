import { Networked3dWebExperienceClient } from "@mml-io/3d-web-experience-client";

const protocol = window.location.protocol === "https:" ? "wss:" : "ws:";
const host = window.location.host;
const userNetworkAddress = `${protocol}//${host}/network`;

const holder = Networked3dWebExperienceClient.createFullscreenHolder();
const app = new Networked3dWebExperienceClient(holder, {
  sessionToken: (window as any).SESSION_TOKEN,
  userNetworkAddress,
  enableChat: true,
  animationConfig: {
    // Using default animations from public MML assets
    airAnimationFileUrl: "https://public.mml.io/anim_air.glb",
    idleAnimationFileUrl: "https://public.mml.io/anim_idle.glb",
    jogAnimationFileUrl: "https://public.mml.io/anim_jog.glb",
    sprintAnimationFileUrl: "https://public.mml.io/anim_run.glb",
    doubleJumpAnimationFileUrl: "https://public.mml.io/anim_double_jump.glb",
  },
  mmlDocuments: {
    minesweeper: { url: `${protocol}//${host}/mml-documents/minesweeper.html` },
  },
  environmentConfiguration: {
    groundPlane: true,
    fog: {
      fogFar: 200,
      fogNear: 50,
      fogColor: "#1a1a2e",
    },
    sun: {
      intensity: 1.5,
    },
  },
  avatarConfiguration: {
    allowCustomAvatars: true,
    availableAvatars: [
      {
        name: "Bot",
        meshFileUrl: "https://public.mml.io/bot.glb",
      },
    ],
  },
  allowOrbitalCamera: true,
  loadingScreen: {
    background: "#1a1a2e",
    color: "#00ff88",
    title: "MINESWEPT",
    subtitle: "3D Multiplayer Minesweeper - Don't step on the mines!",
  },
  spawnConfiguration: {
    spawnPosition: { x: 0, y: 0, z: -5 },
    enableRespawnButton: true,
  },
});

app.update();
