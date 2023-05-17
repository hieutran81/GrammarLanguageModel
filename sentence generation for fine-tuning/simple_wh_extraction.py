from utils import data_generator
from utils.constituent_building import *
from utils.conjugate import *
from utils.randomize import choice
from utils.vocab_sets_dynamic import *
# from utils.vocab_sets import *

class FillerGapGenerator(data_generator.BenchmarkGenerator):
    def __init__(self):
        super().__init__(field="syntax",
                         linguistics="filler_gap_dependency",
                         uid="simple_wh_extraction",
                         simple_lm_method=True,
                         one_prefix_method=False,
                         two_prefix_method=False,
                         lexically_identical=False)
        self.embedding_verbs = get_all("responsive", "1")
        self.prep = ["for", "with"]

    def sample(self):

        # I know what the mailman made for his mother.
        # I know that the mailman made a pie for his mother.
        # I know what the mailman made a pie for.
        # I know what made the pie.

        V1 = choice(self.embedding_verbs)
        N1 = N_to_DP_mutate(choice(get_matches_of(V1, "arg_1", get_all_nouns())))
        V2 = choice(get_all_transitive_verbs())
        N2 = N_to_DP_mutate(choice(get_matches_of(V2, "arg_1", get_all_common_nouns())))
        N3 = N_to_DP_mutate(choice(get_matches_of(V2, "arg_2", get_all_nouns()))) # needed to choose the correct wh-word, but N3 never gets used
        N4 = N_to_DP_mutate(choice(get_all_animate_nouns()))


        V1 = conjugate(V1, N1)
        V2 = conjugate(V2, N2)
#        V_rel = conjugate(V_rel, N2)
        wh = choice(get_matched_by(N3, "arg_1", get_all_wh_words()))
        P = choice(self.prep)

        data = {
            "obj_that": "%s %s that %s %s %s %s %s." % (N1[0], V1[0], N2[0], V2[0], N3[0], P, N4[0]),
            "obj_wh": "%s %s %s %s %s %s %s." % (N1[0], V1[0], wh[0], N2[0], V2[0], P, N4[0]),
            "pp_wh": "%s %s %s %s %s %s %s." % (N1[0], V1[0], wh[0], N2[0], V2[0], N3[0], P),
            "subj_wh": "%s %s %s %s %s." % (N1[0], V1[0], wh[0], V2[0], N3[0])
        }
        return data, data["obj_that"]

generator = FillerGapGenerator()
generator.generate_paradigm(rel_output_path="outputs/blimp/%s.jsonl" % generator.uid)
