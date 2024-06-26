# This file has been generated by node2nix 1.11.1. Do not edit!

{
  nodeEnv,
  fetchurl,
  fetchgit,
  nix-gitignore,
  stdenv,
  lib,
  globalBuildInputs ? [ ],
}:

let
  sources = {
    "@ampproject/remapping-2.2.1" = {
      name = "_at_ampproject_slash_remapping";
      packageName = "@ampproject/remapping";
      version = "2.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@ampproject/remapping/-/remapping-2.2.1.tgz";
        sha512 = "lFMjJTrFL3j7L9yBxwYfCq2k6qqwHyzuUl/XBnif78PWTJYyL/dfowQHWE3sp6U6ZzqWiiIZnpTMO96zhkjwtg==";
      };
    };
    "@babel/code-frame-7.23.5" = {
      name = "_at_babel_slash_code-frame";
      packageName = "@babel/code-frame";
      version = "7.23.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/code-frame/-/code-frame-7.23.5.tgz";
        sha512 = "CgH3s1a96LipHCmSUmYFPwY7MNx8C3avkq7i4Wl3cfa662ldtUe4VM1TPXX70pfmrlWTb6jLqTYrZyT2ZTJBgA==";
      };
    };
    "@babel/compat-data-7.23.5" = {
      name = "_at_babel_slash_compat-data";
      packageName = "@babel/compat-data";
      version = "7.23.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/compat-data/-/compat-data-7.23.5.tgz";
        sha512 = "uU27kfDRlhfKl+w1U6vp16IuvSLtjAxdArVXPa9BvLkrr7CYIsxH5adpHObeAGY/41+syctUWOZ140a2Rvkgjw==";
      };
    };
    "@babel/core-7.23.9" = {
      name = "_at_babel_slash_core";
      packageName = "@babel/core";
      version = "7.23.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/core/-/core-7.23.9.tgz";
        sha512 = "5q0175NOjddqpvvzU+kDiSOAk4PfdO6FvwCWoQ6RO7rTzEe8vlo+4HVfcnAREhD4npMs0e9uZypjTwzZPCf/cw==";
      };
    };
    "@babel/generator-7.23.6" = {
      name = "_at_babel_slash_generator";
      packageName = "@babel/generator";
      version = "7.23.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/generator/-/generator-7.23.6.tgz";
        sha512 = "qrSfCYxYQB5owCmGLbl8XRpX1ytXlpueOb0N0UmQwA073KZxejgQTzAmJezxvpwQD9uGtK2shHdi55QT+MbjIw==";
      };
    };
    "@babel/helper-compilation-targets-7.23.6" = {
      name = "_at_babel_slash_helper-compilation-targets";
      packageName = "@babel/helper-compilation-targets";
      version = "7.23.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/helper-compilation-targets/-/helper-compilation-targets-7.23.6.tgz";
        sha512 = "9JB548GZoQVmzrFgp8o7KxdgkTGm6xs9DW0o/Pim72UDjzr5ObUQ6ZzYPqA+g9OTS2bBQoctLJrky0RDCAWRgQ==";
      };
    };
    "@babel/helper-environment-visitor-7.22.20" = {
      name = "_at_babel_slash_helper-environment-visitor";
      packageName = "@babel/helper-environment-visitor";
      version = "7.22.20";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/helper-environment-visitor/-/helper-environment-visitor-7.22.20.tgz";
        sha512 = "zfedSIzFhat/gFhWfHtgWvlec0nqB9YEIVrpuwjruLlXfUSnA8cJB0miHKwqDnQ7d32aKo2xt88/xZptwxbfhA==";
      };
    };
    "@babel/helper-function-name-7.23.0" = {
      name = "_at_babel_slash_helper-function-name";
      packageName = "@babel/helper-function-name";
      version = "7.23.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/helper-function-name/-/helper-function-name-7.23.0.tgz";
        sha512 = "OErEqsrxjZTJciZ4Oo+eoZqeW9UIiOcuYKRJA4ZAgV9myA+pOXhhmpfNCKjEH/auVfEYVFJ6y1Tc4r0eIApqiw==";
      };
    };
    "@babel/helper-hoist-variables-7.22.5" = {
      name = "_at_babel_slash_helper-hoist-variables";
      packageName = "@babel/helper-hoist-variables";
      version = "7.22.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/helper-hoist-variables/-/helper-hoist-variables-7.22.5.tgz";
        sha512 = "wGjk9QZVzvknA6yKIUURb8zY3grXCcOZt+/7Wcy8O2uctxhplmUPkOdlgoNhmdVee2c92JXbf1xpMtVNbfoxRw==";
      };
    };
    "@babel/helper-module-imports-7.22.15" = {
      name = "_at_babel_slash_helper-module-imports";
      packageName = "@babel/helper-module-imports";
      version = "7.22.15";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/helper-module-imports/-/helper-module-imports-7.22.15.tgz";
        sha512 = "0pYVBnDKZO2fnSPCrgM/6WMc7eS20Fbok+0r88fp+YtWVLZrp4CkafFGIp+W0VKw4a22sgebPT99y+FDNMdP4w==";
      };
    };
    "@babel/helper-module-transforms-7.23.3" = {
      name = "_at_babel_slash_helper-module-transforms";
      packageName = "@babel/helper-module-transforms";
      version = "7.23.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/helper-module-transforms/-/helper-module-transforms-7.23.3.tgz";
        sha512 = "7bBs4ED9OmswdfDzpz4MpWgSrV7FXlc3zIagvLFjS5H+Mk7Snr21vQ6QwrsoCGMfNC4e4LQPdoULEt4ykz0SRQ==";
      };
    };
    "@babel/helper-simple-access-7.22.5" = {
      name = "_at_babel_slash_helper-simple-access";
      packageName = "@babel/helper-simple-access";
      version = "7.22.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/helper-simple-access/-/helper-simple-access-7.22.5.tgz";
        sha512 = "n0H99E/K+Bika3++WNL17POvo4rKWZ7lZEp1Q+fStVbUi8nxPQEBOlTmCOxW/0JsS56SKKQ+ojAe2pHKJHN35w==";
      };
    };
    "@babel/helper-split-export-declaration-7.22.6" = {
      name = "_at_babel_slash_helper-split-export-declaration";
      packageName = "@babel/helper-split-export-declaration";
      version = "7.22.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/helper-split-export-declaration/-/helper-split-export-declaration-7.22.6.tgz";
        sha512 = "AsUnxuLhRYsisFiaJwvp1QF+I3KjD5FOxut14q/GzovUe6orHLesW2C7d754kRm53h5gqrz6sFl6sxc4BVtE/g==";
      };
    };
    "@babel/helper-string-parser-7.23.4" = {
      name = "_at_babel_slash_helper-string-parser";
      packageName = "@babel/helper-string-parser";
      version = "7.23.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/helper-string-parser/-/helper-string-parser-7.23.4.tgz";
        sha512 = "803gmbQdqwdf4olxrX4AJyFBV/RTr3rSmOj0rKwesmzlfhYNDEs+/iOcznzpNWlJlIlTJC2QfPFcHB6DlzdVLQ==";
      };
    };
    "@babel/helper-validator-identifier-7.22.20" = {
      name = "_at_babel_slash_helper-validator-identifier";
      packageName = "@babel/helper-validator-identifier";
      version = "7.22.20";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/helper-validator-identifier/-/helper-validator-identifier-7.22.20.tgz";
        sha512 = "Y4OZ+ytlatR8AI+8KZfKuL5urKp7qey08ha31L8b3BwewJAoJamTzyvxPR/5D+KkdJCGPq/+8TukHBlY10FX9A==";
      };
    };
    "@babel/helper-validator-option-7.23.5" = {
      name = "_at_babel_slash_helper-validator-option";
      packageName = "@babel/helper-validator-option";
      version = "7.23.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/helper-validator-option/-/helper-validator-option-7.23.5.tgz";
        sha512 = "85ttAOMLsr53VgXkTbkx8oA6YTfT4q7/HzXSLEYmjcSTJPMPQtvq1BD79Byep5xMUYbGRzEpDsjUf3dyp54IKw==";
      };
    };
    "@babel/helpers-7.23.9" = {
      name = "_at_babel_slash_helpers";
      packageName = "@babel/helpers";
      version = "7.23.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/helpers/-/helpers-7.23.9.tgz";
        sha512 = "87ICKgU5t5SzOT7sBMfCOZQ2rHjRU+Pcb9BoILMYz600W6DkVRLFBPwQ18gwUVvggqXivaUakpnxWQGbpywbBQ==";
      };
    };
    "@babel/highlight-7.23.4" = {
      name = "_at_babel_slash_highlight";
      packageName = "@babel/highlight";
      version = "7.23.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/highlight/-/highlight-7.23.4.tgz";
        sha512 = "acGdbYSfp2WheJoJm/EBBBLh/ID8KDc64ISZ9DYtBmC8/Q204PZJLHyzeB5qMzJ5trcOkybd78M4x2KWsUq++A==";
      };
    };
    "@babel/parser-7.23.9" = {
      name = "_at_babel_slash_parser";
      packageName = "@babel/parser";
      version = "7.23.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/parser/-/parser-7.23.9.tgz";
        sha512 = "9tcKgqKbs3xGJ+NtKF2ndOBBLVwPjl1SHxPQkd36r3Dlirw3xWUeGaTbqr7uGZcTaxkVNwc+03SVP7aCdWrTlA==";
      };
    };
    "@babel/template-7.23.9" = {
      name = "_at_babel_slash_template";
      packageName = "@babel/template";
      version = "7.23.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/template/-/template-7.23.9.tgz";
        sha512 = "+xrD2BWLpvHKNmX2QbpdpsBaWnRxahMwJjO+KZk2JOElj5nSmKezyS1B4u+QbHMTX69t4ukm6hh9lsYQ7GHCKA==";
      };
    };
    "@babel/traverse-7.23.9" = {
      name = "_at_babel_slash_traverse";
      packageName = "@babel/traverse";
      version = "7.23.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/traverse/-/traverse-7.23.9.tgz";
        sha512 = "I/4UJ9vs90OkBtY6iiiTORVMyIhJ4kAVmsKo9KFc8UOxMeUfi2hvtIBsET5u9GizXE6/GFSuKCTNfgCswuEjRg==";
      };
    };
    "@babel/types-7.23.9" = {
      name = "_at_babel_slash_types";
      packageName = "@babel/types";
      version = "7.23.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/@babel/types/-/types-7.23.9.tgz";
        sha512 = "dQjSq/7HaSjRM43FFGnv5keM2HsxpmyV1PfaSVm0nzzjwwTmjOe6J4bC8e3+pTEIgHaHj+1ZlLThRJ2auc/w1Q==";
      };
    };
    "@codemod/matchers-1.7.0" = {
      name = "_at_codemod_slash_matchers";
      packageName = "@codemod/matchers";
      version = "1.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@codemod/matchers/-/matchers-1.7.0.tgz";
        sha512 = "edfMWz/eckYmtpXuW6JINnWa81eKJ555KX+nn7gUoxQFI5qFY59DIsvZmhACOUpcYAFpF2rT8I7tiLgmZ1zMYQ==";
      };
    };
    "@codemod/parser-1.4.1" = {
      name = "_at_codemod_slash_parser";
      packageName = "@codemod/parser";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@codemod/parser/-/parser-1.4.1.tgz";
        sha512 = "w9bvtcC1oJTuXAnp+ZOYLOWagtb8UBBZEKp9fYI0dA5KARiUJf00MmtDQyULaeZj/AQAGuOrm739DFDLeHv+0g==";
      };
    };
    "@codemod/utils-1.1.0" = {
      name = "_at_codemod_slash_utils";
      packageName = "@codemod/utils";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@codemod/utils/-/utils-1.1.0.tgz";
        sha512 = "Zx6A4xDifEqL0s9ejh62/mQmDXje+E62zYHGiGfRHzVhzmA41pDFZW/m7Hl9+fmbODJxlg9ElMsjHdhasSm7TA==";
      };
    };
    "@jridgewell/gen-mapping-0.3.3" = {
      name = "_at_jridgewell_slash_gen-mapping";
      packageName = "@jridgewell/gen-mapping";
      version = "0.3.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/@jridgewell/gen-mapping/-/gen-mapping-0.3.3.tgz";
        sha512 = "HLhSWOLRi875zjjMG/r+Nv0oCW8umGb0BgEhyX3dDX3egwZtB8PqLnjz3yedt8R5StBrzcg4aBpnh8UA9D1BoQ==";
      };
    };
    "@jridgewell/resolve-uri-3.1.1" = {
      name = "_at_jridgewell_slash_resolve-uri";
      packageName = "@jridgewell/resolve-uri";
      version = "3.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@jridgewell/resolve-uri/-/resolve-uri-3.1.1.tgz";
        sha512 = "dSYZh7HhCDtCKm4QakX0xFpsRDqjjtZf/kjI/v3T3Nwt5r8/qz/M19F9ySyOqU94SXBmeG9ttTul+YnR4LOxFA==";
      };
    };
    "@jridgewell/set-array-1.1.2" = {
      name = "_at_jridgewell_slash_set-array";
      packageName = "@jridgewell/set-array";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/@jridgewell/set-array/-/set-array-1.1.2.tgz";
        sha512 = "xnkseuNADM0gt2bs+BvhO0p78Mk762YnZdsuzFV018NoG1Sj1SCQvpSqa7XUaTam5vAGasABV9qXASMKnFMwMw==";
      };
    };
    "@jridgewell/sourcemap-codec-1.4.15" = {
      name = "_at_jridgewell_slash_sourcemap-codec";
      packageName = "@jridgewell/sourcemap-codec";
      version = "1.4.15";
      src = fetchurl {
        url = "https://registry.npmjs.org/@jridgewell/sourcemap-codec/-/sourcemap-codec-1.4.15.tgz";
        sha512 = "eF2rxCRulEKXHTRiDrDy6erMYWqNw4LPdQ8UQA4huuxaQsVeRPFl2oM8oDGxMFhJUWZf9McpLtJasDDZb/Bpeg==";
      };
    };
    "@jridgewell/trace-mapping-0.3.22" = {
      name = "_at_jridgewell_slash_trace-mapping";
      packageName = "@jridgewell/trace-mapping";
      version = "0.3.22";
      src = fetchurl {
        url = "https://registry.npmjs.org/@jridgewell/trace-mapping/-/trace-mapping-0.3.22.tgz";
        sha512 = "Wf963MzWtA2sjrNt+g18IAln9lKnlRp+K2eH4jjIoF1wYeq3aMREpG09xhlhdzS0EjwU7qmUJYangWa+151vZw==";
      };
    };
    "ansi-styles-3.2.1" = {
      name = "ansi-styles";
      packageName = "ansi-styles";
      version = "3.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ansi-styles/-/ansi-styles-3.2.1.tgz";
        sha512 = "VT0ZI6kZRdTh8YyJw3SMbYm/u+NqfsAxEpWO0Pf9sq8/e94WxxOpPKx9FR1FlyCtOVDNOQ+8ntlqFxiRc+r5qA==";
      };
    };
    "babel-helper-mark-eval-scopes-0.4.3" = {
      name = "babel-helper-mark-eval-scopes";
      packageName = "babel-helper-mark-eval-scopes";
      version = "0.4.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-mark-eval-scopes/-/babel-helper-mark-eval-scopes-0.4.3.tgz";
        sha512 = "+d/mXPP33bhgHkdVOiPkmYoeXJ+rXRWi7OdhwpyseIqOS8CmzHQXHUp/+/Qr8baXsT0kjGpMHHofHs6C3cskdA==";
      };
    };
    "babel-plugin-minify-mangle-names-0.5.1" = {
      name = "babel-plugin-minify-mangle-names";
      packageName = "babel-plugin-minify-mangle-names";
      version = "0.5.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-minify-mangle-names/-/babel-plugin-minify-mangle-names-0.5.1.tgz";
        sha512 = "8KMichAOae2FHlipjNDTo2wz97MdEb2Q0jrn4NIRXzHH7SJ3c5TaNNBkeTHbk9WUsMnqpNUx949ugM9NFWewzw==";
      };
    };
    "base64-js-1.5.1" = {
      name = "base64-js";
      packageName = "base64-js";
      version = "1.5.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/base64-js/-/base64-js-1.5.1.tgz";
        sha512 = "AKpaYlHn8t4SVbOHCy+b5+KKgvR4vrsD8vbvrbiQJps7fKDTkjkDry6ji0rUJjC0kzbNePLwzxq8iypo41qeWA==";
      };
    };
    "bl-4.1.0" = {
      name = "bl";
      packageName = "bl";
      version = "4.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/bl/-/bl-4.1.0.tgz";
        sha512 = "1W07cM9gS6DcLperZfFSj+bWLtaPGSOHWhPiGzXmvVJbRLdG82sH/Kn8EtW1VqWVA54AKf2h5k5BbnIbwF3h6w==";
      };
    };
    "browserslist-4.22.3" = {
      name = "browserslist";
      packageName = "browserslist";
      version = "4.22.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/browserslist/-/browserslist-4.22.3.tgz";
        sha512 = "UAp55yfwNv0klWNapjs/ktHoguxuQNGnOzxYmfnXIS+8AsRDZkSDxg7R1AX3GKzn078SBI5dzwzj/Yx0Or0e3A==";
      };
    };
    "buffer-5.7.1" = {
      name = "buffer";
      packageName = "buffer";
      version = "5.7.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/buffer/-/buffer-5.7.1.tgz";
        sha512 = "EHcyIPBQ4BSGlvjB16k5KgAJ27CIsHY/2JBmCRReo48y9rQ3MaUzWX3KVlBa4U7MyX02HdVj0K7C3WaB3ju7FQ==";
      };
    };
    "caniuse-lite-1.0.30001583" = {
      name = "caniuse-lite";
      packageName = "caniuse-lite";
      version = "1.0.30001583";
      src = fetchurl {
        url = "https://registry.npmjs.org/caniuse-lite/-/caniuse-lite-1.0.30001583.tgz";
        sha512 = "acWTYaha8xfhA/Du/z4sNZjHUWjkiuoAi2LM+T/aL+kemKQgPT1xBb/YKjlQ0Qo8gvbHsGNplrEJ+9G3gL7i4Q==";
      };
    };
    "chalk-2.4.2" = {
      name = "chalk";
      packageName = "chalk";
      version = "2.4.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/chalk/-/chalk-2.4.2.tgz";
        sha512 = "Mti+f9lpJNcwF4tWV8/OrTTtF1gZi+f8FqlyAdouralcFWFQWF2+NgCHShjkCb+IFBLq9buZwE1xckQU4peSuQ==";
      };
    };
    "chownr-1.1.4" = {
      name = "chownr";
      packageName = "chownr";
      version = "1.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/chownr/-/chownr-1.1.4.tgz";
        sha512 = "jJ0bqzaylmJtVnNgzTeSOs8DPavpbYgEr/b0YL8/2GO3xJEhInFmhKMUnEJQjZumK7KXGFhUy89PrsJWlakBVg==";
      };
    };
    "color-convert-1.9.3" = {
      name = "color-convert";
      packageName = "color-convert";
      version = "1.9.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/color-convert/-/color-convert-1.9.3.tgz";
        sha512 = "QfAUtd+vFdAtFQcC8CCyYt1fYWxSqAiK2cSD6zDB8N3cpsEBAvRxp9zOGg6G/SHHJYAT88/az/IuDGALsNVbGg==";
      };
    };
    "color-name-1.1.3" = {
      name = "color-name";
      packageName = "color-name";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/color-name/-/color-name-1.1.3.tgz";
        sha512 = "72fSenhMw2HZMTVHeCA9KCmpEIbzWiQsjN+BHcBbS9vr1mtt+vJjPdksIBNUmKAW8TFUDPJK5SUU3QhE9NEXDw==";
      };
    };
    "commander-11.1.0" = {
      name = "commander";
      packageName = "commander";
      version = "11.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/commander/-/commander-11.1.0.tgz";
        sha512 = "yPVavfyCcRhmorC7rWlkHn15b4wDVgVmBA7kV4QVBsF7kv/9TKJAbAXVTxvTnwP8HHKjRCJDClKbciiYS7p0DQ==";
      };
    };
    "convert-source-map-2.0.0" = {
      name = "convert-source-map";
      packageName = "convert-source-map";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/convert-source-map/-/convert-source-map-2.0.0.tgz";
        sha512 = "Kvp459HrV2FEJ1CAsi1Ku+MY3kasH19TFykTz2xWmMeq6bk2NU3XXvfJ+Q61m0xktWwt+1HSYf3JZsTms3aRJg==";
      };
    };
    "debug-4.3.4" = {
      name = "debug";
      packageName = "debug";
      version = "4.3.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/debug/-/debug-4.3.4.tgz";
        sha512 = "PRWFHuSU3eDtQJPvnNY7Jcket1j0t5OuOsFzPPzsekD52Zl8qUfFIPEiswXqIvHWGVHOgX+7G/vCNNhehwxfkQ==";
      };
    };
    "decompress-response-6.0.0" = {
      name = "decompress-response";
      packageName = "decompress-response";
      version = "6.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/decompress-response/-/decompress-response-6.0.0.tgz";
        sha512 = "aW35yZM6Bb/4oJlZncMH2LCoZtJXTRxES17vE3hoRiowU2kWHaJKFkSBDnDR+cm9J+9QhXmREyIfv0pji9ejCQ==";
      };
    };
    "deep-extend-0.6.0" = {
      name = "deep-extend";
      packageName = "deep-extend";
      version = "0.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/deep-extend/-/deep-extend-0.6.0.tgz";
        sha512 = "LOHxIOaPYdHlJRtCQfDIVZtfw/ufM8+rVj649RIHzcm/vGwQRXFt6OPqIFWsm2XEMrNIEtWR64sY1LEKD2vAOA==";
      };
    };
    "detect-libc-2.0.2" = {
      name = "detect-libc";
      packageName = "detect-libc";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/detect-libc/-/detect-libc-2.0.2.tgz";
        sha512 = "UX6sGumvvqSaXgdKGUsgZWqcUyIXZ/vZTrlRT/iobiKhGL0zL4d3osHj3uqllWJK+i+sixDS/3COVEOFbupFyw==";
      };
    };
    "electron-to-chromium-1.4.656" = {
      name = "electron-to-chromium";
      packageName = "electron-to-chromium";
      version = "1.4.656";
      src = fetchurl {
        url = "https://registry.npmjs.org/electron-to-chromium/-/electron-to-chromium-1.4.656.tgz";
        sha512 = "9AQB5eFTHyR3Gvt2t/NwR0le2jBSUNwCnMbUCejFWHD+so4tH40/dRLgoE+jxlPeWS43XJewyvCv+I8LPMl49Q==";
      };
    };
    "end-of-stream-1.4.4" = {
      name = "end-of-stream";
      packageName = "end-of-stream";
      version = "1.4.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/end-of-stream/-/end-of-stream-1.4.4.tgz";
        sha512 = "+uw1inIHVPQoaVuHzRyXd21icM+cnt4CzD5rW+NC1wjOUSTOs+Te7FOv7AhN7vS9x/oIyhLP5PR1H+phQAHu5Q==";
      };
    };
    "escalade-3.1.1" = {
      name = "escalade";
      packageName = "escalade";
      version = "3.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/escalade/-/escalade-3.1.1.tgz";
        sha512 = "k0er2gUkLf8O0zKJiAhmkTnJlTvINGv7ygDNPbeIsX/TJjGJZHuh9B2UxbsaEkmlEo9MfhrSzmhIlhRlI2GXnw==";
      };
    };
    "escape-string-regexp-1.0.5" = {
      name = "escape-string-regexp";
      packageName = "escape-string-regexp";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/escape-string-regexp/-/escape-string-regexp-1.0.5.tgz";
        sha512 = "vbRorB5FUQWvla16U8R/qgaFIya2qGzwDrNmCZuYKrbdSUMG6I1ZCGQRefkRVhuOkIGVne7BQ35DSfo1qvJqFg==";
      };
    };
    "expand-template-2.0.3" = {
      name = "expand-template";
      packageName = "expand-template";
      version = "2.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/expand-template/-/expand-template-2.0.3.tgz";
        sha512 = "XYfuKMvj4O35f/pOXLObndIRvyQ+/+6AhODh+OKWj9S9498pHHn/IMszH+gt0fBCRWMNfk1ZSp5x3AifmnI2vg==";
      };
    };
    "fs-constants-1.0.0" = {
      name = "fs-constants";
      packageName = "fs-constants";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fs-constants/-/fs-constants-1.0.0.tgz";
        sha512 = "y6OAwoSIf7FyjMIv94u+b5rdheZEjzR63GTyZJm5qh4Bi+2YgwLCcI/fPFZkL5PSixOt6ZNKm+w+Hfp/Bciwow==";
      };
    };
    "gensync-1.0.0-beta.2" = {
      name = "gensync";
      packageName = "gensync";
      version = "1.0.0-beta.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/gensync/-/gensync-1.0.0-beta.2.tgz";
        sha512 = "3hN7NaskYvMDLQY55gnW3NQ+mesEAepTqlg+VEbj7zzqEMBVNhzcGYYeqFo/TlYz6eQiFcp1HcsCZO+nGgS8zg==";
      };
    };
    "github-from-package-0.0.0" = {
      name = "github-from-package";
      packageName = "github-from-package";
      version = "0.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/github-from-package/-/github-from-package-0.0.0.tgz";
        sha512 = "SyHy3T1v2NUXn29OsWdxmK6RwHD+vkj3v8en8AOBZ1wBQ/hCAQ5bAQTD02kW4W9tUp/3Qh6J8r9EvntiyCmOOw==";
      };
    };
    "globals-11.12.0" = {
      name = "globals";
      packageName = "globals";
      version = "11.12.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/globals/-/globals-11.12.0.tgz";
        sha512 = "WOBp/EEGUiIsJSp7wcv/y6MO+lV9UoncWqxuFfm8eBwzWNgyfBd6Gz+IeKQ9jCmyhoH99g15M3T+QaVHFjizVA==";
      };
    };
    "has-flag-3.0.0" = {
      name = "has-flag";
      packageName = "has-flag";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-flag/-/has-flag-3.0.0.tgz";
        sha512 = "sKJf1+ceQBr4SMkvQnBDNDtf4TXpVhVGateu0t918bl30FnbE2m4vNLX+VWe/dpjlb+HugGYzW7uQXH98HPEYw==";
      };
    };
    "ieee754-1.2.1" = {
      name = "ieee754";
      packageName = "ieee754";
      version = "1.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ieee754/-/ieee754-1.2.1.tgz";
        sha512 = "dcyqhDvX1C46lXZcVqCpK+FtMRQVdIMN6/Df5js2zouUsqG7I6sFxitIC+7KYK29KdXOLHdu9zL4sFnoVQnqaA==";
      };
    };
    "inherits-2.0.4" = {
      name = "inherits";
      packageName = "inherits";
      version = "2.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/inherits/-/inherits-2.0.4.tgz";
        sha512 = "k/vGaX4/Yla3WzyMCvTQOXYeIHvqOKtnqBduzTHpzpQZzAskKMhZ2K+EnBiSM9zGSoIFeMpXKxa4dYeZIQqewQ==";
      };
    };
    "ini-1.3.8" = {
      name = "ini";
      packageName = "ini";
      version = "1.3.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/ini/-/ini-1.3.8.tgz";
        sha512 = "JV/yugV2uzW5iMRSiZAyDtQd+nxtUnjeLt0acNdw98kKLrvuRVyB80tsREOE7yvGVgalhZ6RNXCmEHkUKBKxew==";
      };
    };
    "isolated-vm-4.7.2" = {
      name = "isolated-vm";
      packageName = "isolated-vm";
      version = "4.7.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/isolated-vm/-/isolated-vm-4.7.2.tgz";
        sha512 = "JVEs5gzWObzZK5+OlBplCdYSpokMcdhLSs/xWYYxmYWVfOOFF4oZJsYh7E/FmfX8e7gMioXMpMMeEyX1afuKrg==";
      };
    };
    "js-tokens-4.0.0" = {
      name = "js-tokens";
      packageName = "js-tokens";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/js-tokens/-/js-tokens-4.0.0.tgz";
        sha512 = "RdJUflcE3cUzKiMqQgsCu06FPu9UdIJO0beYbPhHN4k6apgJtifcoCtT9bcxOpYBtpD2kCM6Sbzg4CausW/PKQ==";
      };
    };
    "jsesc-2.5.2" = {
      name = "jsesc";
      packageName = "jsesc";
      version = "2.5.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/jsesc/-/jsesc-2.5.2.tgz";
        sha512 = "OYu7XEzjkCQ3C5Ps3QIZsQfNpqoJyZZA99wd9aWd05NCtC5pWOkShK2mkL6HXQR6/Cy2lbNdPlZBpuQHXE63gA==";
      };
    };
    "json5-2.2.3" = {
      name = "json5";
      packageName = "json5";
      version = "2.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/json5/-/json5-2.2.3.tgz";
        sha512 = "XmOWe7eyHYH14cLdVPoyg+GOH3rYX++KpzrylJwSW98t3Nk+U8XOl8FWKOgwtzdb8lXGf6zYwDUzeHMWfxasyg==";
      };
    };
    "lru-cache-5.1.1" = {
      name = "lru-cache";
      packageName = "lru-cache";
      version = "5.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/lru-cache/-/lru-cache-5.1.1.tgz";
        sha512 = "KpNARQA3Iwv+jTA0utUVVbrh+Jlrr1Fv0e56GGzAFOXN7dk/FviaDW8LHmK52DlcH4WP2n6gI8vN1aesBFgo9w==";
      };
    };
    "lru-cache-6.0.0" = {
      name = "lru-cache";
      packageName = "lru-cache";
      version = "6.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lru-cache/-/lru-cache-6.0.0.tgz";
        sha512 = "Jo6dJ04CmSjuznwJSS3pUeWmd/H0ffTlkXXgwZi+eq1UCmqQwCh+eLsYOYCwY991i2Fah4h1BEMCx4qThGbsiA==";
      };
    };
    "mimic-response-3.1.0" = {
      name = "mimic-response";
      packageName = "mimic-response";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/mimic-response/-/mimic-response-3.1.0.tgz";
        sha512 = "z0yWI+4FDrrweS8Zmt4Ej5HdJmky15+L2e6Wgn3+iK5fWzb6T3fhNFq2+MeTRb064c6Wr4N/wv0DzQTjNzHNGQ==";
      };
    };
    "minimist-1.2.8" = {
      name = "minimist";
      packageName = "minimist";
      version = "1.2.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimist/-/minimist-1.2.8.tgz";
        sha512 = "2yyAR8qBkN3YuheJanUpWC5U3bb5osDywNB8RzDVlDwDHbocAJveqqj1u8+SVD7jkWT4yvsHCpWqqWqAxb0zCA==";
      };
    };
    "mkdirp-classic-0.5.3" = {
      name = "mkdirp-classic";
      packageName = "mkdirp-classic";
      version = "0.5.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/mkdirp-classic/-/mkdirp-classic-0.5.3.tgz";
        sha512 = "gKLcREMhtuZRwRAfqP3RFW+TK4JqApVBtOIftVgjuABpAtpxhPGaDcfvbhNvD0B8iD1oUr/txX35NjcaY6Ns/A==";
      };
    };
    "ms-2.1.2" = {
      name = "ms";
      packageName = "ms";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ms/-/ms-2.1.2.tgz";
        sha512 = "sGkPx+VjMtmA6MX27oA4FBFELFCZZ4S4XqeGOXCv68tT+jb3vk/RyaKWP0PTKyWtmLSM0b+adUTEvbs1PEaH2w==";
      };
    };
    "napi-build-utils-1.0.2" = {
      name = "napi-build-utils";
      packageName = "napi-build-utils";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/napi-build-utils/-/napi-build-utils-1.0.2.tgz";
        sha512 = "ONmRUqK7zj7DWX0D9ADe03wbwOBZxNAfF20PlGfCWQcD3+/MakShIHrMqx9YwPTfxDdF1zLeL+RGZiR9kGMLdg==";
      };
    };
    "node-abi-3.54.0" = {
      name = "node-abi";
      packageName = "node-abi";
      version = "3.54.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/node-abi/-/node-abi-3.54.0.tgz";
        sha512 = "p7eGEiQil0YUV3ItH4/tBb781L5impVmmx2E9FRKF7d18XXzp4PGT2tdYMFY6wQqgxD0IwNZOiSJ0/K0fSi/OA==";
      };
    };
    "node-releases-2.0.14" = {
      name = "node-releases";
      packageName = "node-releases";
      version = "2.0.14";
      src = fetchurl {
        url = "https://registry.npmjs.org/node-releases/-/node-releases-2.0.14.tgz";
        sha512 = "y10wOWt8yZpqXmOgRo77WaHEmhYQYGNA6y421PKsKYWEK8aW+cqAphborZDhqfyKrbZEN92CN1X2KbafY2s7Yw==";
      };
    };
    "once-1.4.0" = {
      name = "once";
      packageName = "once";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/once/-/once-1.4.0.tgz";
        sha512 = "lNaJgI+2Q5URQBkccEKHTQOPaXdUxnZZElQTZY0MFUAuaEqe1E+Nyvgdz/aIyNi6Z9MzO5dv1H8n58/GELp3+w==";
      };
    };
    "picocolors-1.0.0" = {
      name = "picocolors";
      packageName = "picocolors";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/picocolors/-/picocolors-1.0.0.tgz";
        sha512 = "1fygroTLlHu66zi26VoTDv8yRgm0Fccecssto+MhsZ0D/DGW2sm8E8AjW7NU5VVTRt5GxbeZ5qBuJr+HyLYkjQ==";
      };
    };
    "prebuild-install-7.1.1" = {
      name = "prebuild-install";
      packageName = "prebuild-install";
      version = "7.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/prebuild-install/-/prebuild-install-7.1.1.tgz";
        sha512 = "jAXscXWMcCK8GgCoHOfIr0ODh5ai8mj63L2nWrjuAgXE6tDyYGnx4/8o/rCgU+B4JSyZBKbeZqzhtwtC3ovxjw==";
      };
    };
    "pump-3.0.0" = {
      name = "pump";
      packageName = "pump";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pump/-/pump-3.0.0.tgz";
        sha512 = "LwZy+p3SFs1Pytd/jYct4wpv49HiYCqd9Rlc5ZVdk0V+8Yzv6jR5Blk3TRmPL1ft69TxP0IMZGJ+WPFU2BFhww==";
      };
    };
    "rc-1.2.8" = {
      name = "rc";
      packageName = "rc";
      version = "1.2.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/rc/-/rc-1.2.8.tgz";
        sha512 = "y3bGgqKj3QBdxLbLkomlohkvsA8gdAiUQlSBJnBhfn+BPxg4bc62d8TcBW15wavDfgexCgccckhcZvywyQYPOw==";
      };
    };
    "readable-stream-3.6.2" = {
      name = "readable-stream";
      packageName = "readable-stream";
      version = "3.6.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/readable-stream/-/readable-stream-3.6.2.tgz";
        sha512 = "9u/sniCrY3D5WdsERHzHE4G2YCXqoG5FTHUiCC4SIbr6XcLZBY05ya9EKjYek9O5xOAwjGq+1JdGBAS7Q9ScoA==";
      };
    };
    "safe-buffer-5.2.1" = {
      name = "safe-buffer";
      packageName = "safe-buffer";
      version = "5.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/safe-buffer/-/safe-buffer-5.2.1.tgz";
        sha512 = "rp3So07KcdmmKbGvgaNxQSJr7bGVSVk5S9Eq1F+ppbRo70+YeaDxkw5Dd8NPN+GD6bjnYm2VuPuCXmpuYvmCXQ==";
      };
    };
    "semver-6.3.1" = {
      name = "semver";
      packageName = "semver";
      version = "6.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/semver/-/semver-6.3.1.tgz";
        sha512 = "BR7VvDCVHO+q2xBEWskxS6DJE1qRnb7DxzUrogb71CWoSficBxYsiAGd+Kl0mmq/MprG9yArRkyrQxTO6XjMzA==";
      };
    };
    "semver-7.5.4" = {
      name = "semver";
      packageName = "semver";
      version = "7.5.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/semver/-/semver-7.5.4.tgz";
        sha512 = "1bCSESV6Pv+i21Hvpxp3Dx+pSD8lIPt8uVjRrxAUt/nbswYc+tK6Y2btiULjd4+fnq15PX+nqQDC7Oft7WkwcA==";
      };
    };
    "simple-concat-1.0.1" = {
      name = "simple-concat";
      packageName = "simple-concat";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/simple-concat/-/simple-concat-1.0.1.tgz";
        sha512 = "cSFtAPtRhljv69IK0hTVZQ+OfE9nePi/rtJmw5UjHeVyVroEqJXP1sFztKUy1qU+xvz3u/sfYJLa947b7nAN2Q==";
      };
    };
    "simple-get-4.0.1" = {
      name = "simple-get";
      packageName = "simple-get";
      version = "4.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/simple-get/-/simple-get-4.0.1.tgz";
        sha512 = "brv7p5WgH0jmQJr1ZDDfKDOSeWWg+OVypG99A/5vYGPqJ6pxiaHLy8nxtFjBA7oMa01ebA9gfh1uMCFqOuXxvA==";
      };
    };
    "string_decoder-1.3.0" = {
      name = "string_decoder";
      packageName = "string_decoder";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/string_decoder/-/string_decoder-1.3.0.tgz";
        sha512 = "hkRX8U1WjJFd8LsDJ2yQ/wWWxaopEsABU1XfkM8A+j0+85JAGppt16cr1Whg6KIbb4okU6Mql6BOj+uup/wKeA==";
      };
    };
    "strip-json-comments-2.0.1" = {
      name = "strip-json-comments";
      packageName = "strip-json-comments";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/strip-json-comments/-/strip-json-comments-2.0.1.tgz";
        sha512 = "4gB8na07fecVVkOI6Rs4e7T6NOTki5EmL7TUduTs6bu3EdnSycntVJ4re8kgZA+wx9IueI2Y11bfbgwtzuE0KQ==";
      };
    };
    "supports-color-5.5.0" = {
      name = "supports-color";
      packageName = "supports-color";
      version = "5.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/supports-color/-/supports-color-5.5.0.tgz";
        sha512 = "QjVjwdXIt408MIiAqCX4oUKsgU2EqAGzs2Ppkm4aQYbjm+ZEWEcW4SfFNTr4uMNZma0ey4f5lgLrkB0aX0QMow==";
      };
    };
    "tar-fs-2.1.1" = {
      name = "tar-fs";
      packageName = "tar-fs";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/tar-fs/-/tar-fs-2.1.1.tgz";
        sha512 = "V0r2Y9scmbDRLCNex/+hYzvp/zyYjvFbHPNgVTKfQvVrb6guiE/fxP+XblDNR011utopbkex2nM4dHNV6GDsng==";
      };
    };
    "tar-stream-2.2.0" = {
      name = "tar-stream";
      packageName = "tar-stream";
      version = "2.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/tar-stream/-/tar-stream-2.2.0.tgz";
        sha512 = "ujeqbceABgwMZxEJnk2HDY2DlnUZ+9oEcb1KzTVfYHio0UE6dG71n60d8D2I4qNvleWrrXpmjpt7vZeF1LnMZQ==";
      };
    };
    "to-fast-properties-2.0.0" = {
      name = "to-fast-properties";
      packageName = "to-fast-properties";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-fast-properties/-/to-fast-properties-2.0.0.tgz";
        sha512 = "/OaKK0xYrs3DmxRYqL/yDc+FxFUVYhDlXMhRmv3z915w2HF1tnN1omB354j8VUGO/hbRzyD6Y3sA7v7GS/ceog==";
      };
    };
    "tunnel-agent-0.6.0" = {
      name = "tunnel-agent";
      packageName = "tunnel-agent";
      version = "0.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/tunnel-agent/-/tunnel-agent-0.6.0.tgz";
        sha512 = "McnNiV1l8RYeY8tBgEpuodCC1mLUdbSN+CYBL7kJsJNInOP8UjDDEwdk6Mw60vdLLrr5NHKZhMAOSrR2NZuQ+w==";
      };
    };
    "update-browserslist-db-1.0.13" = {
      name = "update-browserslist-db";
      packageName = "update-browserslist-db";
      version = "1.0.13";
      src = fetchurl {
        url = "https://registry.npmjs.org/update-browserslist-db/-/update-browserslist-db-1.0.13.tgz";
        sha512 = "xebP81SNcPuNpPP3uzeW1NYXxI3rxyJzF3pD6sH4jE7o/IX+WtSpwnVU+qIsDPyk0d3hmFQ7mjqc6AtV604hbg==";
      };
    };
    "util-deprecate-1.0.2" = {
      name = "util-deprecate";
      packageName = "util-deprecate";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/util-deprecate/-/util-deprecate-1.0.2.tgz";
        sha512 = "EPD5q1uXyFxJpCrLnCc1nHnq3gOa6DZBocAIiI2TaSCA7VCJ1UJDMagCzIkXNsUYfD1daK//LTEQ8xiIbrHtcw==";
      };
    };
    "wrappy-1.0.2" = {
      name = "wrappy";
      packageName = "wrappy";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz";
        sha512 = "l4Sp/DRseor9wL6EvV2+TuQn63dMkPjZ/sp9XkghTEbV9KlPS1xUsZ3u7/IQO4wxtcFB4bgpQPRcR3QCvezPcQ==";
      };
    };
    "yallist-3.1.1" = {
      name = "yallist";
      packageName = "yallist";
      version = "3.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/yallist/-/yallist-3.1.1.tgz";
        sha512 = "a4UGQaWPH59mOXUYnAG2ewncQS4i4F43Tv3JoAM+s2VDAmS9NsK8GpDMLrCHPksFT7h3K6TOoUNn2pb7RoXx4g==";
      };
    };
    "yallist-4.0.0" = {
      name = "yallist";
      packageName = "yallist";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/yallist/-/yallist-4.0.0.tgz";
        sha512 = "3wdGidZyq5PB084XLES5TpOSRA3wjXAlIWMhum2kRcv/41Sn2emQ0dycQW4uZXLejwKvg6EsvbdlVL+FYEct7A==";
      };
    };
  };
in
{
  webcrack = nodeEnv.buildNodePackage {
    name = "webcrack";
    packageName = "webcrack";
    version = "2.13.0";
    src = fetchurl {
      url = "https://registry.npmjs.org/webcrack/-/webcrack-2.13.0.tgz";
      sha512 = "+YCR1zdj2ucVAandKjU6niRJHbuZafu1vd71eoKCRmFqmWob3+FkujREHny6PfLb8G0HJpXNDhoGKiXHNxcFsA==";
    };
    dependencies = [
      sources."@ampproject/remapping-2.2.1"
      sources."@babel/code-frame-7.23.5"
      sources."@babel/compat-data-7.23.5"
      sources."@babel/core-7.23.9"
      sources."@babel/generator-7.23.6"
      sources."@babel/helper-compilation-targets-7.23.6"
      sources."@babel/helper-environment-visitor-7.22.20"
      sources."@babel/helper-function-name-7.23.0"
      sources."@babel/helper-hoist-variables-7.22.5"
      sources."@babel/helper-module-imports-7.22.15"
      sources."@babel/helper-module-transforms-7.23.3"
      sources."@babel/helper-simple-access-7.22.5"
      sources."@babel/helper-split-export-declaration-7.22.6"
      sources."@babel/helper-string-parser-7.23.4"
      sources."@babel/helper-validator-identifier-7.22.20"
      sources."@babel/helper-validator-option-7.23.5"
      sources."@babel/helpers-7.23.9"
      sources."@babel/highlight-7.23.4"
      sources."@babel/parser-7.23.9"
      sources."@babel/template-7.23.9"
      sources."@babel/traverse-7.23.9"
      sources."@babel/types-7.23.9"
      sources."@codemod/matchers-1.7.0"
      sources."@codemod/parser-1.4.1"
      sources."@codemod/utils-1.1.0"
      sources."@jridgewell/gen-mapping-0.3.3"
      sources."@jridgewell/resolve-uri-3.1.1"
      sources."@jridgewell/set-array-1.1.2"
      sources."@jridgewell/sourcemap-codec-1.4.15"
      sources."@jridgewell/trace-mapping-0.3.22"
      sources."ansi-styles-3.2.1"
      sources."babel-helper-mark-eval-scopes-0.4.3"
      sources."babel-plugin-minify-mangle-names-0.5.1"
      sources."base64-js-1.5.1"
      sources."bl-4.1.0"
      sources."browserslist-4.22.3"
      sources."buffer-5.7.1"
      sources."caniuse-lite-1.0.30001583"
      sources."chalk-2.4.2"
      sources."chownr-1.1.4"
      sources."color-convert-1.9.3"
      sources."color-name-1.1.3"
      sources."commander-11.1.0"
      sources."convert-source-map-2.0.0"
      sources."debug-4.3.4"
      sources."decompress-response-6.0.0"
      sources."deep-extend-0.6.0"
      sources."detect-libc-2.0.2"
      sources."electron-to-chromium-1.4.656"
      sources."end-of-stream-1.4.4"
      sources."escalade-3.1.1"
      sources."escape-string-regexp-1.0.5"
      sources."expand-template-2.0.3"
      sources."fs-constants-1.0.0"
      sources."gensync-1.0.0-beta.2"
      sources."github-from-package-0.0.0"
      sources."globals-11.12.0"
      sources."has-flag-3.0.0"
      sources."ieee754-1.2.1"
      sources."inherits-2.0.4"
      sources."ini-1.3.8"
      sources."isolated-vm-4.7.2"
      sources."js-tokens-4.0.0"
      sources."jsesc-2.5.2"
      sources."json5-2.2.3"
      sources."lru-cache-5.1.1"
      sources."mimic-response-3.1.0"
      sources."minimist-1.2.8"
      sources."mkdirp-classic-0.5.3"
      sources."ms-2.1.2"
      sources."napi-build-utils-1.0.2"
      (
        sources."node-abi-3.54.0"
        // {
          dependencies = [
            sources."lru-cache-6.0.0"
            sources."semver-7.5.4"
            sources."yallist-4.0.0"
          ];
        }
      )
      sources."node-releases-2.0.14"
      sources."once-1.4.0"
      sources."picocolors-1.0.0"
      sources."prebuild-install-7.1.1"
      sources."pump-3.0.0"
      sources."rc-1.2.8"
      sources."readable-stream-3.6.2"
      sources."safe-buffer-5.2.1"
      sources."semver-6.3.1"
      sources."simple-concat-1.0.1"
      sources."simple-get-4.0.1"
      sources."string_decoder-1.3.0"
      sources."strip-json-comments-2.0.1"
      sources."supports-color-5.5.0"
      sources."tar-fs-2.1.1"
      sources."tar-stream-2.2.0"
      sources."to-fast-properties-2.0.0"
      sources."tunnel-agent-0.6.0"
      sources."update-browserslist-db-1.0.13"
      sources."util-deprecate-1.0.2"
      sources."wrappy-1.0.2"
      sources."yallist-3.1.1"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Deobfuscate, unminify and unpack bundled javascript";
      homepage = "https://webcrack.netlify.app";
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
}
