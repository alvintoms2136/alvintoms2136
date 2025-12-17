from io import BytesIO
from typing import List

from pypdf import PdfReader


def extract_pdf_text(content: bytes) -> List[str]:
    """
    Extract text from a PDF byte stream, returning a list of page strings.

    The function is intentionally simple—enough to give the downstream agent
    clean text without introducing heavyweight parsing logic.
    """
    reader = PdfReader(BytesIO(content))
    pages: List[str] = []
    for page in reader.pages:
        text = page.extract_text() or ""
        pages.append(text)
    return pages
