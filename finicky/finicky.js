module.exports = {
  defaultBrowser: "Safari",
  handlers: [
    {
      // PlayStation doesn't currently support Safari due to ITP.
      match: finicky.matchDomains(["store.playstation.com"]),
      browser: "Google Chrome",
    },
    {
      // Fantastical opens URLs via a redirect (so the correct account is used).
      // https://accounts.google.com/AccountChooser?Email=xxx&continue=https://meet.google.com/xxx
      match: /meet\.google\.com/,
      browser: "Google Chrome",
    },
  ],
};
