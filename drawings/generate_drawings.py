#!/usr/bin/env python3
"""Pano yerleşimi için 1:1 mm ön görünüş SVG — seri başına tek çizim, şeffaf zemin."""

from pathlib import Path
import json

ROOT = Path(__file__).parent

STYLE = """
  .body-k   { fill: #3a3f47; stroke: #1e293b; stroke-width: 0.2; }
  .body-mcb { fill: #f1f5f9; stroke: #334155; stroke-width: 0.2; }
  .body-rcc { fill: #f8fafc; stroke: #334155; stroke-width: 0.2; }
  .body-vfd { fill: #e8ecf0; stroke: #475569; stroke-width: 0.2; }
  .vfd-disp { fill: #1e293b; stroke: #64748b; stroke-width: 0.12; }
  .vfd-key  { fill: #cbd5e1; stroke: #64748b; stroke-width: 0.1; }
  .vfd-led  { fill: #22c55e; stroke: #15803d; stroke-width: 0.08; }
  .vfd-term { fill: #64748b; stroke: #334155; stroke-width: 0.12; }
  .panel    { fill: #2d3239; stroke: #475569; stroke-width: 0.15; }
  .fin      { fill: #454b54; stroke: #1e293b; stroke-width: 0.12; }
  .screw    { fill: #cbd5e1; stroke: #64748b; stroke-width: 0.12; }
  .screw-h  { fill: none; stroke: #94a3b8; stroke-width: 0.1; }
  .slot     { fill: #1e293b; stroke: #64748b; stroke-width: 0.1; }
  .act-blue { fill: #2563eb; stroke: #1d4ed8; stroke-width: 0.1; }
  .act-red  { fill: #dc2626; stroke: #991b1b; stroke-width: 0.1; }
  .toggle   { fill: #e2e8f0; stroke: #475569; stroke-width: 0.15; }
  .toggle-on{ fill: #22c55e; stroke: #15803d; stroke-width: 0.12; }
  .pole-div { fill: none; stroke: #94a3b8; stroke-width: 0.12; }
  .lbl-w    { font: 500 2px 'Arial', sans-serif; fill: #f8fafc; }
  .lbl-d    { font: 400 1.7px 'Arial', sans-serif; fill: #cbd5e1; }
  .lbl-mcb  { font: 500 2px 'Arial', sans-serif; fill: #334155; }
"""


def svg(w, h, body):
    """viewBox = tam ayak izi (mm). Zemin yok, sınır dışı öğe yok."""
    return f'''<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg"
     viewBox="0 0 {w} {h}"
     width="{w}mm" height="{h}mm"
     data-width-mm="{w}" data-height-mm="{h}">
<style>{STYLE}</style>
<g id="footprint">
{body}
</g>
</svg>
'''


def screw(x, y, r=1.15):
    return f'''
  <circle cx="{x:.2f}" cy="{y:.2f}" r="{r}" class="screw"/>
  <line x1="{x-r:.2f}" y1="{y:.2f}" x2="{x+r:.2f}" y2="{y:.2f}" class="screw-h"/>
  <line x1="{x:.2f}" y1="{y-r:.2f}" x2="{x:.2f}" y2="{y+r:.2f}" class="screw-h"/>'''


def term_row(y, xs, labels, lbl_y):
    parts = []
    for x, lb in zip(xs, labels):
        parts.append(screw(x, y))
        if lb:
            parts.append(f'<text x="{x:.2f}" y="{lbl_y:.2f}" text-anchor="middle" class="lbl-d">{lb}</text>')
    return "\n".join(parts)


def schneider_lc1k():
    w, h = 45, 58
    xs = [5.5, 13.5, 21.5, 29.5, 37.5]
    top = term_row(5.5, xs, ["1 L1", "3 L2", "5 L3", "13 NO", "A1"], 3.8)
    bot = term_row(h - 5.5, xs, ["2 T1", "4 T2", "6 T3", "14 NO", "A2"], h - 2.8)
    body = f'''
  <rect x="0" y="0" width="{w}" height="{h}" rx="0.6" class="body-k"/>
  <rect x="1" y="8" width="{w-2}" height="9" class="fin"/>
  <rect x="1" y="{h-17}" width="{w-2}" height="9" class="fin"/>
  {top}
  {bot}
  <text x="6" y="22" class="lbl-w" font-size="2.2px">LC1K</text>
  <text x="6" y="25.5" class="lbl-d">0610M7</text>
  <text x="6" y="28.5" class="lbl-d">220V</text>
  <text x="{w/2:.1f}" y="21" text-anchor="middle" class="lbl-d" font-size="1.6px">Schneider Electric</text>
  <rect x="32" y="19" width="3" height="10" rx="0.4" class="slot"/>
  <rect x="32.6" y="22" width="1.8" height="4" rx="0.3" class="act-blue"/>
  <text x="35.5" y="22.5" class="lbl-d">I</text>
  <text x="35.5" y="27.5" class="lbl-d">O</text>
  <text x="{w-2}" y="32" text-anchor="end" class="lbl-d" transform="rotate(-90 {w-2} 32)">TeSys K</text>
  <text x="{w/2:.1f}" y="36" text-anchor="middle" class="lbl-d">50/60Hz · 1,3 N.m</text>'''
    return svg(w, h, body)


def schneider_lc1d(w, h, model_hint):
    xs = [7, 15.5, 24, 32.5, 40]
    if w < 50:
        xs = [5.5, 13.5, 21.5, 29.5, 37.5]
    top = term_row(6, xs, ["1/L1", "3/L2", "5/L3", "13/NO", "A1"], 4.2)
    bot = term_row(h - 6, xs, ["2/T1", "4/T2", "6/T3", "14/NO", "A2"], h - 2.5)
    body = f'''
  <rect x="0" y="0" width="{w}" height="{h}" rx="0.8" class="body-k"/>
  <rect x="1.5" y="10" width="{w-3}" height="11" class="fin"/>
  <rect x="1.5" y="{h-21}" width="{w-3}" height="11" class="fin"/>
  {top}
  {bot}
  <rect x="3" y="24" width="{w-14}" height="{h-48}" rx="0.5" class="panel"/>
  <text x="5" y="28" class="lbl-w" font-size="2.4px">LC1D</text>
  <text x="5" y="32" class="lbl-d">{model_hint}</text>
  <text x="{w/2:.1f}" y="26" text-anchor="middle" class="lbl-d">Schneider Electric</text>
  <rect x="{w-9}" y="28" width="4" height="14" rx="0.5" class="slot"/>
  <rect x="{w-8.4}" y="32" width="2.8" height="6" rx="0.3" class="act-blue"/>'''
    return svg(w, h, body)


def schneider_gv2me():
    w, h = 45, 89
    xs = [8, 19.5, 31]
    body = f'''
  <rect x="0" y="0" width="{w}" height="{h}" rx="1" class="body-k"/>
  <rect x="2" y="2" width="{w-4}" height="32" rx="0.8" class="panel"/>
  <circle cx="{w/2:.1f}" cy="11" r="5" class="act-red"/>
  <text x="{w/2:.1f}" y="12" text-anchor="middle" class="lbl-w" font-size="2px">I</text>
  <rect x="10" y="17" width="25" height="11" rx="0.5" class="fin"/>
  <text x="{w/2:.1f}" y="24" text-anchor="middle" class="lbl-w">O / OFF</text>
  <text x="{w/2:.1f}" y="8" text-anchor="middle" class="lbl-d">Schneider Electric</text>
  <text x="4" y="38" class="lbl-w" font-size="2.2px">GV2ME</text>
  <rect x="2" y="42" width="{w-4}" height="44" rx="0.5" class="fin"/>
  {term_row(48, xs, ["1-2", "3-4", "5-6"], 45.5)}
  {term_row(58, xs, ["A1", "A2", ""], 55.5)}'''
    return svg(w, h, body)


def siemens_3rv2():
    w, h = 45, 97
    xs = [8, 19.5, 31]
    body = f'''
  <rect x="0" y="0" width="{w}" height="{h}" rx="0.8" class="body-k"/>
  <rect x="3" y="3" width="{w-6}" height="26" rx="0.6" class="panel"/>
  <circle cx="{w/2:.1f}" cy="16" r="5.5" class="fin"/>
  <line x1="{w/2-3:.1f}" y1="16" x2="{w/2+3:.1f}" y2="16" class="screw-h"/>
  <line x1="{w/2:.1f}" y1="13" x2="{w/2:.1f}" y2="19" class="screw-h"/>
  <text x="{w/2:.1f}" y="34" text-anchor="middle" class="lbl-d">SIRIUS 3RV2</text>
  <rect x="2.5" y="38" width="{w-5}" height="8" rx="0.4" class="fin"/>
  <text x="{w/2:.1f}" y="43.5" text-anchor="middle" class="lbl-d">Ir … A</text>
  <rect x="2" y="50" width="{w-4}" height="44" rx="0.5" class="fin"/>
  {term_row(56, xs, ["L1", "L2", "L3"], 53)}
  {term_row(66, xs, ["T1", "T2", "T3"], 63)}
  {term_row(78, [xs[0], xs[1]], ["95", "96"], 75)}'''
    return svg(w, h, body)


def siemens_3rt2(w, h):
    xs = [5.5, 13.5, 21.5, 29.5, 37.5]
    top = term_row(5.5, xs, ["L1", "L2", "L3", "NO", "A1"], 3.8)
    bot = term_row(h - 5.5, xs, ["T1", "T2", "T3", "NO", "A2"], h - 2.8)
    body = f'''
  <rect x="0" y="0" width="{w}" height="{h}" rx="0.8" class="body-k"/>
  <rect x="1" y="8" width="{w-2}" height="9" class="fin"/>
  <rect x="1" y="{h-17}" width="{w-2}" height="9" class="fin"/>
  {top}
  {bot}
  <text x="5" y="22" class="lbl-w">3RT2</text>
  <text x="{w/2:.1f}" y="21" text-anchor="middle" class="lbl-d">SIEMENS</text>
  <rect x="32" y="24" width="3" height="8" rx="0.3" class="act-blue"/>'''
    return svg(w, h, body)


def schneider_mcb(w, h, poles):
    mod_w = w / poles
    parts = [f'<rect x="0" y="0" width="{w}" height="{h}" rx="0.5" class="body-mcb"/>']
    for i in range(1, poles):
        x = mod_w * i
        parts.append(f'<line x1="{x:.2f}" y1="0" x2="{x:.2f}" y2="{h}" class="pole-div"/>')
    for i in range(poles):
        cx = mod_w * (i + 0.5)
        parts.append(screw(cx, 8, 1.1))
        parts.append(screw(cx, h - 8, 1.1))
        parts.append(f'<rect x="{cx-2.2:.2f}" y="16" width="4.4" height="14" rx="0.5" class="toggle-on"/>')
        parts.append(f'<rect x="{cx-1.5:.2f}" y="20" width="3" height="6" rx="0.3" class="toggle"/>')
    parts.append(f'<text x="{w/2:.2f}" y="13" text-anchor="middle" class="lbl-mcb" font-size="1.8px">Acti9 iC60N</text>')
    return svg(w, h, "\n".join(parts))


def schneider_rcc_a9r414():
    w, h = 72, 91
    mod_w = w / 4
    parts = [f'<rect x="0" y="0" width="{w}" height="{h}" rx="0.6" class="body-rcc"/>']
    for i in range(1, 4):
        x = mod_w * i
        parts.append(f'<line x1="{x:.2f}" y1="0" x2="{x:.2f}" y2="{h}" class="pole-div"/>')
    for i in range(4):
        cx = mod_w * (i + 0.5)
        parts.append(screw(cx, 9, 1.1))
        parts.append(screw(cx, h - 9, 1.1))
        parts.append(f'<rect x="{cx-2.5:.2f}" y="18" width="5" height="18" rx="0.5" class="toggle"/>')
    parts.append(f'<circle cx="{w-6:.1f}" cy="42" r="2.2" class="act-blue"/>')
    parts.append(f'<text x="{w-6:.1f}" y="43" text-anchor="middle" class="lbl-mcb" font-size="1.4px">T</text>')
    parts.append(f'<text x="{w/2:.2f}" y="15" text-anchor="middle" class="lbl-mcb">Acti9 iID</text>')
    return svg(w, h, "\n".join(parts))


def delta_vfd_el21w_a1():
    w, h = 92, 162
    term_cols = [16, 32, 48, 64, 76]
    top_terms = ""
    for i, x in enumerate(term_cols[:4]):
        labels = ["R/L1", "S/L2", "T/L3", "PE"]
        top_terms += screw(x, 10, 1.0)
        top_terms += f'<text x="{x:.1f}" y="7" text-anchor="middle" class="lbl-mcb" font-size="1.4px">{labels[i]}</text>'
    bot_terms = ""
    for i, x in enumerate(term_cols[:4]):
        labels = ["U/T1", "V/T2", "W/T3", "PE"]
        bot_terms += screw(x, h - 10, 1.0)
        bot_terms += f'<text x="{x:.1f}" y="{h-6}" text-anchor="middle" class="lbl-mcb" font-size="1.4px">{labels[i]}</text>'
    body = f'''
  <rect x="0" y="0" width="{w}" height="{h}" rx="1.5" class="body-vfd"/>
  <rect x="3" y="4" width="{w-6}" height="16" rx="0.6" class="vfd-term"/>
  {top_terms}
  <rect x="10" y="26" width="72" height="24" rx="1" class="vfd-disp"/>
  <text x="{w/2:.1f}" y="41" text-anchor="middle" class="lbl-w" font-size="3px">0.00 Hz</text>
  <circle cx="14" cy="56" r="2" class="vfd-led"/>
  <text x="18" y="57.5" class="lbl-mcb" font-size="1.6px">RUN</text>
  <rect x="10" y="62" width="10" height="6" rx="0.5" class="vfd-key"/>
  <text x="15" y="66.5" text-anchor="middle" class="lbl-mcb" font-size="1.2px">RUN</text>
  <rect x="24" y="62" width="10" height="6" rx="0.5" class="vfd-key"/>
  <text x="29" y="66.5" text-anchor="middle" class="lbl-mcb" font-size="1.2px">STOP</text>
  <rect x="38" y="62" width="10" height="6" rx="0.5" class="vfd-key"/>
  <text x="43" y="66.5" text-anchor="middle" class="lbl-mcb" font-size="1.2px">▲</text>
  <rect x="52" y="62" width="10" height="6" rx="0.5" class="vfd-key"/>
  <text x="57" y="66.5" text-anchor="middle" class="lbl-mcb" font-size="1.2px">▼</text>
  <rect x="66" y="62" width="16" height="6" rx="0.5" class="vfd-key"/>
  <text x="74" y="66.5" text-anchor="middle" class="lbl-mcb" font-size="1.2px">MODE</text>
  <text x="{w/2:.1f}" y="78" text-anchor="middle" class="lbl-mcb" font-size="2.4px">DELTA</text>
  <text x="{w/2:.1f}" y="83" text-anchor="middle" class="lbl-d" font-size="1.8px">VFD-EL-W</text>
  <rect x="8" y="94" width="76" height="38" rx="0.8" class="panel"/>
  <rect x="3" y="{h-20}" width="{w-6}" height="16" rx="0.6" class="vfd-term"/>
  {bot_terms}'''
    return svg(w, h, body)


FILES = {
    "mks/schneider-gv2me.svg": schneider_gv2me,
    "mks/siemens-3rv2.svg": siemens_3rv2,
    "kontaktor/schneider-lc1k.svg": schneider_lc1k,
    "kontaktor/schneider-lc1d-09-18.svg": lambda: schneider_lc1d(45, 77, "16M7"),
    "kontaktor/schneider-lc1d-25-32.svg": lambda: schneider_lc1d(45, 85, "25M7"),
    "kontaktor/siemens-3rt2-s00.svg": lambda: siemens_3rt2(45, 58),
    "kontaktor/siemens-3rt2-s0.svg": lambda: siemens_3rt2(45, 85),
    "sigorta/schneider-a9f741.svg": lambda: schneider_mcb(18, 85, 1),
    "sigorta/schneider-a9f742.svg": lambda: schneider_mcb(36, 85, 2),
    "sigorta/schneider-a9f743.svg": lambda: schneider_mcb(54, 85, 3),
    "sigorta/schneider-a9r414.svg": schneider_rcc_a9r414,
    "invertor/delta-vfd-el21w-a1.svg": delta_vfd_el21w_a1,
}

INDEX = {
    "purpose": "Pano 2D yerleşim — ön görünüş, 1:1 mm, şeffaf zemin",
    "scale": "1 SVG birimi = 1 mm",
    "series": {
        "schneider-gv2me": {
            "file": "mks/schneider-gv2me.svg",
            "type": "MKŞ",
            "dimensions_mm": {"w": 45, "h": 89},
            "models": ["GV2ME01", "GV2ME22", "GV2ME32"]
        },
        "siemens-3rv2": {
            "file": "mks/siemens-3rv2.svg",
            "type": "MKŞ",
            "dimensions_mm": {"w": 45, "h": 97},
            "models": ["3RV2011…", "3RV2031…"]
        },
        "schneider-lc1k": {
            "file": "kontaktor/schneider-lc1k.svg",
            "type": "Kontaktör",
            "dimensions_mm": {"w": 45, "h": 58},
            "models": ["LC1K0610M7", "LC1K0910M7", "LC1K1610M7"]
        },
        "schneider-lc1d-09-18": {
            "file": "kontaktor/schneider-lc1d-09-18.svg",
            "type": "Kontaktör",
            "dimensions_mm": {"w": 45, "h": 77},
            "models": ["LC1D16M7", "LC1D18M7"]
        },
        "schneider-lc1d-25-32": {
            "file": "kontaktor/schneider-lc1d-25-32.svg",
            "type": "Kontaktör",
            "dimensions_mm": {"w": 45, "h": 85},
            "models": ["LC1D25M7", "LC1D32M7"]
        },
        "siemens-3rt2-s00": {
            "file": "kontaktor/siemens-3rt2-s00.svg",
            "type": "Kontaktör",
            "dimensions_mm": {"w": 45, "h": 58},
            "models": ["3RT2015…", "3RT2018…"]
        },
        "siemens-3rt2-s0": {
            "file": "kontaktor/siemens-3rt2-s0.svg",
            "type": "Kontaktör",
            "dimensions_mm": {"w": 45, "h": 85},
            "models": ["3RT2026…", "3RT2034…"]
        },
        "schneider-a9f741": {
            "file": "sigorta/schneider-a9f741.svg",
            "type": "Sigorta 1P",
            "dimensions_mm": {"w": 18, "h": 85},
            "models": ["A9F74103", "A9F74106", "A9F74110", "A9F74116", "A9F74125", "A9F74132", "A9F74140", "A9F74150", "A9F74163"]
        },
        "schneider-a9f742": {
            "file": "sigorta/schneider-a9f742.svg",
            "type": "Sigorta 2P",
            "dimensions_mm": {"w": 36, "h": 85},
            "models": ["A9F742…"]
        },
        "schneider-a9f743": {
            "file": "sigorta/schneider-a9f743.svg",
            "type": "Sigorta 3P",
            "dimensions_mm": {"w": 54, "h": 85},
            "models": ["A9F74306", "A9F74310", "A9F74316", "A9F74325", "A9F74332", "A9F74340"]
        },
        "schneider-a9r414": {
            "file": "sigorta/schneider-a9r414.svg",
            "type": "Kaçak Akım RCCB 4P",
            "dimensions_mm": {"w": 72, "h": 91},
            "models": ["A9R41416", "A9R41425", "A9R41440", "A9R41463", "A9R41480", "A9R414100"]
        },
        "delta-vfd-el21w-a1": {
            "file": "invertor/delta-vfd-el21w-a1.svg",
            "type": "İnvertör",
            "dimensions_mm": {"w": 92, "h": 162},
            "models": ["VFD004EL21W-1", "VFD007EL21W-1", "VFD002EL21W-1"]
        }
    }
}

OLD_FILES = [
    "mks/schneider-gv2me-front.svg", "mks/schneider-gv2me-side.svg",
    "mks/siemens-3rv2-front.svg", "mks/siemens-3rv2-side.svg",
    "kontaktor/schneider-lc1k-front.svg", "kontaktor/schneider-lc1k-side.svg",
    "kontaktor/schneider-lc1d09-18-front.svg", "kontaktor/schneider-lc1d09-18-side.svg",
    "kontaktor/schneider-lc1d25-32-front.svg", "kontaktor/schneider-lc1d25-32-side.svg",
    "kontaktor/siemens-3rt2-s00-front.svg", "kontaktor/siemens-3rt2-s00-side.svg",
    "kontaktor/siemens-3rt2-s0-front.svg", "kontaktor/siemens-3rt2-s0-side.svg",
]


def main():
    for folder in ("sigorta", "invertor"):
        (ROOT / folder).mkdir(parents=True, exist_ok=True)
    for rel in OLD_FILES:
        p = ROOT / rel
        if p.exists():
            p.unlink()
            print("removed", rel)
    for rel, fn in FILES.items():
        path = ROOT / rel
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(fn(), encoding="utf-8")
        print("wrote", rel)
    (ROOT / "index.json").write_text(json.dumps(INDEX, indent=2, ensure_ascii=False), encoding="utf-8")
    print("wrote index.json")


if __name__ == "__main__":
    main()
