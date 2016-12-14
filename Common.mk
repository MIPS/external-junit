# -*- mode: makefile -*-
# List of junit files include in documentation.
# Shared with frameworks/base.
# based off libcore/Docs.mk
# Exports:
#   core-junit-files, junit_to_document.
#   They are lists of .java files relative to external/junit/.

ifndef junit4_common_include_once

# List of source to build into the core-junit library
#
core-junit-files := \
src/junit/framework/Assert.java \
src/junit/framework/AssertionFailedError.java \
src/junit/framework/ComparisonCompactor.java \
src/junit/framework/ComparisonFailure.java \
src/junit/framework/Protectable.java \
src/junit/framework/Test.java \
src/junit/framework/TestCase.java \
src/junit/framework/TestFailure.java \
src/junit/framework/TestListener.java \
src/junit/framework/TestResult.java \
src/junit/framework/TestSuite.java

# List of junit javadoc source files for Android public API
#
junit_to_document := \
 $(core-junit-files)

junit4_common_include_once := 1
endif  # junit4_common_include_once
