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
                         uid="adjunct_island",
                         simple_lm_method=True,
                         one_prefix_method=False,
                         two_prefix_method=False,
                         lexically_identical=False)
        self.all_ing_transitives = np.intersect1d(get_all_transitive_verbs(), get_all_ing_verbs())
        self.embedding_verbs = get_all("responsive", "1")

    def sample(self):
        # I know what the policeman read before filing the book.
        # I know that the policeman read a document before filing the book.
        # N1 V1           N2         V2     N3              V3        N4

        # I know that the policeman attacked before filing the book read a document.
        # N1 V1         N2            V_rel          V3      N4      V2     N3

        V1 = choice(self.embedding_verbs)
        N1 = N_to_DP_mutate(choice(get_matches_of(V1, "arg_1", get_all_nouns())))
        V2 = choice(get_all_transitive_verbs())
        N2 = N_to_DP_mutate(choice(get_matches_of(V2, "arg_1", get_all_common_nouns())))
        N3 = N_to_DP_mutate(choice(get_matches_of(V2, "arg_2", get_all_nouns()))) # needed to choose the correct wh-word, but N3 never gets used
        V3 = choice(get_matched_by(N3, "arg_2", get_matched_by(N2, "arg_1", self.all_ing_transitives)))
        N4 = N_to_DP_mutate(choice(get_matches_of(V3, "arg_2", get_all_nouns())))
        self.adverbs = ["before", "after", "without", "while"]

        V_rel = choice(get_matched_by(N2, "arg_2", get_all_en_verbs()))


        V1 = conjugate(V1, N1)
        V2 = conjugate(V2, N2)
#        V_rel = conjugate(V_rel, N2)
        wh = choice(get_matched_by(N3, "arg_1", get_all_wh_words()))
        Adv = choice(self.adverbs)

        data = {
            "adj_that": "%s %s that %s %s %s %s %s %s." % (N1[0], V1[0], N2[0], V2[0], N3[0], Adv, V3[0], N4[0]),
            "adj_wh": "%s %s %s %s %s %s %s %s." % (N1[0], V1[0], wh[0], N2[0], V2[0], Adv, V3[0], N4[0]),
            "adj_subj_that": "%s %s that %s %s %s %s %s %s %s." % (N1[0], V1[0], N2[0], V_rel[0], Adv, V3[0], N4[0], V2[0], N3[0]),
            "adj_subj_wh": "%s %s %s %s %s %s %s %s %s." % (N1[0], V1[0], wh[0], N2[0], V_rel[0], Adv, V3[0], N4[0], V2[0])
        }
        return data, data["adj_that"]

generator = FillerGapGenerator()
generator.generate_paradigm(rel_output_path="outputs/blimp/%s.jsonl" % generator.uid)
