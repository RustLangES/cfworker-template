<div align="right">
<a href="./README.md">ES</a>
</div>

# Cloudflare Worker Template

This is a template to get started with Cloudflare workers written in Rust .

## Features
- Only Rust, you don't need to write code in any other language.
- Ready to use
- Queue events prepared
- Fetch events set up
- Custom panic configured (using the log provided by Cloudflare)
- Automatic Deploy with GitHub Actions

## Configuration

> [!IMPORTANT]
> You must check the `Cargo.toml`, `wrangler.toml` and `src/lib.rs` files.
> To remove the comments you need to implement

Rename the project in the `Cargo.toml` and `wrangler.toml` files.

### Requirements

To build and deploy this project, you will need the following:

- [Rust](https://rust-lang.org)
- [wrangler](https://developers.cloudflare.com/workers/wrangler/install-and-update/)
- [worker-build](https://crates.io/crates/worker-build)
    - [wasm-pack](https://rustwasm.github.io/wasm-pack/)

### Local Tests

> [!IMPORTANT]
> To test the worker locally, see the [official documentation](https://developers.cloudflare.com/workers/testing/local-development)

### Automatic Deployment

This project is configured to deploy automatically using GitHub Actions workflows. For it to work correctly, you must set up the following secrets on GitHub:

- `CLOUDFLARE_ACCOUNT_ID`: ID of your Cloudflare account.
- `CLOUDFLARE_API_TOKEN`: Cloudflare API token.
