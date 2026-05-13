from moviepy import (
    ImageClip,
    AudioFileClip,
    CompositeVideoClip,
    TextClip,
    ColorClip,
)
import os
import requests


BACKGROUND_IMAGE = (
    "https://images.unsplash.com/photo-1504711434969-e33886168f5c"
)


def download_background():
    os.makedirs("output", exist_ok=True)

    output_path = "output/background.jpg"

    response = requests.get(BACKGROUND_IMAGE, timeout=20)

    with open(output_path, "wb") as file:
        file.write(response.content)

    return output_path


def generate_video(
    title,
    audio_path,
    source="News Source",
    output_name="news_video.mp4",
):
    os.makedirs("output", exist_ok=True)

    image_path = download_background()

    audio = AudioFileClip(audio_path)
    duration = audio.duration

    background = (
        ImageClip(image_path)
        .with_duration(duration)
        .resized(height=1920)
        .cropped(x_center=540, width=1080, height=1920)
    )

    dark_overlay = (
        ColorClip(size=(1080, 1920), color=(0, 0, 0))
        .with_duration(duration)
        .with_opacity(0.45)
    )

    red_bar = (
        ColorClip(size=(1080, 90), color=(255, 49, 49))
        .with_duration(duration)
        .with_position(("center", 0))
    )

    brand_text = (
        TextClip(
            text="NewsPulse",
            font_size=48,
            color="white",
            method="caption",
            size=(900, None),
        )
        .with_position((60, 24))
        .with_duration(duration)
    )

    hook_text = (
        TextClip(
            text="এই খবরটি কেন গুরুত্বপূর্ণ?",
            font_size=54,
            color="white",
            method="caption",
            size=(900, None),
        )
        .with_position(("center", 220))
        .with_duration(min(4, duration))
    )

    title_text = (
        TextClip(
            text=title,
            font_size=62,
            color="white",
            method="caption",
            size=(920, None),
        )
        .with_position(("center", 1080))
        .with_duration(duration)
    )

    source_text = (
        TextClip(
            text=f"Source: {source}",
            font_size=32,
            color="white",
            method="caption",
            size=(900, None),
        )
        .with_position((60, 1740))
        .with_duration(duration)
    )

    end_card = (
        TextClip(
            text="আরও আপডেট পেতে NewsPulse Follow করুন",
            font_size=42,
            color="white",
            method="caption",
            size=(900, None),
        )
        .with_position(("center", 1820))
        .with_duration(duration)
    )

    final = CompositeVideoClip(
        [
            background,
            dark_overlay,
            red_bar,
            brand_text,
            hook_text,
            title_text,
            source_text,
            end_card,
        ],
        size=(1080, 1920),
    ).with_audio(audio)

    output_path = f"output/{output_name}"

    final.write_videofile(
        output_path,
        fps=30,
        codec="libx264",
        audio_codec="aac",
        preset="medium",
    )

    audio.close()
    final.close()

    return output_path