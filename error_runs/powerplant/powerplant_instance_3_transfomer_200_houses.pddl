(define (problem powerplant_instance_3_transfomer_200_houses) (:domain Powerplant)
    (:objects
    p1 - powerplant
    t1 - transformer
    t2 - transformer
    t3 - transformer
    h1_1 - house
    lp1_1 - low_voltage_line
    h1_2 - house
    lp1_2 - low_voltage_line
    h1_3 - house
    lp1_3 - low_voltage_line
    h1_4 - house
    lp1_4 - low_voltage_line
    h1_5 - house
    lp1_5 - low_voltage_line
    h1_6 - house
    lp1_6 - low_voltage_line
    h1_7 - house
    lp1_7 - low_voltage_line
    h1_8 - house
    lp1_8 - low_voltage_line
    h1_9 - house
    lp1_9 - low_voltage_line
    h1_10 - house
    lp1_10 - low_voltage_line
    h1_11 - house
    lp1_11 - low_voltage_line
    h1_12 - house
    lp1_12 - low_voltage_line
    h1_13 - house
    lp1_13 - low_voltage_line
    h1_14 - house
    lp1_14 - low_voltage_line
    h1_15 - house
    lp1_15 - low_voltage_line
    h1_16 - house
    lp1_16 - low_voltage_line
    h1_17 - house
    lp1_17 - low_voltage_line
    h1_18 - house
    lp1_18 - low_voltage_line
    h1_19 - house
    lp1_19 - low_voltage_line
    h1_20 - house
    lp1_20 - low_voltage_line
    h1_21 - house
    lp1_21 - low_voltage_line
    h1_22 - house
    lp1_22 - low_voltage_line
    h1_23 - house
    lp1_23 - low_voltage_line
    h1_24 - house
    lp1_24 - low_voltage_line
    h1_25 - house
    lp1_25 - low_voltage_line
    h1_26 - house
    lp1_26 - low_voltage_line
    h1_27 - house
    lp1_27 - low_voltage_line
    h1_28 - house
    lp1_28 - low_voltage_line
    h1_29 - house
    lp1_29 - low_voltage_line
    h1_30 - house
    lp1_30 - low_voltage_line
    h1_31 - house
    lp1_31 - low_voltage_line
    h1_32 - house
    lp1_32 - low_voltage_line
    h1_33 - house
    lp1_33 - low_voltage_line
    h1_34 - house
    lp1_34 - low_voltage_line
    h1_35 - house
    lp1_35 - low_voltage_line
    h1_36 - house
    lp1_36 - low_voltage_line
    h1_37 - house
    lp1_37 - low_voltage_line
    h1_38 - house
    lp1_38 - low_voltage_line
    h1_39 - house
    lp1_39 - low_voltage_line
    h1_40 - house
    lp1_40 - low_voltage_line
    h1_41 - house
    lp1_41 - low_voltage_line
    h1_42 - house
    lp1_42 - low_voltage_line
    h1_43 - house
    lp1_43 - low_voltage_line
    h1_44 - house
    lp1_44 - low_voltage_line
    h1_45 - house
    lp1_45 - low_voltage_line
    h1_46 - house
    lp1_46 - low_voltage_line
    h1_47 - house
    lp1_47 - low_voltage_line
    h1_48 - house
    lp1_48 - low_voltage_line
    h1_49 - house
    lp1_49 - low_voltage_line
    h1_50 - house
    lp1_50 - low_voltage_line
    h1_51 - house
    lp1_51 - low_voltage_line
    h1_52 - house
    lp1_52 - low_voltage_line
    h1_53 - house
    lp1_53 - low_voltage_line
    h1_54 - house
    lp1_54 - low_voltage_line
    h1_55 - house
    lp1_55 - low_voltage_line
    h1_56 - house
    lp1_56 - low_voltage_line
    h1_57 - house
    lp1_57 - low_voltage_line
    h1_58 - house
    lp1_58 - low_voltage_line
    h1_59 - house
    lp1_59 - low_voltage_line
    h1_60 - house
    lp1_60 - low_voltage_line
    h1_61 - house
    lp1_61 - low_voltage_line
    h1_62 - house
    lp1_62 - low_voltage_line
    h1_63 - house
    lp1_63 - low_voltage_line
    h1_64 - house
    lp1_64 - low_voltage_line
    h1_65 - house
    lp1_65 - low_voltage_line
    h1_66 - house
    lp1_66 - low_voltage_line
    h1_67 - house
    lp1_67 - low_voltage_line
    h1_68 - house
    lp1_68 - low_voltage_line
    h1_69 - house
    lp1_69 - low_voltage_line
    h1_70 - house
    lp1_70 - low_voltage_line
    h1_71 - house
    lp1_71 - low_voltage_line
    h1_72 - house
    lp1_72 - low_voltage_line
    h1_73 - house
    lp1_73 - low_voltage_line
    h1_74 - house
    lp1_74 - low_voltage_line
    h1_75 - house
    lp1_75 - low_voltage_line
    h1_76 - house
    lp1_76 - low_voltage_line
    h1_77 - house
    lp1_77 - low_voltage_line
    h1_78 - house
    lp1_78 - low_voltage_line
    h1_79 - house
    lp1_79 - low_voltage_line
    h1_80 - house
    lp1_80 - low_voltage_line
    h1_81 - house
    lp1_81 - low_voltage_line
    h1_82 - house
    lp1_82 - low_voltage_line
    h1_83 - house
    lp1_83 - low_voltage_line
    h1_84 - house
    lp1_84 - low_voltage_line
    h1_85 - house
    lp1_85 - low_voltage_line
    h1_86 - house
    lp1_86 - low_voltage_line
    h1_87 - house
    lp1_87 - low_voltage_line
    h1_88 - house
    lp1_88 - low_voltage_line
    h1_89 - house
    lp1_89 - low_voltage_line
    h1_90 - house
    lp1_90 - low_voltage_line
    h1_91 - house
    lp1_91 - low_voltage_line
    h1_92 - house
    lp1_92 - low_voltage_line
    h1_93 - house
    lp1_93 - low_voltage_line
    h1_94 - house
    lp1_94 - low_voltage_line
    h1_95 - house
    lp1_95 - low_voltage_line
    h1_96 - house
    lp1_96 - low_voltage_line
    h1_97 - house
    lp1_97 - low_voltage_line
    h1_98 - house
    lp1_98 - low_voltage_line
    h1_99 - house
    lp1_99 - low_voltage_line
    h1_100 - house
    lp1_100 - low_voltage_line
    h1_101 - house
    lp1_101 - low_voltage_line
    h1_102 - house
    lp1_102 - low_voltage_line
    h1_103 - house
    lp1_103 - low_voltage_line
    h1_104 - house
    lp1_104 - low_voltage_line
    h1_105 - house
    lp1_105 - low_voltage_line
    h1_106 - house
    lp1_106 - low_voltage_line
    h1_107 - house
    lp1_107 - low_voltage_line
    h1_108 - house
    lp1_108 - low_voltage_line
    h1_109 - house
    lp1_109 - low_voltage_line
    h1_110 - house
    lp1_110 - low_voltage_line
    h1_111 - house
    lp1_111 - low_voltage_line
    h1_112 - house
    lp1_112 - low_voltage_line
    h1_113 - house
    lp1_113 - low_voltage_line
    h1_114 - house
    lp1_114 - low_voltage_line
    h1_115 - house
    lp1_115 - low_voltage_line
    h1_116 - house
    lp1_116 - low_voltage_line
    h1_117 - house
    lp1_117 - low_voltage_line
    h1_118 - house
    lp1_118 - low_voltage_line
    h1_119 - house
    lp1_119 - low_voltage_line
    h1_120 - house
    lp1_120 - low_voltage_line
    h1_121 - house
    lp1_121 - low_voltage_line
    h1_122 - house
    lp1_122 - low_voltage_line
    h1_123 - house
    lp1_123 - low_voltage_line
    h1_124 - house
    lp1_124 - low_voltage_line
    h1_125 - house
    lp1_125 - low_voltage_line
    h1_126 - house
    lp1_126 - low_voltage_line
    h1_127 - house
    lp1_127 - low_voltage_line
    h1_128 - house
    lp1_128 - low_voltage_line
    h1_129 - house
    lp1_129 - low_voltage_line
    h1_130 - house
    lp1_130 - low_voltage_line
    h1_131 - house
    lp1_131 - low_voltage_line
    h1_132 - house
    lp1_132 - low_voltage_line
    h1_133 - house
    lp1_133 - low_voltage_line
    h1_134 - house
    lp1_134 - low_voltage_line
    h1_135 - house
    lp1_135 - low_voltage_line
    h1_136 - house
    lp1_136 - low_voltage_line
    h1_137 - house
    lp1_137 - low_voltage_line
    h1_138 - house
    lp1_138 - low_voltage_line
    h1_139 - house
    lp1_139 - low_voltage_line
    h1_140 - house
    lp1_140 - low_voltage_line
    h1_141 - house
    lp1_141 - low_voltage_line
    h1_142 - house
    lp1_142 - low_voltage_line
    h1_143 - house
    lp1_143 - low_voltage_line
    h1_144 - house
    lp1_144 - low_voltage_line
    h1_145 - house
    lp1_145 - low_voltage_line
    h1_146 - house
    lp1_146 - low_voltage_line
    h1_147 - house
    lp1_147 - low_voltage_line
    h1_148 - house
    lp1_148 - low_voltage_line
    h1_149 - house
    lp1_149 - low_voltage_line
    h1_150 - house
    lp1_150 - low_voltage_line
    h1_151 - house
    lp1_151 - low_voltage_line
    h1_152 - house
    lp1_152 - low_voltage_line
    h1_153 - house
    lp1_153 - low_voltage_line
    h1_154 - house
    lp1_154 - low_voltage_line
    h1_155 - house
    lp1_155 - low_voltage_line
    h1_156 - house
    lp1_156 - low_voltage_line
    h1_157 - house
    lp1_157 - low_voltage_line
    h1_158 - house
    lp1_158 - low_voltage_line
    h1_159 - house
    lp1_159 - low_voltage_line
    h1_160 - house
    lp1_160 - low_voltage_line
    h1_161 - house
    lp1_161 - low_voltage_line
    h1_162 - house
    lp1_162 - low_voltage_line
    h1_163 - house
    lp1_163 - low_voltage_line
    h1_164 - house
    lp1_164 - low_voltage_line
    h1_165 - house
    lp1_165 - low_voltage_line
    h1_166 - house
    lp1_166 - low_voltage_line
    h1_167 - house
    lp1_167 - low_voltage_line
    h1_168 - house
    lp1_168 - low_voltage_line
    h1_169 - house
    lp1_169 - low_voltage_line
    h1_170 - house
    lp1_170 - low_voltage_line
    h1_171 - house
    lp1_171 - low_voltage_line
    h1_172 - house
    lp1_172 - low_voltage_line
    h1_173 - house
    lp1_173 - low_voltage_line
    h1_174 - house
    lp1_174 - low_voltage_line
    h1_175 - house
    lp1_175 - low_voltage_line
    h1_176 - house
    lp1_176 - low_voltage_line
    h1_177 - house
    lp1_177 - low_voltage_line
    h1_178 - house
    lp1_178 - low_voltage_line
    h1_179 - house
    lp1_179 - low_voltage_line
    h1_180 - house
    lp1_180 - low_voltage_line
    h1_181 - house
    lp1_181 - low_voltage_line
    h1_182 - house
    lp1_182 - low_voltage_line
    h1_183 - house
    lp1_183 - low_voltage_line
    h1_184 - house
    lp1_184 - low_voltage_line
    h1_185 - house
    lp1_185 - low_voltage_line
    h1_186 - house
    lp1_186 - low_voltage_line
    h1_187 - house
    lp1_187 - low_voltage_line
    h1_188 - house
    lp1_188 - low_voltage_line
    h1_189 - house
    lp1_189 - low_voltage_line
    h1_190 - house
    lp1_190 - low_voltage_line
    h1_191 - house
    lp1_191 - low_voltage_line
    h1_192 - house
    lp1_192 - low_voltage_line
    h1_193 - house
    lp1_193 - low_voltage_line
    h1_194 - house
    lp1_194 - low_voltage_line
    h1_195 - house
    lp1_195 - low_voltage_line
    h1_196 - house
    lp1_196 - low_voltage_line
    h1_197 - house
    lp1_197 - low_voltage_line
    h1_198 - house
    lp1_198 - low_voltage_line
    h1_199 - house
    lp1_199 - low_voltage_line
    h1_200 - house
    lp1_200 - low_voltage_line
    HP1 - high_voltage_line
    h2_1 - house
    lp2_1 - low_voltage_line
    h2_2 - house
    lp2_2 - low_voltage_line
    h2_3 - house
    lp2_3 - low_voltage_line
    h2_4 - house
    lp2_4 - low_voltage_line
    h2_5 - house
    lp2_5 - low_voltage_line
    h2_6 - house
    lp2_6 - low_voltage_line
    h2_7 - house
    lp2_7 - low_voltage_line
    h2_8 - house
    lp2_8 - low_voltage_line
    h2_9 - house
    lp2_9 - low_voltage_line
    h2_10 - house
    lp2_10 - low_voltage_line
    h2_11 - house
    lp2_11 - low_voltage_line
    h2_12 - house
    lp2_12 - low_voltage_line
    h2_13 - house
    lp2_13 - low_voltage_line
    h2_14 - house
    lp2_14 - low_voltage_line
    h2_15 - house
    lp2_15 - low_voltage_line
    h2_16 - house
    lp2_16 - low_voltage_line
    h2_17 - house
    lp2_17 - low_voltage_line
    h2_18 - house
    lp2_18 - low_voltage_line
    h2_19 - house
    lp2_19 - low_voltage_line
    h2_20 - house
    lp2_20 - low_voltage_line
    h2_21 - house
    lp2_21 - low_voltage_line
    h2_22 - house
    lp2_22 - low_voltage_line
    h2_23 - house
    lp2_23 - low_voltage_line
    h2_24 - house
    lp2_24 - low_voltage_line
    h2_25 - house
    lp2_25 - low_voltage_line
    h2_26 - house
    lp2_26 - low_voltage_line
    h2_27 - house
    lp2_27 - low_voltage_line
    h2_28 - house
    lp2_28 - low_voltage_line
    h2_29 - house
    lp2_29 - low_voltage_line
    h2_30 - house
    lp2_30 - low_voltage_line
    h2_31 - house
    lp2_31 - low_voltage_line
    h2_32 - house
    lp2_32 - low_voltage_line
    h2_33 - house
    lp2_33 - low_voltage_line
    h2_34 - house
    lp2_34 - low_voltage_line
    h2_35 - house
    lp2_35 - low_voltage_line
    h2_36 - house
    lp2_36 - low_voltage_line
    h2_37 - house
    lp2_37 - low_voltage_line
    h2_38 - house
    lp2_38 - low_voltage_line
    h2_39 - house
    lp2_39 - low_voltage_line
    h2_40 - house
    lp2_40 - low_voltage_line
    h2_41 - house
    lp2_41 - low_voltage_line
    h2_42 - house
    lp2_42 - low_voltage_line
    h2_43 - house
    lp2_43 - low_voltage_line
    h2_44 - house
    lp2_44 - low_voltage_line
    h2_45 - house
    lp2_45 - low_voltage_line
    h2_46 - house
    lp2_46 - low_voltage_line
    h2_47 - house
    lp2_47 - low_voltage_line
    h2_48 - house
    lp2_48 - low_voltage_line
    h2_49 - house
    lp2_49 - low_voltage_line
    h2_50 - house
    lp2_50 - low_voltage_line
    h2_51 - house
    lp2_51 - low_voltage_line
    h2_52 - house
    lp2_52 - low_voltage_line
    h2_53 - house
    lp2_53 - low_voltage_line
    h2_54 - house
    lp2_54 - low_voltage_line
    h2_55 - house
    lp2_55 - low_voltage_line
    h2_56 - house
    lp2_56 - low_voltage_line
    h2_57 - house
    lp2_57 - low_voltage_line
    h2_58 - house
    lp2_58 - low_voltage_line
    h2_59 - house
    lp2_59 - low_voltage_line
    h2_60 - house
    lp2_60 - low_voltage_line
    h2_61 - house
    lp2_61 - low_voltage_line
    h2_62 - house
    lp2_62 - low_voltage_line
    h2_63 - house
    lp2_63 - low_voltage_line
    h2_64 - house
    lp2_64 - low_voltage_line
    h2_65 - house
    lp2_65 - low_voltage_line
    h2_66 - house
    lp2_66 - low_voltage_line
    h2_67 - house
    lp2_67 - low_voltage_line
    h2_68 - house
    lp2_68 - low_voltage_line
    h2_69 - house
    lp2_69 - low_voltage_line
    h2_70 - house
    lp2_70 - low_voltage_line
    h2_71 - house
    lp2_71 - low_voltage_line
    h2_72 - house
    lp2_72 - low_voltage_line
    h2_73 - house
    lp2_73 - low_voltage_line
    h2_74 - house
    lp2_74 - low_voltage_line
    h2_75 - house
    lp2_75 - low_voltage_line
    h2_76 - house
    lp2_76 - low_voltage_line
    h2_77 - house
    lp2_77 - low_voltage_line
    h2_78 - house
    lp2_78 - low_voltage_line
    h2_79 - house
    lp2_79 - low_voltage_line
    h2_80 - house
    lp2_80 - low_voltage_line
    h2_81 - house
    lp2_81 - low_voltage_line
    h2_82 - house
    lp2_82 - low_voltage_line
    h2_83 - house
    lp2_83 - low_voltage_line
    h2_84 - house
    lp2_84 - low_voltage_line
    h2_85 - house
    lp2_85 - low_voltage_line
    h2_86 - house
    lp2_86 - low_voltage_line
    h2_87 - house
    lp2_87 - low_voltage_line
    h2_88 - house
    lp2_88 - low_voltage_line
    h2_89 - house
    lp2_89 - low_voltage_line
    h2_90 - house
    lp2_90 - low_voltage_line
    h2_91 - house
    lp2_91 - low_voltage_line
    h2_92 - house
    lp2_92 - low_voltage_line
    h2_93 - house
    lp2_93 - low_voltage_line
    h2_94 - house
    lp2_94 - low_voltage_line
    h2_95 - house
    lp2_95 - low_voltage_line
    h2_96 - house
    lp2_96 - low_voltage_line
    h2_97 - house
    lp2_97 - low_voltage_line
    h2_98 - house
    lp2_98 - low_voltage_line
    h2_99 - house
    lp2_99 - low_voltage_line
    h2_100 - house
    lp2_100 - low_voltage_line
    h2_101 - house
    lp2_101 - low_voltage_line
    h2_102 - house
    lp2_102 - low_voltage_line
    h2_103 - house
    lp2_103 - low_voltage_line
    h2_104 - house
    lp2_104 - low_voltage_line
    h2_105 - house
    lp2_105 - low_voltage_line
    h2_106 - house
    lp2_106 - low_voltage_line
    h2_107 - house
    lp2_107 - low_voltage_line
    h2_108 - house
    lp2_108 - low_voltage_line
    h2_109 - house
    lp2_109 - low_voltage_line
    h2_110 - house
    lp2_110 - low_voltage_line
    h2_111 - house
    lp2_111 - low_voltage_line
    h2_112 - house
    lp2_112 - low_voltage_line
    h2_113 - house
    lp2_113 - low_voltage_line
    h2_114 - house
    lp2_114 - low_voltage_line
    h2_115 - house
    lp2_115 - low_voltage_line
    h2_116 - house
    lp2_116 - low_voltage_line
    h2_117 - house
    lp2_117 - low_voltage_line
    h2_118 - house
    lp2_118 - low_voltage_line
    h2_119 - house
    lp2_119 - low_voltage_line
    h2_120 - house
    lp2_120 - low_voltage_line
    h2_121 - house
    lp2_121 - low_voltage_line
    h2_122 - house
    lp2_122 - low_voltage_line
    h2_123 - house
    lp2_123 - low_voltage_line
    h2_124 - house
    lp2_124 - low_voltage_line
    h2_125 - house
    lp2_125 - low_voltage_line
    h2_126 - house
    lp2_126 - low_voltage_line
    h2_127 - house
    lp2_127 - low_voltage_line
    h2_128 - house
    lp2_128 - low_voltage_line
    h2_129 - house
    lp2_129 - low_voltage_line
    h2_130 - house
    lp2_130 - low_voltage_line
    h2_131 - house
    lp2_131 - low_voltage_line
    h2_132 - house
    lp2_132 - low_voltage_line
    h2_133 - house
    lp2_133 - low_voltage_line
    h2_134 - house
    lp2_134 - low_voltage_line
    h2_135 - house
    lp2_135 - low_voltage_line
    h2_136 - house
    lp2_136 - low_voltage_line
    h2_137 - house
    lp2_137 - low_voltage_line
    h2_138 - house
    lp2_138 - low_voltage_line
    h2_139 - house
    lp2_139 - low_voltage_line
    h2_140 - house
    lp2_140 - low_voltage_line
    h2_141 - house
    lp2_141 - low_voltage_line
    h2_142 - house
    lp2_142 - low_voltage_line
    h2_143 - house
    lp2_143 - low_voltage_line
    h2_144 - house
    lp2_144 - low_voltage_line
    h2_145 - house
    lp2_145 - low_voltage_line
    h2_146 - house
    lp2_146 - low_voltage_line
    h2_147 - house
    lp2_147 - low_voltage_line
    h2_148 - house
    lp2_148 - low_voltage_line
    h2_149 - house
    lp2_149 - low_voltage_line
    h2_150 - house
    lp2_150 - low_voltage_line
    h2_151 - house
    lp2_151 - low_voltage_line
    h2_152 - house
    lp2_152 - low_voltage_line
    h2_153 - house
    lp2_153 - low_voltage_line
    h2_154 - house
    lp2_154 - low_voltage_line
    h2_155 - house
    lp2_155 - low_voltage_line
    h2_156 - house
    lp2_156 - low_voltage_line
    h2_157 - house
    lp2_157 - low_voltage_line
    h2_158 - house
    lp2_158 - low_voltage_line
    h2_159 - house
    lp2_159 - low_voltage_line
    h2_160 - house
    lp2_160 - low_voltage_line
    h2_161 - house
    lp2_161 - low_voltage_line
    h2_162 - house
    lp2_162 - low_voltage_line
    h2_163 - house
    lp2_163 - low_voltage_line
    h2_164 - house
    lp2_164 - low_voltage_line
    h2_165 - house
    lp2_165 - low_voltage_line
    h2_166 - house
    lp2_166 - low_voltage_line
    h2_167 - house
    lp2_167 - low_voltage_line
    h2_168 - house
    lp2_168 - low_voltage_line
    h2_169 - house
    lp2_169 - low_voltage_line
    h2_170 - house
    lp2_170 - low_voltage_line
    h2_171 - house
    lp2_171 - low_voltage_line
    h2_172 - house
    lp2_172 - low_voltage_line
    h2_173 - house
    lp2_173 - low_voltage_line
    h2_174 - house
    lp2_174 - low_voltage_line
    h2_175 - house
    lp2_175 - low_voltage_line
    h2_176 - house
    lp2_176 - low_voltage_line
    h2_177 - house
    lp2_177 - low_voltage_line
    h2_178 - house
    lp2_178 - low_voltage_line
    h2_179 - house
    lp2_179 - low_voltage_line
    h2_180 - house
    lp2_180 - low_voltage_line
    h2_181 - house
    lp2_181 - low_voltage_line
    h2_182 - house
    lp2_182 - low_voltage_line
    h2_183 - house
    lp2_183 - low_voltage_line
    h2_184 - house
    lp2_184 - low_voltage_line
    h2_185 - house
    lp2_185 - low_voltage_line
    h2_186 - house
    lp2_186 - low_voltage_line
    h2_187 - house
    lp2_187 - low_voltage_line
    h2_188 - house
    lp2_188 - low_voltage_line
    h2_189 - house
    lp2_189 - low_voltage_line
    h2_190 - house
    lp2_190 - low_voltage_line
    h2_191 - house
    lp2_191 - low_voltage_line
    h2_192 - house
    lp2_192 - low_voltage_line
    h2_193 - house
    lp2_193 - low_voltage_line
    h2_194 - house
    lp2_194 - low_voltage_line
    h2_195 - house
    lp2_195 - low_voltage_line
    h2_196 - house
    lp2_196 - low_voltage_line
    h2_197 - house
    lp2_197 - low_voltage_line
    h2_198 - house
    lp2_198 - low_voltage_line
    h2_199 - house
    lp2_199 - low_voltage_line
    h2_200 - house
    lp2_200 - low_voltage_line
    HP2 - high_voltage_line
    h3_1 - house
    lp3_1 - low_voltage_line
    h3_2 - house
    lp3_2 - low_voltage_line
    h3_3 - house
    lp3_3 - low_voltage_line
    h3_4 - house
    lp3_4 - low_voltage_line
    h3_5 - house
    lp3_5 - low_voltage_line
    h3_6 - house
    lp3_6 - low_voltage_line
    h3_7 - house
    lp3_7 - low_voltage_line
    h3_8 - house
    lp3_8 - low_voltage_line
    h3_9 - house
    lp3_9 - low_voltage_line
    h3_10 - house
    lp3_10 - low_voltage_line
    h3_11 - house
    lp3_11 - low_voltage_line
    h3_12 - house
    lp3_12 - low_voltage_line
    h3_13 - house
    lp3_13 - low_voltage_line
    h3_14 - house
    lp3_14 - low_voltage_line
    h3_15 - house
    lp3_15 - low_voltage_line
    h3_16 - house
    lp3_16 - low_voltage_line
    h3_17 - house
    lp3_17 - low_voltage_line
    h3_18 - house
    lp3_18 - low_voltage_line
    h3_19 - house
    lp3_19 - low_voltage_line
    h3_20 - house
    lp3_20 - low_voltage_line
    h3_21 - house
    lp3_21 - low_voltage_line
    h3_22 - house
    lp3_22 - low_voltage_line
    h3_23 - house
    lp3_23 - low_voltage_line
    h3_24 - house
    lp3_24 - low_voltage_line
    h3_25 - house
    lp3_25 - low_voltage_line
    h3_26 - house
    lp3_26 - low_voltage_line
    h3_27 - house
    lp3_27 - low_voltage_line
    h3_28 - house
    lp3_28 - low_voltage_line
    h3_29 - house
    lp3_29 - low_voltage_line
    h3_30 - house
    lp3_30 - low_voltage_line
    h3_31 - house
    lp3_31 - low_voltage_line
    h3_32 - house
    lp3_32 - low_voltage_line
    h3_33 - house
    lp3_33 - low_voltage_line
    h3_34 - house
    lp3_34 - low_voltage_line
    h3_35 - house
    lp3_35 - low_voltage_line
    h3_36 - house
    lp3_36 - low_voltage_line
    h3_37 - house
    lp3_37 - low_voltage_line
    h3_38 - house
    lp3_38 - low_voltage_line
    h3_39 - house
    lp3_39 - low_voltage_line
    h3_40 - house
    lp3_40 - low_voltage_line
    h3_41 - house
    lp3_41 - low_voltage_line
    h3_42 - house
    lp3_42 - low_voltage_line
    h3_43 - house
    lp3_43 - low_voltage_line
    h3_44 - house
    lp3_44 - low_voltage_line
    h3_45 - house
    lp3_45 - low_voltage_line
    h3_46 - house
    lp3_46 - low_voltage_line
    h3_47 - house
    lp3_47 - low_voltage_line
    h3_48 - house
    lp3_48 - low_voltage_line
    h3_49 - house
    lp3_49 - low_voltage_line
    h3_50 - house
    lp3_50 - low_voltage_line
    h3_51 - house
    lp3_51 - low_voltage_line
    h3_52 - house
    lp3_52 - low_voltage_line
    h3_53 - house
    lp3_53 - low_voltage_line
    h3_54 - house
    lp3_54 - low_voltage_line
    h3_55 - house
    lp3_55 - low_voltage_line
    h3_56 - house
    lp3_56 - low_voltage_line
    h3_57 - house
    lp3_57 - low_voltage_line
    h3_58 - house
    lp3_58 - low_voltage_line
    h3_59 - house
    lp3_59 - low_voltage_line
    h3_60 - house
    lp3_60 - low_voltage_line
    h3_61 - house
    lp3_61 - low_voltage_line
    h3_62 - house
    lp3_62 - low_voltage_line
    h3_63 - house
    lp3_63 - low_voltage_line
    h3_64 - house
    lp3_64 - low_voltage_line
    h3_65 - house
    lp3_65 - low_voltage_line
    h3_66 - house
    lp3_66 - low_voltage_line
    h3_67 - house
    lp3_67 - low_voltage_line
    h3_68 - house
    lp3_68 - low_voltage_line
    h3_69 - house
    lp3_69 - low_voltage_line
    h3_70 - house
    lp3_70 - low_voltage_line
    h3_71 - house
    lp3_71 - low_voltage_line
    h3_72 - house
    lp3_72 - low_voltage_line
    h3_73 - house
    lp3_73 - low_voltage_line
    h3_74 - house
    lp3_74 - low_voltage_line
    h3_75 - house
    lp3_75 - low_voltage_line
    h3_76 - house
    lp3_76 - low_voltage_line
    h3_77 - house
    lp3_77 - low_voltage_line
    h3_78 - house
    lp3_78 - low_voltage_line
    h3_79 - house
    lp3_79 - low_voltage_line
    h3_80 - house
    lp3_80 - low_voltage_line
    h3_81 - house
    lp3_81 - low_voltage_line
    h3_82 - house
    lp3_82 - low_voltage_line
    h3_83 - house
    lp3_83 - low_voltage_line
    h3_84 - house
    lp3_84 - low_voltage_line
    h3_85 - house
    lp3_85 - low_voltage_line
    h3_86 - house
    lp3_86 - low_voltage_line
    h3_87 - house
    lp3_87 - low_voltage_line
    h3_88 - house
    lp3_88 - low_voltage_line
    h3_89 - house
    lp3_89 - low_voltage_line
    h3_90 - house
    lp3_90 - low_voltage_line
    h3_91 - house
    lp3_91 - low_voltage_line
    h3_92 - house
    lp3_92 - low_voltage_line
    h3_93 - house
    lp3_93 - low_voltage_line
    h3_94 - house
    lp3_94 - low_voltage_line
    h3_95 - house
    lp3_95 - low_voltage_line
    h3_96 - house
    lp3_96 - low_voltage_line
    h3_97 - house
    lp3_97 - low_voltage_line
    h3_98 - house
    lp3_98 - low_voltage_line
    h3_99 - house
    lp3_99 - low_voltage_line
    h3_100 - house
    lp3_100 - low_voltage_line
    h3_101 - house
    lp3_101 - low_voltage_line
    h3_102 - house
    lp3_102 - low_voltage_line
    h3_103 - house
    lp3_103 - low_voltage_line
    h3_104 - house
    lp3_104 - low_voltage_line
    h3_105 - house
    lp3_105 - low_voltage_line
    h3_106 - house
    lp3_106 - low_voltage_line
    h3_107 - house
    lp3_107 - low_voltage_line
    h3_108 - house
    lp3_108 - low_voltage_line
    h3_109 - house
    lp3_109 - low_voltage_line
    h3_110 - house
    lp3_110 - low_voltage_line
    h3_111 - house
    lp3_111 - low_voltage_line
    h3_112 - house
    lp3_112 - low_voltage_line
    h3_113 - house
    lp3_113 - low_voltage_line
    h3_114 - house
    lp3_114 - low_voltage_line
    h3_115 - house
    lp3_115 - low_voltage_line
    h3_116 - house
    lp3_116 - low_voltage_line
    h3_117 - house
    lp3_117 - low_voltage_line
    h3_118 - house
    lp3_118 - low_voltage_line
    h3_119 - house
    lp3_119 - low_voltage_line
    h3_120 - house
    lp3_120 - low_voltage_line
    h3_121 - house
    lp3_121 - low_voltage_line
    h3_122 - house
    lp3_122 - low_voltage_line
    h3_123 - house
    lp3_123 - low_voltage_line
    h3_124 - house
    lp3_124 - low_voltage_line
    h3_125 - house
    lp3_125 - low_voltage_line
    h3_126 - house
    lp3_126 - low_voltage_line
    h3_127 - house
    lp3_127 - low_voltage_line
    h3_128 - house
    lp3_128 - low_voltage_line
    h3_129 - house
    lp3_129 - low_voltage_line
    h3_130 - house
    lp3_130 - low_voltage_line
    h3_131 - house
    lp3_131 - low_voltage_line
    h3_132 - house
    lp3_132 - low_voltage_line
    h3_133 - house
    lp3_133 - low_voltage_line
    h3_134 - house
    lp3_134 - low_voltage_line
    h3_135 - house
    lp3_135 - low_voltage_line
    h3_136 - house
    lp3_136 - low_voltage_line
    h3_137 - house
    lp3_137 - low_voltage_line
    h3_138 - house
    lp3_138 - low_voltage_line
    h3_139 - house
    lp3_139 - low_voltage_line
    h3_140 - house
    lp3_140 - low_voltage_line
    h3_141 - house
    lp3_141 - low_voltage_line
    h3_142 - house
    lp3_142 - low_voltage_line
    h3_143 - house
    lp3_143 - low_voltage_line
    h3_144 - house
    lp3_144 - low_voltage_line
    h3_145 - house
    lp3_145 - low_voltage_line
    h3_146 - house
    lp3_146 - low_voltage_line
    h3_147 - house
    lp3_147 - low_voltage_line
    h3_148 - house
    lp3_148 - low_voltage_line
    h3_149 - house
    lp3_149 - low_voltage_line
    h3_150 - house
    lp3_150 - low_voltage_line
    h3_151 - house
    lp3_151 - low_voltage_line
    h3_152 - house
    lp3_152 - low_voltage_line
    h3_153 - house
    lp3_153 - low_voltage_line
    h3_154 - house
    lp3_154 - low_voltage_line
    h3_155 - house
    lp3_155 - low_voltage_line
    h3_156 - house
    lp3_156 - low_voltage_line
    h3_157 - house
    lp3_157 - low_voltage_line
    h3_158 - house
    lp3_158 - low_voltage_line
    h3_159 - house
    lp3_159 - low_voltage_line
    h3_160 - house
    lp3_160 - low_voltage_line
    h3_161 - house
    lp3_161 - low_voltage_line
    h3_162 - house
    lp3_162 - low_voltage_line
    h3_163 - house
    lp3_163 - low_voltage_line
    h3_164 - house
    lp3_164 - low_voltage_line
    h3_165 - house
    lp3_165 - low_voltage_line
    h3_166 - house
    lp3_166 - low_voltage_line
    h3_167 - house
    lp3_167 - low_voltage_line
    h3_168 - house
    lp3_168 - low_voltage_line
    h3_169 - house
    lp3_169 - low_voltage_line
    h3_170 - house
    lp3_170 - low_voltage_line
    h3_171 - house
    lp3_171 - low_voltage_line
    h3_172 - house
    lp3_172 - low_voltage_line
    h3_173 - house
    lp3_173 - low_voltage_line
    h3_174 - house
    lp3_174 - low_voltage_line
    h3_175 - house
    lp3_175 - low_voltage_line
    h3_176 - house
    lp3_176 - low_voltage_line
    h3_177 - house
    lp3_177 - low_voltage_line
    h3_178 - house
    lp3_178 - low_voltage_line
    h3_179 - house
    lp3_179 - low_voltage_line
    h3_180 - house
    lp3_180 - low_voltage_line
    h3_181 - house
    lp3_181 - low_voltage_line
    h3_182 - house
    lp3_182 - low_voltage_line
    h3_183 - house
    lp3_183 - low_voltage_line
    h3_184 - house
    lp3_184 - low_voltage_line
    h3_185 - house
    lp3_185 - low_voltage_line
    h3_186 - house
    lp3_186 - low_voltage_line
    h3_187 - house
    lp3_187 - low_voltage_line
    h3_188 - house
    lp3_188 - low_voltage_line
    h3_189 - house
    lp3_189 - low_voltage_line
    h3_190 - house
    lp3_190 - low_voltage_line
    h3_191 - house
    lp3_191 - low_voltage_line
    h3_192 - house
    lp3_192 - low_voltage_line
    h3_193 - house
    lp3_193 - low_voltage_line
    h3_194 - house
    lp3_194 - low_voltage_line
    h3_195 - house
    lp3_195 - low_voltage_line
    h3_196 - house
    lp3_196 - low_voltage_line
    h3_197 - house
    lp3_197 - low_voltage_line
    h3_198 - house
    lp3_198 - low_voltage_line
    h3_199 - house
    lp3_199 - low_voltage_line
    h3_200 - house
    lp3_200 - low_voltage_line
    HP3 - high_voltage_line
   lpTransformer_1 - low_voltage_line
   lpTransformer_2 - low_voltage_line
   lpTransformer_3 - low_voltage_line
    )
    (:init
    (0Volt p1)
    (connected p1 t1 HP1)
    (transmissionSafe HP1)
    (connected p1 t2 HP2)
    (transmissionSafe HP2)
    (connected p1 t3 HP3)
    (transmissionSafe HP3)
    (connected h1_1 h1_2 lp1_1)
    (transmissionSafe lp1_1)
    (needsElectricity h1_1)
    (connected h1_2 h1_3 lp1_2)
    (transmissionSafe lp1_2)
    (needsElectricity h1_2)
    (connected h1_3 h1_4 lp1_3)
    (transmissionSafe lp1_3)
    (needsElectricity h1_3)
    (connected h1_4 h1_5 lp1_4)
    (transmissionSafe lp1_4)
    (needsElectricity h1_4)
    (connected h1_5 h1_6 lp1_5)
    (transmissionSafe lp1_5)
    (needsElectricity h1_5)
    (connected h1_6 h1_7 lp1_6)
    (transmissionSafe lp1_6)
    (needsElectricity h1_6)
    (connected h1_7 h1_8 lp1_7)
    (transmissionSafe lp1_7)
    (needsElectricity h1_7)
    (connected h1_8 h1_9 lp1_8)
    (transmissionSafe lp1_8)
    (needsElectricity h1_8)
    (connected h1_9 h1_10 lp1_9)
    (transmissionSafe lp1_9)
    (needsElectricity h1_9)
    (connected h1_10 h1_11 lp1_10)
    (transmissionSafe lp1_10)
    (needsElectricity h1_10)
    (connected h1_11 h1_12 lp1_11)
    (transmissionSafe lp1_11)
    (needsElectricity h1_11)
    (connected h1_12 h1_13 lp1_12)
    (transmissionSafe lp1_12)
    (needsElectricity h1_12)
    (connected h1_13 h1_14 lp1_13)
    (transmissionSafe lp1_13)
    (needsElectricity h1_13)
    (connected h1_14 h1_15 lp1_14)
    (transmissionSafe lp1_14)
    (needsElectricity h1_14)
    (connected h1_15 h1_16 lp1_15)
    (transmissionSafe lp1_15)
    (needsElectricity h1_15)
    (connected h1_16 h1_17 lp1_16)
    (transmissionSafe lp1_16)
    (needsElectricity h1_16)
    (connected h1_17 h1_18 lp1_17)
    (transmissionSafe lp1_17)
    (needsElectricity h1_17)
    (connected h1_18 h1_19 lp1_18)
    (transmissionSafe lp1_18)
    (needsElectricity h1_18)
    (connected h1_19 h1_20 lp1_19)
    (transmissionSafe lp1_19)
    (needsElectricity h1_19)
    (connected h1_20 h1_21 lp1_20)
    (transmissionSafe lp1_20)
    (needsElectricity h1_20)
    (connected h1_21 h1_22 lp1_21)
    (transmissionSafe lp1_21)
    (needsElectricity h1_21)
    (connected h1_22 h1_23 lp1_22)
    (transmissionSafe lp1_22)
    (needsElectricity h1_22)
    (connected h1_23 h1_24 lp1_23)
    (transmissionSafe lp1_23)
    (needsElectricity h1_23)
    (connected h1_24 h1_25 lp1_24)
    (transmissionSafe lp1_24)
    (needsElectricity h1_24)
    (connected h1_25 h1_26 lp1_25)
    (transmissionSafe lp1_25)
    (needsElectricity h1_25)
    (connected h1_26 h1_27 lp1_26)
    (transmissionSafe lp1_26)
    (needsElectricity h1_26)
    (connected h1_27 h1_28 lp1_27)
    (transmissionSafe lp1_27)
    (needsElectricity h1_27)
    (connected h1_28 h1_29 lp1_28)
    (transmissionSafe lp1_28)
    (needsElectricity h1_28)
    (connected h1_29 h1_30 lp1_29)
    (transmissionSafe lp1_29)
    (needsElectricity h1_29)
    (connected h1_30 h1_31 lp1_30)
    (transmissionSafe lp1_30)
    (needsElectricity h1_30)
    (connected h1_31 h1_32 lp1_31)
    (transmissionSafe lp1_31)
    (needsElectricity h1_31)
    (connected h1_32 h1_33 lp1_32)
    (transmissionSafe lp1_32)
    (needsElectricity h1_32)
    (connected h1_33 h1_34 lp1_33)
    (transmissionSafe lp1_33)
    (needsElectricity h1_33)
    (connected h1_34 h1_35 lp1_34)
    (transmissionSafe lp1_34)
    (needsElectricity h1_34)
    (connected h1_35 h1_36 lp1_35)
    (transmissionSafe lp1_35)
    (needsElectricity h1_35)
    (connected h1_36 h1_37 lp1_36)
    (transmissionSafe lp1_36)
    (needsElectricity h1_36)
    (connected h1_37 h1_38 lp1_37)
    (transmissionSafe lp1_37)
    (needsElectricity h1_37)
    (connected h1_38 h1_39 lp1_38)
    (transmissionSafe lp1_38)
    (needsElectricity h1_38)
    (connected h1_39 h1_40 lp1_39)
    (transmissionSafe lp1_39)
    (needsElectricity h1_39)
    (connected h1_40 h1_41 lp1_40)
    (transmissionSafe lp1_40)
    (needsElectricity h1_40)
    (connected h1_41 h1_42 lp1_41)
    (transmissionSafe lp1_41)
    (needsElectricity h1_41)
    (connected h1_42 h1_43 lp1_42)
    (transmissionSafe lp1_42)
    (needsElectricity h1_42)
    (connected h1_43 h1_44 lp1_43)
    (transmissionSafe lp1_43)
    (needsElectricity h1_43)
    (connected h1_44 h1_45 lp1_44)
    (transmissionSafe lp1_44)
    (needsElectricity h1_44)
    (connected h1_45 h1_46 lp1_45)
    (transmissionSafe lp1_45)
    (needsElectricity h1_45)
    (connected h1_46 h1_47 lp1_46)
    (transmissionSafe lp1_46)
    (needsElectricity h1_46)
    (connected h1_47 h1_48 lp1_47)
    (transmissionSafe lp1_47)
    (needsElectricity h1_47)
    (connected h1_48 h1_49 lp1_48)
    (transmissionSafe lp1_48)
    (needsElectricity h1_48)
    (connected h1_49 h1_50 lp1_49)
    (transmissionSafe lp1_49)
    (needsElectricity h1_49)
    (connected h1_50 h1_51 lp1_50)
    (transmissionSafe lp1_50)
    (needsElectricity h1_50)
    (connected h1_51 h1_52 lp1_51)
    (transmissionSafe lp1_51)
    (needsElectricity h1_51)
    (connected h1_52 h1_53 lp1_52)
    (transmissionSafe lp1_52)
    (needsElectricity h1_52)
    (connected h1_53 h1_54 lp1_53)
    (transmissionSafe lp1_53)
    (needsElectricity h1_53)
    (connected h1_54 h1_55 lp1_54)
    (transmissionSafe lp1_54)
    (needsElectricity h1_54)
    (connected h1_55 h1_56 lp1_55)
    (transmissionSafe lp1_55)
    (needsElectricity h1_55)
    (connected h1_56 h1_57 lp1_56)
    (transmissionSafe lp1_56)
    (needsElectricity h1_56)
    (connected h1_57 h1_58 lp1_57)
    (transmissionSafe lp1_57)
    (needsElectricity h1_57)
    (connected h1_58 h1_59 lp1_58)
    (transmissionSafe lp1_58)
    (needsElectricity h1_58)
    (connected h1_59 h1_60 lp1_59)
    (transmissionSafe lp1_59)
    (needsElectricity h1_59)
    (connected h1_60 h1_61 lp1_60)
    (transmissionSafe lp1_60)
    (needsElectricity h1_60)
    (connected h1_61 h1_62 lp1_61)
    (transmissionSafe lp1_61)
    (needsElectricity h1_61)
    (connected h1_62 h1_63 lp1_62)
    (transmissionSafe lp1_62)
    (needsElectricity h1_62)
    (connected h1_63 h1_64 lp1_63)
    (transmissionSafe lp1_63)
    (needsElectricity h1_63)
    (connected h1_64 h1_65 lp1_64)
    (transmissionSafe lp1_64)
    (needsElectricity h1_64)
    (connected h1_65 h1_66 lp1_65)
    (transmissionSafe lp1_65)
    (needsElectricity h1_65)
    (connected h1_66 h1_67 lp1_66)
    (transmissionSafe lp1_66)
    (needsElectricity h1_66)
    (connected h1_67 h1_68 lp1_67)
    (transmissionSafe lp1_67)
    (needsElectricity h1_67)
    (connected h1_68 h1_69 lp1_68)
    (transmissionSafe lp1_68)
    (needsElectricity h1_68)
    (connected h1_69 h1_70 lp1_69)
    (transmissionSafe lp1_69)
    (needsElectricity h1_69)
    (connected h1_70 h1_71 lp1_70)
    (transmissionSafe lp1_70)
    (needsElectricity h1_70)
    (connected h1_71 h1_72 lp1_71)
    (transmissionSafe lp1_71)
    (needsElectricity h1_71)
    (connected h1_72 h1_73 lp1_72)
    (transmissionSafe lp1_72)
    (needsElectricity h1_72)
    (connected h1_73 h1_74 lp1_73)
    (transmissionSafe lp1_73)
    (needsElectricity h1_73)
    (connected h1_74 h1_75 lp1_74)
    (transmissionSafe lp1_74)
    (needsElectricity h1_74)
    (connected h1_75 h1_76 lp1_75)
    (transmissionSafe lp1_75)
    (needsElectricity h1_75)
    (connected h1_76 h1_77 lp1_76)
    (transmissionSafe lp1_76)
    (needsElectricity h1_76)
    (connected h1_77 h1_78 lp1_77)
    (transmissionSafe lp1_77)
    (needsElectricity h1_77)
    (connected h1_78 h1_79 lp1_78)
    (transmissionSafe lp1_78)
    (needsElectricity h1_78)
    (connected h1_79 h1_80 lp1_79)
    (transmissionSafe lp1_79)
    (needsElectricity h1_79)
    (connected h1_80 h1_81 lp1_80)
    (transmissionSafe lp1_80)
    (needsElectricity h1_80)
    (connected h1_81 h1_82 lp1_81)
    (transmissionSafe lp1_81)
    (needsElectricity h1_81)
    (connected h1_82 h1_83 lp1_82)
    (transmissionSafe lp1_82)
    (needsElectricity h1_82)
    (connected h1_83 h1_84 lp1_83)
    (transmissionSafe lp1_83)
    (needsElectricity h1_83)
    (connected h1_84 h1_85 lp1_84)
    (transmissionSafe lp1_84)
    (needsElectricity h1_84)
    (connected h1_85 h1_86 lp1_85)
    (transmissionSafe lp1_85)
    (needsElectricity h1_85)
    (connected h1_86 h1_87 lp1_86)
    (transmissionSafe lp1_86)
    (needsElectricity h1_86)
    (connected h1_87 h1_88 lp1_87)
    (transmissionSafe lp1_87)
    (needsElectricity h1_87)
    (connected h1_88 h1_89 lp1_88)
    (transmissionSafe lp1_88)
    (needsElectricity h1_88)
    (connected h1_89 h1_90 lp1_89)
    (transmissionSafe lp1_89)
    (needsElectricity h1_89)
    (connected h1_90 h1_91 lp1_90)
    (transmissionSafe lp1_90)
    (needsElectricity h1_90)
    (connected h1_91 h1_92 lp1_91)
    (transmissionSafe lp1_91)
    (needsElectricity h1_91)
    (connected h1_92 h1_93 lp1_92)
    (transmissionSafe lp1_92)
    (needsElectricity h1_92)
    (connected h1_93 h1_94 lp1_93)
    (transmissionSafe lp1_93)
    (needsElectricity h1_93)
    (connected h1_94 h1_95 lp1_94)
    (transmissionSafe lp1_94)
    (needsElectricity h1_94)
    (connected h1_95 h1_96 lp1_95)
    (transmissionSafe lp1_95)
    (needsElectricity h1_95)
    (connected h1_96 h1_97 lp1_96)
    (transmissionSafe lp1_96)
    (needsElectricity h1_96)
    (connected h1_97 h1_98 lp1_97)
    (transmissionSafe lp1_97)
    (needsElectricity h1_97)
    (connected h1_98 h1_99 lp1_98)
    (transmissionSafe lp1_98)
    (needsElectricity h1_98)
    (connected h1_99 h1_100 lp1_99)
    (transmissionSafe lp1_99)
    (needsElectricity h1_99)
    (connected h1_100 h1_101 lp1_100)
    (transmissionSafe lp1_100)
    (needsElectricity h1_100)
    (connected h1_101 h1_102 lp1_101)
    (transmissionSafe lp1_101)
    (needsElectricity h1_101)
    (connected h1_102 h1_103 lp1_102)
    (transmissionSafe lp1_102)
    (needsElectricity h1_102)
    (connected h1_103 h1_104 lp1_103)
    (transmissionSafe lp1_103)
    (needsElectricity h1_103)
    (connected h1_104 h1_105 lp1_104)
    (transmissionSafe lp1_104)
    (needsElectricity h1_104)
    (connected h1_105 h1_106 lp1_105)
    (transmissionSafe lp1_105)
    (needsElectricity h1_105)
    (connected h1_106 h1_107 lp1_106)
    (transmissionSafe lp1_106)
    (needsElectricity h1_106)
    (connected h1_107 h1_108 lp1_107)
    (transmissionSafe lp1_107)
    (needsElectricity h1_107)
    (connected h1_108 h1_109 lp1_108)
    (transmissionSafe lp1_108)
    (needsElectricity h1_108)
    (connected h1_109 h1_110 lp1_109)
    (transmissionSafe lp1_109)
    (needsElectricity h1_109)
    (connected h1_110 h1_111 lp1_110)
    (transmissionSafe lp1_110)
    (needsElectricity h1_110)
    (connected h1_111 h1_112 lp1_111)
    (transmissionSafe lp1_111)
    (needsElectricity h1_111)
    (connected h1_112 h1_113 lp1_112)
    (transmissionSafe lp1_112)
    (needsElectricity h1_112)
    (connected h1_113 h1_114 lp1_113)
    (transmissionSafe lp1_113)
    (needsElectricity h1_113)
    (connected h1_114 h1_115 lp1_114)
    (transmissionSafe lp1_114)
    (needsElectricity h1_114)
    (connected h1_115 h1_116 lp1_115)
    (transmissionSafe lp1_115)
    (needsElectricity h1_115)
    (connected h1_116 h1_117 lp1_116)
    (transmissionSafe lp1_116)
    (needsElectricity h1_116)
    (connected h1_117 h1_118 lp1_117)
    (transmissionSafe lp1_117)
    (needsElectricity h1_117)
    (connected h1_118 h1_119 lp1_118)
    (transmissionSafe lp1_118)
    (needsElectricity h1_118)
    (connected h1_119 h1_120 lp1_119)
    (transmissionSafe lp1_119)
    (needsElectricity h1_119)
    (connected h1_120 h1_121 lp1_120)
    (transmissionSafe lp1_120)
    (needsElectricity h1_120)
    (connected h1_121 h1_122 lp1_121)
    (transmissionSafe lp1_121)
    (needsElectricity h1_121)
    (connected h1_122 h1_123 lp1_122)
    (transmissionSafe lp1_122)
    (needsElectricity h1_122)
    (connected h1_123 h1_124 lp1_123)
    (transmissionSafe lp1_123)
    (needsElectricity h1_123)
    (connected h1_124 h1_125 lp1_124)
    (transmissionSafe lp1_124)
    (needsElectricity h1_124)
    (connected h1_125 h1_126 lp1_125)
    (transmissionSafe lp1_125)
    (needsElectricity h1_125)
    (connected h1_126 h1_127 lp1_126)
    (transmissionSafe lp1_126)
    (needsElectricity h1_126)
    (connected h1_127 h1_128 lp1_127)
    (transmissionSafe lp1_127)
    (needsElectricity h1_127)
    (connected h1_128 h1_129 lp1_128)
    (transmissionSafe lp1_128)
    (needsElectricity h1_128)
    (connected h1_129 h1_130 lp1_129)
    (transmissionSafe lp1_129)
    (needsElectricity h1_129)
    (connected h1_130 h1_131 lp1_130)
    (transmissionSafe lp1_130)
    (needsElectricity h1_130)
    (connected h1_131 h1_132 lp1_131)
    (transmissionSafe lp1_131)
    (needsElectricity h1_131)
    (connected h1_132 h1_133 lp1_132)
    (transmissionSafe lp1_132)
    (needsElectricity h1_132)
    (connected h1_133 h1_134 lp1_133)
    (transmissionSafe lp1_133)
    (needsElectricity h1_133)
    (connected h1_134 h1_135 lp1_134)
    (transmissionSafe lp1_134)
    (needsElectricity h1_134)
    (connected h1_135 h1_136 lp1_135)
    (transmissionSafe lp1_135)
    (needsElectricity h1_135)
    (connected h1_136 h1_137 lp1_136)
    (transmissionSafe lp1_136)
    (needsElectricity h1_136)
    (connected h1_137 h1_138 lp1_137)
    (transmissionSafe lp1_137)
    (needsElectricity h1_137)
    (connected h1_138 h1_139 lp1_138)
    (transmissionSafe lp1_138)
    (needsElectricity h1_138)
    (connected h1_139 h1_140 lp1_139)
    (transmissionSafe lp1_139)
    (needsElectricity h1_139)
    (connected h1_140 h1_141 lp1_140)
    (transmissionSafe lp1_140)
    (needsElectricity h1_140)
    (connected h1_141 h1_142 lp1_141)
    (transmissionSafe lp1_141)
    (needsElectricity h1_141)
    (connected h1_142 h1_143 lp1_142)
    (transmissionSafe lp1_142)
    (needsElectricity h1_142)
    (connected h1_143 h1_144 lp1_143)
    (transmissionSafe lp1_143)
    (needsElectricity h1_143)
    (connected h1_144 h1_145 lp1_144)
    (transmissionSafe lp1_144)
    (needsElectricity h1_144)
    (connected h1_145 h1_146 lp1_145)
    (transmissionSafe lp1_145)
    (needsElectricity h1_145)
    (connected h1_146 h1_147 lp1_146)
    (transmissionSafe lp1_146)
    (needsElectricity h1_146)
    (connected h1_147 h1_148 lp1_147)
    (transmissionSafe lp1_147)
    (needsElectricity h1_147)
    (connected h1_148 h1_149 lp1_148)
    (transmissionSafe lp1_148)
    (needsElectricity h1_148)
    (connected h1_149 h1_150 lp1_149)
    (transmissionSafe lp1_149)
    (needsElectricity h1_149)
    (connected h1_150 h1_151 lp1_150)
    (transmissionSafe lp1_150)
    (needsElectricity h1_150)
    (connected h1_151 h1_152 lp1_151)
    (transmissionSafe lp1_151)
    (needsElectricity h1_151)
    (connected h1_152 h1_153 lp1_152)
    (transmissionSafe lp1_152)
    (needsElectricity h1_152)
    (connected h1_153 h1_154 lp1_153)
    (transmissionSafe lp1_153)
    (needsElectricity h1_153)
    (connected h1_154 h1_155 lp1_154)
    (transmissionSafe lp1_154)
    (needsElectricity h1_154)
    (connected h1_155 h1_156 lp1_155)
    (transmissionSafe lp1_155)
    (needsElectricity h1_155)
    (connected h1_156 h1_157 lp1_156)
    (transmissionSafe lp1_156)
    (needsElectricity h1_156)
    (connected h1_157 h1_158 lp1_157)
    (transmissionSafe lp1_157)
    (needsElectricity h1_157)
    (connected h1_158 h1_159 lp1_158)
    (transmissionSafe lp1_158)
    (needsElectricity h1_158)
    (connected h1_159 h1_160 lp1_159)
    (transmissionSafe lp1_159)
    (needsElectricity h1_159)
    (connected h1_160 h1_161 lp1_160)
    (transmissionSafe lp1_160)
    (needsElectricity h1_160)
    (connected h1_161 h1_162 lp1_161)
    (transmissionSafe lp1_161)
    (needsElectricity h1_161)
    (connected h1_162 h1_163 lp1_162)
    (transmissionSafe lp1_162)
    (needsElectricity h1_162)
    (connected h1_163 h1_164 lp1_163)
    (transmissionSafe lp1_163)
    (needsElectricity h1_163)
    (connected h1_164 h1_165 lp1_164)
    (transmissionSafe lp1_164)
    (needsElectricity h1_164)
    (connected h1_165 h1_166 lp1_165)
    (transmissionSafe lp1_165)
    (needsElectricity h1_165)
    (connected h1_166 h1_167 lp1_166)
    (transmissionSafe lp1_166)
    (needsElectricity h1_166)
    (connected h1_167 h1_168 lp1_167)
    (transmissionSafe lp1_167)
    (needsElectricity h1_167)
    (connected h1_168 h1_169 lp1_168)
    (transmissionSafe lp1_168)
    (needsElectricity h1_168)
    (connected h1_169 h1_170 lp1_169)
    (transmissionSafe lp1_169)
    (needsElectricity h1_169)
    (connected h1_170 h1_171 lp1_170)
    (transmissionSafe lp1_170)
    (needsElectricity h1_170)
    (connected h1_171 h1_172 lp1_171)
    (transmissionSafe lp1_171)
    (needsElectricity h1_171)
    (connected h1_172 h1_173 lp1_172)
    (transmissionSafe lp1_172)
    (needsElectricity h1_172)
    (connected h1_173 h1_174 lp1_173)
    (transmissionSafe lp1_173)
    (needsElectricity h1_173)
    (connected h1_174 h1_175 lp1_174)
    (transmissionSafe lp1_174)
    (needsElectricity h1_174)
    (connected h1_175 h1_176 lp1_175)
    (transmissionSafe lp1_175)
    (needsElectricity h1_175)
    (connected h1_176 h1_177 lp1_176)
    (transmissionSafe lp1_176)
    (needsElectricity h1_176)
    (connected h1_177 h1_178 lp1_177)
    (transmissionSafe lp1_177)
    (needsElectricity h1_177)
    (connected h1_178 h1_179 lp1_178)
    (transmissionSafe lp1_178)
    (needsElectricity h1_178)
    (connected h1_179 h1_180 lp1_179)
    (transmissionSafe lp1_179)
    (needsElectricity h1_179)
    (connected h1_180 h1_181 lp1_180)
    (transmissionSafe lp1_180)
    (needsElectricity h1_180)
    (connected h1_181 h1_182 lp1_181)
    (transmissionSafe lp1_181)
    (needsElectricity h1_181)
    (connected h1_182 h1_183 lp1_182)
    (transmissionSafe lp1_182)
    (needsElectricity h1_182)
    (connected h1_183 h1_184 lp1_183)
    (transmissionSafe lp1_183)
    (needsElectricity h1_183)
    (connected h1_184 h1_185 lp1_184)
    (transmissionSafe lp1_184)
    (needsElectricity h1_184)
    (connected h1_185 h1_186 lp1_185)
    (transmissionSafe lp1_185)
    (needsElectricity h1_185)
    (connected h1_186 h1_187 lp1_186)
    (transmissionSafe lp1_186)
    (needsElectricity h1_186)
    (connected h1_187 h1_188 lp1_187)
    (transmissionSafe lp1_187)
    (needsElectricity h1_187)
    (connected h1_188 h1_189 lp1_188)
    (transmissionSafe lp1_188)
    (needsElectricity h1_188)
    (connected h1_189 h1_190 lp1_189)
    (transmissionSafe lp1_189)
    (needsElectricity h1_189)
    (connected h1_190 h1_191 lp1_190)
    (transmissionSafe lp1_190)
    (needsElectricity h1_190)
    (connected h1_191 h1_192 lp1_191)
    (transmissionSafe lp1_191)
    (needsElectricity h1_191)
    (connected h1_192 h1_193 lp1_192)
    (transmissionSafe lp1_192)
    (needsElectricity h1_192)
    (connected h1_193 h1_194 lp1_193)
    (transmissionSafe lp1_193)
    (needsElectricity h1_193)
    (connected h1_194 h1_195 lp1_194)
    (transmissionSafe lp1_194)
    (needsElectricity h1_194)
    (connected h1_195 h1_196 lp1_195)
    (transmissionSafe lp1_195)
    (needsElectricity h1_195)
    (connected h1_196 h1_197 lp1_196)
    (transmissionSafe lp1_196)
    (needsElectricity h1_196)
    (connected h1_197 h1_198 lp1_197)
    (transmissionSafe lp1_197)
    (needsElectricity h1_197)
    (connected h1_198 h1_199 lp1_198)
    (transmissionSafe lp1_198)
    (needsElectricity h1_198)
    (connected h1_199 h1_200 lp1_199)
    (transmissionSafe lp1_199)
    (needsElectricity h1_199)
    (needsElectricity h1_200)
    (connected t1 h1_1 lpTransformer_1)
    (transmissionSafe lpTransformer_1)
    (needsElectricity t1)
    (connected h2_1 h2_2 lp2_1)
    (transmissionSafe lp2_1)
    (needsElectricity h2_1)
    (connected h2_2 h2_3 lp2_2)
    (transmissionSafe lp2_2)
    (needsElectricity h2_2)
    (connected h2_3 h2_4 lp2_3)
    (transmissionSafe lp2_3)
    (needsElectricity h2_3)
    (connected h2_4 h2_5 lp2_4)
    (transmissionSafe lp2_4)
    (needsElectricity h2_4)
    (connected h2_5 h2_6 lp2_5)
    (transmissionSafe lp2_5)
    (needsElectricity h2_5)
    (connected h2_6 h2_7 lp2_6)
    (transmissionSafe lp2_6)
    (needsElectricity h2_6)
    (connected h2_7 h2_8 lp2_7)
    (transmissionSafe lp2_7)
    (needsElectricity h2_7)
    (connected h2_8 h2_9 lp2_8)
    (transmissionSafe lp2_8)
    (needsElectricity h2_8)
    (connected h2_9 h2_10 lp2_9)
    (transmissionSafe lp2_9)
    (needsElectricity h2_9)
    (connected h2_10 h2_11 lp2_10)
    (transmissionSafe lp2_10)
    (needsElectricity h2_10)
    (connected h2_11 h2_12 lp2_11)
    (transmissionSafe lp2_11)
    (needsElectricity h2_11)
    (connected h2_12 h2_13 lp2_12)
    (transmissionSafe lp2_12)
    (needsElectricity h2_12)
    (connected h2_13 h2_14 lp2_13)
    (transmissionSafe lp2_13)
    (needsElectricity h2_13)
    (connected h2_14 h2_15 lp2_14)
    (transmissionSafe lp2_14)
    (needsElectricity h2_14)
    (connected h2_15 h2_16 lp2_15)
    (transmissionSafe lp2_15)
    (needsElectricity h2_15)
    (connected h2_16 h2_17 lp2_16)
    (transmissionSafe lp2_16)
    (needsElectricity h2_16)
    (connected h2_17 h2_18 lp2_17)
    (transmissionSafe lp2_17)
    (needsElectricity h2_17)
    (connected h2_18 h2_19 lp2_18)
    (transmissionSafe lp2_18)
    (needsElectricity h2_18)
    (connected h2_19 h2_20 lp2_19)
    (transmissionSafe lp2_19)
    (needsElectricity h2_19)
    (connected h2_20 h2_21 lp2_20)
    (transmissionSafe lp2_20)
    (needsElectricity h2_20)
    (connected h2_21 h2_22 lp2_21)
    (transmissionSafe lp2_21)
    (needsElectricity h2_21)
    (connected h2_22 h2_23 lp2_22)
    (transmissionSafe lp2_22)
    (needsElectricity h2_22)
    (connected h2_23 h2_24 lp2_23)
    (transmissionSafe lp2_23)
    (needsElectricity h2_23)
    (connected h2_24 h2_25 lp2_24)
    (transmissionSafe lp2_24)
    (needsElectricity h2_24)
    (connected h2_25 h2_26 lp2_25)
    (transmissionSafe lp2_25)
    (needsElectricity h2_25)
    (connected h2_26 h2_27 lp2_26)
    (transmissionSafe lp2_26)
    (needsElectricity h2_26)
    (connected h2_27 h2_28 lp2_27)
    (transmissionSafe lp2_27)
    (needsElectricity h2_27)
    (connected h2_28 h2_29 lp2_28)
    (transmissionSafe lp2_28)
    (needsElectricity h2_28)
    (connected h2_29 h2_30 lp2_29)
    (transmissionSafe lp2_29)
    (needsElectricity h2_29)
    (connected h2_30 h2_31 lp2_30)
    (transmissionSafe lp2_30)
    (needsElectricity h2_30)
    (connected h2_31 h2_32 lp2_31)
    (transmissionSafe lp2_31)
    (needsElectricity h2_31)
    (connected h2_32 h2_33 lp2_32)
    (transmissionSafe lp2_32)
    (needsElectricity h2_32)
    (connected h2_33 h2_34 lp2_33)
    (transmissionSafe lp2_33)
    (needsElectricity h2_33)
    (connected h2_34 h2_35 lp2_34)
    (transmissionSafe lp2_34)
    (needsElectricity h2_34)
    (connected h2_35 h2_36 lp2_35)
    (transmissionSafe lp2_35)
    (needsElectricity h2_35)
    (connected h2_36 h2_37 lp2_36)
    (transmissionSafe lp2_36)
    (needsElectricity h2_36)
    (connected h2_37 h2_38 lp2_37)
    (transmissionSafe lp2_37)
    (needsElectricity h2_37)
    (connected h2_38 h2_39 lp2_38)
    (transmissionSafe lp2_38)
    (needsElectricity h2_38)
    (connected h2_39 h2_40 lp2_39)
    (transmissionSafe lp2_39)
    (needsElectricity h2_39)
    (connected h2_40 h2_41 lp2_40)
    (transmissionSafe lp2_40)
    (needsElectricity h2_40)
    (connected h2_41 h2_42 lp2_41)
    (transmissionSafe lp2_41)
    (needsElectricity h2_41)
    (connected h2_42 h2_43 lp2_42)
    (transmissionSafe lp2_42)
    (needsElectricity h2_42)
    (connected h2_43 h2_44 lp2_43)
    (transmissionSafe lp2_43)
    (needsElectricity h2_43)
    (connected h2_44 h2_45 lp2_44)
    (transmissionSafe lp2_44)
    (needsElectricity h2_44)
    (connected h2_45 h2_46 lp2_45)
    (transmissionSafe lp2_45)
    (needsElectricity h2_45)
    (connected h2_46 h2_47 lp2_46)
    (transmissionSafe lp2_46)
    (needsElectricity h2_46)
    (connected h2_47 h2_48 lp2_47)
    (transmissionSafe lp2_47)
    (needsElectricity h2_47)
    (connected h2_48 h2_49 lp2_48)
    (transmissionSafe lp2_48)
    (needsElectricity h2_48)
    (connected h2_49 h2_50 lp2_49)
    (transmissionSafe lp2_49)
    (needsElectricity h2_49)
    (connected h2_50 h2_51 lp2_50)
    (transmissionSafe lp2_50)
    (needsElectricity h2_50)
    (connected h2_51 h2_52 lp2_51)
    (transmissionSafe lp2_51)
    (needsElectricity h2_51)
    (connected h2_52 h2_53 lp2_52)
    (transmissionSafe lp2_52)
    (needsElectricity h2_52)
    (connected h2_53 h2_54 lp2_53)
    (transmissionSafe lp2_53)
    (needsElectricity h2_53)
    (connected h2_54 h2_55 lp2_54)
    (transmissionSafe lp2_54)
    (needsElectricity h2_54)
    (connected h2_55 h2_56 lp2_55)
    (transmissionSafe lp2_55)
    (needsElectricity h2_55)
    (connected h2_56 h2_57 lp2_56)
    (transmissionSafe lp2_56)
    (needsElectricity h2_56)
    (connected h2_57 h2_58 lp2_57)
    (transmissionSafe lp2_57)
    (needsElectricity h2_57)
    (connected h2_58 h2_59 lp2_58)
    (transmissionSafe lp2_58)
    (needsElectricity h2_58)
    (connected h2_59 h2_60 lp2_59)
    (transmissionSafe lp2_59)
    (needsElectricity h2_59)
    (connected h2_60 h2_61 lp2_60)
    (transmissionSafe lp2_60)
    (needsElectricity h2_60)
    (connected h2_61 h2_62 lp2_61)
    (transmissionSafe lp2_61)
    (needsElectricity h2_61)
    (connected h2_62 h2_63 lp2_62)
    (transmissionSafe lp2_62)
    (needsElectricity h2_62)
    (connected h2_63 h2_64 lp2_63)
    (transmissionSafe lp2_63)
    (needsElectricity h2_63)
    (connected h2_64 h2_65 lp2_64)
    (transmissionSafe lp2_64)
    (needsElectricity h2_64)
    (connected h2_65 h2_66 lp2_65)
    (transmissionSafe lp2_65)
    (needsElectricity h2_65)
    (connected h2_66 h2_67 lp2_66)
    (transmissionSafe lp2_66)
    (needsElectricity h2_66)
    (connected h2_67 h2_68 lp2_67)
    (transmissionSafe lp2_67)
    (needsElectricity h2_67)
    (connected h2_68 h2_69 lp2_68)
    (transmissionSafe lp2_68)
    (needsElectricity h2_68)
    (connected h2_69 h2_70 lp2_69)
    (transmissionSafe lp2_69)
    (needsElectricity h2_69)
    (connected h2_70 h2_71 lp2_70)
    (transmissionSafe lp2_70)
    (needsElectricity h2_70)
    (connected h2_71 h2_72 lp2_71)
    (transmissionSafe lp2_71)
    (needsElectricity h2_71)
    (connected h2_72 h2_73 lp2_72)
    (transmissionSafe lp2_72)
    (needsElectricity h2_72)
    (connected h2_73 h2_74 lp2_73)
    (transmissionSafe lp2_73)
    (needsElectricity h2_73)
    (connected h2_74 h2_75 lp2_74)
    (transmissionSafe lp2_74)
    (needsElectricity h2_74)
    (connected h2_75 h2_76 lp2_75)
    (transmissionSafe lp2_75)
    (needsElectricity h2_75)
    (connected h2_76 h2_77 lp2_76)
    (transmissionSafe lp2_76)
    (needsElectricity h2_76)
    (connected h2_77 h2_78 lp2_77)
    (transmissionSafe lp2_77)
    (needsElectricity h2_77)
    (connected h2_78 h2_79 lp2_78)
    (transmissionSafe lp2_78)
    (needsElectricity h2_78)
    (connected h2_79 h2_80 lp2_79)
    (transmissionSafe lp2_79)
    (needsElectricity h2_79)
    (connected h2_80 h2_81 lp2_80)
    (transmissionSafe lp2_80)
    (needsElectricity h2_80)
    (connected h2_81 h2_82 lp2_81)
    (transmissionSafe lp2_81)
    (needsElectricity h2_81)
    (connected h2_82 h2_83 lp2_82)
    (transmissionSafe lp2_82)
    (needsElectricity h2_82)
    (connected h2_83 h2_84 lp2_83)
    (transmissionSafe lp2_83)
    (needsElectricity h2_83)
    (connected h2_84 h2_85 lp2_84)
    (transmissionSafe lp2_84)
    (needsElectricity h2_84)
    (connected h2_85 h2_86 lp2_85)
    (transmissionSafe lp2_85)
    (needsElectricity h2_85)
    (connected h2_86 h2_87 lp2_86)
    (transmissionSafe lp2_86)
    (needsElectricity h2_86)
    (connected h2_87 h2_88 lp2_87)
    (transmissionSafe lp2_87)
    (needsElectricity h2_87)
    (connected h2_88 h2_89 lp2_88)
    (transmissionSafe lp2_88)
    (needsElectricity h2_88)
    (connected h2_89 h2_90 lp2_89)
    (transmissionSafe lp2_89)
    (needsElectricity h2_89)
    (connected h2_90 h2_91 lp2_90)
    (transmissionSafe lp2_90)
    (needsElectricity h2_90)
    (connected h2_91 h2_92 lp2_91)
    (transmissionSafe lp2_91)
    (needsElectricity h2_91)
    (connected h2_92 h2_93 lp2_92)
    (transmissionSafe lp2_92)
    (needsElectricity h2_92)
    (connected h2_93 h2_94 lp2_93)
    (transmissionSafe lp2_93)
    (needsElectricity h2_93)
    (connected h2_94 h2_95 lp2_94)
    (transmissionSafe lp2_94)
    (needsElectricity h2_94)
    (connected h2_95 h2_96 lp2_95)
    (transmissionSafe lp2_95)
    (needsElectricity h2_95)
    (connected h2_96 h2_97 lp2_96)
    (transmissionSafe lp2_96)
    (needsElectricity h2_96)
    (connected h2_97 h2_98 lp2_97)
    (transmissionSafe lp2_97)
    (needsElectricity h2_97)
    (connected h2_98 h2_99 lp2_98)
    (transmissionSafe lp2_98)
    (needsElectricity h2_98)
    (connected h2_99 h2_100 lp2_99)
    (transmissionSafe lp2_99)
    (needsElectricity h2_99)
    (connected h2_100 h2_101 lp2_100)
    (transmissionSafe lp2_100)
    (needsElectricity h2_100)
    (connected h2_101 h2_102 lp2_101)
    (transmissionSafe lp2_101)
    (needsElectricity h2_101)
    (connected h2_102 h2_103 lp2_102)
    (transmissionSafe lp2_102)
    (needsElectricity h2_102)
    (connected h2_103 h2_104 lp2_103)
    (transmissionSafe lp2_103)
    (needsElectricity h2_103)
    (connected h2_104 h2_105 lp2_104)
    (transmissionSafe lp2_104)
    (needsElectricity h2_104)
    (connected h2_105 h2_106 lp2_105)
    (transmissionSafe lp2_105)
    (needsElectricity h2_105)
    (connected h2_106 h2_107 lp2_106)
    (transmissionSafe lp2_106)
    (needsElectricity h2_106)
    (connected h2_107 h2_108 lp2_107)
    (transmissionSafe lp2_107)
    (needsElectricity h2_107)
    (connected h2_108 h2_109 lp2_108)
    (transmissionSafe lp2_108)
    (needsElectricity h2_108)
    (connected h2_109 h2_110 lp2_109)
    (transmissionSafe lp2_109)
    (needsElectricity h2_109)
    (connected h2_110 h2_111 lp2_110)
    (transmissionSafe lp2_110)
    (needsElectricity h2_110)
    (connected h2_111 h2_112 lp2_111)
    (transmissionSafe lp2_111)
    (needsElectricity h2_111)
    (connected h2_112 h2_113 lp2_112)
    (transmissionSafe lp2_112)
    (needsElectricity h2_112)
    (connected h2_113 h2_114 lp2_113)
    (transmissionSafe lp2_113)
    (needsElectricity h2_113)
    (connected h2_114 h2_115 lp2_114)
    (transmissionSafe lp2_114)
    (needsElectricity h2_114)
    (connected h2_115 h2_116 lp2_115)
    (transmissionSafe lp2_115)
    (needsElectricity h2_115)
    (connected h2_116 h2_117 lp2_116)
    (transmissionSafe lp2_116)
    (needsElectricity h2_116)
    (connected h2_117 h2_118 lp2_117)
    (transmissionSafe lp2_117)
    (needsElectricity h2_117)
    (connected h2_118 h2_119 lp2_118)
    (transmissionSafe lp2_118)
    (needsElectricity h2_118)
    (connected h2_119 h2_120 lp2_119)
    (transmissionSafe lp2_119)
    (needsElectricity h2_119)
    (connected h2_120 h2_121 lp2_120)
    (transmissionSafe lp2_120)
    (needsElectricity h2_120)
    (connected h2_121 h2_122 lp2_121)
    (transmissionSafe lp2_121)
    (needsElectricity h2_121)
    (connected h2_122 h2_123 lp2_122)
    (transmissionSafe lp2_122)
    (needsElectricity h2_122)
    (connected h2_123 h2_124 lp2_123)
    (transmissionSafe lp2_123)
    (needsElectricity h2_123)
    (connected h2_124 h2_125 lp2_124)
    (transmissionSafe lp2_124)
    (needsElectricity h2_124)
    (connected h2_125 h2_126 lp2_125)
    (transmissionSafe lp2_125)
    (needsElectricity h2_125)
    (connected h2_126 h2_127 lp2_126)
    (transmissionSafe lp2_126)
    (needsElectricity h2_126)
    (connected h2_127 h2_128 lp2_127)
    (transmissionSafe lp2_127)
    (needsElectricity h2_127)
    (connected h2_128 h2_129 lp2_128)
    (transmissionSafe lp2_128)
    (needsElectricity h2_128)
    (connected h2_129 h2_130 lp2_129)
    (transmissionSafe lp2_129)
    (needsElectricity h2_129)
    (connected h2_130 h2_131 lp2_130)
    (transmissionSafe lp2_130)
    (needsElectricity h2_130)
    (connected h2_131 h2_132 lp2_131)
    (transmissionSafe lp2_131)
    (needsElectricity h2_131)
    (connected h2_132 h2_133 lp2_132)
    (transmissionSafe lp2_132)
    (needsElectricity h2_132)
    (connected h2_133 h2_134 lp2_133)
    (transmissionSafe lp2_133)
    (needsElectricity h2_133)
    (connected h2_134 h2_135 lp2_134)
    (transmissionSafe lp2_134)
    (needsElectricity h2_134)
    (connected h2_135 h2_136 lp2_135)
    (transmissionSafe lp2_135)
    (needsElectricity h2_135)
    (connected h2_136 h2_137 lp2_136)
    (transmissionSafe lp2_136)
    (needsElectricity h2_136)
    (connected h2_137 h2_138 lp2_137)
    (transmissionSafe lp2_137)
    (needsElectricity h2_137)
    (connected h2_138 h2_139 lp2_138)
    (transmissionSafe lp2_138)
    (needsElectricity h2_138)
    (connected h2_139 h2_140 lp2_139)
    (transmissionSafe lp2_139)
    (needsElectricity h2_139)
    (connected h2_140 h2_141 lp2_140)
    (transmissionSafe lp2_140)
    (needsElectricity h2_140)
    (connected h2_141 h2_142 lp2_141)
    (transmissionSafe lp2_141)
    (needsElectricity h2_141)
    (connected h2_142 h2_143 lp2_142)
    (transmissionSafe lp2_142)
    (needsElectricity h2_142)
    (connected h2_143 h2_144 lp2_143)
    (transmissionSafe lp2_143)
    (needsElectricity h2_143)
    (connected h2_144 h2_145 lp2_144)
    (transmissionSafe lp2_144)
    (needsElectricity h2_144)
    (connected h2_145 h2_146 lp2_145)
    (transmissionSafe lp2_145)
    (needsElectricity h2_145)
    (connected h2_146 h2_147 lp2_146)
    (transmissionSafe lp2_146)
    (needsElectricity h2_146)
    (connected h2_147 h2_148 lp2_147)
    (transmissionSafe lp2_147)
    (needsElectricity h2_147)
    (connected h2_148 h2_149 lp2_148)
    (transmissionSafe lp2_148)
    (needsElectricity h2_148)
    (connected h2_149 h2_150 lp2_149)
    (transmissionSafe lp2_149)
    (needsElectricity h2_149)
    (connected h2_150 h2_151 lp2_150)
    (transmissionSafe lp2_150)
    (needsElectricity h2_150)
    (connected h2_151 h2_152 lp2_151)
    (transmissionSafe lp2_151)
    (needsElectricity h2_151)
    (connected h2_152 h2_153 lp2_152)
    (transmissionSafe lp2_152)
    (needsElectricity h2_152)
    (connected h2_153 h2_154 lp2_153)
    (transmissionSafe lp2_153)
    (needsElectricity h2_153)
    (connected h2_154 h2_155 lp2_154)
    (transmissionSafe lp2_154)
    (needsElectricity h2_154)
    (connected h2_155 h2_156 lp2_155)
    (transmissionSafe lp2_155)
    (needsElectricity h2_155)
    (connected h2_156 h2_157 lp2_156)
    (transmissionSafe lp2_156)
    (needsElectricity h2_156)
    (connected h2_157 h2_158 lp2_157)
    (transmissionSafe lp2_157)
    (needsElectricity h2_157)
    (connected h2_158 h2_159 lp2_158)
    (transmissionSafe lp2_158)
    (needsElectricity h2_158)
    (connected h2_159 h2_160 lp2_159)
    (transmissionSafe lp2_159)
    (needsElectricity h2_159)
    (connected h2_160 h2_161 lp2_160)
    (transmissionSafe lp2_160)
    (needsElectricity h2_160)
    (connected h2_161 h2_162 lp2_161)
    (transmissionSafe lp2_161)
    (needsElectricity h2_161)
    (connected h2_162 h2_163 lp2_162)
    (transmissionSafe lp2_162)
    (needsElectricity h2_162)
    (connected h2_163 h2_164 lp2_163)
    (transmissionSafe lp2_163)
    (needsElectricity h2_163)
    (connected h2_164 h2_165 lp2_164)
    (transmissionSafe lp2_164)
    (needsElectricity h2_164)
    (connected h2_165 h2_166 lp2_165)
    (transmissionSafe lp2_165)
    (needsElectricity h2_165)
    (connected h2_166 h2_167 lp2_166)
    (transmissionSafe lp2_166)
    (needsElectricity h2_166)
    (connected h2_167 h2_168 lp2_167)
    (transmissionSafe lp2_167)
    (needsElectricity h2_167)
    (connected h2_168 h2_169 lp2_168)
    (transmissionSafe lp2_168)
    (needsElectricity h2_168)
    (connected h2_169 h2_170 lp2_169)
    (transmissionSafe lp2_169)
    (needsElectricity h2_169)
    (connected h2_170 h2_171 lp2_170)
    (transmissionSafe lp2_170)
    (needsElectricity h2_170)
    (connected h2_171 h2_172 lp2_171)
    (transmissionSafe lp2_171)
    (needsElectricity h2_171)
    (connected h2_172 h2_173 lp2_172)
    (transmissionSafe lp2_172)
    (needsElectricity h2_172)
    (connected h2_173 h2_174 lp2_173)
    (transmissionSafe lp2_173)
    (needsElectricity h2_173)
    (connected h2_174 h2_175 lp2_174)
    (transmissionSafe lp2_174)
    (needsElectricity h2_174)
    (connected h2_175 h2_176 lp2_175)
    (transmissionSafe lp2_175)
    (needsElectricity h2_175)
    (connected h2_176 h2_177 lp2_176)
    (transmissionSafe lp2_176)
    (needsElectricity h2_176)
    (connected h2_177 h2_178 lp2_177)
    (transmissionSafe lp2_177)
    (needsElectricity h2_177)
    (connected h2_178 h2_179 lp2_178)
    (transmissionSafe lp2_178)
    (needsElectricity h2_178)
    (connected h2_179 h2_180 lp2_179)
    (transmissionSafe lp2_179)
    (needsElectricity h2_179)
    (connected h2_180 h2_181 lp2_180)
    (transmissionSafe lp2_180)
    (needsElectricity h2_180)
    (connected h2_181 h2_182 lp2_181)
    (transmissionSafe lp2_181)
    (needsElectricity h2_181)
    (connected h2_182 h2_183 lp2_182)
    (transmissionSafe lp2_182)
    (needsElectricity h2_182)
    (connected h2_183 h2_184 lp2_183)
    (transmissionSafe lp2_183)
    (needsElectricity h2_183)
    (connected h2_184 h2_185 lp2_184)
    (transmissionSafe lp2_184)
    (needsElectricity h2_184)
    (connected h2_185 h2_186 lp2_185)
    (transmissionSafe lp2_185)
    (needsElectricity h2_185)
    (connected h2_186 h2_187 lp2_186)
    (transmissionSafe lp2_186)
    (needsElectricity h2_186)
    (connected h2_187 h2_188 lp2_187)
    (transmissionSafe lp2_187)
    (needsElectricity h2_187)
    (connected h2_188 h2_189 lp2_188)
    (transmissionSafe lp2_188)
    (needsElectricity h2_188)
    (connected h2_189 h2_190 lp2_189)
    (transmissionSafe lp2_189)
    (needsElectricity h2_189)
    (connected h2_190 h2_191 lp2_190)
    (transmissionSafe lp2_190)
    (needsElectricity h2_190)
    (connected h2_191 h2_192 lp2_191)
    (transmissionSafe lp2_191)
    (needsElectricity h2_191)
    (connected h2_192 h2_193 lp2_192)
    (transmissionSafe lp2_192)
    (needsElectricity h2_192)
    (connected h2_193 h2_194 lp2_193)
    (transmissionSafe lp2_193)
    (needsElectricity h2_193)
    (connected h2_194 h2_195 lp2_194)
    (transmissionSafe lp2_194)
    (needsElectricity h2_194)
    (connected h2_195 h2_196 lp2_195)
    (transmissionSafe lp2_195)
    (needsElectricity h2_195)
    (connected h2_196 h2_197 lp2_196)
    (transmissionSafe lp2_196)
    (needsElectricity h2_196)
    (connected h2_197 h2_198 lp2_197)
    (transmissionSafe lp2_197)
    (needsElectricity h2_197)
    (connected h2_198 h2_199 lp2_198)
    (transmissionSafe lp2_198)
    (needsElectricity h2_198)
    (connected h2_199 h2_200 lp2_199)
    (transmissionSafe lp2_199)
    (needsElectricity h2_199)
    (needsElectricity h2_200)
    (connected t2 h2_1 lpTransformer_2)
    (transmissionSafe lpTransformer_2)
    (needsElectricity t2)
    (connected h3_1 h3_2 lp3_1)
    (transmissionSafe lp3_1)
    (needsElectricity h3_1)
    (connected h3_2 h3_3 lp3_2)
    (transmissionSafe lp3_2)
    (needsElectricity h3_2)
    (connected h3_3 h3_4 lp3_3)
    (transmissionSafe lp3_3)
    (needsElectricity h3_3)
    (connected h3_4 h3_5 lp3_4)
    (transmissionSafe lp3_4)
    (needsElectricity h3_4)
    (connected h3_5 h3_6 lp3_5)
    (transmissionSafe lp3_5)
    (needsElectricity h3_5)
    (connected h3_6 h3_7 lp3_6)
    (transmissionSafe lp3_6)
    (needsElectricity h3_6)
    (connected h3_7 h3_8 lp3_7)
    (transmissionSafe lp3_7)
    (needsElectricity h3_7)
    (connected h3_8 h3_9 lp3_8)
    (transmissionSafe lp3_8)
    (needsElectricity h3_8)
    (connected h3_9 h3_10 lp3_9)
    (transmissionSafe lp3_9)
    (needsElectricity h3_9)
    (connected h3_10 h3_11 lp3_10)
    (transmissionSafe lp3_10)
    (needsElectricity h3_10)
    (connected h3_11 h3_12 lp3_11)
    (transmissionSafe lp3_11)
    (needsElectricity h3_11)
    (connected h3_12 h3_13 lp3_12)
    (transmissionSafe lp3_12)
    (needsElectricity h3_12)
    (connected h3_13 h3_14 lp3_13)
    (transmissionSafe lp3_13)
    (needsElectricity h3_13)
    (connected h3_14 h3_15 lp3_14)
    (transmissionSafe lp3_14)
    (needsElectricity h3_14)
    (connected h3_15 h3_16 lp3_15)
    (transmissionSafe lp3_15)
    (needsElectricity h3_15)
    (connected h3_16 h3_17 lp3_16)
    (transmissionSafe lp3_16)
    (needsElectricity h3_16)
    (connected h3_17 h3_18 lp3_17)
    (transmissionSafe lp3_17)
    (needsElectricity h3_17)
    (connected h3_18 h3_19 lp3_18)
    (transmissionSafe lp3_18)
    (needsElectricity h3_18)
    (connected h3_19 h3_20 lp3_19)
    (transmissionSafe lp3_19)
    (needsElectricity h3_19)
    (connected h3_20 h3_21 lp3_20)
    (transmissionSafe lp3_20)
    (needsElectricity h3_20)
    (connected h3_21 h3_22 lp3_21)
    (transmissionSafe lp3_21)
    (needsElectricity h3_21)
    (connected h3_22 h3_23 lp3_22)
    (transmissionSafe lp3_22)
    (needsElectricity h3_22)
    (connected h3_23 h3_24 lp3_23)
    (transmissionSafe lp3_23)
    (needsElectricity h3_23)
    (connected h3_24 h3_25 lp3_24)
    (transmissionSafe lp3_24)
    (needsElectricity h3_24)
    (connected h3_25 h3_26 lp3_25)
    (transmissionSafe lp3_25)
    (needsElectricity h3_25)
    (connected h3_26 h3_27 lp3_26)
    (transmissionSafe lp3_26)
    (needsElectricity h3_26)
    (connected h3_27 h3_28 lp3_27)
    (transmissionSafe lp3_27)
    (needsElectricity h3_27)
    (connected h3_28 h3_29 lp3_28)
    (transmissionSafe lp3_28)
    (needsElectricity h3_28)
    (connected h3_29 h3_30 lp3_29)
    (transmissionSafe lp3_29)
    (needsElectricity h3_29)
    (connected h3_30 h3_31 lp3_30)
    (transmissionSafe lp3_30)
    (needsElectricity h3_30)
    (connected h3_31 h3_32 lp3_31)
    (transmissionSafe lp3_31)
    (needsElectricity h3_31)
    (connected h3_32 h3_33 lp3_32)
    (transmissionSafe lp3_32)
    (needsElectricity h3_32)
    (connected h3_33 h3_34 lp3_33)
    (transmissionSafe lp3_33)
    (needsElectricity h3_33)
    (connected h3_34 h3_35 lp3_34)
    (transmissionSafe lp3_34)
    (needsElectricity h3_34)
    (connected h3_35 h3_36 lp3_35)
    (transmissionSafe lp3_35)
    (needsElectricity h3_35)
    (connected h3_36 h3_37 lp3_36)
    (transmissionSafe lp3_36)
    (needsElectricity h3_36)
    (connected h3_37 h3_38 lp3_37)
    (transmissionSafe lp3_37)
    (needsElectricity h3_37)
    (connected h3_38 h3_39 lp3_38)
    (transmissionSafe lp3_38)
    (needsElectricity h3_38)
    (connected h3_39 h3_40 lp3_39)
    (transmissionSafe lp3_39)
    (needsElectricity h3_39)
    (connected h3_40 h3_41 lp3_40)
    (transmissionSafe lp3_40)
    (needsElectricity h3_40)
    (connected h3_41 h3_42 lp3_41)
    (transmissionSafe lp3_41)
    (needsElectricity h3_41)
    (connected h3_42 h3_43 lp3_42)
    (transmissionSafe lp3_42)
    (needsElectricity h3_42)
    (connected h3_43 h3_44 lp3_43)
    (transmissionSafe lp3_43)
    (needsElectricity h3_43)
    (connected h3_44 h3_45 lp3_44)
    (transmissionSafe lp3_44)
    (needsElectricity h3_44)
    (connected h3_45 h3_46 lp3_45)
    (transmissionSafe lp3_45)
    (needsElectricity h3_45)
    (connected h3_46 h3_47 lp3_46)
    (transmissionSafe lp3_46)
    (needsElectricity h3_46)
    (connected h3_47 h3_48 lp3_47)
    (transmissionSafe lp3_47)
    (needsElectricity h3_47)
    (connected h3_48 h3_49 lp3_48)
    (transmissionSafe lp3_48)
    (needsElectricity h3_48)
    (connected h3_49 h3_50 lp3_49)
    (transmissionSafe lp3_49)
    (needsElectricity h3_49)
    (connected h3_50 h3_51 lp3_50)
    (transmissionSafe lp3_50)
    (needsElectricity h3_50)
    (connected h3_51 h3_52 lp3_51)
    (transmissionSafe lp3_51)
    (needsElectricity h3_51)
    (connected h3_52 h3_53 lp3_52)
    (transmissionSafe lp3_52)
    (needsElectricity h3_52)
    (connected h3_53 h3_54 lp3_53)
    (transmissionSafe lp3_53)
    (needsElectricity h3_53)
    (connected h3_54 h3_55 lp3_54)
    (transmissionSafe lp3_54)
    (needsElectricity h3_54)
    (connected h3_55 h3_56 lp3_55)
    (transmissionSafe lp3_55)
    (needsElectricity h3_55)
    (connected h3_56 h3_57 lp3_56)
    (transmissionSafe lp3_56)
    (needsElectricity h3_56)
    (connected h3_57 h3_58 lp3_57)
    (transmissionSafe lp3_57)
    (needsElectricity h3_57)
    (connected h3_58 h3_59 lp3_58)
    (transmissionSafe lp3_58)
    (needsElectricity h3_58)
    (connected h3_59 h3_60 lp3_59)
    (transmissionSafe lp3_59)
    (needsElectricity h3_59)
    (connected h3_60 h3_61 lp3_60)
    (transmissionSafe lp3_60)
    (needsElectricity h3_60)
    (connected h3_61 h3_62 lp3_61)
    (transmissionSafe lp3_61)
    (needsElectricity h3_61)
    (connected h3_62 h3_63 lp3_62)
    (transmissionSafe lp3_62)
    (needsElectricity h3_62)
    (connected h3_63 h3_64 lp3_63)
    (transmissionSafe lp3_63)
    (needsElectricity h3_63)
    (connected h3_64 h3_65 lp3_64)
    (transmissionSafe lp3_64)
    (needsElectricity h3_64)
    (connected h3_65 h3_66 lp3_65)
    (transmissionSafe lp3_65)
    (needsElectricity h3_65)
    (connected h3_66 h3_67 lp3_66)
    (transmissionSafe lp3_66)
    (needsElectricity h3_66)
    (connected h3_67 h3_68 lp3_67)
    (transmissionSafe lp3_67)
    (needsElectricity h3_67)
    (connected h3_68 h3_69 lp3_68)
    (transmissionSafe lp3_68)
    (needsElectricity h3_68)
    (connected h3_69 h3_70 lp3_69)
    (transmissionSafe lp3_69)
    (needsElectricity h3_69)
    (connected h3_70 h3_71 lp3_70)
    (transmissionSafe lp3_70)
    (needsElectricity h3_70)
    (connected h3_71 h3_72 lp3_71)
    (transmissionSafe lp3_71)
    (needsElectricity h3_71)
    (connected h3_72 h3_73 lp3_72)
    (transmissionSafe lp3_72)
    (needsElectricity h3_72)
    (connected h3_73 h3_74 lp3_73)
    (transmissionSafe lp3_73)
    (needsElectricity h3_73)
    (connected h3_74 h3_75 lp3_74)
    (transmissionSafe lp3_74)
    (needsElectricity h3_74)
    (connected h3_75 h3_76 lp3_75)
    (transmissionSafe lp3_75)
    (needsElectricity h3_75)
    (connected h3_76 h3_77 lp3_76)
    (transmissionSafe lp3_76)
    (needsElectricity h3_76)
    (connected h3_77 h3_78 lp3_77)
    (transmissionSafe lp3_77)
    (needsElectricity h3_77)
    (connected h3_78 h3_79 lp3_78)
    (transmissionSafe lp3_78)
    (needsElectricity h3_78)
    (connected h3_79 h3_80 lp3_79)
    (transmissionSafe lp3_79)
    (needsElectricity h3_79)
    (connected h3_80 h3_81 lp3_80)
    (transmissionSafe lp3_80)
    (needsElectricity h3_80)
    (connected h3_81 h3_82 lp3_81)
    (transmissionSafe lp3_81)
    (needsElectricity h3_81)
    (connected h3_82 h3_83 lp3_82)
    (transmissionSafe lp3_82)
    (needsElectricity h3_82)
    (connected h3_83 h3_84 lp3_83)
    (transmissionSafe lp3_83)
    (needsElectricity h3_83)
    (connected h3_84 h3_85 lp3_84)
    (transmissionSafe lp3_84)
    (needsElectricity h3_84)
    (connected h3_85 h3_86 lp3_85)
    (transmissionSafe lp3_85)
    (needsElectricity h3_85)
    (connected h3_86 h3_87 lp3_86)
    (transmissionSafe lp3_86)
    (needsElectricity h3_86)
    (connected h3_87 h3_88 lp3_87)
    (transmissionSafe lp3_87)
    (needsElectricity h3_87)
    (connected h3_88 h3_89 lp3_88)
    (transmissionSafe lp3_88)
    (needsElectricity h3_88)
    (connected h3_89 h3_90 lp3_89)
    (transmissionSafe lp3_89)
    (needsElectricity h3_89)
    (connected h3_90 h3_91 lp3_90)
    (transmissionSafe lp3_90)
    (needsElectricity h3_90)
    (connected h3_91 h3_92 lp3_91)
    (transmissionSafe lp3_91)
    (needsElectricity h3_91)
    (connected h3_92 h3_93 lp3_92)
    (transmissionSafe lp3_92)
    (needsElectricity h3_92)
    (connected h3_93 h3_94 lp3_93)
    (transmissionSafe lp3_93)
    (needsElectricity h3_93)
    (connected h3_94 h3_95 lp3_94)
    (transmissionSafe lp3_94)
    (needsElectricity h3_94)
    (connected h3_95 h3_96 lp3_95)
    (transmissionSafe lp3_95)
    (needsElectricity h3_95)
    (connected h3_96 h3_97 lp3_96)
    (transmissionSafe lp3_96)
    (needsElectricity h3_96)
    (connected h3_97 h3_98 lp3_97)
    (transmissionSafe lp3_97)
    (needsElectricity h3_97)
    (connected h3_98 h3_99 lp3_98)
    (transmissionSafe lp3_98)
    (needsElectricity h3_98)
    (connected h3_99 h3_100 lp3_99)
    (transmissionSafe lp3_99)
    (needsElectricity h3_99)
    (connected h3_100 h3_101 lp3_100)
    (transmissionSafe lp3_100)
    (needsElectricity h3_100)
    (connected h3_101 h3_102 lp3_101)
    (transmissionSafe lp3_101)
    (needsElectricity h3_101)
    (connected h3_102 h3_103 lp3_102)
    (transmissionSafe lp3_102)
    (needsElectricity h3_102)
    (connected h3_103 h3_104 lp3_103)
    (transmissionSafe lp3_103)
    (needsElectricity h3_103)
    (connected h3_104 h3_105 lp3_104)
    (transmissionSafe lp3_104)
    (needsElectricity h3_104)
    (connected h3_105 h3_106 lp3_105)
    (transmissionSafe lp3_105)
    (needsElectricity h3_105)
    (connected h3_106 h3_107 lp3_106)
    (transmissionSafe lp3_106)
    (needsElectricity h3_106)
    (connected h3_107 h3_108 lp3_107)
    (transmissionSafe lp3_107)
    (needsElectricity h3_107)
    (connected h3_108 h3_109 lp3_108)
    (transmissionSafe lp3_108)
    (needsElectricity h3_108)
    (connected h3_109 h3_110 lp3_109)
    (transmissionSafe lp3_109)
    (needsElectricity h3_109)
    (connected h3_110 h3_111 lp3_110)
    (transmissionSafe lp3_110)
    (needsElectricity h3_110)
    (connected h3_111 h3_112 lp3_111)
    (transmissionSafe lp3_111)
    (needsElectricity h3_111)
    (connected h3_112 h3_113 lp3_112)
    (transmissionSafe lp3_112)
    (needsElectricity h3_112)
    (connected h3_113 h3_114 lp3_113)
    (transmissionSafe lp3_113)
    (needsElectricity h3_113)
    (connected h3_114 h3_115 lp3_114)
    (transmissionSafe lp3_114)
    (needsElectricity h3_114)
    (connected h3_115 h3_116 lp3_115)
    (transmissionSafe lp3_115)
    (needsElectricity h3_115)
    (connected h3_116 h3_117 lp3_116)
    (transmissionSafe lp3_116)
    (needsElectricity h3_116)
    (connected h3_117 h3_118 lp3_117)
    (transmissionSafe lp3_117)
    (needsElectricity h3_117)
    (connected h3_118 h3_119 lp3_118)
    (transmissionSafe lp3_118)
    (needsElectricity h3_118)
    (connected h3_119 h3_120 lp3_119)
    (transmissionSafe lp3_119)
    (needsElectricity h3_119)
    (connected h3_120 h3_121 lp3_120)
    (transmissionSafe lp3_120)
    (needsElectricity h3_120)
    (connected h3_121 h3_122 lp3_121)
    (transmissionSafe lp3_121)
    (needsElectricity h3_121)
    (connected h3_122 h3_123 lp3_122)
    (transmissionSafe lp3_122)
    (needsElectricity h3_122)
    (connected h3_123 h3_124 lp3_123)
    (transmissionSafe lp3_123)
    (needsElectricity h3_123)
    (connected h3_124 h3_125 lp3_124)
    (transmissionSafe lp3_124)
    (needsElectricity h3_124)
    (connected h3_125 h3_126 lp3_125)
    (transmissionSafe lp3_125)
    (needsElectricity h3_125)
    (connected h3_126 h3_127 lp3_126)
    (transmissionSafe lp3_126)
    (needsElectricity h3_126)
    (connected h3_127 h3_128 lp3_127)
    (transmissionSafe lp3_127)
    (needsElectricity h3_127)
    (connected h3_128 h3_129 lp3_128)
    (transmissionSafe lp3_128)
    (needsElectricity h3_128)
    (connected h3_129 h3_130 lp3_129)
    (transmissionSafe lp3_129)
    (needsElectricity h3_129)
    (connected h3_130 h3_131 lp3_130)
    (transmissionSafe lp3_130)
    (needsElectricity h3_130)
    (connected h3_131 h3_132 lp3_131)
    (transmissionSafe lp3_131)
    (needsElectricity h3_131)
    (connected h3_132 h3_133 lp3_132)
    (transmissionSafe lp3_132)
    (needsElectricity h3_132)
    (connected h3_133 h3_134 lp3_133)
    (transmissionSafe lp3_133)
    (needsElectricity h3_133)
    (connected h3_134 h3_135 lp3_134)
    (transmissionSafe lp3_134)
    (needsElectricity h3_134)
    (connected h3_135 h3_136 lp3_135)
    (transmissionSafe lp3_135)
    (needsElectricity h3_135)
    (connected h3_136 h3_137 lp3_136)
    (transmissionSafe lp3_136)
    (needsElectricity h3_136)
    (connected h3_137 h3_138 lp3_137)
    (transmissionSafe lp3_137)
    (needsElectricity h3_137)
    (connected h3_138 h3_139 lp3_138)
    (transmissionSafe lp3_138)
    (needsElectricity h3_138)
    (connected h3_139 h3_140 lp3_139)
    (transmissionSafe lp3_139)
    (needsElectricity h3_139)
    (connected h3_140 h3_141 lp3_140)
    (transmissionSafe lp3_140)
    (needsElectricity h3_140)
    (connected h3_141 h3_142 lp3_141)
    (transmissionSafe lp3_141)
    (needsElectricity h3_141)
    (connected h3_142 h3_143 lp3_142)
    (transmissionSafe lp3_142)
    (needsElectricity h3_142)
    (connected h3_143 h3_144 lp3_143)
    (transmissionSafe lp3_143)
    (needsElectricity h3_143)
    (connected h3_144 h3_145 lp3_144)
    (transmissionSafe lp3_144)
    (needsElectricity h3_144)
    (connected h3_145 h3_146 lp3_145)
    (transmissionSafe lp3_145)
    (needsElectricity h3_145)
    (connected h3_146 h3_147 lp3_146)
    (transmissionSafe lp3_146)
    (needsElectricity h3_146)
    (connected h3_147 h3_148 lp3_147)
    (transmissionSafe lp3_147)
    (needsElectricity h3_147)
    (connected h3_148 h3_149 lp3_148)
    (transmissionSafe lp3_148)
    (needsElectricity h3_148)
    (connected h3_149 h3_150 lp3_149)
    (transmissionSafe lp3_149)
    (needsElectricity h3_149)
    (connected h3_150 h3_151 lp3_150)
    (transmissionSafe lp3_150)
    (needsElectricity h3_150)
    (connected h3_151 h3_152 lp3_151)
    (transmissionSafe lp3_151)
    (needsElectricity h3_151)
    (connected h3_152 h3_153 lp3_152)
    (transmissionSafe lp3_152)
    (needsElectricity h3_152)
    (connected h3_153 h3_154 lp3_153)
    (transmissionSafe lp3_153)
    (needsElectricity h3_153)
    (connected h3_154 h3_155 lp3_154)
    (transmissionSafe lp3_154)
    (needsElectricity h3_154)
    (connected h3_155 h3_156 lp3_155)
    (transmissionSafe lp3_155)
    (needsElectricity h3_155)
    (connected h3_156 h3_157 lp3_156)
    (transmissionSafe lp3_156)
    (needsElectricity h3_156)
    (connected h3_157 h3_158 lp3_157)
    (transmissionSafe lp3_157)
    (needsElectricity h3_157)
    (connected h3_158 h3_159 lp3_158)
    (transmissionSafe lp3_158)
    (needsElectricity h3_158)
    (connected h3_159 h3_160 lp3_159)
    (transmissionSafe lp3_159)
    (needsElectricity h3_159)
    (connected h3_160 h3_161 lp3_160)
    (transmissionSafe lp3_160)
    (needsElectricity h3_160)
    (connected h3_161 h3_162 lp3_161)
    (transmissionSafe lp3_161)
    (needsElectricity h3_161)
    (connected h3_162 h3_163 lp3_162)
    (transmissionSafe lp3_162)
    (needsElectricity h3_162)
    (connected h3_163 h3_164 lp3_163)
    (transmissionSafe lp3_163)
    (needsElectricity h3_163)
    (connected h3_164 h3_165 lp3_164)
    (transmissionSafe lp3_164)
    (needsElectricity h3_164)
    (connected h3_165 h3_166 lp3_165)
    (transmissionSafe lp3_165)
    (needsElectricity h3_165)
    (connected h3_166 h3_167 lp3_166)
    (transmissionSafe lp3_166)
    (needsElectricity h3_166)
    (connected h3_167 h3_168 lp3_167)
    (transmissionSafe lp3_167)
    (needsElectricity h3_167)
    (connected h3_168 h3_169 lp3_168)
    (transmissionSafe lp3_168)
    (needsElectricity h3_168)
    (connected h3_169 h3_170 lp3_169)
    (transmissionSafe lp3_169)
    (needsElectricity h3_169)
    (connected h3_170 h3_171 lp3_170)
    (transmissionSafe lp3_170)
    (needsElectricity h3_170)
    (connected h3_171 h3_172 lp3_171)
    (transmissionSafe lp3_171)
    (needsElectricity h3_171)
    (connected h3_172 h3_173 lp3_172)
    (transmissionSafe lp3_172)
    (needsElectricity h3_172)
    (connected h3_173 h3_174 lp3_173)
    (transmissionSafe lp3_173)
    (needsElectricity h3_173)
    (connected h3_174 h3_175 lp3_174)
    (transmissionSafe lp3_174)
    (needsElectricity h3_174)
    (connected h3_175 h3_176 lp3_175)
    (transmissionSafe lp3_175)
    (needsElectricity h3_175)
    (connected h3_176 h3_177 lp3_176)
    (transmissionSafe lp3_176)
    (needsElectricity h3_176)
    (connected h3_177 h3_178 lp3_177)
    (transmissionSafe lp3_177)
    (needsElectricity h3_177)
    (connected h3_178 h3_179 lp3_178)
    (transmissionSafe lp3_178)
    (needsElectricity h3_178)
    (connected h3_179 h3_180 lp3_179)
    (transmissionSafe lp3_179)
    (needsElectricity h3_179)
    (connected h3_180 h3_181 lp3_180)
    (transmissionSafe lp3_180)
    (needsElectricity h3_180)
    (connected h3_181 h3_182 lp3_181)
    (transmissionSafe lp3_181)
    (needsElectricity h3_181)
    (connected h3_182 h3_183 lp3_182)
    (transmissionSafe lp3_182)
    (needsElectricity h3_182)
    (connected h3_183 h3_184 lp3_183)
    (transmissionSafe lp3_183)
    (needsElectricity h3_183)
    (connected h3_184 h3_185 lp3_184)
    (transmissionSafe lp3_184)
    (needsElectricity h3_184)
    (connected h3_185 h3_186 lp3_185)
    (transmissionSafe lp3_185)
    (needsElectricity h3_185)
    (connected h3_186 h3_187 lp3_186)
    (transmissionSafe lp3_186)
    (needsElectricity h3_186)
    (connected h3_187 h3_188 lp3_187)
    (transmissionSafe lp3_187)
    (needsElectricity h3_187)
    (connected h3_188 h3_189 lp3_188)
    (transmissionSafe lp3_188)
    (needsElectricity h3_188)
    (connected h3_189 h3_190 lp3_189)
    (transmissionSafe lp3_189)
    (needsElectricity h3_189)
    (connected h3_190 h3_191 lp3_190)
    (transmissionSafe lp3_190)
    (needsElectricity h3_190)
    (connected h3_191 h3_192 lp3_191)
    (transmissionSafe lp3_191)
    (needsElectricity h3_191)
    (connected h3_192 h3_193 lp3_192)
    (transmissionSafe lp3_192)
    (needsElectricity h3_192)
    (connected h3_193 h3_194 lp3_193)
    (transmissionSafe lp3_193)
    (needsElectricity h3_193)
    (connected h3_194 h3_195 lp3_194)
    (transmissionSafe lp3_194)
    (needsElectricity h3_194)
    (connected h3_195 h3_196 lp3_195)
    (transmissionSafe lp3_195)
    (needsElectricity h3_195)
    (connected h3_196 h3_197 lp3_196)
    (transmissionSafe lp3_196)
    (needsElectricity h3_196)
    (connected h3_197 h3_198 lp3_197)
    (transmissionSafe lp3_197)
    (needsElectricity h3_197)
    (connected h3_198 h3_199 lp3_198)
    (transmissionSafe lp3_198)
    (needsElectricity h3_198)
    (connected h3_199 h3_200 lp3_199)
    (transmissionSafe lp3_199)
    (needsElectricity h3_199)
    (needsElectricity h3_200)
    (connected t3 h3_1 lpTransformer_3)
    (transmissionSafe lpTransformer_3)
    (needsElectricity t3)
    (systemsSafe)
    )
    (:goal
        (and
            (230Volt h1_1)
            (230Volt h1_2)
            (230Volt h1_3)
            (230Volt h1_4)
            (230Volt h1_5)
            (230Volt h1_6)
            (230Volt h1_7)
            (230Volt h1_8)
            (230Volt h1_9)
            (230Volt h1_10)
            (230Volt h1_11)
            (230Volt h1_12)
            (230Volt h1_13)
            (230Volt h1_14)
            (230Volt h1_15)
            (230Volt h1_16)
            (230Volt h1_17)
            (230Volt h1_18)
            (230Volt h1_19)
            (230Volt h1_20)
            (230Volt h1_21)
            (230Volt h1_22)
            (230Volt h1_23)
            (230Volt h1_24)
            (230Volt h1_25)
            (230Volt h1_26)
            (230Volt h1_27)
            (230Volt h1_28)
            (230Volt h1_29)
            (230Volt h1_30)
            (230Volt h1_31)
            (230Volt h1_32)
            (230Volt h1_33)
            (230Volt h1_34)
            (230Volt h1_35)
            (230Volt h1_36)
            (230Volt h1_37)
            (230Volt h1_38)
            (230Volt h1_39)
            (230Volt h1_40)
            (230Volt h1_41)
            (230Volt h1_42)
            (230Volt h1_43)
            (230Volt h1_44)
            (230Volt h1_45)
            (230Volt h1_46)
            (230Volt h1_47)
            (230Volt h1_48)
            (230Volt h1_49)
            (230Volt h1_50)
            (230Volt h1_51)
            (230Volt h1_52)
            (230Volt h1_53)
            (230Volt h1_54)
            (230Volt h1_55)
            (230Volt h1_56)
            (230Volt h1_57)
            (230Volt h1_58)
            (230Volt h1_59)
            (230Volt h1_60)
            (230Volt h1_61)
            (230Volt h1_62)
            (230Volt h1_63)
            (230Volt h1_64)
            (230Volt h1_65)
            (230Volt h1_66)
            (230Volt h1_67)
            (230Volt h1_68)
            (230Volt h1_69)
            (230Volt h1_70)
            (230Volt h1_71)
            (230Volt h1_72)
            (230Volt h1_73)
            (230Volt h1_74)
            (230Volt h1_75)
            (230Volt h1_76)
            (230Volt h1_77)
            (230Volt h1_78)
            (230Volt h1_79)
            (230Volt h1_80)
            (230Volt h1_81)
            (230Volt h1_82)
            (230Volt h1_83)
            (230Volt h1_84)
            (230Volt h1_85)
            (230Volt h1_86)
            (230Volt h1_87)
            (230Volt h1_88)
            (230Volt h1_89)
            (230Volt h1_90)
            (230Volt h1_91)
            (230Volt h1_92)
            (230Volt h1_93)
            (230Volt h1_94)
            (230Volt h1_95)
            (230Volt h1_96)
            (230Volt h1_97)
            (230Volt h1_98)
            (230Volt h1_99)
            (230Volt h1_100)
            (230Volt h1_101)
            (230Volt h1_102)
            (230Volt h1_103)
            (230Volt h1_104)
            (230Volt h1_105)
            (230Volt h1_106)
            (230Volt h1_107)
            (230Volt h1_108)
            (230Volt h1_109)
            (230Volt h1_110)
            (230Volt h1_111)
            (230Volt h1_112)
            (230Volt h1_113)
            (230Volt h1_114)
            (230Volt h1_115)
            (230Volt h1_116)
            (230Volt h1_117)
            (230Volt h1_118)
            (230Volt h1_119)
            (230Volt h1_120)
            (230Volt h1_121)
            (230Volt h1_122)
            (230Volt h1_123)
            (230Volt h1_124)
            (230Volt h1_125)
            (230Volt h1_126)
            (230Volt h1_127)
            (230Volt h1_128)
            (230Volt h1_129)
            (230Volt h1_130)
            (230Volt h1_131)
            (230Volt h1_132)
            (230Volt h1_133)
            (230Volt h1_134)
            (230Volt h1_135)
            (230Volt h1_136)
            (230Volt h1_137)
            (230Volt h1_138)
            (230Volt h1_139)
            (230Volt h1_140)
            (230Volt h1_141)
            (230Volt h1_142)
            (230Volt h1_143)
            (230Volt h1_144)
            (230Volt h1_145)
            (230Volt h1_146)
            (230Volt h1_147)
            (230Volt h1_148)
            (230Volt h1_149)
            (230Volt h1_150)
            (230Volt h1_151)
            (230Volt h1_152)
            (230Volt h1_153)
            (230Volt h1_154)
            (230Volt h1_155)
            (230Volt h1_156)
            (230Volt h1_157)
            (230Volt h1_158)
            (230Volt h1_159)
            (230Volt h1_160)
            (230Volt h1_161)
            (230Volt h1_162)
            (230Volt h1_163)
            (230Volt h1_164)
            (230Volt h1_165)
            (230Volt h1_166)
            (230Volt h1_167)
            (230Volt h1_168)
            (230Volt h1_169)
            (230Volt h1_170)
            (230Volt h1_171)
            (230Volt h1_172)
            (230Volt h1_173)
            (230Volt h1_174)
            (230Volt h1_175)
            (230Volt h1_176)
            (230Volt h1_177)
            (230Volt h1_178)
            (230Volt h1_179)
            (230Volt h1_180)
            (230Volt h1_181)
            (230Volt h1_182)
            (230Volt h1_183)
            (230Volt h1_184)
            (230Volt h1_185)
            (230Volt h1_186)
            (230Volt h1_187)
            (230Volt h1_188)
            (230Volt h1_189)
            (230Volt h1_190)
            (230Volt h1_191)
            (230Volt h1_192)
            (230Volt h1_193)
            (230Volt h1_194)
            (230Volt h1_195)
            (230Volt h1_196)
            (230Volt h1_197)
            (230Volt h1_198)
            (230Volt h1_199)
            (230Volt h1_200)
            (230Volt h2_1)
            (230Volt h2_2)
            (230Volt h2_3)
            (230Volt h2_4)
            (230Volt h2_5)
            (230Volt h2_6)
            (230Volt h2_7)
            (230Volt h2_8)
            (230Volt h2_9)
            (230Volt h2_10)
            (230Volt h2_11)
            (230Volt h2_12)
            (230Volt h2_13)
            (230Volt h2_14)
            (230Volt h2_15)
            (230Volt h2_16)
            (230Volt h2_17)
            (230Volt h2_18)
            (230Volt h2_19)
            (230Volt h2_20)
            (230Volt h2_21)
            (230Volt h2_22)
            (230Volt h2_23)
            (230Volt h2_24)
            (230Volt h2_25)
            (230Volt h2_26)
            (230Volt h2_27)
            (230Volt h2_28)
            (230Volt h2_29)
            (230Volt h2_30)
            (230Volt h2_31)
            (230Volt h2_32)
            (230Volt h2_33)
            (230Volt h2_34)
            (230Volt h2_35)
            (230Volt h2_36)
            (230Volt h2_37)
            (230Volt h2_38)
            (230Volt h2_39)
            (230Volt h2_40)
            (230Volt h2_41)
            (230Volt h2_42)
            (230Volt h2_43)
            (230Volt h2_44)
            (230Volt h2_45)
            (230Volt h2_46)
            (230Volt h2_47)
            (230Volt h2_48)
            (230Volt h2_49)
            (230Volt h2_50)
            (230Volt h2_51)
            (230Volt h2_52)
            (230Volt h2_53)
            (230Volt h2_54)
            (230Volt h2_55)
            (230Volt h2_56)
            (230Volt h2_57)
            (230Volt h2_58)
            (230Volt h2_59)
            (230Volt h2_60)
            (230Volt h2_61)
            (230Volt h2_62)
            (230Volt h2_63)
            (230Volt h2_64)
            (230Volt h2_65)
            (230Volt h2_66)
            (230Volt h2_67)
            (230Volt h2_68)
            (230Volt h2_69)
            (230Volt h2_70)
            (230Volt h2_71)
            (230Volt h2_72)
            (230Volt h2_73)
            (230Volt h2_74)
            (230Volt h2_75)
            (230Volt h2_76)
            (230Volt h2_77)
            (230Volt h2_78)
            (230Volt h2_79)
            (230Volt h2_80)
            (230Volt h2_81)
            (230Volt h2_82)
            (230Volt h2_83)
            (230Volt h2_84)
            (230Volt h2_85)
            (230Volt h2_86)
            (230Volt h2_87)
            (230Volt h2_88)
            (230Volt h2_89)
            (230Volt h2_90)
            (230Volt h2_91)
            (230Volt h2_92)
            (230Volt h2_93)
            (230Volt h2_94)
            (230Volt h2_95)
            (230Volt h2_96)
            (230Volt h2_97)
            (230Volt h2_98)
            (230Volt h2_99)
            (230Volt h2_100)
            (230Volt h2_101)
            (230Volt h2_102)
            (230Volt h2_103)
            (230Volt h2_104)
            (230Volt h2_105)
            (230Volt h2_106)
            (230Volt h2_107)
            (230Volt h2_108)
            (230Volt h2_109)
            (230Volt h2_110)
            (230Volt h2_111)
            (230Volt h2_112)
            (230Volt h2_113)
            (230Volt h2_114)
            (230Volt h2_115)
            (230Volt h2_116)
            (230Volt h2_117)
            (230Volt h2_118)
            (230Volt h2_119)
            (230Volt h2_120)
            (230Volt h2_121)
            (230Volt h2_122)
            (230Volt h2_123)
            (230Volt h2_124)
            (230Volt h2_125)
            (230Volt h2_126)
            (230Volt h2_127)
            (230Volt h2_128)
            (230Volt h2_129)
            (230Volt h2_130)
            (230Volt h2_131)
            (230Volt h2_132)
            (230Volt h2_133)
            (230Volt h2_134)
            (230Volt h2_135)
            (230Volt h2_136)
            (230Volt h2_137)
            (230Volt h2_138)
            (230Volt h2_139)
            (230Volt h2_140)
            (230Volt h2_141)
            (230Volt h2_142)
            (230Volt h2_143)
            (230Volt h2_144)
            (230Volt h2_145)
            (230Volt h2_146)
            (230Volt h2_147)
            (230Volt h2_148)
            (230Volt h2_149)
            (230Volt h2_150)
            (230Volt h2_151)
            (230Volt h2_152)
            (230Volt h2_153)
            (230Volt h2_154)
            (230Volt h2_155)
            (230Volt h2_156)
            (230Volt h2_157)
            (230Volt h2_158)
            (230Volt h2_159)
            (230Volt h2_160)
            (230Volt h2_161)
            (230Volt h2_162)
            (230Volt h2_163)
            (230Volt h2_164)
            (230Volt h2_165)
            (230Volt h2_166)
            (230Volt h2_167)
            (230Volt h2_168)
            (230Volt h2_169)
            (230Volt h2_170)
            (230Volt h2_171)
            (230Volt h2_172)
            (230Volt h2_173)
            (230Volt h2_174)
            (230Volt h2_175)
            (230Volt h2_176)
            (230Volt h2_177)
            (230Volt h2_178)
            (230Volt h2_179)
            (230Volt h2_180)
            (230Volt h2_181)
            (230Volt h2_182)
            (230Volt h2_183)
            (230Volt h2_184)
            (230Volt h2_185)
            (230Volt h2_186)
            (230Volt h2_187)
            (230Volt h2_188)
            (230Volt h2_189)
            (230Volt h2_190)
            (230Volt h2_191)
            (230Volt h2_192)
            (230Volt h2_193)
            (230Volt h2_194)
            (230Volt h2_195)
            (230Volt h2_196)
            (230Volt h2_197)
            (230Volt h2_198)
            (230Volt h2_199)
            (230Volt h2_200)
            (230Volt h3_1)
            (230Volt h3_2)
            (230Volt h3_3)
            (230Volt h3_4)
            (230Volt h3_5)
            (230Volt h3_6)
            (230Volt h3_7)
            (230Volt h3_8)
            (230Volt h3_9)
            (230Volt h3_10)
            (230Volt h3_11)
            (230Volt h3_12)
            (230Volt h3_13)
            (230Volt h3_14)
            (230Volt h3_15)
            (230Volt h3_16)
            (230Volt h3_17)
            (230Volt h3_18)
            (230Volt h3_19)
            (230Volt h3_20)
            (230Volt h3_21)
            (230Volt h3_22)
            (230Volt h3_23)
            (230Volt h3_24)
            (230Volt h3_25)
            (230Volt h3_26)
            (230Volt h3_27)
            (230Volt h3_28)
            (230Volt h3_29)
            (230Volt h3_30)
            (230Volt h3_31)
            (230Volt h3_32)
            (230Volt h3_33)
            (230Volt h3_34)
            (230Volt h3_35)
            (230Volt h3_36)
            (230Volt h3_37)
            (230Volt h3_38)
            (230Volt h3_39)
            (230Volt h3_40)
            (230Volt h3_41)
            (230Volt h3_42)
            (230Volt h3_43)
            (230Volt h3_44)
            (230Volt h3_45)
            (230Volt h3_46)
            (230Volt h3_47)
            (230Volt h3_48)
            (230Volt h3_49)
            (230Volt h3_50)
            (230Volt h3_51)
            (230Volt h3_52)
            (230Volt h3_53)
            (230Volt h3_54)
            (230Volt h3_55)
            (230Volt h3_56)
            (230Volt h3_57)
            (230Volt h3_58)
            (230Volt h3_59)
            (230Volt h3_60)
            (230Volt h3_61)
            (230Volt h3_62)
            (230Volt h3_63)
            (230Volt h3_64)
            (230Volt h3_65)
            (230Volt h3_66)
            (230Volt h3_67)
            (230Volt h3_68)
            (230Volt h3_69)
            (230Volt h3_70)
            (230Volt h3_71)
            (230Volt h3_72)
            (230Volt h3_73)
            (230Volt h3_74)
            (230Volt h3_75)
            (230Volt h3_76)
            (230Volt h3_77)
            (230Volt h3_78)
            (230Volt h3_79)
            (230Volt h3_80)
            (230Volt h3_81)
            (230Volt h3_82)
            (230Volt h3_83)
            (230Volt h3_84)
            (230Volt h3_85)
            (230Volt h3_86)
            (230Volt h3_87)
            (230Volt h3_88)
            (230Volt h3_89)
            (230Volt h3_90)
            (230Volt h3_91)
            (230Volt h3_92)
            (230Volt h3_93)
            (230Volt h3_94)
            (230Volt h3_95)
            (230Volt h3_96)
            (230Volt h3_97)
            (230Volt h3_98)
            (230Volt h3_99)
            (230Volt h3_100)
            (230Volt h3_101)
            (230Volt h3_102)
            (230Volt h3_103)
            (230Volt h3_104)
            (230Volt h3_105)
            (230Volt h3_106)
            (230Volt h3_107)
            (230Volt h3_108)
            (230Volt h3_109)
            (230Volt h3_110)
            (230Volt h3_111)
            (230Volt h3_112)
            (230Volt h3_113)
            (230Volt h3_114)
            (230Volt h3_115)
            (230Volt h3_116)
            (230Volt h3_117)
            (230Volt h3_118)
            (230Volt h3_119)
            (230Volt h3_120)
            (230Volt h3_121)
            (230Volt h3_122)
            (230Volt h3_123)
            (230Volt h3_124)
            (230Volt h3_125)
            (230Volt h3_126)
            (230Volt h3_127)
            (230Volt h3_128)
            (230Volt h3_129)
            (230Volt h3_130)
            (230Volt h3_131)
            (230Volt h3_132)
            (230Volt h3_133)
            (230Volt h3_134)
            (230Volt h3_135)
            (230Volt h3_136)
            (230Volt h3_137)
            (230Volt h3_138)
            (230Volt h3_139)
            (230Volt h3_140)
            (230Volt h3_141)
            (230Volt h3_142)
            (230Volt h3_143)
            (230Volt h3_144)
            (230Volt h3_145)
            (230Volt h3_146)
            (230Volt h3_147)
            (230Volt h3_148)
            (230Volt h3_149)
            (230Volt h3_150)
            (230Volt h3_151)
            (230Volt h3_152)
            (230Volt h3_153)
            (230Volt h3_154)
            (230Volt h3_155)
            (230Volt h3_156)
            (230Volt h3_157)
            (230Volt h3_158)
            (230Volt h3_159)
            (230Volt h3_160)
            (230Volt h3_161)
            (230Volt h3_162)
            (230Volt h3_163)
            (230Volt h3_164)
            (230Volt h3_165)
            (230Volt h3_166)
            (230Volt h3_167)
            (230Volt h3_168)
            (230Volt h3_169)
            (230Volt h3_170)
            (230Volt h3_171)
            (230Volt h3_172)
            (230Volt h3_173)
            (230Volt h3_174)
            (230Volt h3_175)
            (230Volt h3_176)
            (230Volt h3_177)
            (230Volt h3_178)
            (230Volt h3_179)
            (230Volt h3_180)
            (230Volt h3_181)
            (230Volt h3_182)
            (230Volt h3_183)
            (230Volt h3_184)
            (230Volt h3_185)
            (230Volt h3_186)
            (230Volt h3_187)
            (230Volt h3_188)
            (230Volt h3_189)
            (230Volt h3_190)
            (230Volt h3_191)
            (230Volt h3_192)
            (230Volt h3_193)
            (230Volt h3_194)
            (230Volt h3_195)
            (230Volt h3_196)
            (230Volt h3_197)
            (230Volt h3_198)
            (230Volt h3_199)
            (230Volt h3_200)
        )
    )
)
