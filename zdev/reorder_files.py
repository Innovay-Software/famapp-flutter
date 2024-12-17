import os
import shutil
import datetime
import time
import random

# root_dir = '/Users/ealton/Work/宝吉/Album'
#
#
# def setFileModifiedDate(filePath, targetDatetime):
#     print(f"setFileModifiedDate {filePath} {targetDatetime}")
#     timestamp = datetime.datetime.timestamp(targetDatetime)
#     os.utime(filePath, (timestamp, timestamp))
#
#
# def flattenSubDirs(currentDir, targetDir, targetDatetime):
#     print(f"flattenSubDirs: {currentDir} {targetDir} {targetDatetime}")
#     sub_dirs = removeDsStoreInList(os.listdir(currentDir))
#
#     for item in sub_dirs:
#         if os.path.isdir(f"{currentDir}/{item}"):
#             flattenSubDirs(f"{currentDir}/{item}", targetDir)
#             continue
#
#         if currentDir == targetDir:
#             continue
#
#         item_parts = os.path.splitext(item)
#         basename = item_parts[0]
#         extension = item_parts[1]
#         file_modified_timestamp = os.path.getmtime(f"{currentDir}/{item}")
#
#         new_filename = datetime.datetime.fromtimestamp(file_modified_timestamp).strftime('%Y%m%d_%H%M%S') + "_" + str(random.randint(1000, 9999))
#
#         old_path = f"{currentDir}/{item}"
#         new_path = f"{targetDir}/{new_filename}{extension}"
#         print(f"rename: {old_path} -> {new_path}")
#
#         os.rename(old_path, new_path)
#
#
# # def setCreationDatetime(filePath, targetDatetime):
#
#
#
# def removeDsStoreInList(items):
#     filtered_dirs = []
#     for item in items:
#         if item == '.DS_Store':
#             continue
#         filtered_dirs.append(item)
#     return filtered_dirs
#
#
# year_dirs = os.listdir(root_dir)
# year_dirs = sorted(removeDsStoreInList(year_dirs))
# print(time.strftime('%Y%m%d_%H%M%S', time.localtime(time.time())))
#
# for year_dir in year_dirs:
#     if not os.path.isdir(f"{root_dir}/{year_dir}"):
#         continue
#     print(f"working on {year_dir}")
#     month_dirs = sorted(removeDsStoreInList(os.listdir(f"{root_dir}/{year_dir}")), key=int)
#     for month_dir in month_dirs:
#         if not os.path.isdir(f"{root_dir}/{year_dir}/{month_dir}"):
#             continue
#         print(f"working on {year_dir} / {month_dir}")
#         files = os.listdir(f"{root_dir}/{year_dir}/{month_dir}")
#         currentDir = f"{root_dir}/{year_dir}/{month_dir}"
#         for item in files:
#             if item == '.DS_Store':
#                 continue
#
#             item_parts = os.path.splitext(item)
#             basename = item_parts[0]
#             extension = item_parts[1]
#             file_modified_timestamp = os.path.getmtime(f"{currentDir}/{item}")
#
#             new_filename = datetime.datetime.fromtimestamp(file_modified_timestamp).strftime(
#                 '%Y%m%d_%H%M%S') + "_" + str(random.randint(1000, 9999))
#
#             old_path = f"{currentDir}/{item}"
#             new_path = f"{currentDir}/{new_filename}{extension}"
#             print(f"rename: {old_path} -> {new_path}")
#
#             os.rename(old_path, new_path)
#
#             # setFileModifiedDate(f"{root_dir}/{year_dir}/{month_dir}/{item}", modified_date)
#             # print(f"{item}: {year}-{month}-{day}_{hour}:{minute}:{second}")
#
#         # day_dirs = os.listdir(f"{root_dir}/{year_dir}/{month_dir}")
#         # filtered_day_dirs = []
#         # for day_dir in day_dirs:
#         #     if not os.path.isdir(f"{root_dir}/{year_dir}/{month_dir}/{day_dir}"):
#         #         continue
#         #     filtered_day_dirs.append(day_dir)
#         # day_dirs = sorted(removeDsStoreInList(filtered_day_dirs), key=float)
#         #
#         # for day_dir in day_dirs:
#         #     if not os.path.isdir(f"{root_dir}/{year_dir}/{month_dir}/{day_dir}"):
#         #         continue
#         #
#         #     month_full_path = f"{root_dir}/{year_dir}/{month_dir}"
#         #     day_full_path = f"{month_full_path}/{day_dir}"
#         #
#         #     day_parts = day_dir.split(".")
#         #     day = day_parts[1]
#         #     flattenSubDirs(day_full_path, month_full_path, datetime.datetime(int(year_dir), int(month_dir), int(day), 0, 0, 1, 0))
#
#
#
#     break