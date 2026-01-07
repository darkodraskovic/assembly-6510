import json
import sys
from pathlib import Path
import re


def convert_gid(gid: int) -> int:
    """
    Convert Tiled GID to engine tile index.

    0  -> -1 (empty)
    n  -> n-1 (0-based tiles)
    """
    if gid == 0:
        return -1
    return gid - 1


def layer_label(name: str) -> str:
    """
    Convert layer name to assembler-friendly label.
    """
    label = name.lower().replace(" ", "_")
    return re.sub(r"[^a-z0-9_]", "", label)


def dump_tile_layer(layer: dict, width: int, out):
    """
    Dump a single tile layer as .byte rows into an open file.
    """
    data = layer["data"]
    label = layer_label(layer["name"])

    out.write(f"{label}:\n")

    for y in range(0, len(data), width):
        row = data[y:y + width]
        converted = [convert_gid(v) for v in row]
        line = ", ".join(str(v) for v in converted)
        out.write(f"    .byte {line}\n")


def main(infile: str):
    infile = Path(infile)

    with infile.open("r") as f:
        m = json.load(f)

    width = m["width"]
    out_file = infile.with_suffix(".asm")

    with out_file.open("w") as out:
        for layer in m["layers"]:
            if layer.get("type") != "tilelayer":
                continue

            dump_tile_layer(layer, width, out)
            out.write("\n")

    print(f"Wrote {out_file}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("usage: python3 charmap_convert.py <map.tmj>")
        sys.exit(1)

    main(sys.argv[1])
