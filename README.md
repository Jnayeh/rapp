# Qatra PFE Report

This folder contains the English PFE report **Design and Implementation of Qatra: A Microservices-Based Platform for Blood Donation and Emergency Response Management**.

## Cover page

Place the final cover PDF beside `main.tex` with the exact name `Page-Garde.pdf`. The report automatically includes every page of that PDF. When the file is absent, a temporary cover placeholder is rendered. The report never generates or overwrites `Page-Garde.pdf`.

## Generate diagrams

From the workspace root:

```powershell
java -jar rapport_pfe_ai_ecommerce_en/tools/plantuml.jar -tpng -o rendered rapport_pfe_qatra_en/diagrams/qatra-diagrams.puml
```

The editable source is `diagrams/qatra-diagrams.puml`; generated PNG files belong in `diagrams/rendered/`.

The portrait icon-based technology, logical architecture, physical deployment, Kafka notification flow, and observability plates are stored in `assets/generated/`. Company and Kanban visuals are stored locally under `assets/company/` and `assets/methodology/`, and the generic ESPRIT back cover is stored as `last page.pdf`, so the report does not depend on the reference folder at build time.

Every output page is portrait A4. Do not introduce `landscape` environments; wide diagrams must be rearranged vertically.

## Build the PDF

Run XeLaTeX three times so the table of contents, lists, labels, and bibliography settle:

```powershell
cd rapport_pfe_qatra_en
xelatex -interaction=nonstopmode -halt-on-error main.tex
xelatex -interaction=nonstopmode -halt-on-error main.tex
xelatex -interaction=nonstopmode -halt-on-error main.tex
```

## Application screenshots

The supplied Qatra interface screenshots are organized by increment under `assets/5.1` through `assets/5.5` and are integrated into Chapter 5. Use `\uiscreenshot` for one interface or `\uiscreenshotpair` for two related workflow views. Keep new filenames short and ASCII-only so the report remains portable across LaTeX environments.

Do not commit credentials, tokens, patient data, or personally identifiable test records in screenshots.
