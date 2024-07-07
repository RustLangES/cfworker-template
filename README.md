<div align="right">
<a href="./README_EN.md">EN</a>
</div>

# Template Cloudflare Worker

Este es un template para empezar con workers de Cloudflare escritos en Rust.

[![Usa el Template](https://github.com/RustLangES/cfworker-template/assets/56278796/0a5924b2-dfe7-4f47-9f06-f82316acbe46)](https://github.com/new?template_owner=RustLangES&template_name=cfworker-template&owner=%40me&name=cloudflare-worker&description=Mi+Super+Worker+hecho+en+Rust&visibility=public)


## Features
- Solo Rust, no necesitas escribir codigo en ningun otro lenguaje
- Listo para usarse
- Eventos de Queue preparados
- Eventos de fetch preparados
- Custom panic configurado (usando el log que ofrece Cloudflare)
- Deploy automático con GitHub Actions
- Entorno Nix para trabajar comodo

## Configuración

> [!IMPORTANT]
> Debes revisar los archivos de `Cargo.toml`, `wrangler.toml` y `src/lib.rs`
> Para quitar los comentarios que necesites implementar

Renombra el proyecto en los archivos de `Cargo.toml` y `wrangler.toml`

### Requisitos

Para construir y desplegar este proyecto, necesitarás lo siguiente:

- [Rust](https://rust-lang.org)
- [wrangler](https://developers.cloudflare.com/workers/wrangler/install-and-update/)
- [worker-build](https://crates.io/crates/worker-build)
    - [wasm-pack](https://rustwasm.github.io/wasm-pack/)

### Pruebas Locales

> [!IMPORTANT]
> Para probar el worker localmente, revisa la [documentacion oficial](https://developers.cloudflare.com/workers/testing/local-development)

### Despliegue Automático

Este proyecto está configurado para desplegar automáticamente utilizando los flujos de trabajo de GitHub Actions. Para que funcione correctamente, debes configurar los siguientes secretos en GitHub:

- `CLOUDFLARE_ACCOUNT_ID`: ID de tu cuenta de Cloudflare.
- `CLOUDFLARE_API_TOKEN`: Token de API de Cloudflare.
