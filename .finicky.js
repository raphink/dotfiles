export default {
  defaultBrowser: {
    name: "Google Chrome",
    profile: "Perso",
  },
  handlers: [
    {
      match: (url) => [
        "www.geoguessr.com",
        "midjourney.com",
        "discord.com",
        "youtube.com",
        "youtu.be",
        "x.com",
        "bsky.app",
        "www.linkedin.com",
      ].includes(url.hostname),
      browser: {
        name: "Google Chrome",
        profile: "Perso",
      },
    },
    {
      match: (url, { opener }) => {
        console.log("Received URL", url.href, "from opener:", opener?.bundleId);
        return opener?.bundleId === "com.tinyspeck.slackmacgap";
      },
      browser: {
        name: "Google Chrome",
        profile: "Work",
      },
    },
  ],
};
