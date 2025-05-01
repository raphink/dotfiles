module.exports = {
    defaultBrowser: {
       name: "Google Chrome",
       profile: "Default",
    },
    handlers: [
        {
            match: finicky.matchHostnames([
                "www.geoguessr.com", "midjourney.com", "discord.com", "youtube.com", "youtu.be",
                "x.com", "bsky.app", "www.linkedin.com",
            ]),
            browser: {
                name: "Google Chrome",
                // Perso
                profile: "Default",
            },
        },
        {
            match: ({ opener, urlString }) => {
                finicky.log("Received URL", urlString, "from opener ID", opener.bundleId);
                return opener.bundleId == "com.tinyspeck.slackmacgap";
            },
            browser: {
                name: "Google Chrome",
                // Work
                profile: "Profile 1",
            },
        }
    ],
  };