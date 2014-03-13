# module include file for CARLsim pti 

objects += $(test_dir)/carlsim_tests.o
output_files += $(test_dir)/carlsim_tests

CARLSIM_TEST_FLAGS := -I$(CURDIR)/$(test_dir)

gtest_deps = $(GTEST_LIB_DIR)/libgtest.a $(GTEST_LIB_DIR)/libgtest_main.a

.PHONY: carlsim_tests
carlsim_tests: $(test_dir)/carlsim_tests $(test_dir)/carlsim_tests.o

$(test_dir)/carlsim_tests: $(test_dir)/carlsim_tests.o $(gtest_deps) \
	$(carlsim_objs)
	$(NVCC) $(CARLSIM_INCLUDES) $(CARLSIM_LFLAGS) $(CARLSIM_LIBS) \
	$(CARLSIM_FLAGS) $(CARLSIM_TEST_FLAGS)  $(carlsim_objs) \
	$(GTEST_CPPFLAGS) -L$(GTEST_LIB_DIR) -lgtest_main $< -o $@

$(test_dir)/carlsim_tests.o: $(test_dir)/carlsim_tests.cpp
	$(NVCC) $(CARLSIM_INCLUDES) $(CARLSIM_LFLAGS) $(CARLSIM_LIBS) \
	$(CARLSIM_FLAGS) $(CARLSIM_TEST_FLAGS) \
	$(GTEST_CPPFLAGS) -L$(GTEST_LIB_DIR) -lgtest_main \
	-c $(test_dir)/carlsim_tests.cpp -o $@