# WiseProd

A sales assistant tool for retail tech advisors, featuring a guided needs assessment, AI-generated sales pitches, and a complete sales flow through to the checkout receipt.

Personal project inspired by my experience as a sales advisor at Fnac — not affiliated, not official.

🔗 **Live demo:** [wiseprod.tremic.fr](https://wiseprod.tremic.fr)

---

## The problem

A salesperson advising a customer needs to understand their needs, know the product catalog, know which add-on services to offer (insurance, warranties...), and put together a convincing pitch — often in just a few minutes, with no time to prepare.

## The solution

WiseProd guides the salesperson from first contact with the customer all the way to payment:

1. **Needs assessment** — tile-based questionnaire (device type, usage, budget, priority), with a short path for a customer who already knows what they want, and a guided path for one who's looking for a solution to a need
2. **Product recommendation** — automatic matching based on the criteria entered
3. **AI-generated sales pitch** — tailored to the product and customer profile, with stackable add-on services suggested
4. **Cart** — add selected products and services
5. **Customer record** — create, search (phone, email, ID number), edit
6. **Checkout receipt** — generates a printable document with VAT calculation (excl./incl. tax), a unique receipt number, and itemized products by SKU

## Features by role

| Feature | Sales advisor | Admin |
|---|---|---|
| Needs assessment & recommendation | ✅ | ✅ |
| AI sales pitch generation | ✅ | ✅ |
| Cart & checkout receipt | ✅ | ✅ |
| Create / edit customer record | ✅ | ✅ |
| Delete customer record | ❌ | ✅ |
| Create / edit / delete product | ❌ | ✅ |

## Tech stack

- **Backend:** Ruby on Rails 8, SQLite
- **Authentication:** Devise
- **Authorization:** Pundit
- **AI:** ruby_llm + OpenAI API
- **Deployment:** Docker, Kamal
- **Frontend:** Stimulus, custom CSS (own visual identity, no generic CSS framework)

## Demo

A demo account is available to try the app without creating one:

```
Email:    demo@wiseprod.fr
Password: demopassword123
```

## Local setup

```bash
git clone git@github.com:mtremauville/Wiseprod.git
cd Wiseprod
bundle install
cp .env.example .env
# Set OPENAI_API_KEY in .env
rails db:migrate
rails db:seed
rails server
```

The app automatically seeds a catalog of realistic high-tech products (smartphones, laptops, tablets) via the [DummyJSON](https://dummyjson.com) API.

## Note on the checkout receipt

The generated document is a simulation for technical demonstration purposes only — it is not a real commercial document and has no purchase value.

## What this project demonstrates

- Modeling a complete business workflow (need → product → sale → payment), not just isolated CRUD
- Generative AI integration tailored to real business data
- Role and permission management with Pundit
- Docker/Kamal production deployment, coexisting with other services on the same server (Nginx cohabitation, port management)
- Git discipline: one feature = one branch = one documented pull request

## Author

**Mickael Tremauville** — Frontend Developer in career transition, former tech retail sales advisor (24 years in tech retail).

- Blog: [tremic.fr](https://tremic.fr)
- LinkedIn: [linkedin.com/in/mickael-tremauville](https://linkedin.com/in/mickael-tremauville)
- GitHub: [@mtremauville](https://github.com/mtremauville)