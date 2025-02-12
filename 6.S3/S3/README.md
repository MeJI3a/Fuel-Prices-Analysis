# README: AWS S3 Setup for Fuel Analysis Project

## Project Overview
This document details the setup and configuration of an AWS S3 bucket for storing fuel analysis data, along with IAM policies and roles for integration with Snowflake.

## S3 Bucket Details
- **Bucket Name:** `bucket-fuel-analysis-2019-2024-zs`
- **Region:** `eu-west-2` (London)
- **Storage Class:** Standard
- **Public Access:** Blocked
- **Server-side Encryption:** AES-256 (SSE-S3)
- **Lifecycle Policy:**
  - 30 days → Move to **STANDARD_IA**
  - 60 days → Move to **GLACIER**
  - 180 days → Permanent deletion
- **Versioning:** Enabled
- **Server Access Logging:** Enabled (Logs stored in `amazons3deepdive-bucket-website-zana-study`)

## Files in Bucket
- `cleaned_currency.csv`
- `filtered_oil_prices.csv`
- `fuel_prices_cleaned.csv`
- `inflation_cleaned.csv`

## IAM Policies and Roles

### **IAM Policy: `SnowflakeS3Access`**
- Allows Snowflake to:
  - `s3:GetObject`
  - `s3:ListBucket`
- Applies to:
  - `arn:aws:s3:::bucket-fuel-analysis-2019-2024-zs`
  - `arn:aws:s3:::bucket-fuel-analysis-2019-2024-zs/*`
- File: `snowflake_iam_policy.json`

### **IAM Role: `SnowflakeS3Role`**
- Allows Snowflake to assume the role for accessing S3.
- Trusts: `s3.amazonaws.com`
- Policies attached:
  - `SnowflakeS3Access`
- Files:
  - `snowflake_iam_role.json`
  - `trust_policy.json`

## Evidence & Logs
- **Lifecycle Policy Configuration:** `lifecycle.json`
- **Encryption Configuration:** `encryption.json`
- **IAM Setup Log:** `s3_snowflake_iam_setup.txt`
- **S3 Setup Log:** `s3_setup_log.txt`

## Next Steps (Step 7: Snowflake Integration)
- Connect S3 bucket to Snowflake.
- Use IAM role `SnowflakeS3Role` for authentication.
- Load and process data in Snowflake.

## Notes
- Versioning is enabled, old versions will accumulate unless manually cleaned.
- Logging is active, access logs can be found in `amazons3deepdive-bucket-website-zana-study`.
- Ensure IAM policies are correctly linked to the Snowflake service for proper access.

---
**Author:** Z.Simanel
**Date:** February 10, 2025
