import os
from gtts import gTTS


def generate_voice(text, filename="news_voice.mp3"):

    output_dir = "output"
    os.makedirs(output_dir, exist_ok=True)

    output_path = os.path.join(output_dir, filename)

    tts = gTTS(
        text=text,
        lang="bn",
        slow=False,
    )

    tts.save(output_path)

    return output_path