#!/usr/bin/env python3
import subprocess, json, os, hashlib, urllib.request, re, sys

CACHE_DIR = "/tmp/waybar-spotify-cache"
os.makedirs(CACHE_DIR, exist_ok=True)

def run(cmd):
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=2)
        return r.stdout.strip()
    except Exception:
        return ""

def get_color(art_url):
    cache_key = hashlib.md5(art_url.encode()).hexdigest()
    color_file = f"{CACHE_DIR}/{cache_key}.color"
    if os.path.exists(color_file):
        return open(color_file).read().strip()
    color = "#1DB954"
    try:
        import tempfile
        tmp = tempfile.mktemp(suffix=".jpg")
        urllib.request.urlretrieve(art_url, tmp)
        out = subprocess.run(
            ["convert", tmp, "-resize", "100x100!", "-colors", "10",
             "-format", "%c", "histogram:info:-"],
            capture_output=True, text=True, timeout=5
        ).stdout
        os.unlink(tmp)
        colors = re.findall(r'#([0-9A-Fa-f]{6})(?![0-9A-Fa-f])', out)
        if colors:
            def vibrancy(h):
                r, g, b = int(h[0:2],16)/255, int(h[2:4],16)/255, int(h[4:6],16)/255
                cmax = max(r,g,b)
                delta = cmax - min(r,g,b)
                s = delta / cmax if cmax else 0
                return s * cmax  # saturation × brightness; punishes dark browns
            color = "#" + max(colors, key=vibrancy).upper()
    except Exception:
        pass
    open(color_file, "w").write(color)
    return color

status = run(["playerctl", "-p", "spotify", "status"])
if not status or status == "Stopped":
    sys.exit(1)

artist  = run(["playerctl", "-p", "spotify", "metadata", "artist"])
title   = run(["playerctl", "-p", "spotify", "metadata", "title"])
art_url = run(["playerctl", "-p", "spotify", "metadata", "mpris:artUrl"])

color = get_color(art_url) if art_url else "#1DB954"

def esc(s):
    return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")

icon = "♫" if status == "Playing" else "⏸"
label = f"{icon} {esc(artist)} - {esc(title)}"
if len(label) > 42:
    label = label[:39] + "..."
pango = f'<span color="{color}">{label}</span>'

print(json.dumps({"text": pango, "tooltip": f"{esc(artist)} — {esc(title)}"}))
