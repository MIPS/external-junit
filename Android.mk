# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

LOCAL_PATH := $(call my-dir)

# include definition of core-junit-files
include $(LOCAL_PATH)/Common.mk

# build a junit jar
# ----------------------
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(call all-java-files-under, src)
LOCAL_MODULE := junit
LOCAL_MODULE_TAGS := tests
LOCAL_SDK_VERSION := 25
LOCAL_STATIC_JAVA_LIBRARIES := hamcrest
# The following is needed by external/apache-harmony/jdwp/Android_debug_config.mk
LOCAL_MODULE_PATH := $(TARGET_OUT_DATA)/junit
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk $(LOCAL_PATH)/Common.mk
include $(BUILD_STATIC_JAVA_LIBRARY)

# build a junit-host jar
# ----------------------

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(call all-java-files-under, src)
LOCAL_MODULE := junit-host
LOCAL_MODULE_TAGS := tests
LOCAL_STATIC_JAVA_LIBRARIES := hamcrest-host
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk $(LOCAL_PATH)/Common.mk
include $(BUILD_HOST_JAVA_LIBRARY)

# build a junit-hostdex jar
# -------------------------

ifeq ($(HOST_OS),linux)
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(call all-java-files-under, src)
LOCAL_MODULE := junit-hostdex
LOCAL_MODULE_TAGS := tests
LOCAL_STATIC_JAVA_LIBRARIES := hamcrest-hostdex
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk $(LOCAL_PATH)/Common.mk
include $(BUILD_HOST_DALVIK_JAVA_LIBRARY)
endif # HOST_OS == linux

# ----------------------------------
# build a core-junit target jar that is built into Android system image

# TODO: remove extensions once core-tests is no longer dependent on it
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(call all-java-files-under, src/junit/extensions)
LOCAL_SRC_FILES += $(core-junit-files)
LOCAL_NO_STANDARD_LIBRARIES := true
LOCAL_JAVA_LIBRARIES := core-oj core-libart
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := core-junit
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk $(LOCAL_PATH)/Common.mk
include $(BUILD_JAVA_LIBRARY)

# ----------------------------------
# build a core-junit-static target jar that is embedded into legacy-test

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(call all-java-files-under, src/junit/extensions)
LOCAL_SRC_FILES += $(core-junit-files)
LOCAL_NO_STANDARD_LIBRARIES := true
LOCAL_JAVA_LIBRARIES := core-oj core-libart
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := core-junit-static
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk $(LOCAL_PATH)/Common.mk
include $(BUILD_STATIC_JAVA_LIBRARY)

#-------------------------------------------------------
# build a junit-runner jar for the host JVM
# (like the junit classes in the frameworks/base android.test.runner.jar)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(junit-runner-files)
LOCAL_MODULE := junit-runner
LOCAL_NO_STANDARD_LIBRARIES := true
LOCAL_JAVA_LIBRARIES := core-oj core-libart core-junit
LOCAL_MODULE_TAGS := optional
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk $(LOCAL_PATH)/Common.mk
include $(BUILD_STATIC_JAVA_LIBRARY)

#-------------------------------------------------------
# build a junit4-target jar representing the
# classes in external/junit that are not in the core public API 4
# Note: 'core' here means excluding the classes that are contained
# in the optional library android.test.runner. Developers who
# build against this jar shouldn't have to also include android.test.runner

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(junit4-target-src)
LOCAL_MODULE := junit4-target
LOCAL_MODULE_TAGS := optional
LOCAL_SDK_VERSION := 25
LOCAL_STATIC_JAVA_LIBRARIES := hamcrest
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk $(LOCAL_PATH)/Common.mk
include $(BUILD_STATIC_JAVA_LIBRARY)
