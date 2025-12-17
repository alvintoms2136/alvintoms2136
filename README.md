# Roofing Estimator Sandbox

A lightweight FastAPI + HTML prototype that accepts a single PDF upload and prepares it for a roofing-scope analysis agent. The current build uses a placeholder system prompt and a local heuristic to surface roofing-related excerpts until a real model is wired in.

## Features
- Upload one PDF architectural drawing/specification.
- Extract PDF text with `pypdf`.
- Apply a placeholder prompt and surface roofing-related lines, detected products, and assumptions.
- Simple, modern UI served directly by FastAPI.

## Quickstart
1. Install dependencies (recommend a virtual environment):
   ```bash
   pip install -r requirements.txt
   ```
2. Run the dev server:
   ```bash
   uvicorn app.main:app --reload
   ```
3. Open the UI at http://127.0.0.1:8000, upload a PDF, and review the extracted roofing scope.

## Project structure
- `app/main.py` — FastAPI app, upload endpoint, placeholder prompt wiring.
- `app/pdf_utils.py` — PDF text extraction helper.
- `app/scope.py` — Lightweight scope/products summarizer.
- `templates/index.html` — Single-page UI.
- `static/style.css` — Styles for the landing page and results.

## Next steps
- Wire the `/api/analyze` route to your chosen LLM or toolchain using the baked-in roofing estimator system prompt.
- Extend parsing to support multi-file uploads and richer metadata extraction.
