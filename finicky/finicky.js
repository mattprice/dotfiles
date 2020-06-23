module.exports = {
  defaultBrowser: "Safari",
  handlers: [
    {
      match: finicky.matchDomains(["meet.google.com", "store.playstation.com"]),
      browser: "Google Chrome",
    },
  ],
};
