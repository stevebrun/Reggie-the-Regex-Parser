###
# Compiler Options
CC	= clang

###
# Target Sources
LIST 		= src/list.c 		src/list.h
MAP			= src/map.c 		src/map.h
STRINGS 	= src/strings.c 	src/strings.h
NFA 		= src/nfa.c 		src/nfa.h
NFA_EVAL 	= src/nfa_eval.c 	src/nfa_eval.h
NFA_PARSING_EVAL 	= src/nfa_parsing_eval.c 	src/nfa_parsing_eval.h
NFA_OPERATIONS 		= src/nfa_operations.c 		src/nfa_operations.h
NFA_USEFUL	= src/nfa_useful.c 	src/nfa_useful.h
REGEX_PARSER	= src/regex_parser.c	src/regex_parser.h
REGEX_TOKENIZER	= src/regex_tokenizer.c	src/regex_tokenizer.h
REGEX_TOKENIZER_NFA	= src/regex_tokenizer_nfa.c	src/regex_tokenizer_nfa.h
NFA_BUILDER	= src/nfa_builder.c src/nfa_builder.h
REGGIE		= src/reggie.c 		src/reggie.h

###
# Target Objects
LIST_O		= bin/build/list.o
MAP_O		= bin/build/map.o
STRINGS_O 	= bin/build/strings.o
NFA_O 		= bin/build/nfa.o
NFA_EVAL_O 	= bin/build/nfa_eval.o
NFA_PARSING_EVAL_O 	= bin/build/nfa_parsing_eval.o
NFA_OPERATIONS_O 	= bin/build/nfa_operations.o
NFA_USEFUL_O	= bin/build/nfa_useful.o
REGEX_PARSER_O	= bin/build/regex_parser.o
REGEX_TOKENIZER_O	= bin/build/regex_tokenizer.o
REGEX_TOKENIZER_NFA_O	= bin/build/regex_tokenizer_nfa.o
NFA_BUILDER_O	= bin/build/nfa_builder.o
REGGIE_O 	= bin/build/reggie.o

# All NFA-Related Objects
ALL_NFA_O 	= $(LIST_O) $(MAP_O) $(STRINGS_O) $(NFA_O) $(NFA_EVAL_O) $(NFA_PARSING_EVAL_O) $(NFA_OPERATIONS_O)

# All Regex Parsing Related Objects
ALL_REGEX_O	= $(ALL_NFA_O) $(NFA_USEFUL_O) $(REGEX_PARSER_O) $(REGEX_TOKENIZER_O) $(REGEX_TOKENIZER_NFA_O) $(NFA_BUILDER_O) $(REGGIE_O)

###
# Suffixes
# .SUFFIXES: .RESULT .ORIGINAL
.SUFFIXES: .o .c

all-object: bin/build $(ALL_O)

###
# Set up the directories for building

bin/build:
	mkdir -p bin/build

testbin/build:
	mkdir -p testbin/build

###
# Build the object files for the source

$(LIST_O): $(LIST) bin/build
	$(CC) -c -o $(LIST_O) src/list.c

$(MAP_O): $(MAP) bin/build
	$(CC) -c -o $(MAP_O) src/map.c

$(STRINGS_O): $(STRINGS) bin/build
	$(CC) -c -o $(STRINGS_O) src/strings.c

$(NFA_O): $(NFA) bin/build
	$(CC) -c -o $(NFA_O) src/nfa.c

$(NFA_EVAL_O): $(NFA_EVAL) bin/build
	$(CC) -c -o $(NFA_EVAL_O) src/nfa_eval.c

$(NFA_PARSING_EVAL_O): $(NFA_PARSING_EVAL) bin/build
	$(CC) -c -o $(NFA_PARSING_EVAL_O) src/nfa_parsing_eval.c

$(NFA_OPERATIONS_O): $(NFA_OPERATIONS) bin/build
	$(CC) -c -o $(NFA_OPERATIONS_O) src/nfa_operations.c

$(NFA_USEFUL_O): $(NFA_USEFUL) bin/build
	$(CC) -c -o $(NFA_USEFUL_O) src/nfa_useful.c

$(REGEX_PARSER_O): $(REGEX_PARSER) bin/build
	$(CC) -c -o $(REGEX_PARSER_O) src/regex_parser.c

$(REGEX_TOKENIZER_O): $(REGEX_TOKENIZER) bin/build
	$(CC) -c -o $(REGEX_TOKENIZER_O) src/regex_tokenizer.c

$(REGEX_TOKENIZER_NFA_O): $(REGEX_TOKENIZER_NFA) bin/build
	$(CC) -c -o $(REGEX_TOKENIZER_NFA_O) src/regex_tokenizer_nfa.c

$(NFA_BUILDER_O): $(NFA_BUILDER) bin/build
	$(CC) -c -o $(NFA_BUILDER_O) src/nfa_builder.c

$(REGGIE_O): $(REGGIE) bin/build
	$(CC) -c -o $(REGGIE_O) src/reggie.c	

###
# Target Test Sources
TESTER 			= test/tester.c 		test/tester.h

LIST_TEST 		= test/list-test.c 		test/list-test.h
MAP_TEST 		= test/map-test.c 		test/map-test.h
STRINGS_TEST 	= test/strings-test.c 	test/strings-test.h
NFA_TEST 		= test/nfa-test.c 		test/nfa-test.h
NFA_EVAL_TEST 	= test/nfa_eval-test.c 	test/nfa_eval-test.h
NFA_PARSING_EVAL_TEST 	= test/nfa_parsing_eval-test.c 	test/nfa_parsing_eval-test.h
NFA_OPERATIONS_TEST 	= test/nfa_operations-test.c 	test/nfa_operations-test.h
REGGIE_TEST		= test/reggie-test.c 	test/reggie-test.h

###
# Target Test Objects
TESTER_O		= testbin/build/tester.o

LIST_TEST_O		= testbin/build/list-test.o
MAP_TEST_O 		= testbin/build/map-test.o
STRINGS_TEST_O 	= testbin/build/strings-test.o
NFA_TEST_O 		= testbin/build/nfa-test.o
NFA_EVAL_TEST_O = testbin/build/nfa_eval-test.o
NFA_PARSING_EVAL_TEST_O = testbin/build/nfa_parsing_eval-test.o
NFA_OPERATIONS_TEST_O 	= testbin/build/nfa_operations-test.o
REGGIE_TEST_O	= testbin/build/reggie-test.o

###
# Compile Tests

$(TESTER_O): $(TESTER)
	$(CC) -c -o $(TESTER_O) test/tester.c

testbin/list-test: testbin/build $(LIST_TEST) $(LIST_O) $(TESTER_O)
	$(CC) -c -o $(LIST_TEST_O) test/list-test.c
	$(CC) -o testbin/list-test $(LIST_TEST_O) $(LIST_O) $(TESTER_O)

testbin/map-test: testbin/build $(MAP_TEST) $(MAP_O) $(LIST_O) $(STRINGS_O) $(TESTER_O)
	$(CC) -c -o $(MAP_TEST_O) test/map-test.c
	$(CC) -o testbin/map-test $(MAP_TEST_O) $(MAP_O) $(LIST_O) $(STRINGS_O) $(TESTER_O)

testbin/nfa-test: ;
# testbin/nfa-test: test/nfa-test.c test/nfa-test.h bin/build/nfa.o testbin/build
# 	clang -c -o testbin/build/nfa-test.o test/nfa-test.c
# 	clang -o testbin/nfa-test testbin/build/nfa-test.o bin/build/nfa.o

testbin/strings-test: testbin/build $(STRINGS_TEST) $(STRINGS_O) $(TESTER_O)
	$(CC) -c -o $(STRINGS_TEST_O) test/strings-test.c
	$(CC) -o testbin/strings-test $(STRINGS_TEST_O) $(STRINGS_O) $(TESTER_O)

testbin/nfa_eval-test: testbin/build $(NFA_EVAL_TEST) $(ALL_NFA_O) $(TESTER_O)
	$(CC) -c -o $(NFA_EVAL_TEST_O) test/nfa_eval-test.c
	$(CC) -o testbin/nfa_eval-test $(NFA_EVAL_TEST_O) $(ALL_NFA_O) $(TESTER_O)

testbin/nfa_parsing_eval-test: testbin/build $(NFA_PARSING_EVAL_TEST) $(ALL_NFA_O) $(TESTER_O)
	$(CC) -c -o $(NFA_PARSING_EVAL_TEST_O) test/nfa_parsing_eval-test.c
	$(CC) -o testbin/nfa_parsing_eval-test $(NFA_PARSING_EVAL_TEST_O) $(ALL_NFA_O) $(TESTER_O)

testbin/nfa_operations-test: testbin/build $(NFA_OPERATIONS_TEST) $(ALL_NFA_O) $(TESTER_O)
	$(CC) -c -o $(NFA_OPERATIONS_TEST_O) test/nfa_operations-test.c
	$(CC) -o testbin/nfa_operations-test $(NFA_OPERATIONS_TEST_O) $(ALL_NFA_O) $(TESTER_O)

testbin/reggie-test: testbin/build $(REGGIE_TEST) $(ALL_REGEX_O) $(TESTER_O)
	$(CC) -c -o $(REGGIE_TEST_O) test/reggie-test.c
	$(CC) -o testbin/reggie-test $(REGGIE_TEST_O) $(ALL_REGEX_O) $(TESTER_O)

###
# Compile and Run Tests

test: testbin/list-test testbin/map-test testbin/nfa-test testbin/strings-test testbin/nfa_eval-test testbin/nfa_parsing_eval-test testbin/nfa_operations-test testbin/reggie-test
	./testbin/list-test
	./testbin/map-test
	# ./testbin/nfa-test
	./testbin/strings-test
	./testbin/nfa_eval-test
	./testbin/nfa_parsing_eval-test
	./testbin/nfa_operations-test
	./testbin/reggie-test

###
# Remove build files from 

clean:
	rm -Rf bin/build
	rm -Rf testbin/build

real-clean:
	rm -Rf bin
	rm -Rf testbin