#include <Reggie/automata_eval.h>

void _automata_evaldata_destroy(evaldata ff, evaldata rw) {
	if (ff.data == rw.data) {
		if (ff.data && ff.destroy)
			ff.destroy(ff.data);
	} else {
		if (ff.data && ff.destroy)
			ff.destroy(ff.data);
		if (rw.data && rw.destroy)
			rw.destroy(rw.data);
	}
}

//////
// total evaluations of automata

bool automata_eval(automata a, evalstream *input) {
	FOREACH(it, a->states) {
		state s = VALUE(it);
		if (s->id == 0) {
			return state_eval(a, s, input);
		}
	}
	return false;
}

bool state_eval(automata a, state s, evalstream *input) {
	if (s->isTerminal && input->closed(input)) {
		return true;
	}
	FOREACH(it, s->transitions) {
		transition t = VALUE(it);
		if (transition_eval(a, t, input)) {
			return true;
		}
	}
	return false;
}

bool transition_eval(automata a, transition t, evalstream *input) {
//	int result = t->func(a, t, input);
//	if (result != -1) {
//		input = input->fastforward(input, a, result);
//		bool success = state_eval(a, t->dst, input);
//		if (success) {
//			return success;
//		} else {
//			input->rewind(input, a, result);
//			return false;
//		}
//	}
//	return false;
	evaldata ff = t->func(a, t, input);
	if (ff.data != NULL) {
		evaldata rw = input->fastforward(input, a, ff);
		if (rw.data != NULL) {
			int success = state_parsing_eval(a, t->dst, input);
			if (success != failure) {
				_automata_evaldata_destroy(ff, rw);
				return true;
			} else {
				input->rewind(input, a, rw);
				_automata_evaldata_destroy(ff, rw);
				return false;
			}
		}
		_automata_evaldata_destroy(ff, rw);
	}
	return false;
}

//////
// partial parsing evaluations of automata

#define failure -1

int automata_parsing_eval(automata a, evalstream *input) {
	FOREACH(it, a->states) {
		state s = VALUE(it);
		if (s->id == 0) {
			return state_parsing_eval(a, s, input);
		}
	}
	return failure;
}

int state_parsing_eval(automata a, state s, evalstream *input) {
	if (s->isTerminal) {
		return 0;
	}
	FOREACH(it, s->transitions) {
		transition t = VALUE(it);
		int result = transition_parsing_eval(a, t, input);
		if (result != failure) {
			return result;
		}
	}
	return failure;
}

int transition_parsing_eval(automata a, transition t, evalstream *input) {
	evaldata ff = t->func(a, t, input);
	if (ff.data != NULL) {
		evaldata rw = input->fastforward(input, a, ff);
		if (rw.data != NULL) {
			int success = state_parsing_eval(a, t->dst, input);
			if (success != failure) {
				_automata_evaldata_destroy(ff, rw);
				return success + result;
			} else {
				input->rewind(input, a, rw);
				_automata_evaldata_destroy(ff, rw);
				return failure;
			}
		}
		_automata_evaldata_destroy(ff, rw);
	}
	return failure;
}

