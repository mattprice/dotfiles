module.exports = {
  defaultBrowser: "Safari",
  handlers: [
    {
      match: finicky.matchDomains("meet.google.com"),
      browser: "Google Chrome",
    },
  ],
};
