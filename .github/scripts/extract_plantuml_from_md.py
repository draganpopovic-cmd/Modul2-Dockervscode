#!/usr/bin/env python3
import os
import re
import hashlib
from pathlib import Path

# Wo .md gesucht wird (Repo-root)
ROOT = Path(".")
# Output-Ordner für generierte .puml
OUT_DIR = Path("diagrams/extracted")

# ```plantuml ... ``` Blöcke
BLOCK_RE = re.compile(r"```plantuml\s*\n(.*?)\n```", re.DOTALL | re.IGNORECASE)

def stable_name(md_path: Path, index: int, content: str) -> str:
    # stabiler Dateiname, damit Commits nicht ständig umsortieren
    h = hashlib.sha1((str(md_path) + str(index) + content).encode("utf-8")).hexdigest()[:10]
    base = md_path.stem.replace(" ", "_")
    return f"{base}_{index:02d}_{h}.puml"

def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    md_files = [p for p in ROOT.rglob("*.md") if ".git" not in p.parts]
    written = 0

    for md in md_files:
        text = md.read_text(encoding="utf-8", errors="ignore")
        blocks = BLOCK_RE.findall(text)
        for i, content in enumerate(blocks, start=1):
            content = content.strip()

            # optional: nur Blöcke schreiben, die @start... enthalten
            # if "@start" not in content:
            #     continue

            fname = stable_name(md, i, content)
            out_path = OUT_DIR / fname
            out_path.write_text(content + "\n", encoding="utf-8")
            written += 1

    print(f"Extracted {written} PlantUML blocks into {OUT_DIR}")

if __name__ == "__main__":
    main()