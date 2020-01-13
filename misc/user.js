


/* 0000: disable about:config warning
 * The XUL version can still be accessed in FF71+ @ chrome://global/content/config.xul
 * and in FF73+ @ chrome://global/content/config.xhtml ***/
user_pref("general.warnOnAboutConfig", false); // for the XUL version
user_pref("browser.aboutConfig.showWarning", false); // for the new HTML version [FF71+]

// https://support.mozilla.org/bm/questions/1241129
user_pref("browser.ctrlTab.recentlyUsedOrder", false);

// https://github.com/Aris-t2/CustomCSSforFx
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.urlbar.oneOffSearches", false);
user_pref("extensions.pocket.enabled", false);
user_pref("browser.ping-centre.telemetry", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);

// Always show download button
user_pref("browser.download.autohideButton", false);


// Session store
user_pref("browser.sessionstore.warnOnQuit", true);


// Privacy
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("privacy.donottrackheader.enabled", true);


// Hide recommended extensions/addons
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
