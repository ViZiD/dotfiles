{ pkgs, colors }:
with colors;
[
  (pkgs.writeText "theme.css.js"
    # css
    ''
      // ==UserScript==
      // @name    Userstyle (theme.css)
      // @include   *
      // ==/UserScript==
      GM_addStyle(`
      :root {
        --theme-orange: ${orange};
        --theme-yellow: ${yellow};
        --theme-green: ${green};
        --theme-magenta: ${magenta};
        --theme-blue: ${blue};
        --theme-cyan: ${cyan};
      }
      `)
    ''
  )

  (pkgs.writeTextFile {
    name = "ytsponsorblock.js";
    text = builtins.readFile ./ytsponsorblock.js;
  })

  (pkgs.writeTextFile {
    name = "yt.css.js";
    text = builtins.readFile ./yt.css.js;
  })
]
