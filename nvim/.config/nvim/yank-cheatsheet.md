# Yank & Register Cheatsheet

Grammar: `"` + register + action → `"ay` (yank into a), `"ap` (paste from a)

Every delete (`d`, `c`, `x`, `s`, visual `p`) is a **cut**: it overwrites `"`.
Only `y` writes to `0`. The macOS clipboard is `+` and only changes when you ask.

## Registers

| Register  | Contains                                              |
| --------- | ----------------------------------------------------- |
| `"`       | Last yank **or** delete. Plain `p` pastes this.       |
| `0`       | Last **yank** only. Deletes never touch it.           |
| `1`–`9`   | Line-sized delete history (`1` = newest)              |
| `-`       | Small deletes within a line (`dw`, `x`)               |
| `a`–`z`   | Named slots you fill yourself (`A`–`Z` appends)       |
| `+`       | macOS system clipboard                                |
| `_`       | Black hole: text sent here is discarded               |
| `.`       | Last inserted text                                    |
| `:`       | Last command-line command                             |
| `/`       | Last search pattern                                   |
| `%`       | Current file name                                     |

## Yank

| Keys        | Action                              |
| ----------- | ----------------------------------- |
| `yy` / `Y`  | Yank line / to end of line          |
| `yiw`       | Yank word                           |
| `yi"` `yi(` | Yank inside quotes / parens         |
| `yap`       | Yank paragraph                      |
| `"ayy`      | Yank line into register `a`         |
| `"Ayy`      | **Append** line to register `a`     |
| `"+y`       | Yank to macOS clipboard             |
| `<leader>cp`| Copy relative file path to clipboard|

## Paste

| Keys           | Action                                        |
| -------------- | --------------------------------------------- |
| `p` / `P`      | Paste after / before cursor                   |
| `"0p`          | Paste last **yank** (ignores deletes)         |
| `"ap`          | Paste register `a`                            |
| `"+p`          | Paste from macOS clipboard                    |
| `"1p` then `.` | Paste delete history: `.` steps to `2`, `3`…  |
| `gp` / `gP`    | Paste and move cursor after pasted text       |
| `]p` / `[p`    | Paste matching current indent                 |

## Visual mode

| Keys | Action                                                    |
| ---- | --------------------------------------------------------- |
| `P`  | Replace selection, **keep** your yank (repeatable)        |
| `p`  | Replace selection, replaced text goes into `"`            |
| `"_d`| Delete selection without saving it                        |

## Delete without saving

| Keys        | Action                         |
| ----------- | ------------------------------ |
| `"_dd`      | Delete line, keep registers    |
| `"_ciw`     | Change word, keep registers    |
| `"_x`       | Delete char, keep registers    |

## Insert & command-line mode

| Keys      | Action                              |
| --------- | ----------------------------------- |
| `<C-r>0`  | Insert last yank                    |
| `<C-r>a`  | Insert register `a`                 |
| `<C-r>+`  | Insert macOS clipboard (or Cmd-V)   |
| `<C-r>"`  | Insert last yank/delete             |
| `<C-r><C-w>` | (cmdline) Insert word under cursor |

## Inspect

| Keys / Command | Action                           |
| -------------- | -------------------------------- |
| `:reg`         | Show all registers               |
| `:reg 0a"`     | Show only `0`, `a`, `"`          |
| `"` (wait)     | which-key register preview       |

## Common workflows

- **Paste the same thing many times:** `yiw`, then visual-select + `P` on each target.
- **Yank, delete stuff, then paste the yank:** `"0p`.
- **Move a line:** `dd`, move, `p`.
- **Swap two chars:** `xp`. **Swap two lines:** `ddp`.
- **Keep a snippet around all session:** `"ay…`, paste anywhere with `"ap`.
- **Collect lines from many places:** `"ayy` first, then `"Ayy` for each extra.
- **Recover something deleted a while ago:** `:reg` to find it, then `"3p` (etc).
