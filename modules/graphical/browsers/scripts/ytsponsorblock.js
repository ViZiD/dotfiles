// ==UserScript==
// @name         SponsorBlock
// @version      2.1.0
// @description  Skip sponsor and other unwanted segments, show labels in tooltips, and apply colors on the seek bar for YouTube
// @match        *://*.youtube.com/*
// @exclude      *://*.youtube.com/subscribe_embed?*
// ==/UserScript==

const delay = 1000;

// Configuration for segment categories
const CATEGORY_SETTINGS = {
  sponsor: {
    color: 'var(--theme-green)',
    label: 'Sponsor',
    skip: true,
    priority: 1
  },
  selfpromo: {
    color: 'var(--theme-yellow)',
    label: 'Unpaid/Self Promotion',
    skip: true,
    priority: 2
  },
  interaction: {
    color: 'var(--theme-cyan)',
    label: 'Interaction Reminder',
    skip: true,
    priority: 2
  },
  intro: {
    color: 'var(--theme-magenta)',
    label: 'Intermission/Intro',
    skip: false,
    priority: 2
  },
  outro: {
    color: 'var(--theme-blue)',
    label: 'Endcards/Credits',
    skip: false,
    priority: 2
  },
  preview: {
    color: 'var(--theme-blue)',
    label: 'Preview/Recap/Hook',
    skip: false,
    priority: 2
  },
  music_offtopic: {
    color: 'var(--theme-orange)',
    label: 'Non-Music Section',
    skip: false,
    priority: 2
  },
  filler: {
    color: 'var(--theme-cyan)',
    label: 'Filler',
    skip: false,
    priority: 3
  },
};

const fetchSegments = (videoID) => {
  const categories = encodeURIComponent(
    JSON.stringify(Object.keys(CATEGORY_SETTINGS))
  );
  return fetch(
    `https://sponsor.ajay.app/api/skipSegments?videoID=${videoID}&categories=${categories}`
  )
    .then((res) => res.json())
    .catch((e) => console.error(`Sponsorblock fetch failed: ${e}`) || []);
};

const getHighestPriorityCategory = (categories) => {
  return categories.reduce((highest, category) => {
    const priority = CATEGORY_SETTINGS[category]?.priority ?? Number.MAX_VALUE;
    const highestPriority = CATEGORY_SETTINGS[highest]?.priority ?? Number.MAX_VALUE;
    return priority < highestPriority ? category : highest;
  });
};

const createCategoryIndicators = (segments) => {
  const seekBar = document.querySelector('.ytp-progress-bar-container');
  if (!seekBar) return;

  // Remove existing indicators
  document.querySelectorAll('.category-indicator').forEach((el) => el.remove());

  const video = document.querySelector('video');
  if (!video || Number.isNaN(video.duration)) return;

  segments.forEach(({ segment, category }) => {
    const [start, end] = segment;
    const categoryConfig = CATEGORY_SETTINGS[category] || {};
    if (!categoryConfig.color) return;

    const indicator = document.createElement('div');
    indicator.className = 'category-indicator';
    indicator.style.position = 'absolute';
    indicator.style.backgroundColor = categoryConfig.color;
    indicator.style.opacity = '0.7';
    indicator.style.height = '100%';
    indicator.style.left = `${(start / video.duration) * 100}%`;
    indicator.style.width = `${((end - start) / video.duration) * 100}%`;
    indicator.style.pointerEvents = 'none';
    seekBar.appendChild(indicator);
  });
};

const createCategoryTooltip = (segments) => {
  const seekBar = document.querySelector('.ytp-progress-bar-container');
  if (!seekBar) return;

  const video = document.querySelector('video');
  if (!video || Number.isNaN(video.duration)) return;

  seekBar.addEventListener('mousemove', (e) => {
    const timeInSeconds =
      ((e.clientX - seekBar.getBoundingClientRect().left) / seekBar.clientWidth) *
      video.duration;

    const tooltip = document.querySelector('.ytp-tooltip-text');
    if (!tooltip) return;

    const overlappingSegments = segments.filter(
      ({ segment }) =>
        timeInSeconds >= segment[0] && timeInSeconds <= segment[1]
    );

    if (overlappingSegments.length > 0) {
      const highestPriorityCategory = getHighestPriorityCategory(
        overlappingSegments.map(({ category }) => category)
      );
      const label = CATEGORY_SETTINGS[highestPriorityCategory]?.label || highestPriorityCategory;

      if (!tooltip.textContent.includes(label)) {
        tooltip.textContent += ` (${label})`;
      }
    } else {
      // Remove any category labels when not hovering over a segment
      Object.values(CATEGORY_SETTINGS).forEach(({ label }) => {
        tooltip.textContent = tooltip.textContent.replace(` (${label})`, '');
      });
    }
  });
};

const skipSegments = async () => {
  const videoID = new URL(document.location).searchParams.get('v');
  if (!videoID) return;

  const key = `segmentsToSkip-${videoID}`;
  window[key] =
    window[key] || (await fetchSegments(videoID));

  createCategoryIndicators(window[key]);
  createCategoryTooltip(window[key]);

  const video = document.querySelector('video');
  if (!video) return;

  for (const { segment: [start, end], category } of window[key]) {
    const categoryConfig = CATEGORY_SETTINGS[category] || {};
    if (!categoryConfig.skip) continue;

    if (video.currentTime < end && video.currentTime >= start) {
      console.log(
        `Sponsorblock: skipped ${category} from ${start} to ${end}`
      );
      video.currentTime = end;
      return;
    }
    const timeToSegment = (start - video.currentTime) / video.playbackRate;
    if (video.currentTime < start && timeToSegment < delay / 1000) {
      setTimeout(skipSegments, timeToSegment * 1000);
    }
  }
};

if (!window.skipSegmentsIntervalID) {
  window.skipSegmentsIntervalID = setInterval(skipSegments, delay);
}

// Style for category indicators
const style = document.createElement('style');
style.textContent = `
    .category-indicator {
        z-index: 9999;
    }
`;
document.head.appendChild(style);
