import sys
import subprocess
from google import genai

# O novo SDK busca automaticamente a env 'GEMINI_API_KEY' 
# se você não passar uma chave explicitamente.
client = genai.Client()

def get_definition(text):
    prompt = f"Defina de forma concisa em português, usando formatação nos estilo pango, o seguinte: '{text}'"
    
    try:
        # Usando o modelo Flash 2.0 (mais rápido e barato)
        response = client.models.generate_content(
            model="gemini-3-flash-preview", 
            contents=prompt
        )
        return response.text.strip()
    except Exception as e:
        print(f"{str(e)}")
        return f"Erro na API: {str(e)}"

def send_notification(title, body):
    # Cria uma janela de texto flutuante, centralizada e com scroll
    subprocess.run([
        'yad', '--text-info', 
        '--title=' + title,
        '--width=459', '--height=800',
        '--center', '--no-buttons',
        '--wrap', '--fontname=Geist,18',
        '--formatted', '--borders=35',
        '--css=scrolledwindow,box{border:none;}'
    ], input=body, text=True)

# def send_notification(title, body):
#     subprocess.run(['notify-send', '-t', '10000', title, body])

if __name__ == "__main__":
    if len(sys.argv[1]) < 3:
        sys.exit(1)

    selected_text = sys.argv[1]

    subprocess.run([
        'notify-send', 
        "Pesquisando",
        selected_text
    ], text=True)

    definition = get_definition(selected_text)
    send_notification(f"Definição: {selected_text}", definition)


