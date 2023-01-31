# CoffeeHouse

A small dummy ecommerce project where I play with Turbo Frames/Stream and Stripe.

> **Note**
> Work In Progress

![Adding to cart](docs/coffeehouse_01.gif)
![Order](docs/coffeehouse_02.gif)

# Domain Docs

See `/docs`

# Environment

| env   | version |
| ----- | ------- |
| rails | 7.0.3   |
| ruby  | 3.0.3   |
| yarn  | 1.22.19 |

## Development

```bash
bin/setup

# This starts
#   - watching assets (Tailwindcss, esbuild)
#   - Start rails server
bin/dev

# This starts stripe webhook listener
bin/stripe
```

### Edit Secret

A Stripe API key and a `endpoint_secret` are required for this app to work.

You can edit the credentials using this command:

```bash
EDITOR="code --wait" bin/rails credentials:edit --environment development
```

Required credentials:

```yaml
admin_email: XXXXXXXXXX
redis_url: redis://UUU:PW@HOST:PORT
stripe:
  stripe_api_key: XXXXXXXXXX
  endpoint_secret: XXXXXXXXXX
```
