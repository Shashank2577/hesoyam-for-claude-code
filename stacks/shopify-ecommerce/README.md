# Stack: Shopify E-Commerce

> ECC configuration for Shopify theme development, Hydrogen storefronts, and app development.

## CLAUDE.md

```markdown
# Project: [Name]

## Platform
- Shopify Plus store
- Theme: Dawn-based custom theme (Liquid + CSS + JS)
- Apps: Shopify CLI for app development
- Data sync: Python pipeline for product categorization

## Conventions
- Liquid templates follow Shopify naming conventions
- Sections are modular and schema-driven
- JavaScript: Vanilla JS or Alpine.js (no heavy frameworks in theme)
- CSS: Tailwind via build pipeline
- Product taxonomy: L1/L2/L3 brand-agnostic classification

## Product Data Pipeline
- Source: Vendor catalog CSVs
- Processing: Python + PostgreSQL for SKU classification
- Sync: Shopify Admin API (GraphQL preferred over REST)
- Collections: Auto-generated from taxonomy via handle matching

## Commands
- Theme dev: `shopify theme dev --store [store].myshopify.com`
- Push: `shopify theme push`
- App dev: `shopify app dev`
- Data sync: `python sync_products.py --dry-run`

## API Keys
- All managed via environment variables
- Never commit .env files
- Use Shopify CLI authentication for theme/app development
```

## Recommended Agents

- `code-reviewer.md` — Liquid template review
- `security-reviewer.md` — Storefront XSS, payment flow security
- `architect.md` — Theme architecture, section schema design

## Key Patterns

- Product variant management across 44+ brands
- SKU classification engine (rule-based + LLM hybrid)
- Collection sync pipeline with handle/sku/product_id alignment
- Batch API operations for large catalog updates
