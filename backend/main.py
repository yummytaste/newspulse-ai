from news_scraper import fetch_news
from ai_summary import generate_summary
from voice_generator import generate_voice
from video_generator import generate_video

from cloudinary_upload import upload_video

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore


cred = credentials.Certificate("serviceAccountKey.json")

if not firebase_admin._apps:
    firebase_admin.initialize_app(cred)

db = firestore.client()


def save_to_firestore(
    title,
    description,
    video_url,
):

    db.collection("shorts").add({
        "title": title,
        "description": description,
        "videoUrl": video_url,
        "thumbnailUrl": "",
        "category": "Breaking",
        "views": 0,
        "likes": 0,
        "shares": 0,
        "isActive": True,
        "createdAt": firestore.SERVER_TIMESTAMP,
    })


def main():

    print("\n🔥 FETCHING NEWS...\n")

    articles = fetch_news()

    first_article = articles[0]

    title = first_article["title"]

    summary = generate_summary(first_article)

    print("\n📰 GENERATED SUMMARY")
    print("-" * 50)
    print(summary)

    voice_path = generate_voice(
        summary,
        filename="news_voice_1.mp3",
    )

    print("\n🎤 VOICE CREATED:")
    print(voice_path)

    video_path = generate_video(
        title=title,
        audio_path=voice_path,
        source="BBC News",
        output_name="news_short_1.mp4",
    )

    print("\n🎬 VIDEO CREATED:")
    print(video_path)

    print("\n☁️ UPLOADING TO CLOUDINARY...")

    video_url = upload_video(video_path)

    print("\n✅ CLOUDINARY URL:")
    print(video_url)

    save_to_firestore(
        title,
        summary,
        video_url,
    )

    print("\n🔥 SHORT SAVED TO FIRESTORE")


if __name__ == "__main__":
    main()