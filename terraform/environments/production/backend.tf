terraform {
  backend "s3" {
    # This will be configured via GitHub Actions
    # We'll use environment variables to set this dynamically
  }
}