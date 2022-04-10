# coding=utf-8
"""
@Time   : 2022/4/10  1:23 
@Author : Haojun Gao (github.com/VincentGaoHJ)
@Email  : vincentgaohj@gmail.com haojun.gao@u.nus.edu
@Sketch : S3 Bucket Sync
"""

import os
import boto3

s3 = boto3.resource('s3')


def list_bucket_file(bucket, folder):
    my_bucket = s3.Bucket(bucket)
    object_key_lst = [bucket_object.key for bucket_object in my_bucket.objects.filter(Prefix=folder)]
    copy_source_lst = [{'Bucket': bucket, 'Key': object_key} for object_key in object_key_lst]
    return copy_source_lst


def sync_file(target_bucket, target_folder, copy_source):
    origin_key = copy_source['Key']
    file_name = origin_key.split('/')[-1]
    target_key = os.path.join(target_folder, file_name)
    try:
        response = s3.copy_object(Bucket=target_bucket, Key=target_key, CopySource=copy_source)
        return response['ContentType']
    except Exception as err:
        print("Error -" + str(err))
        return err


def lambda_handler(event, context):
    """
    Code snippet for copying the objects from AWS source S3 bucket to target S3 bucket
    :param event:
    :param context:
    :return:
    """

    print('Event receive: ', event)

    copy_source_lst = list_bucket_file(
        bucket=os.environ['SOURCE_BUCKET'], folder=os.environ['SOURCE_FOLDER'])

    for copy_source in copy_source_lst:
        sync_file(
            target_bucket=os.environ['TARGET_BUCKET'],
            target_folder=os.environ['TARGET_FOLDER'],
            copy_source=copy_source)
