# Terraform-AWS

This repository is aim to create AWS Cloud Resources through Terraform and orchestrate them as a solution architecture.

## 1. Requirements

### 1.2 Fundamental Requirements

- A new S3 bucket
- An IAM user for external use with proper permission
    - `GetObject` from bucket `s3://<bucket_name>/downloads/`
    - `PutObject` to bucket `s3://<bucket_name>/uploads/`
- An IAM role for internal use having full control of the bucket
- An internal user that assume above internal IAM role
- Create AK/SKs for both internal and external user, and SK cannot store on `terraform state` in plain text form.

### 1.1 Advanced Requirements

- Manage above resources using `terraform module`
- Create multiple external user, and each user can only:
    - Read from `s3://<bucket_name>/downloads/<username>/` and `s3://<bucket_name>/downloads/common/`
    - Write to `s3://<bucket_name>/uploads/<username>`
- Deploy code to `Github` private repository and configure CI/CD.
- Assume that we have 100 IAM user now, manage them through terraform.
- Create a Lambda, and schedule it to sync data:
    - From `s3://<another_bucket>/data/`
    - To `s3://<bucket_name>/downloads/common/`

---

## 2. Prerequisite

- Access key ID & Secret Access Key of that account
- An AWS IAM role with S3 permissions

---

## 3. Folder Structure

- `main.tf`: It contains the main set of the module’s configurations.
- `variable.tf`: Access key, Secret key, and Region will be defined here.
- `src` folder: for all code
    - `s3`: Module that have the S3 configuration
        - `bucket.tf`: Define bucket
        - `var.tf`: Define variables

---

## 4. Implementation

### 4.1 Create an S3 bucket using Terraform

## Terraform script

- Initialize the working directory
    ```shell
    terraform init
    ```
- Script verification
    ```shell
    terraform plan
    ```
- To create your S3 bucket
    ```shell
    Terraform apply
    ```
- To destroy the S3 bucket
    ```shell
    terraform destroy
    ```

---

# Reference

- [How To Create AWS S3 Bucket Using Terraform](https://www.bacancytechnology.com/blog/aws-s3-bucket-using-terraform)
- 