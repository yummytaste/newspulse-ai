import cloudinary
import cloudinary.uploader


cloudinary.config(
    cloud_name="dq8pdewhh",
    api_key="667884597188656",
    api_secret="Czn-BcXIE8Eds0z6g77K2vM8Uvg"
)


def upload_video(video_path):

    response = cloudinary.uploader.upload_large(
        video_path,
        resource_type="video",
        folder="newspulse_shorts"
    )

    return response["secure_url"]