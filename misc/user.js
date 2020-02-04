

/* References: https://github.com/ghacksuserjs/ghacks-user.js/blob/master/user.js */

/* 0000: disable about:config warning
 * The XUL version can still be accessed in FF71+ @ chrome://global/content/config.xul
 * and in FF73+ @ chrome://global/content/config.xhtml ***/
user_pref("general.warnOnAboutConfig", false); // for the XUL version
user_pref("browser.aboutConfig.showWarning", false); // for the new HTML version [FF71+]

// https://github.com/Aris-t2/CustomCSSforFx
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.urlbar.oneOffSearches", false);
user_pref("extensions.pocket.enabled", false);

// https://support.mozilla.org/bm/questions/1241129
user_pref("browser.ctrlTab.recentlyUsedOrder", false);

// Always show download button
user_pref("browser.download.autohideButton", false);

// Always ask where to save
user_pref("browser.download.useDownloadDir", false);

// Session store
user_pref("browser.sessionstore.warnOnQuit", true);

// Hide recommended extensions/addons
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);

// Privacy
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("privacy.donottrackheader.enabled", true);

// Ensure tab on toolbar goes to next text field and not to buttons
user_pref("browser.toolbars.keyboard_navigation", false);

/* 0105a: disable Activity Stream telemetry ***/
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);

/* 0330: disable telemetry
 * the pref (.unified) affects the behaviour of the pref (.enabled)
 * IF unified=false then .enabled controls the telemetry module
 * IF unified=true then .enabled ONLY controls whether to record extended data
 * so make sure to have both set as false
 * [NOTE] FF58+ 'toolkit.telemetry.enabled' is now LOCKED to reflect prerelease
 * or release builds (true and false respectively), see [2]
 * [1] https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/telemetry/internals/preferences.html
 * [2] https://medium.com/georg-fritzsche/data-preference-changes-in-firefox-58-2d5df9c428b5 ***/
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false); // see [NOTE] above FF58+
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false); // [FF55+]
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); // [FF55+]
user_pref("toolkit.telemetry.updatePing.enabled", false); // [FF56+]
user_pref("toolkit.telemetry.bhrPing.enabled", false); // [FF57+] Background Hang Reporter
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false); // [FF57+]
/* 0331: disable Telemetry Coverage
 * [1] https://blog.mozilla.org/data/2018/08/20/effectively-measuring-search-in-firefox/ ***/
user_pref("toolkit.telemetry.coverage.opt-out", true); // [HIDDEN PREF]
user_pref("toolkit.coverage.opt-out", true); // [FF64+] [HIDDEN PREF]
user_pref("toolkit.coverage.endpoint.base", "");

/* 0506: disable PingCentre telemetry (used in several System Add-ons) [FF57+]
 * Currently blocked by 'datareporting.healthreport.uploadEnabled' (see 0340) ***/
user_pref("browser.ping-centre.telemetry", false);

/* 0503: disable Normandy/Shield [FF60+]
 * Shield is an telemetry system (including Heartbeat) that can also push and test "recipes"
 * [1] https://wiki.mozilla.org/Firefox/Shield
 * [2] https://github.com/mozilla/normandy ***/
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");
