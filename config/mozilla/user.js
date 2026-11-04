// Firefox user.js — applied on every startup, overriding prefs.js.
// Real file: ~/config/mozilla/user.js (tracked in ~/.cfg)
// Symlinked into the profile root: <profile>/user.js
//
// Only prefs that are about:config-only tweaks live here. Settings exposed in
// about:preferences, the devtools settings panel, or set by extensions are left
// to prefs.js so the UI keeps working normally.

// --- Extensions -------------------------------------------------------------

// Firefox's built-in default list, plus challenges.cloudflare.com: stop all
// extensions injecting into the Cloudflare Turnstile iframe. Harper's content
// script breaks Turnstile with error 600010:
// https://github.com/Automattic/harper/issues/3815
user_pref("extensions.webextensions.restrictedDomains", "accounts-static.cdn.mozilla.net,accounts.firefox.com,addons.cdn.mozilla.net,addons.mozilla.org,api.accounts.firefox.com,content.cdn.mozilla.net,discovery.addons.mozilla.org,oauth.accounts.firefox.com,profile.accounts.firefox.com,support.mozilla.org,sync.services.mozilla.com,challenges.cloudflare.com");

user_pref("extensions.ml.enabled", false);

// --- UI ---------------------------------------------------------------------

// Required for chrome/userChrome.css to be loaded
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.uidensity", 1);                  // compact
user_pref("browser.touchmode.auto", true);
user_pref("full-screen-api.warning.timeout", 500);
user_pref("widget.gtk.native-emoji-dialog", false);
user_pref("browser.urlbar.showSearchSuggestionsFirst", false);
user_pref("browser.fixup.dns_first_for_single_words", true);
user_pref("browser.translations.enable", false);
user_pref("browser.tabs.groups.smart.enabled", false);
user_pref("dom.forms.autocomplete.formautofill", true);

// --- Network / privacy ------------------------------------------------------

user_pref("network.dns.disablePrefetch", true);
user_pref("network.prefetch-next", false);
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("privacy.resistFingerprinting.reduceTimerPrecision.jitter", false);

// --- Performance ------------------------------------------------------------

user_pref("layers.gpu-process.enabled", true);
