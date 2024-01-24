output "minio_id" {
  value = [ for bucket in minio_s3_bucket.buckets: bucket.id]
}

output "minio_url" {
  value = [ for bucket in minio_s3_bucket.buckets: bucket.bucket_domain_name ]
}

output "user_minio_user" {
  value = [ for user in minio_iam_user.minio_user: user.id ]
}

output "minio_user_status" {
  value = [ for user in minio_iam_user.minio_user: user.status ]
}

output "minio_user_secret" {
  value     = [ for user in minio_iam_user.minio_user: nonsensitive(user.secret) ] #Displays randomly generated secret used ncessary for login information
}