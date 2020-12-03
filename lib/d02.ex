defmodule AOC.D02 do
  def valid_password_count_part_one() do
    String.split(input(), "\n")
    |> Enum.count(fn line ->
      case parse_input_line(line) do
        %{
          "range_left" => min_times,
          "range_right" => max_times,
          "pw_candidate" => pw_candidate,
          "rule_letter" => rule_letter
        } ->
          valid_entry_part_one?(
            String.to_integer(min_times),
            String.to_integer(max_times),
            rule_letter,
            pw_candidate
          )

        nil ->
          false
      end
    end)
  end

  def valid_password_count_part_two() do
    String.split(input(), "\n")
    |> Enum.count(fn line ->
      case parse_input_line(line) do
        %{
          "range_left" => pos_one,
          "range_right" => pos_two,
          "pw_candidate" => pw_candidate,
          "rule_letter" => rule_letter
        } ->
          valid_entry_part_two?(
            String.to_integer(pos_one),
            String.to_integer(pos_two),
            rule_letter,
            pw_candidate
          )

        nil ->
          false
      end
    end)
  end

  def parse_input_line(line) do
    Regex.named_captures(
      ~r/(?<range_left>[[:digit:]]+)-(?<range_right>[[:digit:]]+) (?<rule_letter>[[:alpha:]]): (?<pw_candidate>[[:alnum:]]+)/,
      line
    )
  end

  defp valid_entry_part_one?(min_times, max_times, rule_letter, pw_candidate) do
    rule_letter_count =
      String.split(pw_candidate, "") |> Enum.count(fn letter -> letter == rule_letter end)

    Enum.member?(min_times..max_times, rule_letter_count)
  end

  defp valid_entry_part_two?(pos_one, pos_two, rule_letter, pw_candidate) do
    pos_one = pos_one - 1 # Start from zero
    pos_two = pos_two - 1 # Start from zero
    pos_one_match = String.at(pw_candidate, pos_one) == rule_letter
    pos_two_match = String.at(pw_candidate, pos_two) == rule_letter
    (pos_one_match and not pos_two_match) or (not pos_one_match and pos_two_match) # XOR
  end

  defp input do
    """
    1-14 b: bbbbbbbbbbbbbbbbbbb
    3-14 v: vvpvvvmvvvvvvvv
    2-5 m: mfvxmmm
    15-20 z: zdzzzrjzzzdpzzdzzzzz
    6-8 g: tggjggggrg
    2-3 l: nlllw
    1-5 j: jjjjj
    4-5 t: prttt
    2-4 v: vvrqzp
    4-6 v: vvvvvqvvv
    7-8 d: mpntdwkd
    2-12 w: jwkfktkbthcwvfrkwgz
    12-16 j: jjjjpjjmdhjjdjjjjjjj
    10-11 f: fffffffffff
    3-20 n: pbclshqmxtkmgsmztjlm
    11-12 q: qqqqxqqqqqqqwqrxqs
    5-6 p: hppvnppcvqf
    10-11 k: kckkrbkxtknhkkkk
    5-7 m: kmmgxgmnnpzrzmgsbm
    10-17 b: bbbbbbbbbbbbbbbbrbbb
    5-7 v: vvvvtqvvvv
    6-8 g: gggggpglgzgg
    8-16 q: fqtqqqqxqqzgzfqq
    9-11 r: rrrrprjrwrrrm
    4-13 z: rnlzzqptmhgvk
    4-9 r: rkrzscrrvrtkhrrzvwvs
    9-10 f: qqmkffffrs
    6-11 z: zzkzpzzzwzf
    10-19 n: nnnnnnnnnnnnnnnnnnnn
    7-12 x: xmpxbxxxzxxxsxxsxn
    17-19 f: ffffffffffffffffffff
    2-4 n: nnns
    3-4 q: xhzskzqp
    1-5 l: sllljllll
    8-13 l: ffwsllhmlxcllnr
    1-4 j: jztj
    8-10 b: dbzkwdpcss
    7-9 k: kpckkkkfktkv
    7-11 c: mnzhpxcxxccshcnb
    1-5 l: llllll
    4-6 r: wnjzhrrxchm
    1-2 t: btttlttttt
    14-19 m: lvgmmmwmmmmmmmlmmmz
    1-4 x: xlxg
    2-16 s: jxkwvhwzxwcxhtvss
    3-5 s: rxswsszs
    8-11 d: ddqdkddddddddds
    3-6 v: vpswxv
    8-17 h: hhhhhhhqhhhhhhhdthh
    1-6 j: jjjjjjjjj
    9-10 z: zgzzzzzczzz
    3-5 k: kwzkkdkzfptslvg
    6-7 m: fpmgmmb
    5-13 k: kkkkkkrwkfkkkxkkhkz
    1-3 g: mjggbqgqpqxdwrkwj
    10-12 g: bggggggggggfgg
    4-9 n: nnnnnnnnn
    17-19 p: ppppppppppppppppcpv
    13-14 p: pjkphnpjsgppkfpppmr
    11-12 l: lllllllllllmll
    1-8 v: vzvjhbgvvnzvnt
    8-16 w: vwxmrfwwltswwtcw
    1-5 s: lssdx
    10-13 f: sfffffffffffbffff
    6-10 z: zzzzzzzzzdz
    5-8 m: mmjgmhwm
    1-3 m: mmqmm
    4-6 c: cccrwctcws
    8-15 f: fffffffffffffftffff
    5-6 k: rkddknvp
    1-2 w: pwlw
    7-16 p: pppppppppppppppppp
    7-11 v: fvcszzvdwnbk
    15-16 k: bkkkkkkkkkkkkkkk
    4-5 g: gggggg
    1-6 j: tjhjjfphjjjjjjjjjj
    5-7 z: zhzzpzz
    13-15 w: wwvwwwwcwwwwwkb
    5-19 z: zzzltwskszzrzztkpzd
    2-7 m: rjcmqkwjwx
    11-16 t: ttfttrtmptbttttt
    6-9 k: kkkkkhkkkk
    11-16 l: lllllllllltlllll
    7-8 x: xxxxxgxxx
    3-5 x: jqxlbw
    6-9 k: kdjkkkpzk
    8-10 h: hhhhhhhhhg
    3-4 t: htmrtktcv
    12-16 b: mbxrkbbbzbbpbbbb
    7-12 s: ssrssltsssssssssssss
    3-13 h: hhhjhbhthtblqj
    12-16 d: ddddddddddwwpddkdtd
    18-19 h: hhhhhhhhhhhhhhhhhhh
    3-7 g: vgggggg
    7-9 h: hhhhpkphhtwhhh
    6-7 f: pffffvgqff
    3-7 z: wldszzzz
    6-14 v: vvvvvvrvvvvvvwvv
    1-3 s: qknsgbfsmclhhbrdqg
    8-10 b: bbktbhbpbb
    10-18 j: zljvjwjwjszqjjgvtj
    9-10 p: pppnpnppppppwpz
    8-9 t: ttxtmttntptt
    4-7 t: pwstbrttx
    1-6 w: rwpwwcww
    8-9 j: jjjjjjchmj
    6-9 z: zpxzczzjzz
    8-11 x: mlzjxpjxdxdxx
    10-11 d: dddddkdddmd
    8-9 f: qfpdfhfffffff
    8-9 n: nnnhnncnnngn
    3-4 n: nnnd
    7-8 w: wwwwwwrvwwwwww
    1-8 j: jtpmjnfjzg
    1-4 z: zdzzzf
    3-6 x: xxtxxsx
    5-8 h: hhhhhhhhh
    1-3 s: xsxs
    5-9 l: zlnllqllpl
    16-17 z: jzzgsjwxnklzzxmtz
    10-11 z: zzzzzzztzzsszqmqx
    3-6 l: lldllkl
    2-3 g: sgtggmvwhm
    12-13 m: mmmmmmnmmmmmmb
    1-8 x: hxhdlxxj
    11-17 c: cjccccsccccfccccj
    7-8 x: xxxxsxtxgdxrhvxr
    4-5 b: dbbql
    3-9 w: wwswwwwwbw
    3-5 q: qqqml
    3-8 f: dhsdprvcg
    4-9 m: rhvzxnmwm
    4-11 m: mcncqssmmtj
    2-4 t: btgzt
    4-5 g: ggjgsg
    3-6 h: lmwjhh
    2-10 q: pqnqqqqtzlcqlmgk
    2-4 l: cvmqc
    7-14 c: lzcwzccchgbvcc
    9-11 r: rrrrrrrrcrrrrrrd
    11-13 g: gggpgggwggggj
    10-16 p: mpgtppppfvpptppp
    17-18 g: ggggggggrgggggggqgf
    3-5 g: lpgbgggm
    4-6 d: dddcds
    3-4 c: rbktcqrjvcb
    3-4 g: wgfvgdpgm
    6-11 n: knnhnnfdnknnghnxxsr
    14-15 b: znsbblhbxsxljgb
    8-10 w: lrgwrhdmrwvwwwjc
    4-5 c: gcgjcnc
    3-20 h: fhhnhpshhhhpfhhbhwxh
    4-7 s: sssssbs
    9-12 k: kkkkkkvktkzkw
    3-9 k: skjxkckkk
    13-14 k: kkkkkdkkkkkknp
    4-8 x: mztxblxxxxmcxnljzwqc
    6-8 n: lnbnnznnfn
    3-7 k: khmkkkspkkk
    1-9 j: jbrxjjnvgwkfjwj
    14-16 v: gsfvlhjqkwqrtftvvwlv
    3-6 t: ttrttttttt
    1-5 q: xqqjq
    10-13 n: nnnnnnnnnnnzn
    2-6 f: msfffff
    9-11 s: ksxsssnslss
    9-10 f: fffspfffwsf
    1-9 q: fmqqnqqqq
    1-5 s: kssssssss
    9-18 l: zfqlflvcmlgdwlnlfql
    8-11 s: sssssslsstm
    16-17 n: rmxqmndnrzxrqcrwfmd
    11-17 j: jcjlzcjzjpzjjqjcj
    12-13 r: rrrrrrrrfrrxqrqr
    6-10 n: nnnnznncnnkklqn
    14-16 z: csdpmzztklzzvzmf
    3-4 z: zzzd
    7-8 d: dddpjdfdmjxjddd
    3-11 s: ssshsslfmsspslsxsss
    4-5 m: srwmf
    5-6 l: llllld
    13-14 c: ccdcccczvcbcrrsw
    7-10 h: hhhfhhkhhhhh
    4-5 j: hbpjfwzj
    10-11 l: ldlllllllwn
    4-5 p: jptlp
    2-4 h: hhkzphw
    14-17 b: bbbbtbbbbbbnbrbbz
    14-18 x: hnpzxjzxglxncqldxznf
    2-4 q: qhqqqq
    8-9 j: jwjjjjjjx
    1-2 w: czgpwwfl
    9-10 t: tznttztsctvvttptjt
    6-11 x: gxzxxlxxxxtjxx
    13-17 w: wwwwwwwwwwwwqwwwr
    7-9 d: ddddddddddd
    2-5 h: hqwhhhkqqhnmngl
    4-7 m: mmjmmmj
    13-19 f: jdmfffkfbfnffbffcfxf
    12-13 b: bgbdbgtbbdbjb
    1-6 v: svvvvhvv
    5-6 m: mmmmdm
    10-12 n: nnnnnnnnnrnnnnn
    7-16 t: tttnzxtqrpktgtmzm
    1-3 c: dccccc
    9-17 l: lkqllllllllkllsfj
    5-7 r: zrrrrkrdfrwwr
    2-3 c: ccdjtcc
    13-20 p: pppppppppppppppppppp
    7-10 g: qqwcgfqgfm
    7-8 q: qzdqpzqqqqqhgqkqtnq
    4-9 p: crzpcgqwpd
    14-19 t: ttttttttttttttttttx
    10-13 j: mkjjxjsfxpmqjplhwn
    5-13 p: pzppdqppppprd
    10-14 k: kkkkkxqktkkkkkkkhkk
    9-10 p: srpplgnpjp
    6-9 b: rbbzcbbbjflbbbbxxwbc
    11-14 n: nndngqnnpnnncn
    8-16 z: bhjzjrczkzxzzfgf
    1-6 d: dxptddcddwdd
    6-9 r: fxrhrrtlr
    8-9 m: hmmmmmmmt
    3-11 g: kkfgggvpgzv
    13-18 l: znlllvkzllzrzzzrrl
    3-7 n: nnnnnnnn
    5-7 d: zdptjdd
    15-16 x: xxxxxxxxxxxxxxxlx
    9-12 h: cdbrghhdwhhhh
    10-16 t: ttttxjtttttstttw
    13-14 j: jjjjrsjjjjjjjjjj
    3-4 f: ffflf
    6-9 t: ctpktwjttttttt
    1-10 x: xncxxwqwxxxp
    4-5 x: xxxxxx
    9-17 t: tttttttttttttttth
    7-16 w: wwwwwwwwwwlwcwwkwx
    9-11 v: vlwvvvlvbvtbvv
    4-14 f: ffffsfzffskffffff
    2-4 b: jcqbh
    2-5 j: fjmwjzkfrjprrjj
    16-17 f: fffffffffffffffff
    5-9 n: bjmbpncrpw
    4-11 z: kxzzzzzcrsz
    10-19 z: zzzzzzzzztzzzzzzzztz
    3-8 n: nngnnnnnnnn
    1-15 b: bgxdbrbggnbhjbj
    3-4 d: wddd
    6-7 j: jjjjjjnjlj
    16-17 q: qqgqqwqqqqqqqqqqqql
    2-5 t: tddzt
    8-13 g: qjvkvckgnklmglrxpmpw
    14-17 l: lllllllllllllllll
    9-14 p: nppppphpmpsppp
    3-5 s: ffscssqwssj
    7-17 k: xsbskfwmhsksmxhkkm
    4-5 v: vvvvvv
    7-8 b: bbbbbgbncbbbbbbg
    3-4 f: vwfnmfkxmzgxztlncxk
    1-5 p: lpppb
    3-4 n: dwnzx
    7-13 d: vrdxdcldpddbdv
    12-17 x: cxxxxjdxxxxqxxxxx
    1-2 w: mjwqw
    2-10 w: bwrcwwwsvjwdlsnw
    2-5 b: gbbrx
    17-18 b: bgbbbbbbbbbbbbfbkb
    3-4 m: mmmr
    7-10 f: tkhffrflhzfjf
    2-4 j: fvjjjj
    9-11 n: nnnnnnnnhcnn
    5-14 q: dqnkvqnccqwsnmqmgjq
    2-4 p: ppxt
    2-4 b: bbbbbbb
    1-5 c: ccccqcc
    11-15 k: rfkkgkkkknkkfkkkk
    11-13 j: jjjjmjjjjjqjjjl
    2-6 h: bhhhhh
    4-5 p: ppqpmjppvp
    13-14 h: vhhhvwhnhhhhhh
    1-3 n: mnnnn
    8-14 p: zjpdpjpxzzwqts
    3-7 b: bbbbbbf
    13-15 s: spsscssssgssbsss
    8-12 g: sggggggxgggk
    1-4 f: fjfx
    6-8 l: hgllllll
    4-14 l: znqpzslgsfxrzms
    3-5 b: btbnb
    4-9 b: bnqpbbgrkbstrbj
    6-7 x: xxxxxxxqmxqxd
    2-5 t: jtcctkh
    3-4 v: hvvspvhqv
    9-11 z: bqcklzzpzzk
    17-18 z: tkkvdzxpgkdbrmxmxw
    13-17 w: lmsbqwwwwxlwgwwrbz
    6-9 b: bbbnbbbqbbkbbbnkb
    8-12 l: llkllllgpljlgglrqll
    6-15 j: jwzqwlpjjgjtjjrhjj
    18-19 k: khnrkvlprggwhzlfrkbk
    5-7 v: vghwwvvvvvx
    1-7 p: dpphzmwptpsptrrzdpg
    1-3 k: lkbxk
    3-6 h: qhhcrjzqvqdhfrjxz
    12-13 k: kkkkklkkkkkkk
    12-15 c: ckgkcdcvgcxbcrbz
    2-6 j: zjjljrlj
    6-7 r: rxrntss
    18-20 d: mhvlzntnfvndrpmczwkm
    13-16 z: zzzzzzzzzzzzwzzz
    8-9 p: pgftmlvpvlt
    4-11 v: pvvxxsvhzvzbhwvwz
    4-6 j: jjjjjj
    2-6 q: rhrxgwfhgjkmqtbbs
    11-18 d: qnzwlfgddnhqpxxwsgd
    2-9 p: pqvpnphjm
    5-6 h: wclhgh
    2-14 n: tnkcfsnnknmnndnvntp
    3-13 s: sswxsfsksssswj
    4-12 f: wnhfjgsdfkjwvn
    6-11 h: qxggfhlgfhhtvznxhh
    7-8 r: rrrrrrzrrrr
    1-11 q: fddtjqvqljqqqqprqqs
    11-13 d: ddndddddkddtddddl
    6-8 d: dddddqddk
    7-17 t: lxnzrtjzfzndbbdss
    4-5 w: wwzfmwww
    3-4 s: bgsszwmfbssnmzts
    9-16 q: wtqqqqwqqsqqqpqdqqc
    7-11 k: kkkxkkkkkxkgkkk
    3-6 j: jjjzjj
    15-17 w: ntpqgqzkhvlwqcwpkml
    8-9 s: sssssssss
    3-8 p: phpppwpph
    6-7 l: nlflllc
    5-8 q: qctqqqnq
    5-7 q: qqqqzqtqq
    3-7 k: jgkkbkkkbg
    3-5 b: mzbbc
    6-11 w: qswfwtnfwsw
    9-10 z: zzzzzzzzzzzzz
    3-4 n: nrkn
    11-13 n: ntssnqhwnhfpbsnn
    5-6 d: wsdnjv
    2-7 s: gwsqsgj
    3-5 p: pppppjlpbmhrkp
    1-10 n: zwzpblnrln
    3-7 s: bgstvvn
    11-12 n: tnnnnnnmnnnnnjn
    5-6 v: vvmvvj
    4-6 d: dddqdwd
    5-6 w: xjhwbj
    1-3 q: lqqq
    5-10 g: jgtgplmgggghzsgwgngb
    1-8 x: xxxxxxxjxjx
    1-2 d: mddddddddddm
    8-9 r: rrrrrrrrl
    2-5 w: swwwww
    2-5 b: xwjlb
    2-16 k: kkfkhsqkkkkmpfdbdfb
    9-12 k: kkkkjkkkpfkc
    4-7 s: dstwsss
    6-13 t: tmtrtpttnmtcjk
    14-16 q: qgqqqqqqqqqjqqqqq
    6-8 z: zjzzzzqf
    11-12 t: tttttttttthtq
    11-14 m: hmmmncqmmmmmmm
    8-10 q: qqqqqqqqmq
    4-5 t: qtqtt
    1-5 m: ndkwggwtm
    5-6 n: nnnzcn
    1-7 l: llmllll
    2-4 l: vptl
    6-8 w: lwwwwcwwdwj
    8-18 q: qqqqqqqhqqqqqqqqqqq
    6-9 t: ttttttttwt
    12-14 p: gpprpppwfnpppbgspdpp
    14-15 f: fffffffffffffqf
    14-15 h: hhhhhhhhhhhhhhgh
    10-13 m: mmmmmmmmmvmmm
    10-12 b: bbbbbbbkbbwfb
    9-11 h: hhhmhhbhnhrh
    4-10 v: tvcpfrfvmvczvvwj
    12-13 j: jjjjjjjjjjfjjpj
    3-6 q: cqqqqfq
    18-20 p: ppppppppppppppkppppx
    14-16 l: llllllrllslllllllllv
    17-20 x: txkgsxxxfgcjwxhdxqxt
    2-3 b: bjbb
    14-16 h: hhhhhhhhvhzhhcgthqh
    15-16 m: mmmmmmmmmmmmmmnp
    3-9 r: drvtprzmzjrrmjzrr
    13-14 d: ddddddddddddddc
    5-13 q: zxthgdmsdqqln
    9-10 g: btgpjgglng
    5-7 z: jhnzlltcrgj
    5-11 l: lknhltlnzbljzzpjbfrm
    6-8 n: nnlnnfgdn
    5-11 x: xxxxxxmqfwxjxhk
    2-4 m: mmwm
    1-8 r: rrrrdrjrrp
    2-4 s: ssrsc
    9-10 d: dpdddddhddd
    3-10 q: cqqqqjvqgqgqqmrzq
    5-6 c: ccccshcccc
    6-15 w: wwwwwwwnxwwxwww
    9-12 j: njcgjjjjjjjjjjjgwfj
    8-16 n: nvnnfnrgmndksngn
    14-15 z: zzzdzzzzzzzzzsj
    4-8 h: hthqthcqnbh
    12-14 q: qqqzpqkqqkqsqpwqqqq
    4-6 l: bzqrdj
    4-5 h: hhhfjhhhh
    9-13 x: xxdqbxxwxdxxxhxxmxx
    3-4 t: rtwt
    8-15 s: sssssskdsssssssss
    3-8 r: rrdrrrqsm
    3-4 w: wwzw
    7-11 c: vfgdgnpfswsdjjwz
    16-17 b: bbrbbcbpnbbtklfvtj
    13-14 g: jggggpgggdpgggjv
    2-10 v: wvdfgchsgv
    3-4 s: sswsssx
    8-10 s: sbssssslsss
    14-16 r: grrrrrhrrrrrrlqrrt
    4-9 p: ppzppppprpp
    3-8 m: wmmmfzmdc
    17-18 b: bbbbbsbbbbbbbbbbbb
    5-7 p: ppppvppppppp
    2-4 g: bgmgnj
    1-7 s: sdsjsblc
    3-4 s: qrxk
    10-13 r: rrrrrrrrrjrrtr
    1-3 c: cckc
    10-11 l: llcllllllld
    10-13 s: rlggmfsskssrssjssss
    2-7 v: vvrjzwcrh
    3-5 k: kkkkktk
    1-5 b: xbbbtb
    8-9 b: bbbbbbbbhn
    14-15 s: scsssssssssssls
    5-7 f: gfqfgfwfffffffffg
    9-10 f: ffffqfffhb
    15-16 r: rvrrrrmrrrrrrbrd
    3-5 v: vvhvjv
    2-5 g: ggdgf
    2-10 j: lcfjjjjjjct
    2-4 h: hchh
    8-12 b: drnwwmhgpbhrpq
    11-12 m: mmmmfmrmnzlmmmmmb
    1-5 c: pgcwckcrgc
    12-14 g: jzgpnqlgqjwdksgpmggc
    4-6 q: bhchmrqqt
    5-7 k: kkktzkk
    1-4 n: nnbm
    3-5 m: mmmmms
    6-9 j: jlnnjjtcvjfjjv
    3-6 x: vxxxfwxxxx
    10-16 c: cccccccccccckccct
    1-6 n: xqnbzmd
    8-9 f: fffffffhv
    5-6 p: vphcppmpx
    9-12 b: vbznbbqbpbhbbrb
    3-4 r: rfpkbnptxgj
    4-15 s: sfssssqssznssss
    1-4 k: kkgk
    4-5 w: rqwwww
    10-14 b: fcblhcbhsgnfkb
    4-10 f: dvjhdpdfff
    13-14 p: gcpcbpdppprmpbssd
    10-12 v: vvvvvvvvvvvmvvvvvvvv
    2-4 m: smvmjcrtmxxnmmzxzc
    14-15 x: xfxxxxxxxxxkzxxxxxx
    10-12 d: dpdmddddgrsddddd
    8-10 x: xxgqxqxxxxxxh
    1-9 x: dxxrcxktx
    6-12 d: tddddddddddsdddd
    2-6 p: fjkbdpp
    16-17 p: ppppppppppppkppqpp
    2-4 d: ddthzddddf
    3-4 f: ffvx
    10-12 m: kmmmmmmmmnmmmm
    3-4 r: hrnrr
    3-4 g: gggg
    1-4 j: jqjltjwj
    5-7 j: jjjjcjnj
    5-6 r: rwjbgnrfrh
    5-8 b: bzcxgbbbbh
    2-3 j: jcjrjj
    7-8 b: fhmhlcjj
    5-6 j: jjjjgk
    10-11 x: kxxxxdxxnffxxxx
    5-15 k: kkkknkkkkkkkkkkkkkk
    3-4 t: jttt
    8-10 w: zwwrwwswmn
    4-12 d: dddwdddddtddddbd
    2-3 x: dxxbjcxzxn
    12-16 j: jjjjjjjjjjjjjjjzj
    6-8 c: ccgmclcczccc
    9-10 p: ppppppppsd
    2-3 n: npnz
    7-8 z: zzzzzzzz
    1-10 z: vnqbljpczz
    3-5 t: ttftttttt
    4-5 x: xxdpx
    15-16 z: zzzzzzzzzzzzzzzx
    8-11 m: pmdzmjbmmlmvm
    2-4 x: xxxxzx
    9-11 c: ccccccccrcl
    6-14 r: rrrrrrfsrrrrrrr
    10-12 j: jxjjjnjjjjjjj
    5-7 v: vvvvvvvvvvvvvv
    5-7 n: nnqnnnj
    9-13 l: llllllllxlllcl
    2-14 h: gtjmvthqqtghhhbhk
    2-4 j: wpljhpjh
    3-6 b: dbvmcp
    1-4 p: dpppp
    6-9 x: xnvxxxxxxxzxv
    2-4 n: vnjj
    1-8 l: lllllllz
    4-7 w: qkzwwxwkncwzd
    9-10 r: rhrrlrrrqgfrn
    16-18 m: mmmwmmmmmmmmmmmdmm
    3-5 m: gbmwmmfvmfbdzccqhmmx
    6-8 c: ccccfxzc
    4-5 h: hhhhn
    2-5 l: lwtlv
    4-15 j: jjjljjjjjjjjjjjjj
    8-10 w: wwwwqcwwlvqw
    3-4 g: gfgm
    5-9 t: tthptxkttbshtjv
    7-13 b: nrjjbspgkqpbbcr
    4-7 s: ssscsss
    10-17 d: dsdddddzddcdddddjddd
    3-4 j: jrbjjvsj
    4-7 h: hhhhbdchhhhhhh
    4-10 p: pdpqppppppp
    10-14 g: shznjbglbghtngzbhg
    4-5 k: vhkkskkb
    7-10 j: zjjjjqzcjknjjjg
    10-11 k: kkkzkkkkkgkkkvkkk
    2-6 c: vczcxbbccc
    3-10 l: lldllllllnllll
    5-6 k: kklpksq
    5-9 k: kkhkkkkmkkzk
    4-5 j: djjqj
    9-10 q: qqqqqqqqqz
    2-16 c: ccczxccccccjkcccc
    3-4 l: mljl
    7-8 v: vvvvqrxk
    2-14 v: vntfpvvbrvvvvvvv
    7-10 f: fffsmbffffzftfqfjdj
    10-11 v: kvvtvhvvhvvkpvzc
    10-11 z: zzfgjqkgzzzdz
    2-4 k: xgvr
    2-6 b: bbbbbvbbb
    18-20 f: fffffffcffffffffffff
    2-6 m: mmmlmmjmmm
    7-10 q: qhjqbqqrsrqnmbtqfqbr
    6-10 c: tsqclcqmncpccdd
    3-4 z: ztxzz
    2-4 r: jrrf
    7-9 m: mzmmmmmplpg
    9-13 b: bbbbnmbbbrpbbbbbb
    4-14 z: zzqvwzzzzzzjzbzzf
    2-9 x: gbxxxxxsxfxpxxt
    9-11 v: ddhtvfzvjvv
    2-5 x: hxxxxdwjxnvwx
    8-12 k: gkklpkqgkjncl
    2-6 d: ndvdbk
    3-4 m: mmmmm
    9-10 z: tcstfmslrsxbz
    2-7 j: pjvjjfgfztsvnc
    3-4 j: jjjj
    4-13 r: rzgrkzqkzsgzxwchbtv
    4-7 p: pptdppprwz
    2-5 j: wfpjjzjwjcpsjq
    14-15 x: hxxsdnvgvxxppxxhkn
    10-20 r: rrvrrrpxbvplrrxttrkr
    12-16 v: vvvvvvvvvvhvvvxdvv
    14-19 w: wwbwwwjwwwwwswwwwrw
    7-16 b: jxwbbbbbbbwbbbqbbkz
    3-9 r: xsrmlrzmnrrq
    17-18 m: mmnmmmmmmmmmmmmnnmmm
    1-4 n: nznnnnnnnnn
    6-9 w: kwnbnnwwzl
    1-6 k: kkgnbkpmmjh
    5-9 v: vvwtvvzcvvvfdvflnd
    1-2 q: qqckqspjkgnlnpth
    5-7 b: kfhcdlbpvbslfscbt
    8-9 r: rrrclrrrwrcm
    2-4 d: ndqcbndjvmddpw
    6-8 k: skldfkdbwbpbklkk
    2-8 c: cczcccqcrcccckd
    3-4 c: cchbkcdc
    6-7 l: lwlclrhlll
    2-7 l: cwkllzfmlrrjljl
    13-14 j: jjjjjjjgjjjjjb
    12-13 v: vvvvvvvvvvvvv
    8-9 g: ggdggxggg
    3-4 f: pfwgcrf
    4-7 m: mvhmbwtm
    15-17 c: cpccrslcrspkfjhcc
    12-15 v: vvrvvvzvrvbhvvvvv
    8-17 c: pczcccccncllvpxrpt
    10-12 r: rrrrrrvrrtrrr
    3-10 n: nrzcnnvtnwnnnn
    8-9 x: xxcmxxxdxjx
    1-4 s: fdbsstzvqsxf
    9-11 d: dddddddddmmddd
    8-11 f: nffxfffffff
    3-4 g: zggg
    5-10 g: cphtggfxgg
    3-11 s: nvxqhqgfsklk
    4-5 b: qbxtb
    10-11 h: hhhmhhhzbhm
    6-10 b: bbbmbbbxbqbb
    14-17 h: hhhhhzhfwfhhrhhhh
    5-11 h: xjsnhhjhrhhjnhhwsdmc
    2-8 r: hrrdzhfsrltr
    9-12 n: nnnnnnnndnnx
    6-13 g: gdgzxgnglbgtggnfcglm
    1-3 j: jjlj
    4-7 t: tttxtttt
    4-19 t: vflbmbhngnjkkvqzvjk
    4-12 n: gnnnnnlnxnnnqwngn
    10-13 m: mmmmmmmmmmmmmmm
    1-3 t: ktmqtst
    7-12 q: qclsqqqqqqqfnw
    6-9 r: rrrwrjrqpw
    7-10 s: sssssqfssgsbs
    4-9 t: tfktphnmtncj
    12-16 z: zfjzqzzzzwzzzzfzzzj
    1-4 d: rddxdd
    5-18 z: zzzzlzzzzzzzzzzzzzz
    14-17 x: rmmxdvwxbrwxxxdrjzz
    2-12 d: ddzddkddbnddddd
    2-5 x: xxrxt
    14-15 r: nrrrrrcrrrrrrsrrr
    3-9 z: szgzqvzfmrzztzzz
    1-6 b: fdbpbb
    15-16 z: zzjzzzzzzzzzzzfrz
    2-9 d: zdnmmnfhdc
    3-5 h: hhdzxhhhh
    5-6 v: vvvvnv
    10-13 p: lpbxtppfbphhr
    1-9 p: gmtbnlpsphppvfppp
    4-7 r: rlrcrqrrrrrr
    5-15 f: gffffqvfffrkffb
    5-13 k: lkswkhhqxpfjkrvqbkjs
    2-4 h: fshrhhh
    1-5 l: lplllllmv
    1-15 j: jjjnjjjxpdjjqjpj
    3-4 p: phppf
    14-18 p: pppppppppppppppppp
    3-5 b: jmbbbsxrqhht
    11-13 v: lpzcvmmblzcvctjvvvj
    10-13 z: mszzdwzzntzxzzzv
    2-5 w: wwfjw
    8-9 c: cscccccgscccccw
    5-6 x: xxxxxjxxxxxxxxxx
    14-15 h: hjhhhhhhhhhhhhm
    9-12 l: lllllllllllbl
    7-8 j: jjjjjjrj
    9-13 w: fwwshrkqprlcfwrnnhws
    15-16 w: wwwwwwqwwwwwwfwk
    5-11 g: ggwgxgggggngg
    5-9 h: hhhhhhhhlhh
    7-11 r: rrrxrrhxrjtrr
    5-10 n: nngknxnrnn
    7-12 t: tdptttkvtttst
    4-10 g: dbggxcbvhdvbgg
    2-4 n: bnnnxgqsmqd
    3-7 f: fffdppf
    7-12 n: nnknnldnfpndnnz
    17-18 j: jvjjjjjjjjjjjjjjrk
    4-7 f: nffnfffcf
    4-5 p: pcppqvp
    12-13 c: chccmcczcsbccqhbkccc
    4-12 t: ftjtvbjtftcjxdf
    4-7 r: bgdnrdrfpd
    5-6 m: mmmmmm
    8-9 v: vvjvvvvvvvvl
    9-11 v: vvvvvvvvbvq
    4-12 r: kncrkgzrchvr
    14-18 v: vvgsxvztvvkvvvvbsv
    5-10 v: mwhtvfvvvvtvbpvvhvv
    2-6 f: bfrmbflfk
    13-19 v: wvvzvvhsvdvvmvvvvvh
    8-10 h: hhmhhhhvhsz
    8-9 f: fbfffffkg
    3-5 z: zzqzq
    3-4 s: zdcfbdss
    2-8 n: dzdnhldbpd
    9-11 k: fphphksskqkkz
    2-3 h: ndhgh
    2-3 p: pkpmgp
    7-17 r: brpwrmrfrtvfrqldrnhm
    1-4 q: wtkqq
    9-19 b: bbbbbbbblbbbbbbbbbbb
    3-8 s: ssssttgs
    7-12 w: wwwkwwwmwwwcw
    8-11 s: sszjsslsslnss
    8-9 v: bvkvvvvbvvcpnmv
    1-9 j: qlhcjdtqjjb
    16-17 q: kqgkqnmwdqcxqnnqq
    12-13 f: fffffffftfffff
    10-11 k: kkkkkkkkkkk
    6-7 r: hrrlfrr
    3-4 s: sgsss
    1-4 x: qxqx
    2-12 p: cppdxmdrfmkptslj
    15-16 j: jjjjjjwjjjjtjjjjj
    3-4 c: ccpc
    4-5 b: bzbbh
    4-5 m: mdmzm
    3-5 n: nnnnn
    14-15 b: bbbbbbbbbbbbbbkbb
    9-12 f: htjbckfxbpffl
    8-10 k: kkhxxmwpvkfkkhvv
    7-10 p: ppxppppwmzpp
    1-6 k: kkkkkqk
    9-12 m: mmmmmmmmmjmt
    11-13 q: qcqrqcxsnqxqq
    7-16 z: jfdzzhzznzzzzzdfzcm
    4-5 c: cwcqf
    4-5 p: ppppr
    4-12 r: rrrnrrrrrrrnr
    3-4 j: wjfjj
    6-7 j: wbscpkz
    7-8 f: fffflfwff
    4-6 x: xxxdxt
    2-3 w: sfnw
    4-5 n: nnnnm
    4-5 w: rwwqntw
    3-4 n: dnnnqpn
    4-8 m: mmmfmmmhmmmmmmm
    4-17 n: nnnwnnqzndwbnnnnpnnn
    7-8 x: rqswdxxz
    1-5 x: wshxxxcsxvx
    7-9 m: mmmmmmpms
    17-19 m: fmjmjfbqqpbtnbhmwns
    1-3 j: jtmswbmwlqpnwrsnt
    11-12 r: rrrrrrrrrrbprn
    3-7 v: vvvvvvv
    4-8 h: drhxhbvnrqldgf
    16-20 x: hrvxjqxxxxwfkpzjxtxx
    3-4 b: bbth
    3-9 k: ttpjhlqnkk
    9-10 w: wwwkwwwdnwvlw
    1-2 j: ffjx
    3-4 q: zvmd
    3-6 p: vngptsmhplptp
    11-13 c: xfrccqbcsxcrtfvwg
    2-6 r: rrrrjprrrz
    1-15 t: tttttttttttttttt
    7-11 g: dbxjvjwwsbghhts
    4-5 j: jjjjl
    10-16 b: tbbbbnbgbrwmcxkh
    10-19 g: sgggggsgggggggggggk
    4-6 w: wwwwwwwww
    14-16 k: wkqhxkkkkkkkmkpd
    7-8 w: wbwhwwsg
    8-9 r: nrrrhskwm
    3-8 f: fffnmqfflgffzsjmm
    3-13 n: dznkvhtztwnjf
    6-9 d: zbdddvdddddd
    7-16 j: jjjjjjzjjjjjjjjjjjjj
    2-3 k: qqkk
    15-16 l: lllllllllllllldl
    1-3 j: jjtjjjjjj
    7-17 k: kkknbkkvqbkjgkrkvkkk
    3-6 w: rwvqbx
    7-16 x: xxxxwxsxxxvxxxxmxxm
    6-15 n: zhmnsnmlmgzxdwnhlcbk
    1-17 x: xpxpmxrgxmjxxxxxcxx
    7-9 b: bqnhbbsbbwbb
    8-9 g: ggtggggdg
    6-10 m: mrszmmmmcmgmm
    10-12 j: ljvjgjgjhjjp
    7-9 z: zzdzzzwzhzgzzg
    4-5 k: kkkkk
    2-4 z: szzzzzpzgqzmpcctpc
    5-6 q: qghxqqxqqdfhqbt
    5-6 w: wwwwwww
    4-10 w: wwwbxswwwnwn
    5-10 n: nnnnnngnnjnnw
    4-14 s: fhnscjmmkxplmgnslfz
    4-7 p: nptcxvppp
    2-5 x: lxlxvxxxhr
    8-11 g: fwgrkggrggkggkggj
    8-11 j: ljgjjnjjjsw
    14-15 m: mmmmmmkmmmmmmrv
    1-2 t: trqtc
    2-7 s: sqtssss
    4-6 v: vvvvvwj
    4-12 w: sqwxkvwwwdfwhswww
    5-7 m: mmmnpmmmmmmmtmm
    11-13 h: hhhhhgqhlzkhqhhvhhhs
    8-9 f: fffwbfvfwff
    1-4 s: ssstfzsssns
    5-6 p: cvpfpp
    1-3 b: bblpbzb
    15-16 l: qlppjglsdpfldmlg
    3-7 h: hkshhbrrjrnhbhlrmh
    1-9 b: bbwlbwzbmb
    4-5 d: txlddjgdd
    9-12 k: kkkkkkzknkdkk
    9-17 q: qqdqgqqsvqqmcqnqqqr
    12-15 l: llpllllzflnnltlzkt
    8-9 h: hhhphhhghphhh
    4-6 r: rrmrrdrr
    6-16 r: kcrdvqntdxckjxsqksxg
    4-9 d: grfdddffz
    10-11 m: mmmhmmmmmmm
    8-10 l: llllljlgllxlw
    11-16 h: hhhhhhhhxzshhhhhhhhh
    8-9 s: fmqsdsrsnspsslc
    5-6 h: khrhbhvhhkmh
    2-13 r: srhvjgsgvhqfrhrfhp
    4-5 s: shssss
    4-6 r: rrrcvnrrtr
    5-6 p: ppppxpp
    3-4 r: nxrnxrd
    2-10 q: gqghqqzflmj
    1-10 r: rztsjmwcrrdd
    5-7 b: rsbbnrnlwbgb
    4-12 g: qggggggcgbggg
    11-13 q: qqqpqqqlqqdqh
    5-6 z: tzzzzzvfsz
    15-16 s: smqxzshssmkncscssg
    5-7 f: grlbfrfcjfffgpf
    1-5 r: crrrrrr
    12-13 v: vvsvvvvvvvvvb
    6-7 h: hhhhhzqh
    3-7 b: btdgdbbb
    1-3 x: lxdx
    9-10 p: gpdppwpppppppp
    3-13 w: wjwvwrwwswwwwr
    10-11 p: npppppprpppp
    16-18 x: xxxxxxxxxxxxxxwsxxx
    7-8 m: mmmmmmtj
    2-3 b: lbbbb
    10-16 n: nnnmnnnzxnfnnnqn
    10-12 q: jqqqqpqqqqdqqq
    14-18 x: xxxxxxxxxxxxxxxxxxx
    3-6 n: nnnnfdnz
    7-8 p: plpppppp
    3-7 t: hctttzktntt
    3-4 z: zjzgbz
    4-10 k: mkkskqknklk
    5-7 l: llhlllpl
    2-11 c: cwcccjcccpcccvcccmck
    5-10 l: nvlvlxxlllhlctllglll
    7-11 n: nnnnnnnrnnnn
    4-5 z: zzzfzlkz
    2-4 q: wmqq
    3-5 h: hhhhh
    7-8 j: jkwlwjhj
    13-14 m: mmmzmmbmmmmmfwms
    9-10 k: mkfhkgkjdj
    15-19 n: nnnnnnmnnnvnnxnnnnv
    11-16 l: ltlllljlllpclllltll
    3-9 x: twkgzhpcq
    4-10 l: rsrcwkdcsks
    10-12 g: ggggdggggggj
    8-15 z: tzvbtbnbjjsppczf
    12-13 q: qzrzqjqqxzqqh
    10-11 d: dkdsxxxdkdd
    4-14 l: gllfglslrlvllglzlll
    2-3 r: rrcbrr
    2-5 c: vcdgc
    7-8 z: zzzzxfnz
    1-5 m: tcjkmm
    1-4 v: vvvpvr
    1-3 w: wwmwww
    8-11 t: wsjttdvqttttdrtttt
    9-11 f: mhfxhxvjgvf
    5-8 w: wwwwswwdww
    9-11 n: pcfhnkpnnsnw
    4-7 l: gslllllxllqlnllbdf
    2-4 j: jjjjj
    6-9 m: nmlmmmmkv
    1-10 w: xwwwwwwdww
    5-10 s: nsshbsscnssj
    10-11 f: ffffffffflj
    5-7 v: gwvjvvhzfvnzvqwcqv
    4-7 b: shbpbbbnmdjgmd
    6-11 b: bbbkbpzlhjbjxlbr
    13-15 n: nnnnnnnzrnnnzhnnxzn
    1-2 c: ctcccc
    2-3 p: pppppp
    2-3 g: dggg
    4-5 p: jpppx
    4-6 p: ppppptp
    2-7 s: stsnsjpsss
    6-9 x: cxxdgxhmxfdxxxqtz
    10-14 l: lljblhnllrmlpllhlls
    1-8 m: ppmnmwmmn
    12-15 s: gsssqsssssssslsrjss
    10-12 k: kkkkkkkkkkkq
    8-10 d: ddddddddnjs
    2-3 d: dgmd
    1-18 k: kjjkkkkrkdkkqvkkwdkk
    3-7 d: dhdvqwdbg
    8-9 z: vsccrzszmz
    8-17 r: rrrfrxrzrrrqrwxrrrr
    7-13 z: zhzczhbxphhdzzzmtj
    2-9 w: wbwwwwwwwzqwwwww
    9-13 q: kpwqqljsqdcfwc
    5-11 g: lmbzgggggggzkzg
    4-6 q: qqqqqqcw
    9-10 f: zqffftffvfjffckffg
    3-7 s: dsssshssssss
    3-11 m: njqmrkblsbmlxqn
    8-19 j: jsjjjjjjjjjjjjjjjjc
    12-13 w: mrmxswfhkwmwwl
    3-4 x: xxxx
    11-12 h: hhhhhhhhhhhx
    12-16 k: kkkkkkvkkkkqkkkkk
    3-6 z: zzxzznz
    14-16 l: lllllllklllllfll
    1-10 c: cccccccccdcccwt
    8-9 s: szsssssgspss
    2-4 n: npct
    2-14 x: xmxqbpbxxxxxxxsjxt
    3-12 k: xpfkkkmkmkjwk
    9-10 q: qmqqqqqqqq
    12-15 x: xxxxxxwxldxgxxx
    14-15 v: vvvvvvvvvvvvvvx
    4-9 r: rrrrrdrrrrcrrvr
    2-4 v: rvzxtdkvsnhv
    4-5 j: jnjjclj
    8-9 c: ccccccccc
    7-10 t: ttfjvztrtht
    14-16 f: ffgfbfffffbffgfff
    13-16 z: zzzzgzzzpzvlmclnzzz
    12-15 k: kkxwshnkwfkdwws
    3-4 s: sskb
    14-17 g: ggggggggggggggggs
    12-13 r: rrrrrrrrrxrrrrr
    1-14 l: jzwwlldlhzllmljlclw
    14-15 w: zcwxxmfwlbvnsmcnzbm
    10-12 l: lplblnqpdllwmllttm
    9-17 p: bmbrzkjhqvzlmkttpp
    3-12 q: dwrkbstbbzwqkckvj
    2-7 x: txxxxxbgxx
    6-9 x: xxxxlbvxq
    7-11 k: kkkkkkbkkks
    3-4 p: bxptpp
    3-5 z: fndtmzrmlqh
    1-10 k: tmfjqlghfzbgwt
    8-12 z: zxzzzzfxzlmzz
    3-11 m: mmnjmmmmmmkmmqm
    3-5 z: zzrmzz
    1-2 t: btcq
    5-7 r: rdrrmrr
    3-4 v: hmssgxvqxcqpv
    1-10 s: ssgpdqssps
    9-10 z: zzzzzbzzczzqh
    6-7 n: xmnmnrxnnntn
    9-10 n: nnnnnnnnnc
    5-6 r: tgrjtr
    6-7 d: ddddddd
    8-12 n: pnnhnsnnnnnn
    3-7 c: zkccckqc
    4-17 g: srtggggmggjfxgggzxm
    1-2 c: clcc
    2-6 w: vxwwwcw
    15-16 r: rrdlrrdmrrrrvtrl
    12-15 m: qgfbgpqnnmmsfjz
    1-11 b: bbvbpxbbztbbbqbbgtk
    7-11 l: lllllmlllfllll
    1-2 n: vlnl
    8-11 n: wszsqncnntnm
    10-11 m: cmzmmmmmmvsq
    2-3 j: kjjjdvjx
    2-4 h: hhhfhhhhhg
    3-4 b: bbbc
    9-10 r: rnrrrrrrrrr
    3-5 m: mwmkm
    1-4 h: hldfhhhwh
    1-3 h: hhmh
    11-16 c: vwcccpcznqcqxvjw
    8-9 p: pptppfppkpqqpp
    13-17 r: rrrrrrrrrrrrrrrrb
    7-9 q: jqdzzpqbqklqg
    11-12 c: bccdccccqccx
    4-20 s: sssxsxksssssstnntsqs
    1-2 q: gvcq
    12-14 c: ccscjccccccqzc
    10-13 x: xxxxxxxxxbxxjx
    2-5 h: cphhbhh
    2-3 v: vhfv
    7-14 r: zrqmcfrvsrfrrvmr
    1-2 b: zrdtblbbb
    8-9 q: qssqqxqqcqqgkzbq
    3-8 m: tmmmmmmmmmmmj
    2-5 f: mmcfxtk
    """
  end
end
