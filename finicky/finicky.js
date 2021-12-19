module.exports = {
  defaultBrowser: "Safari",
  handlers: [
    {
      // Fantastical opens URLs via a redirect (so the correct account is used).
      // https://accounts.google.com/AccountChooser?Email=xxx&continue=https://meet.google.com/xxx
      match: /meet\.google\.com/,
      browser: "Google Chrome",
    },
  ],
};
