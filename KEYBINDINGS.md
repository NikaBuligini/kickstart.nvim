# Key bindings

Quick reference for your current Neovim setup.

- **Navigate:** [Notation](#read-the-notation) · [Files](#find-files) · [Pickers](#use-pickers) · [Directories](#browse-directories)
- **Edit:** [Code](#inspect-code) · [Diagnostics](#review-diagnostics) · [Formatting](#format-and-toggle) · [Text](#edit-text) · [Structures](#select-structures) · [Folds](#control-folds)
- **Write:** [Search and replace](#replace-across-files) · [Completion and snippets](#complete-and-expand) · [Lua](#execute-lua)
- **Develop:** [Git](#work-with-git) · [Tests](#run-tests) · [Debugging](#control-debugging)
- **Organize:** [Sessions](#manage-sessions) · [Windows and terminals](#move-between-windows) · [More help](#look-up-more)

---

## Read the notation

`<leader>` and `<localleader>` both mean **Space**: `<leader>sf` is Space, then s, then f. Keys are case-sensitive: `grd` and `grD`, or `<leader>hr` and `<leader>hR`, do different things.

| Notation                      | Meaning                                                              |
| ----------------------------- | -------------------------------------------------------------------- |
| N / V / I / S / T / O         | Normal / Visual / Insert / Select / Terminal / Operator-pending mode |
| `<C-x>` / `<M-x>` / `<S-Tab>` | Ctrl+x / Alt (Meta)+x / Shift+Tab                                    |
| `<CR>` / `<Esc>`              | Enter / Escape                                                       |
| `{motion}` / `{id}`           | Supply a motion or textobject / surrounding identifier               |

Tables list configured mappings unless marked as defaults; buffer-local mappings take priority over global ones. Alt/Option combinations and function keys depend on what your terminal sends.

---

## Find files

| Key                | Mode | Action                                                    |
| ------------------ | ---- | --------------------------------------------------------- |
| `<leader>pf`       | N    | FFF: find files                                           |
| `<leader>pg`       | N    | FFF: live grep                                            |
| `<leader>pz`       | N    | FFF: fuzzy grep, with fuzzy/plain modes                   |
| `<leader>pw`       | N    | FFF: grep with the word under the cursor prefilled        |
| `<leader>sf`       | N    | Telescope: find files, including hidden files             |
| `<leader>sb`       | N    | Telescope: file browser                                   |
| `<leader>sg`       | N    | Telescope: live grep                                      |
| `<leader>sg`       | V    | Telescope: grep the selection                             |
| `<leader>sw`       | N    | Telescope: grep the current word                          |
| `<leader>sw`       | V    | Telescope: fuzzy-find the selection in the current buffer |
| `<leader>/`        | N    | Telescope: fuzzy-find in the current buffer               |
| `<leader>s/`       | N    | Telescope: live grep in open files                        |
| `<leader><leader>` | N    | Telescope: open buffers                                   |
| `<leader>s.`       | N    | Telescope: recent files                                   |
| `<leader>sn`       | N    | Telescope: files in the Neovim config directory           |
| `<leader>sr`       | N    | Telescope: resume the previous picker                     |
| `<leader>ss`       | N    | Telescope: choose a built-in picker                       |
| `<leader>sc`       | N    | Telescope: commands                                       |
| `<leader>sh`       | N    | Telescope: help tags                                      |
| `<leader>sk`       | N    | Telescope: key mappings                                   |
| `<Esc>`            | N    | Clear search highlighting                                 |

---

## Use pickers

These are installed plugin defaults, active inside the picker rather than your editing buffer.

| Key                         | Telescope mode | Action                                                 |
| --------------------------- | -------------- | ------------------------------------------------------ |
| `<C-n>` / `<C-p>`           | I              | Next / previous result                                 |
| `j` / `k`                   | N              | Next / previous result                                 |
| `<Down>` / `<Up>`           | I, N           | Next / previous result                                 |
| `<CR>`                      | I, N           | Open selection                                         |
| `<C-x>` / `<C-v>` / `<C-t>` | I, N           | Open in horizontal split / vertical split / tab        |
| `<C-u>` / `<C-d>`           | I, N           | Scroll preview up / down                               |
| `<Tab>` / `<S-Tab>`         | I, N           | Toggle selection and move down / up the result order   |
| `<C-q>`                     | I, N           | Send all filtered results to quickfix and open it      |
| `<M-q>`                     | I, N           | Send marked results to quickfix and open it            |
| `<C-/>`                     | I              | Show picker mappings                                   |
| `?`                         | N              | Show picker mappings                                   |
| `<C-c>`                     | I              | Close picker                                           |
| `<Esc>`                     | I → N          | Leave Insert mode; press again in Normal mode to close |

| Key                         | FFF mode | Action                                                                 |
| --------------------------- | -------- | ---------------------------------------------------------------------- |
| `<C-n>` / `<C-p>` or arrows | I, N     | Next / previous result                                                 |
| `<CR>`                      | I, N     | Open selection                                                         |
| `<C-s>` / `<C-v>` / `<C-t>` | I, N     | Open in horizontal split / vertical split / tab                        |
| `<C-u>` / `<C-d>`           | I, N     | Scroll preview up / down                                               |
| `<Tab>`                     | I, N     | Mark or unmark a result                                                |
| `<C-q>`                     | I, N     | Send marked results, or search results if none are marked, to quickfix |
| `<S-Tab>`                   | I, N     | Cycle grep modes in a grep picker                                      |
| `<C-Up>` / `<C-Down>`       | I        | Previous / next query in history                                       |
| `<Esc>`                     | I, N     | Close picker                                                           |

---

## Browse directories

`-` opens Oil explicitly; Telescope File Browser handles directory buffers by default. Edit filenames as text in Oil, then use `:w` to apply filesystem changes.

| Key                         | Context           | Action                                               |
| --------------------------- | ----------------- | ---------------------------------------------------- |
| `-`                         | N, editing buffer | Open parent directory in Oil                         |
| `<CR>`                      | Oil, N/V          | Open selected entry or entries                       |
| `<C-s>` / `<C-h>` / `<C-t>` | Oil, N/V          | Open in vertical split / horizontal split / tab      |
| `<C-p>`                     | Oil, N/V          | Preview entry                                        |
| `-` / `_`                   | Oil, N            | Parent directory / current working directory         |
| `g.`                        | Oil, N            | Toggle hidden files                                  |
| `<C-l>`                     | Oil, N/V          | Refresh directory                                    |
| `gs`                        | Oil, N/V          | Open Grug Far with this directory as the search path |
| `g?`                        | Oil, N            | Show mappings                                        |
| `<C-c>`                     | Oil, N            | Close Oil                                            |

Oil's `gs` is customized for search and replace, not sorting. Its `<C-h>` and `<C-l>` also override the usual window-focus mappings.

---

## Inspect code

Configured LSP mappings are local to buffers with an attached language server. Server-specific actions appear only when that server attaches.

| Key           | Mode      | Action                                                  |
| ------------- | --------- | ------------------------------------------------------- |
| `grd` / `grD` | N         | Definition picker / declaration                         |
| `grr`         | N         | References picker                                       |
| `gri`         | N         | Implementation picker                                   |
| `grt`         | N         | Type-definition picker                                  |
| `grn`         | N         | Rename symbol                                           |
| `gra`         | N, V      | Code action                                             |
| `gO` / `gW`   | N         | Document / workspace symbol picker                      |
| `grs`         | N, vtsls  | Go to source definition                                 |
| `<leader>co`  | N, vtsls  | Organize imports                                        |
| `<leader>cm`  | N, vtsls  | Add missing imports                                     |
| `<leader>cr`  | N, vtsls  | Rename file and update imports                          |
| `<leader>cv`  | N, vtsls  | Select TypeScript version                               |
| `<leader>cF`  | N, oxlint | Apply Oxlint fixes                                      |
| `<leader>rl`  | N         | Run `:lsp restart`                                      |
| `K`           | N         | Hover documentation (Neovim default when available)     |
| `<C-s>`       | I         | Signature help (Neovim default)                         |
| `grx`         | N         | Run code lens (Neovim default, server support required) |

---

## Review diagnostics

| Key               | Mode                      | Action                                                                |
| ----------------- | ------------------------- | --------------------------------------------------------------------- |
| `<leader>sd`      | N                         | Telescope diagnostic picker                                           |
| `<leader>q`       | N                         | Open current-buffer diagnostics in the current window's location list |
| `]l` / `[l`       | N                         | Next / previous location-list item                                    |
| `<M-j>` / `<M-k>` | N                         | Next / previous quickfix item                                         |
| `>` / `<`         | N, quickfix/location list | Expand result context by two lines each side / collapse it            |
| `]d` / `[d`       | N                         | Next / previous diagnostic (Neovim defaults)                          |
| `]D` / `[D`       | N                         | Last / first diagnostic (Neovim defaults)                             |
| `<C-w>d`          | N                         | Diagnostic float at cursor (Neovim default)                           |

Despite its “Quickfix” mapping description, `<leader>q` opens a **location list**, not quickfix; from a location-list buffer it closes that list. Diagnostic jumps also open a non-focused float with details.

---

## Format and toggle

| Key          | Mode                    | Action                                                                        |
| ------------ | ----------------------- | ----------------------------------------------------------------------------- |
| `<leader>f`  | N, V                    | Format buffer / selection asynchronously with Conform                         |
| `<leader>uf` | N                       | Toggle format-on-save for this buffer                                         |
| `<leader>ud` | N                       | Switch diagnostic display between current-line virtual lines and virtual text |
| `<leader>uh` | N, supported LSP buffer | Toggle inlay hints                                                            |
| `<leader>ub` | N, Gitsigns buffer      | Toggle current-line Git blame                                                 |
| `<leader>uD` | N, Gitsigns buffer      | Preview the hunk inline, including deleted lines                              |

Format-on-save starts enabled for ordinary buffers with a configured formatter. Conform never falls back to LSP formatting here; `<leader>uD` is a preview action, not a persistent display toggle.

---

## Edit text

Mini operators use `{motion}` in Normal mode or operate directly on a Visual selection. These are plugin defaults except for `gR`; repeat the final character for a linewise action: `gRR`, `gmm`, `gss`, `gxx`, or `g==`.

| Key                         | Mode  | Action                                                   |
| --------------------------- | ----- | -------------------------------------------------------- |
| `gR{motion}` / `gR`         | N / V | Replace with register contents                           |
| `gm{motion}` / `gm`         | N / V | Duplicate text                                           |
| `gs{motion}` / `gs`         | N / V | Sort text                                                |
| `gx{motion}` / `gx`         | N / V | Mark a region, then repeat on another to exchange them   |
| `g={motion}` / `g=`         | N / V | Evaluate a Lua expression and replace it with its result |
| `gS`                        | N, V  | Toggle splitting/joining arguments inside brackets       |
| `<leader>ca` / `<leader>cA` | N     | Swap parameter with next / previous parameter            |

The replace prefix is deliberately **`gR`**, leaving `gr` available for LSP actions. For example, `gRiw` replaces the word under the cursor with the default register.

Mini surround defaults:

| Key                 | Mode | Action                                                      |
| ------------------- | ---- | ----------------------------------------------------------- |
| `sa{motion}{id}`    | N    | Add surrounding; `saiw)` wraps a word in parentheses        |
| `sa{id}`            | V    | Surround the selection                                      |
| `sd{id}`            | N    | Delete surrounding; `sd"` removes double quotes             |
| `sr{old}{new}`      | N    | Replace surrounding; `sr"'` changes double to single quotes |
| `sf{id}` / `sF{id}` | N    | Find surrounding to the right / left                        |
| `sh{id}`            | N    | Highlight surrounding                                       |

---

## Select structures

Use textobjects after an operator (`dif`, `yic`) or from Visual mode (`vaf`). Function, class, and parameter objects rely on available Tree-sitter parsers and queries.

| Key                                   | Mode    | Action                                          |
| ------------------------------------- | ------- | ----------------------------------------------- |
| `if` / `af`                           | O, V    | Inside / around function                        |
| `ic` / `ac`                           | O, V    | Inside / around class                           |
| `ia` / `aa`                           | O, V    | Inside / around parameter                       |
| `i)` / `a)`; `i]` / `a]`; `i}` / `a}` | O, V    | Inside / around the corresponding bracket pair  |
| `iq` / `aq`                           | O, V    | Inside / around quotes (Mini default)           |
| `it` / `at`                           | O, V    | Inside / around tag (Mini default)              |
| `in{id}` / `an{id}`                   | O, V    | Inside / around next object                     |
| `il{id}` / `al{id}`                   | O, V    | Inside / around previous object                 |
| `g[{id}` / `g]{id}`                   | N, V, O | Move to left / right edge of an “around” object |
| `]m` / `[m`                           | N, V, O | Next / previous function start                  |
| `]M` / `[M`                           | N, V, O | Next / previous function end                    |

Mini searches up to 500 surrounding lines for textobjects in this config.

---

## Control folds

Folds start open in this config (`foldlevel` and `foldlevelstart` are 99). These are native Neovim keys; Tree-sitter provides folds when a parser is available.

| Key  | Mode | Action                       |
| ---- | ---- | ---------------------------- |
| `za` | N    | Toggle fold under the cursor |
| `zo` | N    | Open fold under the cursor   |
| `zc` | N    | Close fold under the cursor  |
| `zR` | N    | Open all folds               |
| `zM` | N    | Close all folds              |

---

## Replace across files

| Key                 | Context     | Action                                     |
| ------------------- | ----------- | ------------------------------------------ |
| `<leader>sR`        | N           | Open Grug Far search and replace           |
| `<leader>sR`        | V           | Open Grug Far with the selection           |
| `gs`                | Oil, N/V    | Open Grug Far scoped to the directory      |
| `<Tab>` / `<S-Tab>` | Grug Far, N | Next / previous input field                |
| `<localleader>r`    | Grug Far, N | Run replacement                            |
| `<localleader>s`    | Grug Far, N | Sync edited result locations back to files |
| `<localleader>l`    | Grug Far, N | Sync the current result line               |
| `<localleader>q`    | Grug Far, N | Send results to quickfix                   |
| `<CR>`              | Grug Far, N | Go to result location                      |
| `<localleader>i`    | Grug Far, N | Preview location                           |
| `<localleader>t`    | Grug Far, N | Open search history                        |
| `<localleader>b`    | Grug Far, N | Abort the running operation                |
| `<localleader>c`    | Grug Far, N | Close Grug Far                             |
| `g?`                | Grug Far, N | Show help                                  |

Inside Grug Far, `<localleader>q` is Space q and **does** target quickfix, overriding the global diagnostic-list mapping.

---

## Complete and expand

Blink uses the **enter** preset with LuaSnip; the keys below are its installed defaults. `<CR>` accepts a selected completion, while `<Tab>` is for snippet movement, not completion acceptance.

| Key                         | Mode | Action                                             |
| --------------------------- | ---- | -------------------------------------------------- |
| `<C-Space>`                 | I    | Show completion menu, then show/hide documentation |
| `<C-n>` / `<C-p>` or arrows | I    | Select next / previous completion                  |
| `<CR>`                      | I    | Accept selected completion, or fall back to Enter  |
| `<C-e>`                     | I    | Cancel completion                                  |
| `<C-b>` / `<C-f>`           | I    | Scroll completion documentation up / down          |
| `<C-k>`                     | I, S | Show/hide signature help                           |
| `<Tab>` / `<S-Tab>`         | I, S | Jump forward / backward through snippet fields     |

In Insert mode, Blink's buffer-local `<Tab>` handles snippets first, then falls back to Copilot's global `<Tab>` mapping. Copilot accepts an available suggestion or falls back to a normal Tab; this ordering applies while Blink is enabled in the buffer.

Blink's LuaSnip integration can also expand a matching trigger when the completion menu is hidden and no local forward jump is available. This snippet expansion takes priority over Copilot too.

Copilot defaults (Insert mode; Copilot must be available):

| Key               | Action                                                        |
| ----------------- | ------------------------------------------------------------- |
| `<Tab>`           | Accept suggestion when Blink has no snippet action to perform |
| `<M-]>` / `<M-[>` | Next / previous suggestion                                    |
| `<M-\>`           | Request a suggestion                                          |
| `<M-Right>`       | Accept next word                                              |
| `<M-C-Right>`     | Accept next line                                              |
| `<C-]>`           | Dismiss suggestion                                            |

Type a snippet trigger, select its Blink completion, and press Enter to expand it.

| Trigger     | Filetypes        | Expansion                                  |
| ----------- | ---------------- | ------------------------------------------ |
| `vitest`    | TS, TSX, JS, JSX | Vitest import, describe block, and test    |
| `testcase`  | TS, TSX, JS, JSX | Synchronous `it` block                     |
| `testasync` | TS, TSX, JS, JSX | Async `it` block                           |
| `component` | TSX only         | Props type and exported function component |

---

## Work with git

Hunk mappings are local to buffers where Gitsigns attaches; `<leader>lg` is global.

| Key                         | Mode | Action                                                          |
| --------------------------- | ---- | --------------------------------------------------------------- |
| `<leader>lg`                | N    | Open LazyGit                                                    |
| `]c` / `[c`                 | N    | Next / previous hunk; use built-in diff navigation in diff mode |
| `<leader>hs`                | N, V | Stage hunk / selected lines                                     |
| `<leader>hr`                | N, V | Reset hunk / selected lines                                     |
| `<leader>hS`                | N    | Stage entire buffer                                             |
| `<leader>hR`                | N    | Reset entire buffer                                             |
| `<leader>hu`                | N    | Call `stage_hunk` again; on a staged hunk, unstage it           |
| `<leader>hp`                | N    | Preview hunk                                                    |
| `<leader>hb`                | N    | Show line blame                                                 |
| `<leader>hd` / `<leader>hD` | N    | Diff against index / last commit                                |

`<leader>hu` is labeled “undo stage hunk,” but it is not an undo-last-stage command: it calls the same function as `<leader>hs`.

---

## Run tests

Neotest is configured with the Vitest adapter; debugging also needs a working DAP setup.

| Key          | Mode | Action                            |
| ------------ | ---- | --------------------------------- |
| `<leader>tt` | N    | Run nearest test                  |
| `<leader>tT` | N    | Run test suite                    |
| `<leader>tf` | N    | Run tests in current file         |
| `<leader>tl` | N    | Run last test                     |
| `<leader>td` | N    | Debug nearest test                |
| `<leader>tS` | N    | Stop running tests                |
| `<leader>to` | N    | Open and focus test output        |
| `<leader>ts` | N    | Toggle test summary               |
| `<leader>tp` | N    | Toggle output panel               |
| `[t` / `]t`  | N    | Previous / next failed test       |
| `<leader>nx` | N    | Open Nx actions through Telescope |

---

## Control debugging

| Key                      | Mode | Action                     |
| ------------------------ | ---- | -------------------------- |
| `<F5>`                   | N    | Start / continue           |
| `<F1>` / `<F2>` / `<F3>` | N    | Step into / over / out     |
| `<leader>b`              | N    | Toggle breakpoint          |
| `<leader>B`              | N    | Set conditional breakpoint |
| `<F7>`                   | N    | Toggle debugger UI         |

Node attach configurations are provided for JS/TS, with a current-file launch option for JavaScript; `.vscode/launch.json` can supply more. Go debugging is configured only when `go` is executable.

---

## Manage sessions

| Key          | Mode | Action                                           |
| ------------ | ---- | ------------------------------------------------ |
| `<leader>ws` | N    | Restore session for the current directory/branch |
| `<leader>ww` | N    | Save current session                             |
| `<leader>wS` | N    | Select a saved session                           |
| `<leader>wl` | N    | Restore most recent session                      |
| `<leader>wd` | N    | Choose a session to delete                       |
| `<leader>wD` | N    | Stop saving the current session                  |

Starting Neovim with no file arguments attempts to restore a session, except for stdin, diff, and headless starts. Deleting the current session also stops saving it for this run.

---

## Move between windows

| Key                                   | Mode | Action                                                                    |
| ------------------------------------- | ---- | ------------------------------------------------------------------------- |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | N    | Focus left / lower / upper / right window                                 |
| `<C-d>` / `<C-u>`                     | N    | Scroll half-page down / up, then center cursor                            |
| `<leader>cb`                          | N    | Delete listed buffers, then reopen the previous current file (`:%bd\|e#`) |
| `<leader>st`                          | N    | Open a bottom terminal, 15 lines high, and enter Terminal mode            |
| `<Esc><Esc>`                          | T    | Leave Terminal mode without closing the terminal                          |
| `<C-q>`                               | T    | Force-delete the terminal buffer                                          |

After leaving Terminal mode, use Normal-mode window keys; `i` returns to terminal input. `<leader>cb` deletes and reopens rather than preserving the current buffer object, and modified buffers may prompt.

---

## Execute lua

| Key                 | Mode  | Action                                                   |
| ------------------- | ----- | -------------------------------------------------------- |
| `<leader>x`         | N     | Execute the current line as Lua (`:.lua`)                |
| `<leader>x`         | V     | Execute the selected line range as Lua (`:'<,'>lua`)     |
| `g={motion}` / `g=` | N / V | Evaluate Lua expression and replace text with its result |

---

## Look up more

Press `<leader>sk` to search active mappings, or start a prefix such as Space, `gr`, or Space t and let which-key show the choices. For a specific key, `:verbose nmap <Space>sf` or `:verbose imap <Tab>` shows its mapping and where it was defined.

Use `:help mini-surround`, `:help mini-ai`, `:help mini-operators`, `:help oil`, or `:help telescope.mappings` for plugin details. This sheet follows `init.lua`, `lua/config/`, `lua/custom/plugins/`, `snippets/`, and the locally installed plugin and Neovim 0.12.5 documentation.
