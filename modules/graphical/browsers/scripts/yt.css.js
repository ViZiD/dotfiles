// ==UserScript==
// @name    Userstyle (youtube.css)
// @match        *://*.youtube.com/*
// @exclude     *://music.youtube.com/*
// ==/UserScript==
GM_addStyle(`
  ytd-rich-grid-renderer {
    /* show more videos per row - Youtube used to look like this, but changed recently (2025-04-28) */
    --ytd-rich-grid-items-per-row: var(--ytd-rich-grid-slim-items-per-row) !important;
  }
  
  /* hide anoying branding over the top of the video bottom right */
  .annotation.annotation-type-custom.iv-branding {
    display: none !important;
  }

  ytd-grid-video-renderer:has([overlay-style="SHORTS"]),
  ytd-reel-shelf-renderer,
  ytd-rich-shelf-renderer,
  ytd-video-renderer:has([aria-label="Shorts"]),
  ytd-guide-entry-renderer:has(
    [d="M10 14.65v-5.3L15 12l-5 2.65zm7.77-4.33c-.77-.32-1.2-.5-1.2-.5L18 9.06c1.84-.96 2.53-3.23 1.56-5.06s-3.24-2.53-5.07-1.56L6 6.94c-1.29.68-2.07 2.04-2 3.49.07 1.42.93 2.67 2.22 3.25.03.01 1.2.5 1.2.5L6 14.93c-1.83.97-2.53 3.24-1.56 5.07.97 1.83 3.24 2.53 5.07 1.56l8.5-4.5c1.29-.68 2.06-2.04 1.99-3.49-.07-1.42-.94-2.68-2.23-3.25zm-.23 5.86l-8.5 4.5c-1.34.71-3.01.2-3.72-1.14-.71-1.34-.2-3.01 1.14-3.72l2.04-1.08v-1.21l-.69-.28-1.11-.46c-.99-.41-1.65-1.35-1.7-2.41-.05-1.06.52-2.06 1.46-2.56l8.5-4.5c1.34-.71 3.01-.2 3.72 1.14.71 1.34.2 3.01-1.14 3.72L15.5 9.26v1.21l1.8.74c.99.41 1.65 1.35 1.7 2.41.05 1.06-.52 2.06-1.46 2.56z"]
  ) {
    display: none !important;
  }  
  `)
