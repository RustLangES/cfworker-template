use worker::event;

// This event is called on start worker
// So we use the `start` event to initialize our tracing subscriber when the worker starts.
#[event(start)]
fn start() {
    // Custom panic
    #[cfg(target_arch = "wasm32")]
    std::panic::set_hook(Box::new(|info: &std::panic::PanicInfo| {
        worker::console_error!("{info}")
    }));
}

// Remove commentary if you need scheduled cron event trigger
//
// use worker::{Env, ScheduleContext, ScheduledEvent};
//
// #[event(scheduled)]
// pub async fn main(_e: ScheduledEvent, _env: Env, _ctx: ScheduleContext) {
//
// }
//


// Remove commentary if you need fetch worker
//
// use worker::{Env, Request, Context, Result, Response, Router};
//
// Docs: https://github.com/cloudflare/workers-rs#or-use-the-router
// Example: https://github.com/cloudflare/workers-rs/blob/main/examples/router/src/lib.rs
//
// #[event(fetch)]
// pub async fn main(req: Request, env: Env, _ctx: Context) -> Result<Response> {
//     Router::new()
//         .run(req, env)
//         .await
// }
//

// Remove commentary if you need queue worker
//
// Docs: https://developers.cloudflare.com/queues/
//       https://github.com/cloudflare/workers-rs#queues
// Example: https://github.com/cloudflare/workers-rs/blob/main/examples/queue/src/lib.rs
//
// use worker::*;
// use serde::{Deserialize, Serialize};
// 
// #[derive(Serialize, Debug, Clone, Deserialize)]
// pub struct MyType {
//     foo: String,
//     bar: u32,
// }
// 
// // Consume messages from a queue
// #[event(queue)]
// pub async fn main(message_batch: MessageBatch<MyType>, env: Env, _ctx: Context) -> Result<()> {
//     // Get a queue with the binding 'my_queue'
//     let my_queue = env.queue("my_queue")?;
// 
//     // Deserialize the message batch
//     let messages = message_batch.messages()?;
// 
//     // Loop through the messages
//     for message in messages {
//         // Log the message and meta data
//         console_log!(
//             "Got message {:?}, with id {} and timestamp: {}",
//             message.body(),
//             message.id(),
//             message.timestamp().to_string()
//         );
// 
//         // Send the message body to the other queue
//         my_queue.send(message.body()).await?;
// 
//         // Ack individual message
//         message.ack();
// 
//         // Retry individual message
//         message.retry();
//     }
// 
//     // Retry all messages
//     message_batch.retry_all();
//     // Ack all messages
//     message_batch.ack_all();
//     Ok(())
// }
