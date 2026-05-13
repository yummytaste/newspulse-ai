import os
import uuid
from datetime import datetime

import firebase_admin
from firebase_admin import credentials, firestore, storage


SERVICE_ACCOUNT_PATH = "serviceAccountKey.json"

# Firebase Storage bucket name
# Firebase Console → Storage → bucket name দেখে বসাবেন
BUCKET_NAME = "newspulse-ai-cce53.firebasestorage.app"


def init_firebase():
    if not firebase_admin._apps:
        cred = credentials.Certificate(SERVICE_ACCOUNT_PATH)

        firebase_admin.initialize_app(
            cred,
            {
                "storageBucket": BUCKET_NAME,
            },
        )


def upload_video_to_firebase(video_path):
    init_firebase()

    file_id = str(uuid.uuid4())
    file_name = f"shorts/videos/{file_id}.mp4"

    bucket = storage.bucket()
    blob = bucket.blob(file_name)

    blob.upload_from_filename(
        video_path,
        content_type="video/mp4",
    )

    blob.make_public()

    return blob.public_url


def create_short_document(
    title,
    description,
    category,
    video_url,
    source,
):
    init_firebase()

    db = firestore.client()

    doc_data = {
        "title": title,
        "description": description,
        "category": category,
        "videoUrl": video_url,
        "thumbnailUrl": "",
        "views": 0,
        "likes": 0,
        "shares": 0,
        "isActive": True,
        "source": source,
        "createdAt": firestore.SERVER_TIMESTAMP,
    }

    doc_ref = db.collection("shorts").document()
    doc_ref.set(doc_data)

    return doc_ref.id