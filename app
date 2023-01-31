import os
import openai

# Inicialización de Twilio
account_sid = os.getenv('AC665cb5de0ffbe291c58c65468a73006a')
auth_token = os.getenv('87245f339d8c88aa307f5cbf06025eba')
client = Client(account_sid, auth_token)

# Inicialización de OpenAI
openai.api_key = os.getenv("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")

# Función para enviar un mensaje a través de WhatsApp con Twilio
def send_message(to, message):
    message = client.messages.create(
        to=to,
        from_="whatsapp:+14155238886",
        body=message
    )

# Función para recibir mensajes a través de WhatsApp con Twilio
def receive_message():
    messages = client.messages.list(
        from_="whatsapp:+14155238886"
    )
    for message in messages:
        return message.body

# Loop infinito para escuchar y responder a mensajes de WhatsApp
while True:
    # Recibir un mensaje
    incoming_message = receive_message()

    # Generar una respuesta usando OpenAI
    response = openai.Completion.create(
        model="text-davinci-003",
        prompt=f"The following is a conversation with an AI assistant. The assistant is helpful, creative, clever, and very friendly.\n\nHuman: {incoming_message}\nAI:",
        temperature=0.9,
        max_tokens=150,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0.6,
        stop=[""Human:", "AI:"]
