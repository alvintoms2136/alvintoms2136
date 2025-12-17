from typing import Dict, List

ROOFING_KEYWORDS = (
    "roof",
    "roofing",
    "membrane",
    "shingle",
    "asphalt",
    "tile",
    "torch",
    "insulation",
    "flashing",
    "underlayment",
    "gutter",
)

PRODUCT_KEYWORDS = {
    "single-ply membrane": ("tpo", "pvc", "single ply", "single-ply"),
    "modified bitumen": ("modified bitumen", "sbs", "app"),
    "asphalt shingle": ("asphalt shingle", "architectural shingle", "shingle"),
    "built-up roof": ("built-up", "tar and gravel", "bur"),
    "metal roof": ("metal roof", "standing seam", "metal panel"),
    "insulation": ("insulation", "polyiso", "eps"),
    "flashing": ("flashing", "edge metal", "counterflashing"),
}


def _filter_scope_lines(lines: List[str]) -> List[str]:
    scoped = []
    for line in lines:
        lower = line.lower()
        if any(keyword in lower for keyword in ROOFING_KEYWORDS):
            scoped.append(line)
    # Preserve ordering but keep the excerpt short for UI clarity.
    return scoped[:12]


def _detect_products(text: str) -> List[str]:
    products = []
    lower = text.lower()
    for name, keywords in PRODUCT_KEYWORDS.items():
        if any(keyword in lower for keyword in keywords):
            products.append(name)
    return products


def summarize_roofing_scope(pages: List[str], placeholder_prompt: str) -> Dict[str, object]:
    combined = "\n".join(pages)
    lines = [line.strip() for line in combined.splitlines() if line.strip()]

    scope_lines = _filter_scope_lines(lines)
    products = _detect_products(combined)

    summary_parts: List[str] = []
    if scope_lines:
        summary_parts.append("Detected roofing-related excerpts:")
        for line in scope_lines:
            summary_parts.append(f"• {line}")
    else:
        summary_parts.append(
            "No explicit roofing scope was detected in the uploaded PDF text. "
            "The configured agent prompt will analyze the full document for you."
        )

    if not products:
        products.append("To be identified by the agent from the specification.")

    assumptions = [
        "This summary is generated locally using a placeholder prompt. A connected agent "
        "will deliver a project-ready scope once configured.",
        f"System prompt to be finalized: {placeholder_prompt}",
    ]

    return {
        "scope_excerpt": "\n".join(summary_parts),
        "products": products,
        "assumptions": assumptions,
    }
